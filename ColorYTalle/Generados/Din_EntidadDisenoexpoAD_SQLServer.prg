
define class Din_EntidadDISENOEXPOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DISENOEXPO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_EXPPK'
	cTablaPrincipal = 'DISEXPO'
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
			local  lxDisexpoFecimpo, lxDisexpoFectrans, lxDisexpoFmodifw, lxDisexpoFaltafw, lxDisexpoFecexpo, lxDisexpoHaltafw, lxDisexpoHoraexpo, lxDisexpoBdmodifw, lxDisexpoVmodifw, lxDisexpoEsttrans, lxDisexpoHoraimpo, lxDisexpoValtafw, lxDisexpoZadsfw, lxDisexpoBdaltafw, lxDisexpoSmodifw, lxDisexpoUaltafw, lxDisexpoUmodifw, lxDisexpoSaltafw, lxDisexpoHmodifw, lxDisexpoAgrup, lxDisexpoCtiparch, lxDisexpoCtipreg, lxDisexpoTimestamp, lxDisexpoHabgcomo, lxDisexpoSinnodo, lxDisexpoBloqreg, lxDisexpoClasehook, lxDisexpoCcod, lxDisexpoCobs, lxDisexpoEntafe, lxDisexpoCxml, lxDisexpoCdelimi, lxDisexpoCexten, lxDisexpoActfecexp, lxDisexpoCdes, lxDisexpoCategoria, lxDisexpoCrutasal, lxDisexpoCarchsal, lxDisexpoCentidad, lxDisexpoFavorito, lxDisexpoLagrfh, lxDisexpoLseparachr, lxDisexpoComext, lxDisexpoAppendarch, lxDisexpoParcoma, lxDisexpoCrutabkp, lxDisexpoCarchbkp, lxDisexpoLagrfhbp, lxDisexpoAppendback
				lxDisexpoFecimpo =  .Fechaimpo			lxDisexpoFectrans =  .Fechatransferencia			lxDisexpoFmodifw =  .Fechamodificacionfw			lxDisexpoFaltafw =  .Fechaaltafw			lxDisexpoFecexpo =  .Fechaexpo			lxDisexpoHaltafw =  .Horaaltafw			lxDisexpoHoraexpo =  .Horaexpo			lxDisexpoBdmodifw =  .Basededatosmodificacionfw			lxDisexpoVmodifw =  .Versionmodificacionfw			lxDisexpoEsttrans =  .Estadotransferencia			lxDisexpoHoraimpo =  .Horaimpo			lxDisexpoValtafw =  .Versionaltafw			lxDisexpoZadsfw =  .Zadsfw			lxDisexpoBdaltafw =  .Basededatosaltafw			lxDisexpoSmodifw =  .Seriemodificacionfw			lxDisexpoUaltafw =  .Usuarioaltafw			lxDisexpoUmodifw =  .Usuariomodificacionfw			lxDisexpoSaltafw =  .Seriealtafw			lxDisexpoHmodifw =  .Horamodificacionfw			lxDisexpoAgrup =  .Agrupamiento			lxDisexpoCtiparch =  upper( .TipoArchivo_PK ) 			lxDisexpoCtipreg =  upper( .TipoRegistro_PK ) 			lxDisexpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisexpoHabgcomo =  .Habilitarguardarcomocondicionado			lxDisexpoSinnodo =  .Ocultarnodoexpo			lxDisexpoBloqreg =  .Bloquearregistro			lxDisexpoClasehook =  .Clasehook			lxDisexpoCcod =  .Codigo			lxDisexpoCobs =  .Obs			lxDisexpoEntafe =  .Entafectadas			lxDisexpoCxml =  .Xmlconfig			lxDisexpoCdelimi =  .Delimitadores			lxDisexpoCexten =  .Extension			lxDisexpoActfecexp =  .Actualizarfechaexportacion			lxDisexpoCdes =  .Descripcion			lxDisexpoCategoria =  .Categoria			lxDisexpoCrutasal =  .Rutasalida			lxDisexpoCarchsal =  .Archivosalida			lxDisexpoCentidad =  .Entidad			lxDisexpoFavorito =  .Favorito			lxDisexpoLagrfh =  .Agregarfh			lxDisexpoLseparachr =  .Separacionporcaracter			lxDisexpoComext =  .Comandoexterno			lxDisexpoAppendarch =  .Appendarchivo			lxDisexpoParcoma =  .Parametroscomando			lxDisexpoCrutabkp =  .Rutabackup			lxDisexpoCarchbkp =  .Archivobackup			lxDisexpoLagrfhbp =  .Agregarfhbk			lxDisexpoAppendback =  .Appendbackup
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxDisexpoCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.DISEXPO ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Haltafw","Horaexpo","Bdmodifw","Vmodifw","Esttrans","Horaimpo","Valtafw","Zadsfw","Bdaltafw","Smodifw","Ualtafw","Umodifw","Saltafw","Hmodifw","Agrup","Ctiparch","Ctipreg","Timestamp","Habgcomo","Sinnodo","Bloqreg","Clasehook","Ccod","Cobs","Entafe","Cxml","Cdelimi","Cexten","Actfecexp","Cdes","Categoria","Crutasal","Carchsal","Centidad","Favorito","Lagrfh","Lseparachr","Comext","Appendarch","Parcoma","Crutabkp","Carchbkp","Lagrfhbp","Appendback" ) values ( <<"'" + this.ConvertirDateSql( lxDisexpoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisexpoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisexpoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisexpoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisexpoFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoAgrup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCtiparch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCtipreg ) + "'" >>, <<lxDisexpoTimestamp >>, <<iif( lxDisexpoHabgcomo, 1, 0 ) >>, <<iif( lxDisexpoSinnodo, 1, 0 ) >>, <<iif( lxDisexpoBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisexpoClasehook ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoEntafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCxml ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCdelimi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCexten ) + "'" >>, <<iif( lxDisexpoActfecexp, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisexpoCdes ) + "'" >>, <<lxDisexpoCategoria >>, <<"'" + this.FormatearTextoSql( lxDisexpoCrutasal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCarchsal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCentidad ) + "'" >>, <<iif( lxDisexpoFavorito, 1, 0 ) >>, <<iif( lxDisexpoLagrfh, 1, 0 ) >>, <<iif( lxDisexpoLseparachr, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisexpoComext ) + "'" >>, <<iif( lxDisexpoAppendarch, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisexpoParcoma ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCrutabkp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCarchbkp ) + "'" >>, <<iif( lxDisexpoLagrfhbp, 1, 0 ) >>, <<iif( lxDisexpoAppendback, 1, 0 ) >> )
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoArea("NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","nOrden" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<lxOrden>> ) 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxAtributo = loItem.Atributo
					lxOrden = loItem.Orden
					lxAncho = loItem.Ancho
					lxConversion_PK = loItem.Conversion_PK
					lxFormato_PK = loItem.Formato_PK
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoAtri("NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxOrden>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxFormato_PK ) + "'">> ) 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoEnt("NROITEM","SINNODO","BLOQREG","iCod","iEnt" ) values ( <<lxNroitem>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDisexpoTimestamp
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
			local  lxDisexpoFecimpo, lxDisexpoFectrans, lxDisexpoFmodifw, lxDisexpoFaltafw, lxDisexpoFecexpo, lxDisexpoHaltafw, lxDisexpoHoraexpo, lxDisexpoBdmodifw, lxDisexpoVmodifw, lxDisexpoEsttrans, lxDisexpoHoraimpo, lxDisexpoValtafw, lxDisexpoZadsfw, lxDisexpoBdaltafw, lxDisexpoSmodifw, lxDisexpoUaltafw, lxDisexpoUmodifw, lxDisexpoSaltafw, lxDisexpoHmodifw, lxDisexpoAgrup, lxDisexpoCtiparch, lxDisexpoCtipreg, lxDisexpoTimestamp, lxDisexpoHabgcomo, lxDisexpoSinnodo, lxDisexpoBloqreg, lxDisexpoClasehook, lxDisexpoCcod, lxDisexpoCobs, lxDisexpoEntafe, lxDisexpoCxml, lxDisexpoCdelimi, lxDisexpoCexten, lxDisexpoActfecexp, lxDisexpoCdes, lxDisexpoCategoria, lxDisexpoCrutasal, lxDisexpoCarchsal, lxDisexpoCentidad, lxDisexpoFavorito, lxDisexpoLagrfh, lxDisexpoLseparachr, lxDisexpoComext, lxDisexpoAppendarch, lxDisexpoParcoma, lxDisexpoCrutabkp, lxDisexpoCarchbkp, lxDisexpoLagrfhbp, lxDisexpoAppendback
				lxDisexpoFecimpo =  .Fechaimpo			lxDisexpoFectrans =  .Fechatransferencia			lxDisexpoFmodifw =  .Fechamodificacionfw			lxDisexpoFaltafw =  .Fechaaltafw			lxDisexpoFecexpo =  .Fechaexpo			lxDisexpoHaltafw =  .Horaaltafw			lxDisexpoHoraexpo =  .Horaexpo			lxDisexpoBdmodifw =  .Basededatosmodificacionfw			lxDisexpoVmodifw =  .Versionmodificacionfw			lxDisexpoEsttrans =  .Estadotransferencia			lxDisexpoHoraimpo =  .Horaimpo			lxDisexpoValtafw =  .Versionaltafw			lxDisexpoZadsfw =  .Zadsfw			lxDisexpoBdaltafw =  .Basededatosaltafw			lxDisexpoSmodifw =  .Seriemodificacionfw			lxDisexpoUaltafw =  .Usuarioaltafw			lxDisexpoUmodifw =  .Usuariomodificacionfw			lxDisexpoSaltafw =  .Seriealtafw			lxDisexpoHmodifw =  .Horamodificacionfw			lxDisexpoAgrup =  .Agrupamiento			lxDisexpoCtiparch =  upper( .TipoArchivo_PK ) 			lxDisexpoCtipreg =  upper( .TipoRegistro_PK ) 			lxDisexpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisexpoHabgcomo =  .Habilitarguardarcomocondicionado			lxDisexpoSinnodo =  .Ocultarnodoexpo			lxDisexpoBloqreg =  .Bloquearregistro			lxDisexpoClasehook =  .Clasehook			lxDisexpoCcod =  .Codigo			lxDisexpoCobs =  .Obs			lxDisexpoEntafe =  .Entafectadas			lxDisexpoCxml =  .Xmlconfig			lxDisexpoCdelimi =  .Delimitadores			lxDisexpoCexten =  .Extension			lxDisexpoActfecexp =  .Actualizarfechaexportacion			lxDisexpoCdes =  .Descripcion			lxDisexpoCategoria =  .Categoria			lxDisexpoCrutasal =  .Rutasalida			lxDisexpoCarchsal =  .Archivosalida			lxDisexpoCentidad =  .Entidad			lxDisexpoFavorito =  .Favorito			lxDisexpoLagrfh =  .Agregarfh			lxDisexpoLseparachr =  .Separacionporcaracter			lxDisexpoComext =  .Comandoexterno			lxDisexpoAppendarch =  .Appendarchivo			lxDisexpoParcoma =  .Parametroscomando			lxDisexpoCrutabkp =  .Rutabackup			lxDisexpoCarchbkp =  .Archivobackup			lxDisexpoLagrfhbp =  .Agregarfhbk			lxDisexpoAppendback =  .Appendbackup
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
				update ORGANIZACION.DISEXPO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDisexpoFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxDisexpoFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxDisexpoFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxDisexpoFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxDisexpoFecexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxDisexpoHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxDisexpoHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoBdmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoVmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxDisexpoEsttrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxDisexpoHoraimpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxDisexpoValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxDisexpoZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDisexpoBdaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxDisexpoUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxDisexpoSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoHmodifw ) + "'">>,"Agrup" = <<"'" + this.FormatearTextoSql( lxDisexpoAgrup ) + "'">>,"Ctiparch" = <<"'" + this.FormatearTextoSql( lxDisexpoCtiparch ) + "'">>,"Ctipreg" = <<"'" + this.FormatearTextoSql( lxDisexpoCtipreg ) + "'">>,"Timestamp" = <<lxDisexpoTimestamp>>,"Habgcomo" = <<iif( lxDisexpoHabgcomo, 1, 0 )>>,"Sinnodo" = <<iif( lxDisexpoSinnodo, 1, 0 )>>,"Bloqreg" = <<iif( lxDisexpoBloqreg, 1, 0 )>>,"Clasehook" = <<"'" + this.FormatearTextoSql( lxDisexpoClasehook ) + "'">>,"Ccod" = <<"'" + this.FormatearTextoSql( lxDisexpoCcod ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxDisexpoCobs ) + "'">>,"Entafe" = <<"'" + this.FormatearTextoSql( lxDisexpoEntafe ) + "'">>,"Cxml" = <<"'" + this.FormatearTextoSql( lxDisexpoCxml ) + "'">>,"Cdelimi" = <<"'" + this.FormatearTextoSql( lxDisexpoCdelimi ) + "'">>,"Cexten" = <<"'" + this.FormatearTextoSql( lxDisexpoCexten ) + "'">>,"Actfecexp" = <<iif( lxDisexpoActfecexp, 1, 0 )>>,"Cdes" = <<"'" + this.FormatearTextoSql( lxDisexpoCdes ) + "'">>,"Categoria" = <<lxDisexpoCategoria>>,"Crutasal" = <<"'" + this.FormatearTextoSql( lxDisexpoCrutasal ) + "'">>,"Carchsal" = <<"'" + this.FormatearTextoSql( lxDisexpoCarchsal ) + "'">>,"Centidad" = <<"'" + this.FormatearTextoSql( lxDisexpoCentidad ) + "'">>,"Favorito" = <<iif( lxDisexpoFavorito, 1, 0 )>>,"Lagrfh" = <<iif( lxDisexpoLagrfh, 1, 0 )>>,"Lseparachr" = <<iif( lxDisexpoLseparachr, 1, 0 )>>,"Comext" = <<"'" + this.FormatearTextoSql( lxDisexpoComext ) + "'">>,"Appendarch" = <<iif( lxDisexpoAppendarch, 1, 0 )>>,"Parcoma" = <<"'" + this.FormatearTextoSql( lxDisexpoParcoma ) + "'">>,"Crutabkp" = <<"'" + this.FormatearTextoSql( lxDisexpoCrutabkp ) + "'">>,"Carchbkp" = <<"'" + this.FormatearTextoSql( lxDisexpoCarchbkp ) + "'">>,"Lagrfhbp" = <<iif( lxDisexpoLagrfhbp, 1, 0 )>>,"Appendback" = <<iif( lxDisexpoAppendback, 1, 0 )>> where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisexpoCcod ) + "'">> and  DISEXPO.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisExpoArea where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisExpoAtri where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisExpoEnt where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoArea("NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","nOrden" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<lxOrden>> ) 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxAtributo = loItem.Atributo
					lxOrden = loItem.Orden
					lxAncho = loItem.Ancho
					lxConversion_PK = loItem.Conversion_PK
					lxFormato_PK = loItem.Formato_PK
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoAtri("NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxOrden>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxFormato_PK ) + "'">> ) 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoEnt("NROITEM","SINNODO","BLOQREG","iCod","iEnt" ) values ( <<lxNroitem>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDisexpoTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ORGANIZACION.DISEXPO where " + this.ConvertirFuncionesSql( " DISEXPO.CCOD != ''" ) )
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
			Local lxDisexpoCcod
			lxDisexpoCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Agrup" as "Agrupamiento", "Ctiparch" as "Tipoarchivo", "Ctipreg" as "Tiporegistro", "Timestamp" as "Timestamp", "Habgcomo" as "Habilitarguardarcomocondicionado", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Ccod" as "Codigo", "Cobs" as "Obs", "Entafe" as "Entafectadas", "Cxml" as "Xmlconfig", "Cdelimi" as "Delimitadores", "Cexten" as "Extension", "Actfecexp" as "Actualizarfechaexportacion", "Cdes" as "Descripcion", "Categoria" as "Categoria", "Crutasal" as "Rutasalida", "Carchsal" as "Archivosalida", "Centidad" as "Entidad", "Favorito" as "Favorito", "Lagrfh" as "Agregarfh", "Lseparachr" as "Separacionporcaracter", "Comext" as "Comandoexterno", "Appendarch" as "Appendarchivo", "Parcoma" as "Parametroscomando", "Crutabkp" as "Rutabackup", "Carchbkp" as "Archivobackup", "Lagrfhbp" as "Agregarfhbk", "Appendback" as "Appendbackup" from ORGANIZACION.DISEXPO where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisexpoCcod ) + "'">> and  DISEXPO.CCOD != ''
			endtext
			use in select('c_DISENOEXPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOEXPO', set( 'Datasession' ) )

			if reccount( 'c_DISENOEXPO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden" from ORGANIZACION.DisExpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato" from ORGANIZACION.DisExpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ORGANIZACION.DisExpoEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxDisexpoCcod as Variant
		llRetorno = .t.
		lxDisexpoCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.DISEXPO where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisexpoCcod ) + "'">> and  DISEXPO.CCOD != ''
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
				lcOrden =  .Descripcion + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Agrup" as "Agrupamiento", "Ctiparch" as "Tipoarchivo", "Ctipreg" as "Tiporegistro", "Timestamp" as "Timestamp", "Habgcomo" as "Habilitarguardarcomocondicionado", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Ccod" as "Codigo", "Cobs" as "Obs", "Entafe" as "Entafectadas", "Cxml" as "Xmlconfig", "Cdelimi" as "Delimitadores", "Cexten" as "Extension", "Actfecexp" as "Actualizarfechaexportacion", "Cdes" as "Descripcion", "Categoria" as "Categoria", "Crutasal" as "Rutasalida", "Carchsal" as "Archivosalida", "Centidad" as "Entidad", "Favorito" as "Favorito", "Lagrfh" as "Agregarfh", "Lseparachr" as "Separacionporcaracter", "Comext" as "Comandoexterno", "Appendarch" as "Appendarchivo", "Parcoma" as "Parametroscomando", "Crutabkp" as "Rutabackup", "Carchbkp" as "Archivobackup", "Lagrfhbp" as "Agregarfhbk", "Appendback" as "Appendbackup" from ORGANIZACION.DISEXPO where  DISEXPO.CCOD != '' order by cDes,cCod
			endtext
			use in select('c_DISENOEXPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOEXPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden" from ORGANIZACION.DisExpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato" from ORGANIZACION.DisExpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ORGANIZACION.DisExpoEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
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
				lcOrden =  .Descripcion + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Agrup" as "Agrupamiento", "Ctiparch" as "Tipoarchivo", "Ctipreg" as "Tiporegistro", "Timestamp" as "Timestamp", "Habgcomo" as "Habilitarguardarcomocondicionado", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Ccod" as "Codigo", "Cobs" as "Obs", "Entafe" as "Entafectadas", "Cxml" as "Xmlconfig", "Cdelimi" as "Delimitadores", "Cexten" as "Extension", "Actfecexp" as "Actualizarfechaexportacion", "Cdes" as "Descripcion", "Categoria" as "Categoria", "Crutasal" as "Rutasalida", "Carchsal" as "Archivosalida", "Centidad" as "Entidad", "Favorito" as "Favorito", "Lagrfh" as "Agregarfh", "Lseparachr" as "Separacionporcaracter", "Comext" as "Comandoexterno", "Appendarch" as "Appendarchivo", "Parcoma" as "Parametroscomando", "Crutabkp" as "Rutabackup", "Carchbkp" as "Archivobackup", "Lagrfhbp" as "Agregarfhbk", "Appendback" as "Appendbackup" from ORGANIZACION.DISEXPO where  funciones.padr( cDes, 100, ' ' ) + funciones.padr( cCod, 40, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DISEXPO.CCOD != '' order by cDes,cCod
			endtext
			use in select('c_DISENOEXPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOEXPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden" from ORGANIZACION.DisExpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato" from ORGANIZACION.DisExpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ORGANIZACION.DisExpoEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
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
				lcOrden =  .Descripcion + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Agrup" as "Agrupamiento", "Ctiparch" as "Tipoarchivo", "Ctipreg" as "Tiporegistro", "Timestamp" as "Timestamp", "Habgcomo" as "Habilitarguardarcomocondicionado", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Ccod" as "Codigo", "Cobs" as "Obs", "Entafe" as "Entafectadas", "Cxml" as "Xmlconfig", "Cdelimi" as "Delimitadores", "Cexten" as "Extension", "Actfecexp" as "Actualizarfechaexportacion", "Cdes" as "Descripcion", "Categoria" as "Categoria", "Crutasal" as "Rutasalida", "Carchsal" as "Archivosalida", "Centidad" as "Entidad", "Favorito" as "Favorito", "Lagrfh" as "Agregarfh", "Lseparachr" as "Separacionporcaracter", "Comext" as "Comandoexterno", "Appendarch" as "Appendarchivo", "Parcoma" as "Parametroscomando", "Crutabkp" as "Rutabackup", "Carchbkp" as "Archivobackup", "Lagrfhbp" as "Agregarfhbk", "Appendback" as "Appendbackup" from ORGANIZACION.DISEXPO where  funciones.padr( cDes, 100, ' ' ) + funciones.padr( cCod, 40, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DISEXPO.CCOD != '' order by cDes desc,cCod desc
			endtext
			use in select('c_DISENOEXPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOEXPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden" from ORGANIZACION.DisExpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato" from ORGANIZACION.DisExpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ORGANIZACION.DisExpoEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
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
				lcOrden =  .Descripcion + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Agrup" as "Agrupamiento", "Ctiparch" as "Tipoarchivo", "Ctipreg" as "Tiporegistro", "Timestamp" as "Timestamp", "Habgcomo" as "Habilitarguardarcomocondicionado", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Ccod" as "Codigo", "Cobs" as "Obs", "Entafe" as "Entafectadas", "Cxml" as "Xmlconfig", "Cdelimi" as "Delimitadores", "Cexten" as "Extension", "Actfecexp" as "Actualizarfechaexportacion", "Cdes" as "Descripcion", "Categoria" as "Categoria", "Crutasal" as "Rutasalida", "Carchsal" as "Archivosalida", "Centidad" as "Entidad", "Favorito" as "Favorito", "Lagrfh" as "Agregarfh", "Lseparachr" as "Separacionporcaracter", "Comext" as "Comandoexterno", "Appendarch" as "Appendarchivo", "Parcoma" as "Parametroscomando", "Crutabkp" as "Rutabackup", "Carchbkp" as "Archivobackup", "Lagrfhbp" as "Agregarfhbk", "Appendback" as "Appendbackup" from ORGANIZACION.DISEXPO where  DISEXPO.CCOD != '' order by cDes desc,cCod desc
			endtext
			use in select('c_DISENOEXPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOEXPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden" from ORGANIZACION.DisExpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato" from ORGANIZACION.DisExpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ORGANIZACION.DisExpoEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOEXPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Haltafw,Horaexpo,Bdmodifw,Vmodifw,Esttrans,Horaimpo" + ;
",Valtafw,Zadsfw,Bdaltafw,Smodifw,Ualtafw,Umodifw,Saltafw,Hmodifw,Agrup,Ctiparch,Ctipreg,Timestamp,Ha" + ;
"bgcomo,Sinnodo,Bloqreg,Clasehook,Ccod,Cobs,Entafe,Cxml,Cdelimi,Cexten,Actfecexp,Cdes,Categoria,Cruta" + ;
"sal,Carchsal,Centidad,Favorito,Lagrfh,Lseparachr,Comext,Appendarch,Parcoma,Crutabkp,Carchbkp,Lagrfhb" + ;
"p,Appendback" + ;
" from ORGANIZACION.DISEXPO where  DISEXPO.CCOD != '' and " + lcFiltro )
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
			local  lxDisexpoFecimpo, lxDisexpoFectrans, lxDisexpoFmodifw, lxDisexpoFaltafw, lxDisexpoFecexpo, lxDisexpoHaltafw, lxDisexpoHoraexpo, lxDisexpoBdmodifw, lxDisexpoVmodifw, lxDisexpoEsttrans, lxDisexpoHoraimpo, lxDisexpoValtafw, lxDisexpoZadsfw, lxDisexpoBdaltafw, lxDisexpoSmodifw, lxDisexpoUaltafw, lxDisexpoUmodifw, lxDisexpoSaltafw, lxDisexpoHmodifw, lxDisexpoAgrup, lxDisexpoCtiparch, lxDisexpoCtipreg, lxDisexpoTimestamp, lxDisexpoHabgcomo, lxDisexpoSinnodo, lxDisexpoBloqreg, lxDisexpoClasehook, lxDisexpoCcod, lxDisexpoCobs, lxDisexpoEntafe, lxDisexpoCxml, lxDisexpoCdelimi, lxDisexpoCexten, lxDisexpoActfecexp, lxDisexpoCdes, lxDisexpoCategoria, lxDisexpoCrutasal, lxDisexpoCarchsal, lxDisexpoCentidad, lxDisexpoFavorito, lxDisexpoLagrfh, lxDisexpoLseparachr, lxDisexpoComext, lxDisexpoAppendarch, lxDisexpoParcoma, lxDisexpoCrutabkp, lxDisexpoCarchbkp, lxDisexpoLagrfhbp, lxDisexpoAppendback
				lxDisexpoFecimpo = ctod( '  /  /    ' )			lxDisexpoFectrans = ctod( '  /  /    ' )			lxDisexpoFmodifw = ctod( '  /  /    ' )			lxDisexpoFaltafw = ctod( '  /  /    ' )			lxDisexpoFecexpo = ctod( '  /  /    ' )			lxDisexpoHaltafw = []			lxDisexpoHoraexpo = []			lxDisexpoBdmodifw = []			lxDisexpoVmodifw = []			lxDisexpoEsttrans = []			lxDisexpoHoraimpo = []			lxDisexpoValtafw = []			lxDisexpoZadsfw = []			lxDisexpoBdaltafw = []			lxDisexpoSmodifw = []			lxDisexpoUaltafw = []			lxDisexpoUmodifw = []			lxDisexpoSaltafw = []			lxDisexpoHmodifw = []			lxDisexpoAgrup = []			lxDisexpoCtiparch = []			lxDisexpoCtipreg = []			lxDisexpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisexpoHabgcomo = .F.			lxDisexpoSinnodo = .F.			lxDisexpoBloqreg = .F.			lxDisexpoClasehook = []			lxDisexpoCcod = []			lxDisexpoCobs = []			lxDisexpoEntafe = []			lxDisexpoCxml = []			lxDisexpoCdelimi = []			lxDisexpoCexten = []			lxDisexpoActfecexp = .F.			lxDisexpoCdes = []			lxDisexpoCategoria = 0			lxDisexpoCrutasal = []			lxDisexpoCarchsal = []			lxDisexpoCentidad = []			lxDisexpoFavorito = .F.			lxDisexpoLagrfh = .F.			lxDisexpoLseparachr = .F.			lxDisexpoComext = []			lxDisexpoAppendarch = .F.			lxDisexpoParcoma = []			lxDisexpoCrutabkp = []			lxDisexpoCarchbkp = []			lxDisexpoLagrfhbp = .F.			lxDisexpoAppendback = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisExpoArea where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisExpoAtri where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisExpoEnt where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.DISEXPO where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'DISEXPO' + '_' + tcCampo
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
		lcWhere = " Where  DISEXPO.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Agrup" as "Agrupamiento", "Ctiparch" as "Tipoarchivo", "Ctipreg" as "Tiporegistro", "Timestamp" as "Timestamp", "Habgcomo" as "Habilitarguardarcomocondicionado", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Ccod" as "Codigo", "Cobs" as "Obs", "Entafe" as "Entafectadas", "Cxml" as "Xmlconfig", "Cdelimi" as "Delimitadores", "Cexten" as "Extension", "Actfecexp" as "Actualizarfechaexportacion", "Cdes" as "Descripcion", "Categoria" as "Categoria", "Crutasal" as "Rutasalida", "Carchsal" as "Archivosalida", "Centidad" as "Entidad", "Favorito" as "Favorito", "Lagrfh" as "Agregarfh", "Lseparachr" as "Separacionporcaracter", "Comext" as "Comandoexterno", "Appendarch" as "Appendarchivo", "Parcoma" as "Parametroscomando", "Crutabkp" as "Rutabackup", "Carchbkp" as "Archivobackup", "Lagrfhbp" as "Agregarfhbk", "Appendback" as "Appendbackup"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DISEXPO', '', tnTope )
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
		lcWhere = " Where  DISEXPOAREA.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAreas( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisExpoArea', 'Areas', tnTope )
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
		lcWhere = " Where  DISEXPOATRI.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Sinnodo" as "Ocultarnodoexpo", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAtributos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisExpoAtri', 'Atributos', tnTope )
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
	Function ObtenerDatosDetalleEntidades( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DISEXPOENT.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleEntidades( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisExpoEnt', 'Entidades', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'TIPOARCHIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPARCH AS TIPOARCHIVO'
				Case lcAtributo == 'TIPOREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPREG AS TIPOREGISTRO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HABILITARGUARDARCOMOCONDICIONADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HABGCOMO AS HABILITARGUARDARCOMOCONDICIONADO'
				Case lcAtributo == 'OCULTARNODOEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SINNODO AS OCULTARNODOEXPO'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CLASEHOOK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASEHOOK AS CLASEHOOK'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBS'
				Case lcAtributo == 'ENTAFECTADAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTAFE AS ENTAFECTADAS'
				Case lcAtributo == 'XMLCONFIG'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CXML AS XMLCONFIG'
				Case lcAtributo == 'DELIMITADORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDELIMI AS DELIMITADORES'
				Case lcAtributo == 'EXTENSION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CEXTEN AS EXTENSION'
				Case lcAtributo == 'ACTUALIZARFECHAEXPORTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACTFECEXP AS ACTUALIZARFECHAEXPORTACION'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDES AS DESCRIPCION'
				Case lcAtributo == 'CATEGORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATEGORIA AS CATEGORIA'
				Case lcAtributo == 'RUTASALIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRUTASAL AS RUTASALIDA'
				Case lcAtributo == 'ARCHIVOSALIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CARCHSAL AS ARCHIVOSALIDA'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTIDAD AS ENTIDAD'
				Case lcAtributo == 'FAVORITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAVORITO AS FAVORITO'
				Case lcAtributo == 'AGREGARFH'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LAGRFH AS AGREGARFH'
				Case lcAtributo == 'SEPARACIONPORCARACTER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LSEPARACHR AS SEPARACIONPORCARACTER'
				Case lcAtributo == 'COMANDOEXTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMEXT AS COMANDOEXTERNO'
				Case lcAtributo == 'APPENDARCHIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APPENDARCH AS APPENDARCHIVO'
				Case lcAtributo == 'PARAMETROSCOMANDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PARCOMA AS PARAMETROSCOMANDO'
				Case lcAtributo == 'RUTABACKUP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRUTABKP AS RUTABACKUP'
				Case lcAtributo == 'ARCHIVOBACKUP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CARCHBKP AS ARCHIVOBACKUP'
				Case lcAtributo == 'AGREGARFHBK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LAGRFHBP AS AGREGARFHBK'
				Case lcAtributo == 'APPENDBACKUP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APPENDBACK AS APPENDBACKUP'
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
				Case lcAtributo == 'OCULTARNODOEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SINNODO AS OCULTARNODOEXPO'
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
				Case lcAtributo == 'OCULTARNODOEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SINNODO AS OCULTARNODOEXPO'
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
				Case lcAtributo == 'OCULTARNODOEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SINNODO AS OCULTARNODOEXPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOARCHIVO'
				lcCampo = 'CTIPARCH'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOREGISTRO'
				lcCampo = 'CTIPREG'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITARGUARDARCOMOCONDICIONADO'
				lcCampo = 'HABGCOMO'
			Case upper( alltrim( tcAtributo ) ) == 'OCULTARNODOEXPO'
				lcCampo = 'SINNODO'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CLASEHOOK'
				lcCampo = 'CLASEHOOK'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'ENTAFECTADAS'
				lcCampo = 'ENTAFE'
			Case upper( alltrim( tcAtributo ) ) == 'XMLCONFIG'
				lcCampo = 'CXML'
			Case upper( alltrim( tcAtributo ) ) == 'DELIMITADORES'
				lcCampo = 'CDELIMI'
			Case upper( alltrim( tcAtributo ) ) == 'EXTENSION'
				lcCampo = 'CEXTEN'
			Case upper( alltrim( tcAtributo ) ) == 'ACTUALIZARFECHAEXPORTACION'
				lcCampo = 'ACTFECEXP'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CDES'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIA'
				lcCampo = 'CATEGORIA'
			Case upper( alltrim( tcAtributo ) ) == 'RUTASALIDA'
				lcCampo = 'CRUTASAL'
			Case upper( alltrim( tcAtributo ) ) == 'ARCHIVOSALIDA'
				lcCampo = 'CARCHSAL'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'CENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'FAVORITO'
				lcCampo = 'FAVORITO'
			Case upper( alltrim( tcAtributo ) ) == 'AGREGARFH'
				lcCampo = 'LAGRFH'
			Case upper( alltrim( tcAtributo ) ) == 'SEPARACIONPORCARACTER'
				lcCampo = 'LSEPARACHR'
			Case upper( alltrim( tcAtributo ) ) == 'COMANDOEXTERNO'
				lcCampo = 'COMEXT'
			Case upper( alltrim( tcAtributo ) ) == 'APPENDARCHIVO'
				lcCampo = 'APPENDARCH'
			Case upper( alltrim( tcAtributo ) ) == 'PARAMETROSCOMANDO'
				lcCampo = 'PARCOMA'
			Case upper( alltrim( tcAtributo ) ) == 'RUTABACKUP'
				lcCampo = 'CRUTABKP'
			Case upper( alltrim( tcAtributo ) ) == 'ARCHIVOBACKUP'
				lcCampo = 'CARCHBKP'
			Case upper( alltrim( tcAtributo ) ) == 'AGREGARFHBK'
				lcCampo = 'LAGRFHBP'
			Case upper( alltrim( tcAtributo ) ) == 'APPENDBACKUP'
				lcCampo = 'APPENDBACK'
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
			Case upper( alltrim( tcAtributo ) ) == 'OCULTARNODOEXPO'
				lcCampo = 'SINNODO'
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
			Case upper( alltrim( tcAtributo ) ) == 'OCULTARNODOEXPO'
				lcCampo = 'SINNODO'
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
			Case upper( alltrim( tcAtributo ) ) == 'OCULTARNODOEXPO'
				lcCampo = 'SINNODO'
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
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AREAS'
			lcRetorno = 'DISEXPOAREA'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ATRIBUTOS'
			lcRetorno = 'DISEXPOATRI'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ENTIDADES'
			lcRetorno = 'DISEXPOENT'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDisexpoFecimpo, lxDisexpoFectrans, lxDisexpoFmodifw, lxDisexpoFaltafw, lxDisexpoFecexpo, lxDisexpoHaltafw, lxDisexpoHoraexpo, lxDisexpoBdmodifw, lxDisexpoVmodifw, lxDisexpoEsttrans, lxDisexpoHoraimpo, lxDisexpoValtafw, lxDisexpoZadsfw, lxDisexpoBdaltafw, lxDisexpoSmodifw, lxDisexpoUaltafw, lxDisexpoUmodifw, lxDisexpoSaltafw, lxDisexpoHmodifw, lxDisexpoAgrup, lxDisexpoCtiparch, lxDisexpoCtipreg, lxDisexpoTimestamp, lxDisexpoHabgcomo, lxDisexpoSinnodo, lxDisexpoBloqreg, lxDisexpoClasehook, lxDisexpoCcod, lxDisexpoCobs, lxDisexpoEntafe, lxDisexpoCxml, lxDisexpoCdelimi, lxDisexpoCexten, lxDisexpoActfecexp, lxDisexpoCdes, lxDisexpoCategoria, lxDisexpoCrutasal, lxDisexpoCarchsal, lxDisexpoCentidad, lxDisexpoFavorito, lxDisexpoLagrfh, lxDisexpoLseparachr, lxDisexpoComext, lxDisexpoAppendarch, lxDisexpoParcoma, lxDisexpoCrutabkp, lxDisexpoCarchbkp, lxDisexpoLagrfhbp, lxDisexpoAppendback
				lxDisexpoFecimpo =  .Fechaimpo			lxDisexpoFectrans =  .Fechatransferencia			lxDisexpoFmodifw =  .Fechamodificacionfw			lxDisexpoFaltafw =  .Fechaaltafw			lxDisexpoFecexpo =  .Fechaexpo			lxDisexpoHaltafw =  .Horaaltafw			lxDisexpoHoraexpo =  .Horaexpo			lxDisexpoBdmodifw =  .Basededatosmodificacionfw			lxDisexpoVmodifw =  .Versionmodificacionfw			lxDisexpoEsttrans =  .Estadotransferencia			lxDisexpoHoraimpo =  .Horaimpo			lxDisexpoValtafw =  .Versionaltafw			lxDisexpoZadsfw =  .Zadsfw			lxDisexpoBdaltafw =  .Basededatosaltafw			lxDisexpoSmodifw =  .Seriemodificacionfw			lxDisexpoUaltafw =  .Usuarioaltafw			lxDisexpoUmodifw =  .Usuariomodificacionfw			lxDisexpoSaltafw =  .Seriealtafw			lxDisexpoHmodifw =  .Horamodificacionfw			lxDisexpoAgrup =  .Agrupamiento			lxDisexpoCtiparch =  upper( .TipoArchivo_PK ) 			lxDisexpoCtipreg =  upper( .TipoRegistro_PK ) 			lxDisexpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisexpoHabgcomo =  .Habilitarguardarcomocondicionado			lxDisexpoSinnodo =  .Ocultarnodoexpo			lxDisexpoBloqreg =  .Bloquearregistro			lxDisexpoClasehook =  .Clasehook			lxDisexpoCcod =  .Codigo			lxDisexpoCobs =  .Obs			lxDisexpoEntafe =  .Entafectadas			lxDisexpoCxml =  .Xmlconfig			lxDisexpoCdelimi =  .Delimitadores			lxDisexpoCexten =  .Extension			lxDisexpoActfecexp =  .Actualizarfechaexportacion			lxDisexpoCdes =  .Descripcion			lxDisexpoCategoria =  .Categoria			lxDisexpoCrutasal =  .Rutasalida			lxDisexpoCarchsal =  .Archivosalida			lxDisexpoCentidad =  .Entidad			lxDisexpoFavorito =  .Favorito			lxDisexpoLagrfh =  .Agregarfh			lxDisexpoLseparachr =  .Separacionporcaracter			lxDisexpoComext =  .Comandoexterno			lxDisexpoAppendarch =  .Appendarchivo			lxDisexpoParcoma =  .Parametroscomando			lxDisexpoCrutabkp =  .Rutabackup			lxDisexpoCarchbkp =  .Archivobackup			lxDisexpoLagrfhbp =  .Agregarfhbk			lxDisexpoAppendback =  .Appendbackup
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.DISEXPO ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Haltafw","Horaexpo","Bdmodifw","Vmodifw","Esttrans","Horaimpo","Valtafw","Zadsfw","Bdaltafw","Smodifw","Ualtafw","Umodifw","Saltafw","Hmodifw","Agrup","Ctiparch","Ctipreg","Timestamp","Habgcomo","Sinnodo","Bloqreg","Clasehook","Ccod","Cobs","Entafe","Cxml","Cdelimi","Cexten","Actfecexp","Cdes","Categoria","Crutasal","Carchsal","Centidad","Favorito","Lagrfh","Lseparachr","Comext","Appendarch","Parcoma","Crutabkp","Carchbkp","Lagrfhbp","Appendback" ) values ( <<"'" + this.ConvertirDateSql( lxDisexpoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisexpoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisexpoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisexpoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisexpoFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoAgrup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCtiparch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCtipreg ) + "'" >>, <<lxDisexpoTimestamp >>, <<iif( lxDisexpoHabgcomo, 1, 0 ) >>, <<iif( lxDisexpoSinnodo, 1, 0 ) >>, <<iif( lxDisexpoBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisexpoClasehook ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoEntafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCxml ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCdelimi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCexten ) + "'" >>, <<iif( lxDisexpoActfecexp, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisexpoCdes ) + "'" >>, <<lxDisexpoCategoria >>, <<"'" + this.FormatearTextoSql( lxDisexpoCrutasal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCarchsal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCentidad ) + "'" >>, <<iif( lxDisexpoFavorito, 1, 0 ) >>, <<iif( lxDisexpoLagrfh, 1, 0 ) >>, <<iif( lxDisexpoLseparachr, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisexpoComext ) + "'" >>, <<iif( lxDisexpoAppendarch, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisexpoParcoma ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCrutabkp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisexpoCarchbkp ) + "'" >>, <<iif( lxDisexpoLagrfhbp, 1, 0 ) >>, <<iif( lxDisexpoAppendback, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'DISEXPO' 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoArea("NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","nOrden" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<lxOrden>> ) 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxAtributo = loItem.Atributo
					lxOrden = loItem.Orden
					lxAncho = loItem.Ancho
					lxConversion_PK = loItem.Conversion_PK
					lxFormato_PK = loItem.Formato_PK
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoAtri("NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxOrden>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxFormato_PK ) + "'">> ) 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoEnt("NROITEM","SINNODO","BLOQREG","iCod","iEnt" ) values ( <<lxNroitem>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
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
			local  lxDisexpoFecimpo, lxDisexpoFectrans, lxDisexpoFmodifw, lxDisexpoFaltafw, lxDisexpoFecexpo, lxDisexpoHaltafw, lxDisexpoHoraexpo, lxDisexpoBdmodifw, lxDisexpoVmodifw, lxDisexpoEsttrans, lxDisexpoHoraimpo, lxDisexpoValtafw, lxDisexpoZadsfw, lxDisexpoBdaltafw, lxDisexpoSmodifw, lxDisexpoUaltafw, lxDisexpoUmodifw, lxDisexpoSaltafw, lxDisexpoHmodifw, lxDisexpoAgrup, lxDisexpoCtiparch, lxDisexpoCtipreg, lxDisexpoTimestamp, lxDisexpoHabgcomo, lxDisexpoSinnodo, lxDisexpoBloqreg, lxDisexpoClasehook, lxDisexpoCcod, lxDisexpoCobs, lxDisexpoEntafe, lxDisexpoCxml, lxDisexpoCdelimi, lxDisexpoCexten, lxDisexpoActfecexp, lxDisexpoCdes, lxDisexpoCategoria, lxDisexpoCrutasal, lxDisexpoCarchsal, lxDisexpoCentidad, lxDisexpoFavorito, lxDisexpoLagrfh, lxDisexpoLseparachr, lxDisexpoComext, lxDisexpoAppendarch, lxDisexpoParcoma, lxDisexpoCrutabkp, lxDisexpoCarchbkp, lxDisexpoLagrfhbp, lxDisexpoAppendback
				lxDisexpoFecimpo =  .Fechaimpo			lxDisexpoFectrans =  .Fechatransferencia			lxDisexpoFmodifw =  .Fechamodificacionfw			lxDisexpoFaltafw =  .Fechaaltafw			lxDisexpoFecexpo =  .Fechaexpo			lxDisexpoHaltafw =  .Horaaltafw			lxDisexpoHoraexpo =  .Horaexpo			lxDisexpoBdmodifw =  .Basededatosmodificacionfw			lxDisexpoVmodifw =  .Versionmodificacionfw			lxDisexpoEsttrans =  .Estadotransferencia			lxDisexpoHoraimpo =  .Horaimpo			lxDisexpoValtafw =  .Versionaltafw			lxDisexpoZadsfw =  .Zadsfw			lxDisexpoBdaltafw =  .Basededatosaltafw			lxDisexpoSmodifw =  .Seriemodificacionfw			lxDisexpoUaltafw =  .Usuarioaltafw			lxDisexpoUmodifw =  .Usuariomodificacionfw			lxDisexpoSaltafw =  .Seriealtafw			lxDisexpoHmodifw =  .Horamodificacionfw			lxDisexpoAgrup =  .Agrupamiento			lxDisexpoCtiparch =  upper( .TipoArchivo_PK ) 			lxDisexpoCtipreg =  upper( .TipoRegistro_PK ) 			lxDisexpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisexpoHabgcomo =  .Habilitarguardarcomocondicionado			lxDisexpoSinnodo =  .Ocultarnodoexpo			lxDisexpoBloqreg =  .Bloquearregistro			lxDisexpoClasehook =  .Clasehook			lxDisexpoCcod =  .Codigo			lxDisexpoCobs =  .Obs			lxDisexpoEntafe =  .Entafectadas			lxDisexpoCxml =  .Xmlconfig			lxDisexpoCdelimi =  .Delimitadores			lxDisexpoCexten =  .Extension			lxDisexpoActfecexp =  .Actualizarfechaexportacion			lxDisexpoCdes =  .Descripcion			lxDisexpoCategoria =  .Categoria			lxDisexpoCrutasal =  .Rutasalida			lxDisexpoCarchsal =  .Archivosalida			lxDisexpoCentidad =  .Entidad			lxDisexpoFavorito =  .Favorito			lxDisexpoLagrfh =  .Agregarfh			lxDisexpoLseparachr =  .Separacionporcaracter			lxDisexpoComext =  .Comandoexterno			lxDisexpoAppendarch =  .Appendarchivo			lxDisexpoParcoma =  .Parametroscomando			lxDisexpoCrutabkp =  .Rutabackup			lxDisexpoCarchbkp =  .Archivobackup			lxDisexpoLagrfhbp =  .Agregarfhbk			lxDisexpoAppendback =  .Appendbackup
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  DISEXPO.CCOD != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.DISEXPO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDisexpoFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxDisexpoFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDisexpoFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxDisexpoFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDisexpoFecexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxDisexpoHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxDisexpoHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoBdmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoVmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxDisexpoEsttrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxDisexpoHoraimpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxDisexpoValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxDisexpoZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDisexpoBdaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxDisexpoUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxDisexpoSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxDisexpoHmodifw ) + "'">>, "Agrup" = <<"'" + this.FormatearTextoSql( lxDisexpoAgrup ) + "'">>, "Ctiparch" = <<"'" + this.FormatearTextoSql( lxDisexpoCtiparch ) + "'">>, "Ctipreg" = <<"'" + this.FormatearTextoSql( lxDisexpoCtipreg ) + "'">>, "Timestamp" = <<lxDisexpoTimestamp>>, "Habgcomo" = <<iif( lxDisexpoHabgcomo, 1, 0 )>>, "Sinnodo" = <<iif( lxDisexpoSinnodo, 1, 0 )>>, "Bloqreg" = <<iif( lxDisexpoBloqreg, 1, 0 )>>, "Clasehook" = <<"'" + this.FormatearTextoSql( lxDisexpoClasehook ) + "'">>, "Ccod" = <<"'" + this.FormatearTextoSql( lxDisexpoCcod ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxDisexpoCobs ) + "'">>, "Entafe" = <<"'" + this.FormatearTextoSql( lxDisexpoEntafe ) + "'">>, "Cxml" = <<"'" + this.FormatearTextoSql( lxDisexpoCxml ) + "'">>, "Cdelimi" = <<"'" + this.FormatearTextoSql( lxDisexpoCdelimi ) + "'">>, "Cexten" = <<"'" + this.FormatearTextoSql( lxDisexpoCexten ) + "'">>, "Actfecexp" = <<iif( lxDisexpoActfecexp, 1, 0 )>>, "Cdes" = <<"'" + this.FormatearTextoSql( lxDisexpoCdes ) + "'">>, "Categoria" = <<lxDisexpoCategoria>>, "Crutasal" = <<"'" + this.FormatearTextoSql( lxDisexpoCrutasal ) + "'">>, "Carchsal" = <<"'" + this.FormatearTextoSql( lxDisexpoCarchsal ) + "'">>, "Centidad" = <<"'" + this.FormatearTextoSql( lxDisexpoCentidad ) + "'">>, "Favorito" = <<iif( lxDisexpoFavorito, 1, 0 )>>, "Lagrfh" = <<iif( lxDisexpoLagrfh, 1, 0 )>>, "Lseparachr" = <<iif( lxDisexpoLseparachr, 1, 0 )>>, "Comext" = <<"'" + this.FormatearTextoSql( lxDisexpoComext ) + "'">>, "Appendarch" = <<iif( lxDisexpoAppendarch, 1, 0 )>>, "Parcoma" = <<"'" + this.FormatearTextoSql( lxDisexpoParcoma ) + "'">>, "Crutabkp" = <<"'" + this.FormatearTextoSql( lxDisexpoCrutabkp ) + "'">>, "Carchbkp" = <<"'" + this.FormatearTextoSql( lxDisexpoCarchbkp ) + "'">>, "Lagrfhbp" = <<iif( lxDisexpoLagrfhbp, 1, 0 )>>, "Appendback" = <<iif( lxDisexpoAppendback, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'DISEXPO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ORGANIZACION.DisExpoArea where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DisExpoAtri where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DisExpoEnt where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoArea("NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","nOrden" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<lxOrden>> ) 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxAtributo = loItem.Atributo
					lxOrden = loItem.Orden
					lxAncho = loItem.Ancho
					lxConversion_PK = loItem.Conversion_PK
					lxFormato_PK = loItem.Formato_PK
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoAtri("NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxOrden>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxFormato_PK ) + "'">> ) 
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
					lxOcultarnodoexpo = loItem.Ocultarnodoexpo
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisExpoEnt("NROITEM","SINNODO","BLOQREG","iCod","iEnt" ) values ( <<lxNroitem>>, <<iif( lxOcultarnodoexpo, 1, 0 )>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  DISEXPO.CCOD != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.DISEXPO where ' + lcFiltro )
			loColeccion.Agregar([delete from ORGANIZACION.DisExpoArea where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DisExpoAtri where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DisExpoEnt where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'DISEXPO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.DISEXPO where  DISEXPO.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.DISEXPO where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  DISEXPO.CCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOEXPO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.DISEXPO Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.DISEXPO set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, Agrup = ] + "'" + this.FormatearTextoSql( &lcCursor..Agrup ) + "'"+ [, cTipArch = ] + "'" + this.FormatearTextoSql( &lcCursor..cTipArch ) + "'"+ [, cTipReg = ] + "'" + this.FormatearTextoSql( &lcCursor..cTipReg ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, habgcomo = ] + Transform( iif( &lcCursor..habgcomo, 1, 0 ))+ [, SINNODO = ] + Transform( iif( &lcCursor..SINNODO, 1, 0 ))+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, clasehook = ] + "'" + this.FormatearTextoSql( &lcCursor..clasehook ) + "'"+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"+ [, EntAfe = ] + "'" + this.FormatearTextoSql( &lcCursor..EntAfe ) + "'"+ [, cXml = ] + "'" + this.FormatearTextoSql( &lcCursor..cXml ) + "'"+ [, cDelimi = ] + "'" + this.FormatearTextoSql( &lcCursor..cDelimi ) + "'"+ [, cExten = ] + "'" + this.FormatearTextoSql( &lcCursor..cExten ) + "'"+ [, ActFecExp = ] + Transform( iif( &lcCursor..ActFecExp, 1, 0 ))+ [, cDes = ] + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'"+ [, categoria = ] + transform( &lcCursor..categoria )+ [, cRutaSal = ] + "'" + this.FormatearTextoSql( &lcCursor..cRutaSal ) + "'"+ [, cArchSal = ] + "'" + this.FormatearTextoSql( &lcCursor..cArchSal ) + "'"+ [, cEntidad = ] + "'" + this.FormatearTextoSql( &lcCursor..cEntidad ) + "'"+ [, favorito = ] + Transform( iif( &lcCursor..favorito, 1, 0 ))+ [, lAgrFH = ] + Transform( iif( &lcCursor..lAgrFH, 1, 0 ))+ [, lSeparaChr = ] + Transform( iif( &lcCursor..lSeparaChr, 1, 0 ))+ [, ComExt = ] + "'" + this.FormatearTextoSql( &lcCursor..ComExt ) + "'"+ [, appendArch = ] + Transform( iif( &lcCursor..appendArch, 1, 0 ))+ [, ParComa = ] + "'" + this.FormatearTextoSql( &lcCursor..ParComa ) + "'"+ [, cRutabkp = ] + "'" + this.FormatearTextoSql( &lcCursor..cRutabkp ) + "'"+ [, cArchbkp = ] + "'" + this.FormatearTextoSql( &lcCursor..cArchbkp ) + "'"+ [, lAgrFHBP = ] + Transform( iif( &lcCursor..lAgrFHBP, 1, 0 ))+ [, appendBack = ] + Transform( iif( &lcCursor..appendBack, 1, 0 )) + [ Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, HALTAFW, HORAEXPO, BDMODIFW, VMODIFW, ESTTRANS, HORAIMPO, VALTAFW, ZADSFW, BDALTAFW, SMODIFW, UALTAFW, UMODIFW, SALTAFW, HMODIFW, Agrup, cTipArch, cTipReg, TIMESTAMP, habgcomo, SINNODO, BLOQREG, clasehook, cCod, cObs, EntAfe, cXml, cDelimi, cExten, ActFecExp, cDes, categoria, cRutaSal, cArchSal, cEntidad, favorito, lAgrFH, lSeparaChr, ComExt, appendArch, ParComa, cRutabkp, cArchbkp, lAgrFHBP, appendBack
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Agrup ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cTipArch ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cTipReg ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..habgcomo, 1, 0 )) + ',' + Transform( iif( &lcCursor..SINNODO, 1, 0 )) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..clasehook ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..EntAfe ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cXml ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDelimi ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cExten ) + "'" + ',' + Transform( iif( &lcCursor..ActFecExp, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'" + ',' + transform( &lcCursor..categoria )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cRutaSal ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cArchSal ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEntidad ) + "'" + ',' + Transform( iif( &lcCursor..favorito, 1, 0 )) + ',' + Transform( iif( &lcCursor..lAgrFH, 1, 0 )) + ',' + Transform( iif( &lcCursor..lSeparaChr, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ComExt ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..appendArch, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ParComa ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cRutabkp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cArchbkp ) + "'" + ',' + Transform( iif( &lcCursor..lAgrFHBP, 1, 0 )) + ',' + Transform( iif( &lcCursor..appendBack, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DISEXPO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOEXPO'
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
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DisExpoArea Where iCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DisExpoAtri Where iCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DisExpoEnt Where iCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAREASEXPO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","nOrden"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DisExpoArea ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.SINNODO   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cArea      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipo      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipDet    ) + "'" + ',' + transform( cDetallesExistentes.nOrden     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMATRIBUTOSEXPO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","SINNODO","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DisExpoAtri ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.SINNODO   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cArea      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipo      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cAtributo  ) + "'" + ',' + transform( cDetallesExistentes.nOrden     ) + ',' + transform( cDetallesExistentes.nLong      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cConv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cFormato   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMENTIDADESEXPO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","SINNODO","BLOQREG","iCod","iEnt"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DisExpoEnt ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.SINNODO   , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iEnt       ) + "'" + ' )'  )
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
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..cCod       )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'DISENOEXPO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOEXPO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOEXPO_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOEXPO_ENTAFE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOEXPO_CXML'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAREASEXPO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMATRIBUTOSEXPO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMENTIDADESEXPO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_DisExpo')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DISENOEXPO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DISENOEXPO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOEXPO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOEXPO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_DisExpo') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_DisExpo
Create Table ORGANIZACION.TablaTrabajo_DisExpo ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"esttrans" char( 20 )  null, 
"horaimpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"agrup" char( 40 )  null, 
"ctiparch" char( 3 )  null, 
"ctipreg" char( 3 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"habgcomo" bit  null, 
"sinnodo" bit  null, 
"bloqreg" bit  null, 
"clasehook" char( 100 )  null, 
"ccod" char( 40 )  null, 
"cobs" varchar(max)  null, 
"entafe" varchar(max)  null, 
"cxml" varchar(max)  null, 
"cdelimi" char( 40 )  null, 
"cexten" char( 3 )  null, 
"actfecexp" bit  null, 
"cdes" char( 100 )  null, 
"categoria" numeric( 2, 0 )  null, 
"crutasal" char( 254 )  null, 
"carchsal" char( 60 )  null, 
"centidad" char( 40 )  null, 
"favorito" bit  null, 
"lagrfh" bit  null, 
"lseparachr" bit  null, 
"comext" char( 254 )  null, 
"appendarch" bit  null, 
"parcoma" char( 254 )  null, 
"crutabkp" char( 254 )  null, 
"carchbkp" char( 60 )  null, 
"lagrfhbp" bit  null, 
"appendback" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_DisExpo' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_DisExpo' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOEXPO'
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('agrup','agrup')
			.AgregarMapeo('ctiparch','ctiparch')
			.AgregarMapeo('ctipreg','ctipreg')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('habgcomo','habgcomo')
			.AgregarMapeo('sinnodo','sinnodo')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('clasehook','clasehook')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('entafe','entafe')
			.AgregarMapeo('cxml','cxml')
			.AgregarMapeo('cdelimi','cdelimi')
			.AgregarMapeo('cexten','cexten')
			.AgregarMapeo('actfecexp','actfecexp')
			.AgregarMapeo('cdes','cdes')
			.AgregarMapeo('categoria','categoria')
			.AgregarMapeo('crutasal','crutasal')
			.AgregarMapeo('carchsal','carchsal')
			.AgregarMapeo('centidad','centidad')
			.AgregarMapeo('favorito','favorito')
			.AgregarMapeo('lagrfh','lagrfh')
			.AgregarMapeo('lseparachr','lseparachr')
			.AgregarMapeo('comext','comext')
			.AgregarMapeo('appendarch','appendarch')
			.AgregarMapeo('parcoma','parcoma')
			.AgregarMapeo('crutabkp','crutabkp')
			.AgregarMapeo('carchbkp','carchbkp')
			.AgregarMapeo('lagrfhbp','lagrfhbp')
			.AgregarMapeo('appendback','appendback')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_DisExpo'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.AGRUP = isnull( d.AGRUP, t.AGRUP ),t.CTIPARCH = isnull( d.CTIPARCH, t.CTIPARCH ),t.CTIPREG = isnull( d.CTIPREG, t.CTIPREG ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HABGCOMO = isnull( d.HABGCOMO, t.HABGCOMO ),t.SINNODO = isnull( d.SINNODO, t.SINNODO ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.CLASEHOOK = isnull( d.CLASEHOOK, t.CLASEHOOK ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.COBS = isnull( d.COBS, t.COBS ),t.ENTAFE = isnull( d.ENTAFE, t.ENTAFE ),t.CXML = isnull( d.CXML, t.CXML ),t.CDELIMI = isnull( d.CDELIMI, t.CDELIMI ),t.CEXTEN = isnull( d.CEXTEN, t.CEXTEN ),t.ACTFECEXP = isnull( d.ACTFECEXP, t.ACTFECEXP ),t.CDES = isnull( d.CDES, t.CDES ),t.CATEGORIA = isnull( d.CATEGORIA, t.CATEGORIA ),t.CRUTASAL = isnull( d.CRUTASAL, t.CRUTASAL ),t.CARCHSAL = isnull( d.CARCHSAL, t.CARCHSAL ),t.CENTIDAD = isnull( d.CENTIDAD, t.CENTIDAD ),t.FAVORITO = isnull( d.FAVORITO, t.FAVORITO ),t.LAGRFH = isnull( d.LAGRFH, t.LAGRFH ),t.LSEPARACHR = isnull( d.LSEPARACHR, t.LSEPARACHR ),t.COMEXT = isnull( d.COMEXT, t.COMEXT ),t.APPENDARCH = isnull( d.APPENDARCH, t.APPENDARCH ),t.PARCOMA = isnull( d.PARCOMA, t.PARCOMA ),t.CRUTABKP = isnull( d.CRUTABKP, t.CRUTABKP ),t.CARCHBKP = isnull( d.CARCHBKP, t.CARCHBKP ),t.LAGRFHBP = isnull( d.LAGRFHBP, t.LAGRFHBP ),t.APPENDBACK = isnull( d.APPENDBACK, t.APPENDBACK )
					from ORGANIZACION.DISEXPO t inner join deleted d 
							 on t.cCod = d.cCod
				-- Fin Updates
				insert into ORGANIZACION.DISEXPO(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Haltafw,Horaexpo,Bdmodifw,Vmodifw,Esttrans,Horaimpo,Valtafw,Zadsfw,Bdaltafw,Smodifw,Ualtafw,Umodifw,Saltafw,Hmodifw,Agrup,Ctiparch,Ctipreg,Timestamp,Habgcomo,Sinnodo,Bloqreg,Clasehook,Ccod,Cobs,Entafe,Cxml,Cdelimi,Cexten,Actfecexp,Cdes,Categoria,Crutasal,Carchsal,Centidad,Favorito,Lagrfh,Lseparachr,Comext,Appendarch,Parcoma,Crutabkp,Carchbkp,Lagrfhbp,Appendback)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAIMPO,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.AGRUP,''),isnull( d.CTIPARCH,''),isnull( d.CTIPREG,''),isnull( d.TIMESTAMP,0),isnull( d.HABGCOMO,0),isnull( d.SINNODO,0),isnull( d.BLOQREG,0),isnull( d.CLASEHOOK,''),isnull( d.CCOD,''),isnull( d.COBS,''),isnull( d.ENTAFE,''),isnull( d.CXML,''),isnull( d.CDELIMI,''),isnull( d.CEXTEN,''),isnull( d.ACTFECEXP,0),isnull( d.CDES,''),isnull( d.CATEGORIA,0),isnull( d.CRUTASAL,''),isnull( d.CARCHSAL,''),isnull( d.CENTIDAD,''),isnull( d.FAVORITO,0),isnull( d.LAGRFH,0),isnull( d.LSEPARACHR,0),isnull( d.COMEXT,''),isnull( d.APPENDARCH,0),isnull( d.PARCOMA,''),isnull( d.CRUTABKP,''),isnull( d.CARCHBKP,''),isnull( d.LAGRFHBP,0),isnull( d.APPENDBACK,0)
						From deleted d left join ORGANIZACION.DISEXPO pk 
							 on d.cCod = pk.cCod
						Where pk.cCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisExpoArea( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_DISEXPO_DisExpoArea
ON ORGANIZACION.TablaTrabajo_DISEXPO_DisExpoArea
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.SINNODO = isnull( d.SINNODO, t.SINNODO ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.CAREA = isnull( d.CAREA, t.CAREA ),
t.CTIPO = isnull( d.CTIPO, t.CTIPO ),
t.CTIPDET = isnull( d.CTIPDET, t.CTIPDET ),
t.NORDEN = isnull( d.NORDEN, t.NORDEN )
from ORGANIZACION.DisExpoArea t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DisExpoArea
( 
"NROITEM",
"BLOQREG",
"SINNODO",
"ICOD",
"CAREA",
"CTIPO",
"CTIPDET",
"NORDEN"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.SINNODO,
d.ICOD,
d.CAREA,
d.CTIPO,
d.CTIPDET,
d.NORDEN
From deleted d left join ORGANIZACION.DisExpoArea pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisExpoAtri( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_DISEXPO_DisExpoAtri
ON ORGANIZACION.TablaTrabajo_DISEXPO_DisExpoAtri
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.SINNODO = isnull( d.SINNODO, t.SINNODO ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.CAREA = isnull( d.CAREA, t.CAREA ),
t.CTIPO = isnull( d.CTIPO, t.CTIPO ),
t.CTIPDET = isnull( d.CTIPDET, t.CTIPDET ),
t.CATRIBUTO = isnull( d.CATRIBUTO, t.CATRIBUTO ),
t.NORDEN = isnull( d.NORDEN, t.NORDEN ),
t.NLONG = isnull( d.NLONG, t.NLONG ),
t.CCONV = isnull( d.CCONV, t.CCONV ),
t.CFORMATO = isnull( d.CFORMATO, t.CFORMATO )
from ORGANIZACION.DisExpoAtri t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DisExpoAtri
( 
"NROITEM",
"BLOQREG",
"SINNODO",
"ICOD",
"CAREA",
"CTIPO",
"CTIPDET",
"CATRIBUTO",
"NORDEN",
"NLONG",
"CCONV",
"CFORMATO"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.SINNODO,
d.ICOD,
d.CAREA,
d.CTIPO,
d.CTIPDET,
d.CATRIBUTO,
d.NORDEN,
d.NLONG,
d.CCONV,
d.CFORMATO
From deleted d left join ORGANIZACION.DisExpoAtri pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisExpoEnt( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_DISEXPO_DisExpoEnt
ON ORGANIZACION.TablaTrabajo_DISEXPO_DisExpoEnt
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.SINNODO = isnull( d.SINNODO, t.SINNODO ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.IENT = isnull( d.IENT, t.IENT )
from ORGANIZACION.DisExpoEnt t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DisExpoEnt
( 
"NROITEM",
"SINNODO",
"BLOQREG",
"ICOD",
"IENT"
 )
Select 
d.NROITEM,
d.SINNODO,
d.BLOQREG,
d.ICOD,
d.IENT
From deleted d left join ORGANIZACION.DisExpoEnt pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_DisExpo') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_DisExpo
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DISENOEXPO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOEXPO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOEXPO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOEXPO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOEXPO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOEXPO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_DISENOEXPO.Horaaltafw, [] )
					.Horaexpo = nvl( c_DISENOEXPO.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_DISENOEXPO.Basededatosmodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_DISENOEXPO.Versionmodificacionfw, [] )
					.Estadotransferencia = nvl( c_DISENOEXPO.Estadotransferencia, [] )
					.Horaimpo = nvl( c_DISENOEXPO.Horaimpo, [] )
					.Versionaltafw = nvl( c_DISENOEXPO.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_DISENOEXPO.Basededatosaltafw, [] )
					.Seriemodificacionfw = nvl( c_DISENOEXPO.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_DISENOEXPO.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_DISENOEXPO.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_DISENOEXPO.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_DISENOEXPO.Horamodificacionfw, [] )
					.Agrupamiento = nvl( c_DISENOEXPO.Agrupamiento, [] )
					.Tipoarchivo_PK =  nvl( c_DISENOEXPO.Tipoarchivo, [] )
					.Tiporegistro_PK =  nvl( c_DISENOEXPO.Tiporegistro, [] )
					.Areas.Limpiar()
					.Areas.SetearEsNavegacion( .lProcesando )
					.Areas.Cargar()
					.Atributos.Limpiar()
					.Atributos.SetearEsNavegacion( .lProcesando )
					.Atributos.Cargar()
					.Timestamp = nvl( c_DISENOEXPO.Timestamp, 0 )
					.Habilitarguardarcomocondicionado = nvl( c_DISENOEXPO.Habilitarguardarcomocondicionado, .F. )
					.Ocultarnodoexpo = nvl( c_DISENOEXPO.Ocultarnodoexpo, .F. )
					.Bloquearregistro = nvl( c_DISENOEXPO.Bloquearregistro, .F. )
					.Clasehook = nvl( c_DISENOEXPO.Clasehook, [] )
					.Codigo = nvl( c_DISENOEXPO.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					lcValor = This.ObtenerMemo( 'c_Entafectadas')
					.Entafectadas = lcValor 
					lcValor = This.ObtenerMemo( 'c_Xmlconfig')
					.Xmlconfig = lcValor 
					.Delimitadores = nvl( c_DISENOEXPO.Delimitadores, [] )
					.Extension = nvl( c_DISENOEXPO.Extension, [] )
					.Actualizarfechaexportacion = nvl( c_DISENOEXPO.Actualizarfechaexportacion, .F. )
					.Descripcion = nvl( c_DISENOEXPO.Descripcion, [] )
					.Categoria = nvl( c_DISENOEXPO.Categoria, 0 )
					.Rutasalida = nvl( c_DISENOEXPO.Rutasalida, [] )
					.Entidades.Limpiar()
					.Entidades.SetearEsNavegacion( .lProcesando )
					.Entidades.Cargar()
					.Archivosalida = nvl( c_DISENOEXPO.Archivosalida, [] )
					.Entidad = nvl( c_DISENOEXPO.Entidad, [] )
					.Favorito = nvl( c_DISENOEXPO.Favorito, .F. )
					.Agregarfh = nvl( c_DISENOEXPO.Agregarfh, .F. )
					.Separacionporcaracter = nvl( c_DISENOEXPO.Separacionporcaracter, .F. )
					.Comandoexterno = nvl( c_DISENOEXPO.Comandoexterno, [] )
					.Appendarchivo = nvl( c_DISENOEXPO.Appendarchivo, .F. )
					.Parametroscomando = nvl( c_DISENOEXPO.Parametroscomando, [] )
					.Rutabackup = nvl( c_DISENOEXPO.Rutabackup, [] )
					.Archivobackup = nvl( c_DISENOEXPO.Archivobackup, [] )
					.Agregarfhbk = nvl( c_DISENOEXPO.Agregarfhbk, .F. )
					.Appendbackup = nvl( c_DISENOEXPO.Appendbackup, .F. )
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

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_DISENOEXPO.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.DISEXPO' )
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
								from ORGANIZACION.DISEXPO 
								Where   DISEXPO.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "DISEXPO", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Agrup" as "Agrupamiento", "Ctiparch" as "Tipoarchivo", "Ctipreg" as "Tiporegistro", "Timestamp" as "Timestamp", "Habgcomo" as "Habilitarguardarcomocondicionado", "Sinnodo" as "Ocultarnodoexpo", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Ccod" as "Codigo", "Cobs" as "Obs", "Entafe" as "Entafectadas", "Cxml" as "Xmlconfig", "Cdelimi" as "Delimitadores", "Cexten" as "Extension", "Actfecexp" as "Actualizarfechaexportacion", "Cdes" as "Descripcion", "Categoria" as "Categoria", "Crutasal" as "Rutasalida", "Carchsal" as "Archivosalida", "Centidad" as "Entidad", "Favorito" as "Favorito", "Lagrfh" as "Agregarfh", "Lseparachr" as "Separacionporcaracter", "Comext" as "Comandoexterno", "Appendarch" as "Appendarchivo", "Parcoma" as "Parametroscomando", "Crutabkp" as "Rutabackup", "Carchbkp" as "Archivobackup", "Lagrfhbp" as "Agregarfhbk", "Appendback" as "Appendbackup"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.DISEXPO 
								Where   DISEXPO.CCOD != ''
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
	Tabla = 'DISEXPO'
	Filtro = " DISEXPO.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " DISEXPO.CCOD != ''"
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
	<row entidad="DISENOEXPO                              " atributo="FECHAIMPO                               " tabla="DISEXPO        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="FECHATRANSFERENCIA                      " tabla="DISEXPO        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="FECHAMODIFICACIONFW                     " tabla="DISEXPO        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="FECHAALTAFW                             " tabla="DISEXPO        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="FECHAEXPO                               " tabla="DISEXPO        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="HORAALTAFW                              " tabla="DISEXPO        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="HORAEXPO                                " tabla="DISEXPO        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="DISEXPO        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="VERSIONMODIFICACIONFW                   " tabla="DISEXPO        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ESTADOTRANSFERENCIA                     " tabla="DISEXPO        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="HORAIMPO                                " tabla="DISEXPO        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="VERSIONALTAFW                           " tabla="DISEXPO        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ZADSFW                                  " tabla="DISEXPO        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="BASEDEDATOSALTAFW                       " tabla="DISEXPO        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="SERIEMODIFICACIONFW                     " tabla="DISEXPO        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="USUARIOALTAFW                           " tabla="DISEXPO        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="USUARIOMODIFICACIONFW                   " tabla="DISEXPO        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="SERIEALTAFW                             " tabla="DISEXPO        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="HORAMODIFICACIONFW                      " tabla="DISEXPO        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="AGRUPAMIENTO                            " tabla="DISEXPO        " campo="AGRUP     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Origen                                                                                                                                                          " dominio="COMBOSUCYAGRU                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="TIPOARCHIVO                             " tabla="DISEXPO        " campo="CTIPARCH  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOARCHIVOEXPORTACION                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="402" etiqueta="Tipo archivo exportación                                                                                                                                        " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="TIPOREGISTRO                            " tabla="DISEXPO        " campo="CTIPREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOREGISTROEXPORTACION                 " tipodato="C         " longitud="3" decimales="0" valorsugerido="=&quot;LFI&quot;                                                                                                                                                                                                                                                        " obligatorio="true" admitebusqueda="404" etiqueta="Tipo registro exportación                                                                                                                                       " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="AREAS                                   " tabla="DISEXPOAREA    " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Área                                                                                                                                                            " dominio="DETALLEITEMAREASEXPO          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ATRIBUTOS                               " tabla="DISEXPOATRI    " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Atributos                                                                                                                                                       " dominio="DETALLEITEMATRIBUTOSEXPO      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="TIMESTAMP                               " tabla="DISEXPO        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="HABILITARGUARDARCOMOCONDICIONADO        " tabla="DISEXPO        " campo="HABGCOMO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="OCULTARNODOEXPO                         " tabla="DISEXPO        " campo="SINNODO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="BLOQUEARREGISTRO                        " tabla="DISEXPO        " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="CLASEHOOK                               " tabla="DISEXPO        " campo="CLASEHOOK " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Clase hook                                                                                                                                                      " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="CODIGO                                  " tabla="DISEXPO        " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="OBS                                     " tabla="DISEXPO        " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ENTAFECTADAS                            " tabla="DISEXPO        " campo="ENTAFE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="XMLCONFIG                               " tabla="DISEXPO        " campo="CXML      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Xml Configuracion                                                                                                                                               " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="DELIMITADORES                           " tabla="DISEXPO        " campo="CDELIMI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Delimitadores                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="EXTENSION                               " tabla="DISEXPO        " campo="CEXTEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="414" etiqueta="Extensión                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ACTUALIZARFECHAEXPORTACION              " tabla="DISEXPO        " campo="ACTFECEXP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="416" etiqueta="Actualizar fecha exportación                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="DESCRIPCION                             " tabla="DISEXPO        " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="CATEGORIA                               " tabla="DISEXPO        " campo="CATEGORIA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Categoría                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="21" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="RUTASALIDA                              " tabla="DISEXPO        " campo="CRUTASAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="420" etiqueta="Ruta salida                                                                                                                                                     " dominio="DIRECTORIOPORPARAMETRO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ENTIDADES                               " tabla="DISEXPOENT     " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Entidades afectadas                                                                                                                                             " dominio="DETALLEITEMENTIDADESEXPO      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ARCHIVOSALIDA                           " tabla="DISEXPO        " campo="CARCHSAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="424" etiqueta="Archivos salida                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ENTIDAD                                 " tabla="DISEXPO        " campo="CENTIDAD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entidad                                                                                                                                                         " dominio="COMBOENTIDADESEXPO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="FAVORITO                                " tabla="DISEXPO        " campo="FAVORITO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="426" etiqueta="Favorito                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="21" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="AGREGARFH                               " tabla="DISEXPO        " campo="LAGRFH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Agregar fechahora salida                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="SEPARACIONPORCARACTER                   " tabla="DISEXPO        " campo="LSEPARACHR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Separacion por caracter                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="COMANDOEXTERNO                          " tabla="DISEXPO        " campo="COMEXT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Archivo aplicación                                                                                                                                              " dominio="ARCHIVOPORPARAMETRO           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="20" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="APPENDARCHIVO                           " tabla="DISEXPO        " campo="APPENDARCH" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Agregar archivo salida                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="PARAMETROSCOMANDO                       " tabla="DISEXPO        " campo="PARCOMA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Parámetros                                                                                                                                                      " dominio="EXPRESIONSIMPLE               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="20" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="RUTABACKUP                              " tabla="DISEXPO        " campo="CRUTABKP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Ruta salida backup                                                                                                                                              " dominio="DIRECTORIOPORPARAMETRO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="ARCHIVOBACKUP                           " tabla="DISEXPO        " campo="CARCHBKP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Archivos salida backup                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="AGREGARFHBK                             " tabla="DISEXPO        " campo="LAGRFHBP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Agregar fechahora salida backup                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOEXPO                              " atributo="APPENDBACKUP                            " tabla="DISEXPO        " campo="APPENDBACK" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Agregar salida backup                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOARCHIVOEXPORTACION                  " atributo="DESCRIPCION                             " tabla="TIPARCEXP      " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPARCEXP On DISEXPO.CTIPARCH = TIPARCEXP.cCod And  TIPARCEXP.CCOD != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOREGISTROEXPORTACION                 " atributo="DESCRIPCION                             " tabla="TIPREGEXP      " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="405" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPREGEXP On DISEXPO.CTIPREG = TIPREGEXP.cCod And  TIPREGEXP.CCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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