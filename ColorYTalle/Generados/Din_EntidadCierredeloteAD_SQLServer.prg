
define class Din_EntidadCIERREDELOTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CIERREDELOTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( NumeroC, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.numeroC, 8, 0)]
	cTagClaveCandidata = '_057CC'
	cTagClavePk = '_057PK'
	cTablaPrincipal = 'CIELOTE'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxCieloteFecimpo, lxCieloteFectrans, lxCieloteFmodifw, lxCieloteFaltafw, lxCieloteFecexpo, lxCieloteHoraexpo, lxCieloteHoraimpo, lxCieloteHaltafw, lxCieloteSmodifw, lxCieloteUmodifw, lxCieloteSaltafw, lxCieloteUaltafw, lxCieloteHmodifw, lxCieloteZadsfw, lxCieloteBdaltafw, lxCieloteBdmodifw, lxCieloteEsttrans, lxCieloteValtafw, lxCieloteGuid, lxCieloteVmodifw, lxCieloteTimestamp, lxCieloteCod, lxCieloteTxticard, lxCieloteNumeroc, lxCieloteFalta, lxCieloteFcielote, lxCieloteHalta, lxCieloteHcielote, lxCieloteSerie, lxCieloteEquipopos, lxCieloteObs
				lxCieloteFecimpo =  .Fechaimpo			lxCieloteFectrans =  .Fechatransferencia			lxCieloteFmodifw =  .Fechamodificacionfw			lxCieloteFaltafw =  .Fechaaltafw			lxCieloteFecexpo =  .Fechaexpo			lxCieloteHoraexpo =  .Horaexpo			lxCieloteHoraimpo =  .Horaimpo			lxCieloteHaltafw =  .Horaaltafw			lxCieloteSmodifw =  .Seriemodificacionfw			lxCieloteUmodifw =  .Usuariomodificacionfw			lxCieloteSaltafw =  .Seriealtafw			lxCieloteUaltafw =  .Usuarioaltafw			lxCieloteHmodifw =  .Horamodificacionfw			lxCieloteZadsfw =  .Zadsfw			lxCieloteBdaltafw =  .Basededatosaltafw			lxCieloteBdmodifw =  .Basededatosmodificacionfw			lxCieloteEsttrans =  .Estadotransferencia			lxCieloteValtafw =  .Versionaltafw			lxCieloteGuid =  .Guid			lxCieloteVmodifw =  .Versionmodificacionfw			lxCieloteTimestamp = goLibrerias.ObtenerTimestamp()			lxCieloteCod =  .Codigo			lxCieloteTxticard =  .Ticketicard			lxCieloteNumeroc =  .Numeroc			lxCieloteFalta =  .Fechaalta			lxCieloteFcielote =  .Fechacierredelote			lxCieloteHalta =  .Horaalta			lxCieloteHcielote =  .Horacierredelote			lxCieloteSerie =  .Serieorigen			lxCieloteEquipopos =  upper( .EquipoPOS_PK ) 			lxCieloteObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCieloteCod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CIELOTE ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Horaexpo","Horaimpo","Haltafw","Smodifw","Umodifw","Saltafw","Ualtafw","Hmodifw","Zadsfw","Bdaltafw","Bdmodifw","Esttrans","Valtafw","Guid","Vmodifw","Timestamp","Cod","Txticard","Numeroc","Falta","Fcielote","Halta","Hcielote","Serie","Equipopos","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCieloteFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteGuid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteVmodifw ) + "'" >>, <<lxCieloteTimestamp >>, <<"'" + this.FormatearTextoSql( lxCieloteCod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteTxticard ) + "'" >>, <<lxCieloteNumeroc >>, <<"'" + this.ConvertirDateSql( lxCieloteFalta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFcielote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHalta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHcielote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteEquipopos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteObs ) + "'" >> )
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
			for each loItem in this.oEntidad.Detalle
				if this.oEntidad.Detalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNrolote = loItem.Nrolote
					lxTarjeta_PK = loItem.Tarjeta_PK
					lxTarjetadetalle = loItem.Tarjetadetalle
					lxMontototalcompras = loItem.Montototalcompras
					lxMontototalanulacioncompras = loItem.Montototalanulacioncompras
					lxMontototaldevoluciones = loItem.Montototaldevoluciones
					lxMontototalanulaciondevoluciones = loItem.Montototalanulaciondevoluciones
					lxMontototal = loItem.Montototal
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETCIELOTE("NROITEM","Cod","NroLote","Tarjeta","DescTarj","MTotCom","MTotAnuCom","MTotDev","MTotAnuDev","MTot" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNrolote>>, <<"'" + this.FormatearTextoSql( lxTarjeta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTarjetadetalle ) + "'">>, <<lxMontototalcompras>>, <<lxMontototalanulacioncompras>>, <<lxMontototaldevoluciones>>, <<lxMontototalanulaciondevoluciones>>, <<lxMontototal>> ) 
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
		this.oEntidad.Timestamp = lxCieloteTimestamp
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
			this.GenerarSentenciasComponentes()
			local  lxCieloteFecimpo, lxCieloteFectrans, lxCieloteFmodifw, lxCieloteFaltafw, lxCieloteFecexpo, lxCieloteHoraexpo, lxCieloteHoraimpo, lxCieloteHaltafw, lxCieloteSmodifw, lxCieloteUmodifw, lxCieloteSaltafw, lxCieloteUaltafw, lxCieloteHmodifw, lxCieloteZadsfw, lxCieloteBdaltafw, lxCieloteBdmodifw, lxCieloteEsttrans, lxCieloteValtafw, lxCieloteGuid, lxCieloteVmodifw, lxCieloteTimestamp, lxCieloteCod, lxCieloteTxticard, lxCieloteNumeroc, lxCieloteFalta, lxCieloteFcielote, lxCieloteHalta, lxCieloteHcielote, lxCieloteSerie, lxCieloteEquipopos, lxCieloteObs
				lxCieloteFecimpo =  .Fechaimpo			lxCieloteFectrans =  .Fechatransferencia			lxCieloteFmodifw =  .Fechamodificacionfw			lxCieloteFaltafw =  .Fechaaltafw			lxCieloteFecexpo =  .Fechaexpo			lxCieloteHoraexpo =  .Horaexpo			lxCieloteHoraimpo =  .Horaimpo			lxCieloteHaltafw =  .Horaaltafw			lxCieloteSmodifw =  .Seriemodificacionfw			lxCieloteUmodifw =  .Usuariomodificacionfw			lxCieloteSaltafw =  .Seriealtafw			lxCieloteUaltafw =  .Usuarioaltafw			lxCieloteHmodifw =  .Horamodificacionfw			lxCieloteZadsfw =  .Zadsfw			lxCieloteBdaltafw =  .Basededatosaltafw			lxCieloteBdmodifw =  .Basededatosmodificacionfw			lxCieloteEsttrans =  .Estadotransferencia			lxCieloteValtafw =  .Versionaltafw			lxCieloteGuid =  .Guid			lxCieloteVmodifw =  .Versionmodificacionfw			lxCieloteTimestamp = goLibrerias.ObtenerTimestamp()			lxCieloteCod =  .Codigo			lxCieloteTxticard =  .Ticketicard			lxCieloteNumeroc =  .Numeroc			lxCieloteFalta =  .Fechaalta			lxCieloteFcielote =  .Fechacierredelote			lxCieloteHalta =  .Horaalta			lxCieloteHcielote =  .Horacierredelote			lxCieloteSerie =  .Serieorigen			lxCieloteEquipopos =  upper( .EquipoPOS_PK ) 			lxCieloteObs =  .Observacion
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
				update ZooLogic.CIELOTE set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCieloteFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCieloteFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCieloteFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCieloteFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCieloteFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCieloteHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCieloteHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCieloteHaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCieloteSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCieloteUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCieloteSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCieloteUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCieloteHmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCieloteZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCieloteBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCieloteBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCieloteEsttrans ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCieloteValtafw ) + "'">>,"Guid" = <<"'" + this.FormatearTextoSql( lxCieloteGuid ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCieloteVmodifw ) + "'">>,"Timestamp" = <<lxCieloteTimestamp>>,"Cod" = <<"'" + this.FormatearTextoSql( lxCieloteCod ) + "'">>,"Txticard" = <<"'" + this.FormatearTextoSql( lxCieloteTxticard ) + "'">>,"Numeroc" = <<lxCieloteNumeroc>>,"Falta" = <<"'" + this.ConvertirDateSql( lxCieloteFalta ) + "'">>,"Fcielote" = <<"'" + this.ConvertirDateSql( lxCieloteFcielote ) + "'">>,"Halta" = <<"'" + this.FormatearTextoSql( lxCieloteHalta ) + "'">>,"Hcielote" = <<"'" + this.FormatearTextoSql( lxCieloteHcielote ) + "'">>,"Serie" = <<"'" + this.FormatearTextoSql( lxCieloteSerie ) + "'">>,"Equipopos" = <<"'" + this.FormatearTextoSql( lxCieloteEquipopos ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCieloteObs ) + "'">> where "Cod" = <<"'" + this.FormatearTextoSql( lxCieloteCod ) + "'">> and  CIELOTE.COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETCIELOTE where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Detalle
				if this.oEntidad.Detalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNrolote = loItem.Nrolote
					lxTarjeta_PK = loItem.Tarjeta_PK
					lxTarjetadetalle = loItem.Tarjetadetalle
					lxMontototalcompras = loItem.Montototalcompras
					lxMontototalanulacioncompras = loItem.Montototalanulacioncompras
					lxMontototaldevoluciones = loItem.Montototaldevoluciones
					lxMontototalanulaciondevoluciones = loItem.Montototalanulaciondevoluciones
					lxMontototal = loItem.Montototal
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETCIELOTE("NROITEM","Cod","NroLote","Tarjeta","DescTarj","MTotCom","MTotAnuCom","MTotDev","MTotAnuDev","MTot" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNrolote>>, <<"'" + this.FormatearTextoSql( lxTarjeta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTarjetadetalle ) + "'">>, <<lxMontototalcompras>>, <<lxMontototalanulacioncompras>>, <<lxMontototaldevoluciones>>, <<lxMontototalanulaciondevoluciones>>, <<lxMontototal>> ) 
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
		this.oEntidad.Timestamp = lxCieloteTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Cod from ZooLogic.CIELOTE where " + this.ConvertirFuncionesSql( " CIELOTE.COD != ''" ) )
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
			Local lxCieloteCod
			lxCieloteCod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Guid" as "Guid", "Vmodifw" as "Versionmodificacionfw", "Timestamp" as "Timestamp", "Cod" as "Codigo", "Txticard" as "Ticketicard", "Numeroc" as "Numeroc", "Falta" as "Fechaalta", "Fcielote" as "Fechacierredelote", "Halta" as "Horaalta", "Hcielote" as "Horacierredelote", "Serie" as "Serieorigen", "Equipopos" as "Equipopos", "Obs" as "Observacion" from ZooLogic.CIELOTE where "Cod" = <<"'" + this.FormatearTextoSql( lxCieloteCod ) + "'">> and  CIELOTE.COD != ''
			endtext
			use in select('c_CIERREDELOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREDELOTE', set( 'Datasession' ) )

			if reccount( 'c_CIERREDELOTE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Nrolote" as "Nrolote", "Tarjeta" as "Tarjeta", "Desctarj" as "Tarjetadetalle", "Mtotcom" as "Montototalcompras", "Mtotanucom" as "Montototalanulacioncompras", "Mtotdev" as "Montototaldevoluciones", "Mtotanudev" as "Montototalanulaciondevoluciones", "Mtot" as "Montototal" from ZooLogic.DETCIELOTE where Cod = <<"'" + this.FormatearTextoSql( c_CIERREDELOTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Detalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Detalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Detalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCIELOTEnumeroC As Variant
			lxCIELOTEnumeroC = .NumeroC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Guid" as "Guid", "Vmodifw" as "Versionmodificacionfw", "Timestamp" as "Timestamp", "Cod" as "Codigo", "Txticard" as "Ticketicard", "Numeroc" as "Numeroc", "Falta" as "Fechaalta", "Fcielote" as "Fechacierredelote", "Halta" as "Horaalta", "Hcielote" as "Horacierredelote", "Serie" as "Serieorigen", "Equipopos" as "Equipopos", "Obs" as "Observacion" from ZooLogic.CIELOTE where  CIELOTE.COD != '' And numeroC = <<lxCIELOTEnumeroC>>
			endtext
			use in select('c_CIERREDELOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREDELOTE', set( 'Datasession' ) )
			if reccount( 'c_CIERREDELOTE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Nrolote" as "Nrolote", "Tarjeta" as "Tarjeta", "Desctarj" as "Tarjetadetalle", "Mtotcom" as "Montototalcompras", "Mtotanucom" as "Montototalanulacioncompras", "Mtotdev" as "Montototaldevoluciones", "Mtotanudev" as "Montototalanulaciondevoluciones", "Mtot" as "Montototal" from ZooLogic.DETCIELOTE where Cod = <<"'" + this.FormatearTextoSql( c_CIERREDELOTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Detalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Detalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Detalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCieloteCod as Variant
		llRetorno = .t.
		lxCieloteCod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CIELOTE where "Cod" = <<"'" + this.FormatearTextoSql( lxCieloteCod ) + "'">> and  CIELOTE.COD != ''
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
				lcOrden =  str( .NumeroC, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Guid" as "Guid", "Vmodifw" as "Versionmodificacionfw", "Timestamp" as "Timestamp", "Cod" as "Codigo", "Txticard" as "Ticketicard", "Numeroc" as "Numeroc", "Falta" as "Fechaalta", "Fcielote" as "Fechacierredelote", "Halta" as "Horaalta", "Hcielote" as "Horacierredelote", "Serie" as "Serieorigen", "Equipopos" as "Equipopos", "Obs" as "Observacion" from ZooLogic.CIELOTE where  CIELOTE.COD != '' order by numeroC
			endtext
			use in select('c_CIERREDELOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREDELOTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Nrolote" as "Nrolote", "Tarjeta" as "Tarjeta", "Desctarj" as "Tarjetadetalle", "Mtotcom" as "Montototalcompras", "Mtotanucom" as "Montototalanulacioncompras", "Mtotdev" as "Montototaldevoluciones", "Mtotanudev" as "Montototalanulaciondevoluciones", "Mtot" as "Montototal" from ZooLogic.DETCIELOTE where Cod = <<"'" + this.FormatearTextoSql( c_CIERREDELOTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Detalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Detalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Detalle
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
				lcOrden =  str( .NumeroC, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Guid" as "Guid", "Vmodifw" as "Versionmodificacionfw", "Timestamp" as "Timestamp", "Cod" as "Codigo", "Txticard" as "Ticketicard", "Numeroc" as "Numeroc", "Falta" as "Fechaalta", "Fcielote" as "Fechacierredelote", "Halta" as "Horaalta", "Hcielote" as "Horacierredelote", "Serie" as "Serieorigen", "Equipopos" as "Equipopos", "Obs" as "Observacion" from ZooLogic.CIELOTE where  str( numeroC, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CIELOTE.COD != '' order by numeroC
			endtext
			use in select('c_CIERREDELOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREDELOTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Nrolote" as "Nrolote", "Tarjeta" as "Tarjeta", "Desctarj" as "Tarjetadetalle", "Mtotcom" as "Montototalcompras", "Mtotanucom" as "Montototalanulacioncompras", "Mtotdev" as "Montototaldevoluciones", "Mtotanudev" as "Montototalanulaciondevoluciones", "Mtot" as "Montototal" from ZooLogic.DETCIELOTE where Cod = <<"'" + this.FormatearTextoSql( c_CIERREDELOTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Detalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Detalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Detalle
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
				lcOrden =  str( .NumeroC, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Guid" as "Guid", "Vmodifw" as "Versionmodificacionfw", "Timestamp" as "Timestamp", "Cod" as "Codigo", "Txticard" as "Ticketicard", "Numeroc" as "Numeroc", "Falta" as "Fechaalta", "Fcielote" as "Fechacierredelote", "Halta" as "Horaalta", "Hcielote" as "Horacierredelote", "Serie" as "Serieorigen", "Equipopos" as "Equipopos", "Obs" as "Observacion" from ZooLogic.CIELOTE where  str( numeroC, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CIELOTE.COD != '' order by numeroC desc
			endtext
			use in select('c_CIERREDELOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREDELOTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Nrolote" as "Nrolote", "Tarjeta" as "Tarjeta", "Desctarj" as "Tarjetadetalle", "Mtotcom" as "Montototalcompras", "Mtotanucom" as "Montototalanulacioncompras", "Mtotdev" as "Montototaldevoluciones", "Mtotanudev" as "Montototalanulaciondevoluciones", "Mtot" as "Montototal" from ZooLogic.DETCIELOTE where Cod = <<"'" + this.FormatearTextoSql( c_CIERREDELOTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Detalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Detalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Detalle
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
				lcOrden =  str( .NumeroC, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Guid" as "Guid", "Vmodifw" as "Versionmodificacionfw", "Timestamp" as "Timestamp", "Cod" as "Codigo", "Txticard" as "Ticketicard", "Numeroc" as "Numeroc", "Falta" as "Fechaalta", "Fcielote" as "Fechacierredelote", "Halta" as "Horaalta", "Hcielote" as "Horacierredelote", "Serie" as "Serieorigen", "Equipopos" as "Equipopos", "Obs" as "Observacion" from ZooLogic.CIELOTE where  CIELOTE.COD != '' order by numeroC desc
			endtext
			use in select('c_CIERREDELOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CIERREDELOTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Nrolote" as "Nrolote", "Tarjeta" as "Tarjeta", "Desctarj" as "Tarjetadetalle", "Mtotcom" as "Montototalcompras", "Mtotanucom" as "Montototalanulacioncompras", "Mtotdev" as "Montototaldevoluciones", "Mtotanudev" as "Montototalanulaciondevoluciones", "Mtot" as "Montototal" from ZooLogic.DETCIELOTE where Cod = <<"'" + this.FormatearTextoSql( c_CIERREDELOTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Detalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Detalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Detalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Horaexpo,Horaimpo,Haltafw,Smodifw,Umodifw,Saltafw,U" + ;
"altafw,Hmodifw,Zadsfw,Bdaltafw,Bdmodifw,Esttrans,Valtafw,Guid,Vmodifw,Timestamp,Cod,Txticard,Numeroc" + ;
",Falta,Fcielote,Halta,Hcielote,Serie,Equipopos,Obs" + ;
" from ZooLogic.CIELOTE where  CIELOTE.COD != '' and " + lcFiltro )
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
			local  lxCieloteFecimpo, lxCieloteFectrans, lxCieloteFmodifw, lxCieloteFaltafw, lxCieloteFecexpo, lxCieloteHoraexpo, lxCieloteHoraimpo, lxCieloteHaltafw, lxCieloteSmodifw, lxCieloteUmodifw, lxCieloteSaltafw, lxCieloteUaltafw, lxCieloteHmodifw, lxCieloteZadsfw, lxCieloteBdaltafw, lxCieloteBdmodifw, lxCieloteEsttrans, lxCieloteValtafw, lxCieloteGuid, lxCieloteVmodifw, lxCieloteTimestamp, lxCieloteCod, lxCieloteTxticard, lxCieloteNumeroc, lxCieloteFalta, lxCieloteFcielote, lxCieloteHalta, lxCieloteHcielote, lxCieloteSerie, lxCieloteEquipopos, lxCieloteObs
				lxCieloteFecimpo = ctod( '  /  /    ' )			lxCieloteFectrans = ctod( '  /  /    ' )			lxCieloteFmodifw = ctod( '  /  /    ' )			lxCieloteFaltafw = ctod( '  /  /    ' )			lxCieloteFecexpo = ctod( '  /  /    ' )			lxCieloteHoraexpo = []			lxCieloteHoraimpo = []			lxCieloteHaltafw = []			lxCieloteSmodifw = []			lxCieloteUmodifw = []			lxCieloteSaltafw = []			lxCieloteUaltafw = []			lxCieloteHmodifw = []			lxCieloteZadsfw = []			lxCieloteBdaltafw = []			lxCieloteBdmodifw = []			lxCieloteEsttrans = []			lxCieloteValtafw = []			lxCieloteGuid = []			lxCieloteVmodifw = []			lxCieloteTimestamp = goLibrerias.ObtenerTimestamp()			lxCieloteCod = []			lxCieloteTxticard = []			lxCieloteNumeroc = 0			lxCieloteFalta = ctod( '  /  /    ' )			lxCieloteFcielote = ctod( '  /  /    ' )			lxCieloteHalta = []			lxCieloteHcielote = []			lxCieloteSerie = []			lxCieloteEquipopos = []			lxCieloteObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETCIELOTE where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CIELOTE where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'CIELOTE' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Cod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Cod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CIELOTE.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Guid" as "Guid", "Vmodifw" as "Versionmodificacionfw", "Timestamp" as "Timestamp", "Cod" as "Codigo", "Txticard" as "Ticketicard", "Numeroc" as "Numeroc", "Falta" as "Fechaalta", "Fcielote" as "Fechacierredelote", "Halta" as "Horaalta", "Hcielote" as "Horacierredelote", "Serie" as "Serieorigen", "Equipopos" as "Equipopos", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CIELOTE', '', tnTope )
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
	Function ObtenerDatosDetalleDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETCIELOTE.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Cod" as "Codigo", "Nrolote" as "Nrolote", "Tarjeta" as "Tarjeta", "Desctarj" as "Tarjetadetalle", "Mtotcom" as "Montototalcompras", "Mtotanucom" as "Montototalanulacioncompras", "Mtotdev" as "Montototaldevoluciones", "Mtotanudev" as "Montototalanulaciondevoluciones", "Mtot" as "Montototal"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETCIELOTE', 'Detalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalle( lcAtributo )
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
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'GUID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUID AS GUID'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGO'
				Case lcAtributo == 'TICKETICARD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TXTICARD AS TICKETICARD'
				Case lcAtributo == 'NUMEROC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROC AS NUMEROC'
				Case lcAtributo == 'FECHAALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTA AS FECHAALTA'
				Case lcAtributo == 'FECHACIERREDELOTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCIELOTE AS FECHACIERREDELOTE'
				Case lcAtributo == 'HORAALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTA AS HORAALTA'
				Case lcAtributo == 'HORACIERREDELOTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HCIELOTE AS HORACIERREDELOTE'
				Case lcAtributo == 'SERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIEORIGEN'
				Case lcAtributo == 'EQUIPOPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIPOPOS AS EQUIPOPOS'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGO'
				Case lcAtributo == 'NROLOTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROLOTE AS NROLOTE'
				Case lcAtributo == 'TARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TARJETA AS TARJETA'
				Case lcAtributo == 'TARJETADETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCTARJ AS TARJETADETALLE'
				Case lcAtributo == 'MONTOTOTALCOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MTOTCOM AS MONTOTOTALCOMPRAS'
				Case lcAtributo == 'MONTOTOTALANULACIONCOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MTOTANUCOM AS MONTOTOTALANULACIONCOMPRAS'
				Case lcAtributo == 'MONTOTOTALDEVOLUCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MTOTDEV AS MONTOTOTALDEVOLUCIONES'
				Case lcAtributo == 'MONTOTOTALANULACIONDEVOLUCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MTOTANUDEV AS MONTOTOTALANULACIONDEVOLUCIONES'
				Case lcAtributo == 'MONTOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MTOT AS MONTOTOTAL'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'GUID'
				lcCampo = 'GUID'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'TICKETICARD'
				lcCampo = 'TXTICARD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROC'
				lcCampo = 'NUMEROC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTA'
				lcCampo = 'FALTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACIERREDELOTE'
				lcCampo = 'FCIELOTE'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTA'
				lcCampo = 'HALTA'
			Case upper( alltrim( tcAtributo ) ) == 'HORACIERREDELOTE'
				lcCampo = 'HCIELOTE'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEORIGEN'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIPOPOS'
				lcCampo = 'EQUIPOPOS'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'NROLOTE'
				lcCampo = 'NROLOTE'
			Case upper( alltrim( tcAtributo ) ) == 'TARJETA'
				lcCampo = 'TARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'TARJETADETALLE'
				lcCampo = 'DESCTARJ'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOTOTALCOMPRAS'
				lcCampo = 'MTOTCOM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOTOTALANULACIONCOMPRAS'
				lcCampo = 'MTOTANUCOM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOTOTALDEVOLUCIONES'
				lcCampo = 'MTOTDEV'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOTOTALANULACIONDEVOLUCIONES'
				lcCampo = 'MTOTANUDEV'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOTOTAL'
				lcCampo = 'MTOT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLE'
			lcRetorno = 'DETCIELOTE'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCieloteFecimpo, lxCieloteFectrans, lxCieloteFmodifw, lxCieloteFaltafw, lxCieloteFecexpo, lxCieloteHoraexpo, lxCieloteHoraimpo, lxCieloteHaltafw, lxCieloteSmodifw, lxCieloteUmodifw, lxCieloteSaltafw, lxCieloteUaltafw, lxCieloteHmodifw, lxCieloteZadsfw, lxCieloteBdaltafw, lxCieloteBdmodifw, lxCieloteEsttrans, lxCieloteValtafw, lxCieloteGuid, lxCieloteVmodifw, lxCieloteTimestamp, lxCieloteCod, lxCieloteTxticard, lxCieloteNumeroc, lxCieloteFalta, lxCieloteFcielote, lxCieloteHalta, lxCieloteHcielote, lxCieloteSerie, lxCieloteEquipopos, lxCieloteObs
				lxCieloteFecimpo =  .Fechaimpo			lxCieloteFectrans =  .Fechatransferencia			lxCieloteFmodifw =  .Fechamodificacionfw			lxCieloteFaltafw =  .Fechaaltafw			lxCieloteFecexpo =  .Fechaexpo			lxCieloteHoraexpo =  .Horaexpo			lxCieloteHoraimpo =  .Horaimpo			lxCieloteHaltafw =  .Horaaltafw			lxCieloteSmodifw =  .Seriemodificacionfw			lxCieloteUmodifw =  .Usuariomodificacionfw			lxCieloteSaltafw =  .Seriealtafw			lxCieloteUaltafw =  .Usuarioaltafw			lxCieloteHmodifw =  .Horamodificacionfw			lxCieloteZadsfw =  .Zadsfw			lxCieloteBdaltafw =  .Basededatosaltafw			lxCieloteBdmodifw =  .Basededatosmodificacionfw			lxCieloteEsttrans =  .Estadotransferencia			lxCieloteValtafw =  .Versionaltafw			lxCieloteGuid =  .Guid			lxCieloteVmodifw =  .Versionmodificacionfw			lxCieloteTimestamp = goLibrerias.ObtenerTimestamp()			lxCieloteCod =  .Codigo			lxCieloteTxticard =  .Ticketicard			lxCieloteNumeroc =  .Numeroc			lxCieloteFalta =  .Fechaalta			lxCieloteFcielote =  .Fechacierredelote			lxCieloteHalta =  .Horaalta			lxCieloteHcielote =  .Horacierredelote			lxCieloteSerie =  .Serieorigen			lxCieloteEquipopos =  upper( .EquipoPOS_PK ) 			lxCieloteObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CIELOTE ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Horaexpo","Horaimpo","Haltafw","Smodifw","Umodifw","Saltafw","Ualtafw","Hmodifw","Zadsfw","Bdaltafw","Bdmodifw","Esttrans","Valtafw","Guid","Vmodifw","Timestamp","Cod","Txticard","Numeroc","Falta","Fcielote","Halta","Hcielote","Serie","Equipopos","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCieloteFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteGuid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteVmodifw ) + "'" >>, <<lxCieloteTimestamp >>, <<"'" + this.FormatearTextoSql( lxCieloteCod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteTxticard ) + "'" >>, <<lxCieloteNumeroc >>, <<"'" + this.ConvertirDateSql( lxCieloteFalta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCieloteFcielote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHalta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteHcielote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteEquipopos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCieloteObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CIELOTE' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Detalle
				if this.oEntidad.Detalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNrolote = loItem.Nrolote
					lxTarjeta_PK = loItem.Tarjeta_PK
					lxTarjetadetalle = loItem.Tarjetadetalle
					lxMontototalcompras = loItem.Montototalcompras
					lxMontototalanulacioncompras = loItem.Montototalanulacioncompras
					lxMontototaldevoluciones = loItem.Montototaldevoluciones
					lxMontototalanulaciondevoluciones = loItem.Montototalanulaciondevoluciones
					lxMontototal = loItem.Montototal
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETCIELOTE("NROITEM","Cod","NroLote","Tarjeta","DescTarj","MTotCom","MTotAnuCom","MTotDev","MTotAnuDev","MTot" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxNrolote>>, <<"'" + this.FormatearTextoSql( lxTarjeta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTarjetadetalle ) + "'">>, <<lxMontototalcompras>>, <<lxMontototalanulacioncompras>>, <<lxMontototaldevoluciones>>, <<lxMontototalanulaciondevoluciones>>, <<lxMontototal>> ) 
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
			local  lxCieloteFecimpo, lxCieloteFectrans, lxCieloteFmodifw, lxCieloteFaltafw, lxCieloteFecexpo, lxCieloteHoraexpo, lxCieloteHoraimpo, lxCieloteHaltafw, lxCieloteSmodifw, lxCieloteUmodifw, lxCieloteSaltafw, lxCieloteUaltafw, lxCieloteHmodifw, lxCieloteZadsfw, lxCieloteBdaltafw, lxCieloteBdmodifw, lxCieloteEsttrans, lxCieloteValtafw, lxCieloteGuid, lxCieloteVmodifw, lxCieloteTimestamp, lxCieloteCod, lxCieloteTxticard, lxCieloteNumeroc, lxCieloteFalta, lxCieloteFcielote, lxCieloteHalta, lxCieloteHcielote, lxCieloteSerie, lxCieloteEquipopos, lxCieloteObs
				lxCieloteFecimpo =  .Fechaimpo			lxCieloteFectrans =  .Fechatransferencia			lxCieloteFmodifw =  .Fechamodificacionfw			lxCieloteFaltafw =  .Fechaaltafw			lxCieloteFecexpo =  .Fechaexpo			lxCieloteHoraexpo =  .Horaexpo			lxCieloteHoraimpo =  .Horaimpo			lxCieloteHaltafw =  .Horaaltafw			lxCieloteSmodifw =  .Seriemodificacionfw			lxCieloteUmodifw =  .Usuariomodificacionfw			lxCieloteSaltafw =  .Seriealtafw			lxCieloteUaltafw =  .Usuarioaltafw			lxCieloteHmodifw =  .Horamodificacionfw			lxCieloteZadsfw =  .Zadsfw			lxCieloteBdaltafw =  .Basededatosaltafw			lxCieloteBdmodifw =  .Basededatosmodificacionfw			lxCieloteEsttrans =  .Estadotransferencia			lxCieloteValtafw =  .Versionaltafw			lxCieloteGuid =  .Guid			lxCieloteVmodifw =  .Versionmodificacionfw			lxCieloteTimestamp = goLibrerias.ObtenerTimestamp()			lxCieloteCod =  .Codigo			lxCieloteTxticard =  .Ticketicard			lxCieloteNumeroc =  .Numeroc			lxCieloteFalta =  .Fechaalta			lxCieloteFcielote =  .Fechacierredelote			lxCieloteHalta =  .Horaalta			lxCieloteHcielote =  .Horacierredelote			lxCieloteSerie =  .Serieorigen			lxCieloteEquipopos =  upper( .EquipoPOS_PK ) 			lxCieloteObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Cod" = ] + lcValorClavePrimariaString  + [ and  CIELOTE.COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CIELOTE set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCieloteFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCieloteFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCieloteFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCieloteFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCieloteFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCieloteHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCieloteHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCieloteHaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCieloteSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCieloteUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCieloteSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCieloteUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCieloteHmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCieloteZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCieloteBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCieloteBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCieloteEsttrans ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCieloteValtafw ) + "'">>, "Guid" = <<"'" + this.FormatearTextoSql( lxCieloteGuid ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCieloteVmodifw ) + "'">>, "Timestamp" = <<lxCieloteTimestamp>>, "Cod" = <<"'" + this.FormatearTextoSql( lxCieloteCod ) + "'">>, "Txticard" = <<"'" + this.FormatearTextoSql( lxCieloteTxticard ) + "'">>, "Numeroc" = <<lxCieloteNumeroc>>, "Falta" = <<"'" + this.ConvertirDateSql( lxCieloteFalta ) + "'">>, "Fcielote" = <<"'" + this.ConvertirDateSql( lxCieloteFcielote ) + "'">>, "Halta" = <<"'" + this.FormatearTextoSql( lxCieloteHalta ) + "'">>, "Hcielote" = <<"'" + this.FormatearTextoSql( lxCieloteHcielote ) + "'">>, "Serie" = <<"'" + this.FormatearTextoSql( lxCieloteSerie ) + "'">>, "Equipopos" = <<"'" + this.FormatearTextoSql( lxCieloteEquipopos ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCieloteObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CIELOTE' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DETCIELOTE where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Detalle
				if this.oEntidad.Detalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNrolote = loItem.Nrolote
					lxTarjeta_PK = loItem.Tarjeta_PK
					lxTarjetadetalle = loItem.Tarjetadetalle
					lxMontototalcompras = loItem.Montototalcompras
					lxMontototalanulacioncompras = loItem.Montototalanulacioncompras
					lxMontototaldevoluciones = loItem.Montototaldevoluciones
					lxMontototalanulaciondevoluciones = loItem.Montototalanulaciondevoluciones
					lxMontototal = loItem.Montototal
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETCIELOTE("NROITEM","Cod","NroLote","Tarjeta","DescTarj","MTotCom","MTotAnuCom","MTotDev","MTotAnuDev","MTot" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxNrolote>>, <<"'" + this.FormatearTextoSql( lxTarjeta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTarjetadetalle ) + "'">>, <<lxMontototalcompras>>, <<lxMontototalanulacioncompras>>, <<lxMontototaldevoluciones>>, <<lxMontototalanulaciondevoluciones>>, <<lxMontototal>> ) 
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

			lcFiltro = ["Cod" = ] + lcValorClavePrimariaString  + [ and  CIELOTE.COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.CIELOTE where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DETCIELOTE where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CIELOTE' 
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
		
			.oCompCierredelote.lNuevo = .EsNuevo()
			.oCompCierredelote.lEdicion = .EsEdicion()
			.oCompCierredelote.lEliminar = .lEliminar
			.oCompCierredelote.lAnular = .lAnular
			loColSentencias = .oCompCierredelote.grabar()
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
			lcRetorno = [update ZooLogic.CIELOTE set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Cod = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  CIELOTE.COD != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CIELOTE where  CIELOTE.COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CIELOTE where Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CIELOTE.COD != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCIELOTEnumeroC as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREDELOTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CIELOTE Where  numeroC = ] + transform( &lcCursor..numeroC    ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Cod
				if lxValorClavePK == curSeek.Cod or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Cod and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Cod
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.CIELOTE set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, GUID = ] + "'" + this.FormatearTextoSql( &lcCursor..GUID ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..Cod ) + "'"+ [, txticard = ] + "'" + this.FormatearTextoSql( &lcCursor..txticard ) + "'"+ [, numeroC = ] + transform( &lcCursor..numeroC )+ [, FALTA = ] + "'" + this.ConvertirDateSql( &lcCursor..FALTA ) + "'"+ [, FCieLote = ] + "'" + this.ConvertirDateSql( &lcCursor..FCieLote ) + "'"+ [, HALTA = ] + "'" + this.FormatearTextoSql( &lcCursor..HALTA ) + "'"+ [, HCieLote = ] + "'" + this.FormatearTextoSql( &lcCursor..HCieLote ) + "'"+ [, Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'"+ [, EquipoPOS = ] + "'" + this.FormatearTextoSql( &lcCursor..EquipoPOS ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Cod = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CIELOTE Where Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..Cod ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, HORAEXPO, HORAIMPO, HALTAFW, SMODIFW, UMODIFW, SALTAFW, UALTAFW, HMODIFW, ZADSFW, BDALTAFW, BDMODIFW, ESTTRANS, VALTAFW, GUID, VMODIFW, TIMESTAMP, Cod, txticard, numeroC, FALTA, FCieLote, HALTA, HCieLote, Serie, EquipoPOS, Obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GUID ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..txticard ) + "'" + ',' + transform( &lcCursor..numeroC ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FCieLote ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HCieLote ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EquipoPOS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CIELOTE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREDELOTE'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Cod','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Cod')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DETCIELOTE Where Cod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMLOTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Cod in ( select Cod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Cod","NroLote","Tarjeta","DescTarj","MTotCom","MTotAnuCom","MTotDev","MTotAnuDev","MTot"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DETCIELOTE ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cod        ) + "'" + ',' + transform( cDetallesExistentes.NroLote    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Tarjeta    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescTarj   ) + "'" + ',' + transform( cDetallesExistentes.MTotCom    ) + ',' + transform( cDetallesExistentes.MTotAnuCom ) + ',' + transform( cDetallesExistentes.MTotDev    ) + ',' + transform( cDetallesExistentes.MTotAnuDev ) + ',' + transform( cDetallesExistentes.MTot       ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Cod C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
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
			Case  lcAlias == lcPrefijo + 'CIERREDELOTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CIERREDELOTE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CIERREDELOTE_TXTICARD'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CIERREDELOTE_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMLOTE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CIELOTE')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CIERREDELOTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Cod
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..numeroC )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CIERREDELOTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREDELOTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Cod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Cod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( numeroC, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( numeroC, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREDELOTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTA     
		* Validar ANTERIORES A 1/1/1753  FCieLote  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CIELOTE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CIELOTE
Create Table ZooLogic.TablaTrabajo_CIELOTE ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"valtafw" char( 13 )  null, 
"guid" char( 38 )  null, 
"vmodifw" char( 13 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"cod" char( 38 )  null, 
"txticard" varchar(max)  null, 
"numeroc" numeric( 8, 0 )  null, 
"falta" datetime  null, 
"fcielote" datetime  null, 
"halta" char( 8 )  null, 
"hcielote" char( 5 )  null, 
"serie" char( 10 )  null, 
"equipopos" char( 10 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CIELOTE' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CIELOTE' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CIERREDELOTE'
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
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('guid','guid')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('cod','cod')
			.AgregarMapeo('txticard','txticard')
			.AgregarMapeo('numeroc','numeroc')
			.AgregarMapeo('falta','falta')
			.AgregarMapeo('fcielote','fcielote')
			.AgregarMapeo('halta','halta')
			.AgregarMapeo('hcielote','hcielote')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('equipopos','equipopos')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CIELOTE'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.GUID = isnull( d.GUID, t.GUID ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.COD = isnull( d.COD, t.COD ),t.TXTICARD = isnull( d.TXTICARD, t.TXTICARD ),t.NUMEROC = isnull( d.NUMEROC, t.NUMEROC ),t.FALTA = isnull( d.FALTA, t.FALTA ),t.FCIELOTE = isnull( d.FCIELOTE, t.FCIELOTE ),t.HALTA = isnull( d.HALTA, t.HALTA ),t.HCIELOTE = isnull( d.HCIELOTE, t.HCIELOTE ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.EQUIPOPOS = isnull( d.EQUIPOPOS, t.EQUIPOPOS ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.CIELOTE t inner join deleted d 
							 on t.Cod = d.Cod
							 and  t.numeroC = d.numeroC
				-- Fin Updates
				insert into ZooLogic.CIELOTE(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Horaexpo,Horaimpo,Haltafw,Smodifw,Umodifw,Saltafw,Ualtafw,Hmodifw,Zadsfw,Bdaltafw,Bdmodifw,Esttrans,Valtafw,Guid,Vmodifw,Timestamp,Cod,Txticard,Numeroc,Falta,Fcielote,Halta,Hcielote,Serie,Equipopos,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.VALTAFW,''),isnull( d.GUID,''),isnull( d.VMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.COD,''),isnull( d.TXTICARD,''),isnull( d.NUMEROC,0),isnull( d.FALTA,''),isnull( d.FCIELOTE,''),isnull( d.HALTA,''),isnull( d.HCIELOTE,''),isnull( d.SERIE,''),isnull( d.EQUIPOPOS,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.CIELOTE pk 
							 on d.Cod = pk.Cod
						 left join ZooLogic.CIELOTE cc 
							 on  d.numeroC = cc.numeroC
						Where pk.Cod Is Null 
							 and cc.numeroC Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO INTERNO ' + cast( d.numeroC as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.CIELOTE t inner join deleted d 
							on   t.numeroC = d.numeroC
						left join deleted h 
							 on t.Cod = h.Cod
							 where h.Cod is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO INTERNO ' + cast( d.numeroC as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CIELOTE t inner join deleted d 
							 on t.Cod = d.Cod
						left join deleted h 
							on   t.numeroC = h.numeroC
							where   h.numeroC is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETCIELOTE( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CIELOTE_DETCIELOTE
ON ZooLogic.TablaTrabajo_CIELOTE_DETCIELOTE
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COD = isnull( d.COD, t.COD ),
t.NROLOTE = isnull( d.NROLOTE, t.NROLOTE ),
t.TARJETA = isnull( d.TARJETA, t.TARJETA ),
t.DESCTARJ = isnull( d.DESCTARJ, t.DESCTARJ ),
t.MTOTCOM = isnull( d.MTOTCOM, t.MTOTCOM ),
t.MTOTANUCOM = isnull( d.MTOTANUCOM, t.MTOTANUCOM ),
t.MTOTDEV = isnull( d.MTOTDEV, t.MTOTDEV ),
t.MTOTANUDEV = isnull( d.MTOTANUDEV, t.MTOTANUDEV ),
t.MTOT = isnull( d.MTOT, t.MTOT )
from ZooLogic.DETCIELOTE t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DETCIELOTE
( 
"NROITEM",
"COD",
"NROLOTE",
"TARJETA",
"DESCTARJ",
"MTOTCOM",
"MTOTANUCOM",
"MTOTDEV",
"MTOTANUDEV",
"MTOT"
 )
Select 
d.NROITEM,
d.COD,
d.NROLOTE,
d.TARJETA,
d.DESCTARJ,
d.MTOTCOM,
d.MTOTANUCOM,
d.MTOTDEV,
d.MTOTANUDEV,
d.MTOT
From deleted d left join ZooLogic.DETCIELOTE pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CIELOTE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CIELOTE
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CIERREDELOTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREDELOTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREDELOTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREDELOTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREDELOTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREDELOTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_CIERREDELOTE.Horaexpo, [] )
					.Horaimpo = nvl( c_CIERREDELOTE.Horaimpo, [] )
					.Horaaltafw = nvl( c_CIERREDELOTE.Horaaltafw, [] )
					.Seriemodificacionfw = nvl( c_CIERREDELOTE.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_CIERREDELOTE.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_CIERREDELOTE.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_CIERREDELOTE.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_CIERREDELOTE.Horamodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_CIERREDELOTE.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CIERREDELOTE.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CIERREDELOTE.Estadotransferencia, [] )
					.Versionaltafw = nvl( c_CIERREDELOTE.Versionaltafw, [] )
					.Guid = nvl( c_CIERREDELOTE.Guid, [] )
					.Versionmodificacionfw = nvl( c_CIERREDELOTE.Versionmodificacionfw, [] )
					.Timestamp = nvl( c_CIERREDELOTE.Timestamp, 0 )
					.Codigo = nvl( c_CIERREDELOTE.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Ticketicard')
					.Ticketicard = lcValor 
					.Numeroc = nvl( c_CIERREDELOTE.Numeroc, 0 )
					.Fechaalta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREDELOTE.Fechaalta, ctod( '  /  /    ' ) ) )
					.Fechacierredelote = GoLibrerias.ObtenerFechaFormateada( nvl( c_CIERREDELOTE.Fechacierredelote, ctod( '  /  /    ' ) ) )
					.Horaalta = nvl( c_CIERREDELOTE.Horaalta, [] )
					.Horacierredelote = nvl( c_CIERREDELOTE.Horacierredelote, [] )
					.Serieorigen = nvl( c_CIERREDELOTE.Serieorigen, [] )
					.Detalle.Limpiar()
					.Detalle.SetearEsNavegacion( .lProcesando )
					.Detalle.Cargar()
					.Equipopos_PK =  nvl( c_CIERREDELOTE.Equipopos, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
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
			lxRetorno = c_CIERREDELOTE.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.Detalle
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
		return c_CIERREDELOTE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CIELOTE' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Cod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Cod from (
							select * 
								from ZooLogic.CIELOTE 
								Where   CIELOTE.COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CIELOTE", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Guid" as "Guid", "Vmodifw" as "Versionmodificacionfw", "Timestamp" as "Timestamp", "Cod" as "Codigo", "Txticard" as "Ticketicard", "Numeroc" as "Numeroc", "Falta" as "Fechaalta", "Fcielote" as "Fechacierredelote", "Halta" as "Horaalta", "Hcielote" as "Horacierredelote", "Serie" as "Serieorigen", "Equipopos" as "Equipopos", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CIELOTE 
								Where   CIELOTE.COD != ''
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
	Tabla = 'CIELOTE'
	Filtro = " CIELOTE.COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CIELOTE.COD != ''"
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
	<row entidad="CIERREDELOTE                            " atributo="FECHAIMPO                               " tabla="CIELOTE        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="FECHATRANSFERENCIA                      " tabla="CIELOTE        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="FECHAMODIFICACIONFW                     " tabla="CIELOTE        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="FECHAALTAFW                             " tabla="CIELOTE        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="FECHAEXPO                               " tabla="CIELOTE        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="HORAEXPO                                " tabla="CIELOTE        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="HORAIMPO                                " tabla="CIELOTE        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="HORAALTAFW                              " tabla="CIELOTE        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="SERIEMODIFICACIONFW                     " tabla="CIELOTE        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="USUARIOMODIFICACIONFW                   " tabla="CIELOTE        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="SERIEALTAFW                             " tabla="CIELOTE        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="USUARIOALTAFW                           " tabla="CIELOTE        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="HORAMODIFICACIONFW                      " tabla="CIELOTE        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="ZADSFW                                  " tabla="CIELOTE        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="BASEDEDATOSALTAFW                       " tabla="CIELOTE        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CIELOTE        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="ESTADOTRANSFERENCIA                     " tabla="CIELOTE        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="VERSIONALTAFW                           " tabla="CIELOTE        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="GUID                                    " tabla="CIELOTE        " campo="GUID      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="=iif(.VerificarContexto( 'CB' ),.Guid,goLibrerias.ObtenerGuid())                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="VERSIONMODIFICACIONFW                   " tabla="CIELOTE        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="TIMESTAMP                               " tabla="CIELOTE        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="CODIGO                                  " tabla="CIELOTE        " campo="COD       " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="TICKETICARD                             " tabla="CIELOTE        " campo="TXTICARD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Cupón I-Card                                                                                                                                                    " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="NUMEROC                                 " tabla="CIELOTE        " campo="NUMEROC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                  " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="FECHAALTA                               " tabla="CIELOTE        " campo="FALTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="4" etiqueta="Fecha alta lote                                                                                                                                                 " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="FECHACIERREDELOTE                       " tabla="CIELOTE        " campo="FCIELOTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="402" etiqueta="Fecha de cierre de lote                                                                                                                                         " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="HORAALTA                                " tabla="CIELOTE        " campo="HALTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="6" etiqueta="Hora alta lote                                                                                                                                                  " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99X99                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="HORACIERREDELOTE                        " tabla="CIELOTE        " campo="HCIELOTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Hora cierre de lote                                                                                                                                             " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="SERIEORIGEN                             " tabla="CIELOTE        " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="8" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="DETALLE                                 " tabla="DETCIELOTE     " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMLOTE               " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="EQUIPOPOS                               " tabla="CIELOTE        " campo="EQUIPOPOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="POS                                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="@OBTENERPOSDEFAULT()                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="10" etiqueta="Dispositivo POS                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CIERREDELOTE                            " atributo="OBSERVACION                             " tabla="CIELOTE        " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="DESCRIPCION                             " tabla="POS            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Dis.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join POS On CIELOTE.EQUIPOPOS = POS.Codigo And  POS.CODIGO != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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