
define class Din_EntidadDESPACHODEIMPORTACIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DESPACHODEIMPORTACION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_DDIPK'
	cTablaPrincipal = 'DESPIMP'
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
			local  lxDespimpFaltafw, lxDespimpFecexpo, lxDespimpFectrans, lxDespimpFmodifw, lxDespimpFecimpo, lxDespimpTimestamp, lxDespimpZadsfw, lxDespimpHmodifw, lxDespimpSaltafw, lxDespimpUmodifw, lxDespimpHoraimpo, lxDespimpUaltafw, lxDespimpVmodifw, lxDespimpValtafw, lxDespimpSmodifw, lxDespimpEsttrans, lxDespimpHoraexpo, lxDespimpBdaltafw, lxDespimpBdmodifw, lxDespimpHaltafw, lxDespimpDespacho, lxDespimpIncoterms, lxDespimpFechaing, lxDespimpMoneda, lxDespimpOficializ, lxDespimpCantuni, lxDespimpArribo, lxDespimpFob, lxDespimpFlete, lxDespimpSeguro, lxDespimpObs, lxDespimpFtotal
				lxDespimpFaltafw =  .Fechaaltafw			lxDespimpFecexpo =  .Fechaexpo			lxDespimpFectrans =  .Fechatransferencia			lxDespimpFmodifw =  .Fechamodificacionfw			lxDespimpFecimpo =  .Fechaimpo			lxDespimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDespimpZadsfw =  .Zadsfw			lxDespimpHmodifw =  .Horamodificacionfw			lxDespimpSaltafw =  .Seriealtafw			lxDespimpUmodifw =  .Usuariomodificacionfw			lxDespimpHoraimpo =  .Horaimpo			lxDespimpUaltafw =  .Usuarioaltafw			lxDespimpVmodifw =  .Versionmodificacionfw			lxDespimpValtafw =  .Versionaltafw			lxDespimpSmodifw =  .Seriemodificacionfw			lxDespimpEsttrans =  .Estadotransferencia			lxDespimpHoraexpo =  .Horaexpo			lxDespimpBdaltafw =  .Basededatosaltafw			lxDespimpBdmodifw =  .Basededatosmodificacionfw			lxDespimpHaltafw =  .Horaaltafw			lxDespimpDespacho =  .Despacho			lxDespimpIncoterms =  upper( .Incoterms_PK ) 			lxDespimpFechaing =  .Fechaing			lxDespimpMoneda =  upper( .Moneda_PK ) 			lxDespimpOficializ =  .Oficializacion			lxDespimpCantuni =  .Cantunidades			lxDespimpArribo =  .Arribo			lxDespimpFob =  .Fob			lxDespimpFlete =  .Flete			lxDespimpSeguro =  .Seguro			lxDespimpObs =  .Observacion			lxDespimpFtotal =  .Total
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxDespimpDespacho = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.DESPIMP ( "Faltafw","Fecexpo","Fectrans","Fmodifw","Fecimpo","Timestamp","Zadsfw","Hmodifw","Saltafw","Umodifw","Horaimpo","Ualtafw","Vmodifw","Valtafw","Smodifw","Esttrans","Horaexpo","Bdaltafw","Bdmodifw","Haltafw","Despacho","Incoterms","Fechaing","Moneda","Oficializ","Cantuni","Arribo","Fob","Flete","Seguro","Obs","Ftotal" ) values ( <<"'" + this.ConvertirDateSql( lxDespimpFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFecimpo ) + "'" >>, <<lxDespimpTimestamp >>, <<"'" + this.FormatearTextoSql( lxDespimpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpDespacho ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpIncoterms ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFechaing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpMoneda ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpOficializ ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpCantuni ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpArribo ) + "'" >>, <<lxDespimpFob >>, <<lxDespimpFlete >>, <<lxDespimpSeguro >>, <<"'" + this.FormatearTextoSql( lxDespimpObs ) + "'" >>, <<lxDespimpFtotal >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.DESPACHO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleArticulos
				if this.oEntidad.DetalleArticulos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxOficializacion = loItem.Oficializacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DespImpDet("NROITEM","Codigo","CodArt","Descrip","Oficializ" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxOficializacion ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDespimpTimestamp
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
		return this.oEntidad.DESPACHO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxDespimpFaltafw, lxDespimpFecexpo, lxDespimpFectrans, lxDespimpFmodifw, lxDespimpFecimpo, lxDespimpTimestamp, lxDespimpZadsfw, lxDespimpHmodifw, lxDespimpSaltafw, lxDespimpUmodifw, lxDespimpHoraimpo, lxDespimpUaltafw, lxDespimpVmodifw, lxDespimpValtafw, lxDespimpSmodifw, lxDespimpEsttrans, lxDespimpHoraexpo, lxDespimpBdaltafw, lxDespimpBdmodifw, lxDespimpHaltafw, lxDespimpDespacho, lxDespimpIncoterms, lxDespimpFechaing, lxDespimpMoneda, lxDespimpOficializ, lxDespimpCantuni, lxDespimpArribo, lxDespimpFob, lxDespimpFlete, lxDespimpSeguro, lxDespimpObs, lxDespimpFtotal
				lxDespimpFaltafw =  .Fechaaltafw			lxDespimpFecexpo =  .Fechaexpo			lxDespimpFectrans =  .Fechatransferencia			lxDespimpFmodifw =  .Fechamodificacionfw			lxDespimpFecimpo =  .Fechaimpo			lxDespimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDespimpZadsfw =  .Zadsfw			lxDespimpHmodifw =  .Horamodificacionfw			lxDespimpSaltafw =  .Seriealtafw			lxDespimpUmodifw =  .Usuariomodificacionfw			lxDespimpHoraimpo =  .Horaimpo			lxDespimpUaltafw =  .Usuarioaltafw			lxDespimpVmodifw =  .Versionmodificacionfw			lxDespimpValtafw =  .Versionaltafw			lxDespimpSmodifw =  .Seriemodificacionfw			lxDespimpEsttrans =  .Estadotransferencia			lxDespimpHoraexpo =  .Horaexpo			lxDespimpBdaltafw =  .Basededatosaltafw			lxDespimpBdmodifw =  .Basededatosmodificacionfw			lxDespimpHaltafw =  .Horaaltafw			lxDespimpDespacho =  .Despacho			lxDespimpIncoterms =  upper( .Incoterms_PK ) 			lxDespimpFechaing =  .Fechaing			lxDespimpMoneda =  upper( .Moneda_PK ) 			lxDespimpOficializ =  .Oficializacion			lxDespimpCantuni =  .Cantunidades			lxDespimpArribo =  .Arribo			lxDespimpFob =  .Fob			lxDespimpFlete =  .Flete			lxDespimpSeguro =  .Seguro			lxDespimpObs =  .Observacion			lxDespimpFtotal =  .Total
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
			lxValorClavePrimaria = .oEntidad.DESPACHO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.DESPIMP set "Faltafw" = <<"'" + this.ConvertirDateSql( lxDespimpFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxDespimpFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxDespimpFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxDespimpFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxDespimpFecimpo ) + "'">>,"Timestamp" = <<lxDespimpTimestamp>>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxDespimpZadsfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxDespimpHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxDespimpSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxDespimpUmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxDespimpHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxDespimpUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxDespimpVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxDespimpValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxDespimpSmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxDespimpEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxDespimpHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDespimpBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDespimpBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxDespimpHaltafw ) + "'">>,"Despacho" = <<"'" + this.FormatearTextoSql( lxDespimpDespacho ) + "'">>,"Incoterms" = <<"'" + this.FormatearTextoSql( lxDespimpIncoterms ) + "'">>,"Fechaing" = <<"'" + this.ConvertirDateSql( lxDespimpFechaing ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxDespimpMoneda ) + "'">>,"Oficializ" = <<"'" + this.ConvertirDateSql( lxDespimpOficializ ) + "'">>,"Cantuni" = <<"'" + this.FormatearTextoSql( lxDespimpCantuni ) + "'">>,"Arribo" = <<"'" + this.ConvertirDateSql( lxDespimpArribo ) + "'">>,"Fob" = <<lxDespimpFob>>,"Flete" = <<lxDespimpFlete>>,"Seguro" = <<lxDespimpSeguro>>,"Obs" = <<"'" + this.FormatearTextoSql( lxDespimpObs ) + "'">>,"Ftotal" = <<lxDespimpFtotal>> where "Despacho" = <<"'" + this.FormatearTextoSql( lxDespimpDespacho ) + "'">> and  DESPIMP.DESPACHO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DespImpDet where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.DESPACHO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleArticulos
				if this.oEntidad.DetalleArticulos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxOficializacion = loItem.Oficializacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DespImpDet("NROITEM","Codigo","CodArt","Descrip","Oficializ" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxOficializacion ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDespimpTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Despacho from ZooLogic.DESPIMP where " + this.ConvertirFuncionesSql( " DESPIMP.DESPACHO != ''" ) )
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
			Local lxDespimpDespacho
			lxDespimpDespacho = .Despacho

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Despacho" as "Despacho", "Incoterms" as "Incoterms", "Fechaing" as "Fechaing", "Moneda" as "Moneda", "Oficializ" as "Oficializacion", "Cantuni" as "Cantunidades", "Arribo" as "Arribo", "Fob" as "Fob", "Flete" as "Flete", "Seguro" as "Seguro", "Obs" as "Observacion", "Ftotal" as "Total" from ZooLogic.DESPIMP where "Despacho" = <<"'" + this.FormatearTextoSql( lxDespimpDespacho ) + "'">> and  DESPIMP.DESPACHO != ''
			endtext
			use in select('c_DESPACHODEIMPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESPACHODEIMPORTACION', set( 'Datasession' ) )

			if reccount( 'c_DESPACHODEIMPORTACION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codart" as "Articulo", "Descrip" as "Articulodetalle", "Oficializ" as "Oficializacion" from ZooLogic.DespImpDet where Codigo = <<"'" + this.FormatearTextoSql( c_DESPACHODEIMPORTACION.DESPACHO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleArticulos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleArticulos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleArticulos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxDespimpDespacho as Variant
		llRetorno = .t.
		lxDespimpDespacho = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.DESPIMP where "Despacho" = <<"'" + this.FormatearTextoSql( lxDespimpDespacho ) + "'">> and  DESPIMP.DESPACHO != ''
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
				lcOrden =  .Despacho
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Despacho" as "Despacho", "Incoterms" as "Incoterms", "Fechaing" as "Fechaing", "Moneda" as "Moneda", "Oficializ" as "Oficializacion", "Cantuni" as "Cantunidades", "Arribo" as "Arribo", "Fob" as "Fob", "Flete" as "Flete", "Seguro" as "Seguro", "Obs" as "Observacion", "Ftotal" as "Total" from ZooLogic.DESPIMP where  DESPIMP.DESPACHO != '' order by Despacho
			endtext
			use in select('c_DESPACHODEIMPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESPACHODEIMPORTACION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codart" as "Articulo", "Descrip" as "Articulodetalle", "Oficializ" as "Oficializacion" from ZooLogic.DespImpDet where Codigo = <<"'" + this.FormatearTextoSql( c_DESPACHODEIMPORTACION.DESPACHO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleArticulos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleArticulos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleArticulos
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
				lcOrden =  .Despacho
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Despacho" as "Despacho", "Incoterms" as "Incoterms", "Fechaing" as "Fechaing", "Moneda" as "Moneda", "Oficializ" as "Oficializacion", "Cantuni" as "Cantunidades", "Arribo" as "Arribo", "Fob" as "Fob", "Flete" as "Flete", "Seguro" as "Seguro", "Obs" as "Observacion", "Ftotal" as "Total" from ZooLogic.DESPIMP where  funciones.padr( Despacho, 16, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DESPIMP.DESPACHO != '' order by Despacho
			endtext
			use in select('c_DESPACHODEIMPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESPACHODEIMPORTACION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codart" as "Articulo", "Descrip" as "Articulodetalle", "Oficializ" as "Oficializacion" from ZooLogic.DespImpDet where Codigo = <<"'" + this.FormatearTextoSql( c_DESPACHODEIMPORTACION.DESPACHO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleArticulos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleArticulos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleArticulos
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
				lcOrden =  .Despacho
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Despacho" as "Despacho", "Incoterms" as "Incoterms", "Fechaing" as "Fechaing", "Moneda" as "Moneda", "Oficializ" as "Oficializacion", "Cantuni" as "Cantunidades", "Arribo" as "Arribo", "Fob" as "Fob", "Flete" as "Flete", "Seguro" as "Seguro", "Obs" as "Observacion", "Ftotal" as "Total" from ZooLogic.DESPIMP where  funciones.padr( Despacho, 16, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DESPIMP.DESPACHO != '' order by Despacho desc
			endtext
			use in select('c_DESPACHODEIMPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESPACHODEIMPORTACION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codart" as "Articulo", "Descrip" as "Articulodetalle", "Oficializ" as "Oficializacion" from ZooLogic.DespImpDet where Codigo = <<"'" + this.FormatearTextoSql( c_DESPACHODEIMPORTACION.DESPACHO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleArticulos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleArticulos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleArticulos
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
				lcOrden =  .Despacho
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Despacho" as "Despacho", "Incoterms" as "Incoterms", "Fechaing" as "Fechaing", "Moneda" as "Moneda", "Oficializ" as "Oficializacion", "Cantuni" as "Cantunidades", "Arribo" as "Arribo", "Fob" as "Fob", "Flete" as "Flete", "Seguro" as "Seguro", "Obs" as "Observacion", "Ftotal" as "Total" from ZooLogic.DESPIMP where  DESPIMP.DESPACHO != '' order by Despacho desc
			endtext
			use in select('c_DESPACHODEIMPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESPACHODEIMPORTACION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codart" as "Articulo", "Descrip" as "Articulodetalle", "Oficializ" as "Oficializacion" from ZooLogic.DespImpDet where Codigo = <<"'" + this.FormatearTextoSql( c_DESPACHODEIMPORTACION.DESPACHO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleArticulos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleArticulos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleArticulos
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.DESPACHO ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fecexpo,Fectrans,Fmodifw,Fecimpo,Timestamp,Zadsfw,Hmodifw,Saltafw,Umodifw,Horaimpo,U" + ;
"altafw,Vmodifw,Valtafw,Smodifw,Esttrans,Horaexpo,Bdaltafw,Bdmodifw,Haltafw,Despacho,Incoterms,Fechai" + ;
"ng,Moneda,Oficializ,Cantuni,Arribo,Fob,Flete,Seguro,Obs,Ftotal" + ;
" from ZooLogic.DESPIMP where  DESPIMP.DESPACHO != '' and " + lcFiltro )
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
			local  lxDespimpFaltafw, lxDespimpFecexpo, lxDespimpFectrans, lxDespimpFmodifw, lxDespimpFecimpo, lxDespimpTimestamp, lxDespimpZadsfw, lxDespimpHmodifw, lxDespimpSaltafw, lxDespimpUmodifw, lxDespimpHoraimpo, lxDespimpUaltafw, lxDespimpVmodifw, lxDespimpValtafw, lxDespimpSmodifw, lxDespimpEsttrans, lxDespimpHoraexpo, lxDespimpBdaltafw, lxDespimpBdmodifw, lxDespimpHaltafw, lxDespimpDespacho, lxDespimpIncoterms, lxDespimpFechaing, lxDespimpMoneda, lxDespimpOficializ, lxDespimpCantuni, lxDespimpArribo, lxDespimpFob, lxDespimpFlete, lxDespimpSeguro, lxDespimpObs, lxDespimpFtotal
				lxDespimpFaltafw = ctod( '  /  /    ' )			lxDespimpFecexpo = ctod( '  /  /    ' )			lxDespimpFectrans = ctod( '  /  /    ' )			lxDespimpFmodifw = ctod( '  /  /    ' )			lxDespimpFecimpo = ctod( '  /  /    ' )			lxDespimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDespimpZadsfw = []			lxDespimpHmodifw = []			lxDespimpSaltafw = []			lxDespimpUmodifw = []			lxDespimpHoraimpo = []			lxDespimpUaltafw = []			lxDespimpVmodifw = []			lxDespimpValtafw = []			lxDespimpSmodifw = []			lxDespimpEsttrans = []			lxDespimpHoraexpo = []			lxDespimpBdaltafw = []			lxDespimpBdmodifw = []			lxDespimpHaltafw = []			lxDespimpDespacho = []			lxDespimpIncoterms = []			lxDespimpFechaing = ctod( '  /  /    ' )			lxDespimpMoneda = []			lxDespimpOficializ = ctod( '  /  /    ' )			lxDespimpCantuni = []			lxDespimpArribo = ctod( '  /  /    ' )			lxDespimpFob = 0			lxDespimpFlete = 0			lxDespimpSeguro = 0			lxDespimpObs = []			lxDespimpFtotal = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DespImpDet where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.DESPACHO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.DESPIMP where "Despacho" = ] + "'" + this.FormatearTextoSql( .oEntidad.DESPACHO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'DESPIMP' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Despacho = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Despacho, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DESPIMP.DESPACHO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Despacho" as "Despacho", "Incoterms" as "Incoterms", "Fechaing" as "Fechaing", "Moneda" as "Moneda", "Oficializ" as "Oficializacion", "Cantuni" as "Cantunidades", "Arribo" as "Arribo", "Fob" as "Fob", "Flete" as "Flete", "Seguro" as "Seguro", "Obs" as "Observacion", "Ftotal" as "Total"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DESPIMP', '', tnTope )
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
	Function ObtenerDatosDetalleDetalleArticulos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DESPIMPDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codart" as "Articulo", "Descrip" as "Articulodetalle", "Oficializ" as "Oficializacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleArticulos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DespImpDet', 'DetalleArticulos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleArticulos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleArticulos( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'DESPACHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESPACHO AS DESPACHO'
				Case lcAtributo == 'INCOTERMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INCOTERMS AS INCOTERMS'
				Case lcAtributo == 'FECHAING'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAING AS FECHAING'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDA'
				Case lcAtributo == 'OFICIALIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OFICIALIZ AS OFICIALIZACION'
				Case lcAtributo == 'CANTUNIDADES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTUNI AS CANTUNIDADES'
				Case lcAtributo == 'ARRIBO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARRIBO AS ARRIBO'
				Case lcAtributo == 'FOB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOB AS FOB'
				Case lcAtributo == 'FLETE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETE AS FLETE'
				Case lcAtributo == 'SEGURO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEGURO AS SEGURO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleArticulos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS ARTICULODETALLE'
				Case lcAtributo == 'OFICIALIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OFICIALIZ AS OFICIALIZACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESPACHO'
				lcCampo = 'DESPACHO'
			Case upper( alltrim( tcAtributo ) ) == 'INCOTERMS'
				lcCampo = 'INCOTERMS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAING'
				lcCampo = 'FECHAING'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'OFICIALIZACION'
				lcCampo = 'OFICIALIZ'
			Case upper( alltrim( tcAtributo ) ) == 'CANTUNIDADES'
				lcCampo = 'CANTUNI'
			Case upper( alltrim( tcAtributo ) ) == 'ARRIBO'
				lcCampo = 'ARRIBO'
			Case upper( alltrim( tcAtributo ) ) == 'FOB'
				lcCampo = 'FOB'
			Case upper( alltrim( tcAtributo ) ) == 'FLETE'
				lcCampo = 'FLETE'
			Case upper( alltrim( tcAtributo ) ) == 'SEGURO'
				lcCampo = 'SEGURO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleArticulos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'CODART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OFICIALIZACION'
				lcCampo = 'OFICIALIZ'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLEARTICULOS'
			lcRetorno = 'DESPIMPDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDespimpFaltafw, lxDespimpFecexpo, lxDespimpFectrans, lxDespimpFmodifw, lxDespimpFecimpo, lxDespimpTimestamp, lxDespimpZadsfw, lxDespimpHmodifw, lxDespimpSaltafw, lxDespimpUmodifw, lxDespimpHoraimpo, lxDespimpUaltafw, lxDespimpVmodifw, lxDespimpValtafw, lxDespimpSmodifw, lxDespimpEsttrans, lxDespimpHoraexpo, lxDespimpBdaltafw, lxDespimpBdmodifw, lxDespimpHaltafw, lxDespimpDespacho, lxDespimpIncoterms, lxDespimpFechaing, lxDespimpMoneda, lxDespimpOficializ, lxDespimpCantuni, lxDespimpArribo, lxDespimpFob, lxDespimpFlete, lxDespimpSeguro, lxDespimpObs, lxDespimpFtotal
				lxDespimpFaltafw =  .Fechaaltafw			lxDespimpFecexpo =  .Fechaexpo			lxDespimpFectrans =  .Fechatransferencia			lxDespimpFmodifw =  .Fechamodificacionfw			lxDespimpFecimpo =  .Fechaimpo			lxDespimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDespimpZadsfw =  .Zadsfw			lxDespimpHmodifw =  .Horamodificacionfw			lxDespimpSaltafw =  .Seriealtafw			lxDespimpUmodifw =  .Usuariomodificacionfw			lxDespimpHoraimpo =  .Horaimpo			lxDespimpUaltafw =  .Usuarioaltafw			lxDespimpVmodifw =  .Versionmodificacionfw			lxDespimpValtafw =  .Versionaltafw			lxDespimpSmodifw =  .Seriemodificacionfw			lxDespimpEsttrans =  .Estadotransferencia			lxDespimpHoraexpo =  .Horaexpo			lxDespimpBdaltafw =  .Basededatosaltafw			lxDespimpBdmodifw =  .Basededatosmodificacionfw			lxDespimpHaltafw =  .Horaaltafw			lxDespimpDespacho =  .Despacho			lxDespimpIncoterms =  upper( .Incoterms_PK ) 			lxDespimpFechaing =  .Fechaing			lxDespimpMoneda =  upper( .Moneda_PK ) 			lxDespimpOficializ =  .Oficializacion			lxDespimpCantuni =  .Cantunidades			lxDespimpArribo =  .Arribo			lxDespimpFob =  .Fob			lxDespimpFlete =  .Flete			lxDespimpSeguro =  .Seguro			lxDespimpObs =  .Observacion			lxDespimpFtotal =  .Total
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.DESPIMP ( "Faltafw","Fecexpo","Fectrans","Fmodifw","Fecimpo","Timestamp","Zadsfw","Hmodifw","Saltafw","Umodifw","Horaimpo","Ualtafw","Vmodifw","Valtafw","Smodifw","Esttrans","Horaexpo","Bdaltafw","Bdmodifw","Haltafw","Despacho","Incoterms","Fechaing","Moneda","Oficializ","Cantuni","Arribo","Fob","Flete","Seguro","Obs","Ftotal" ) values ( <<"'" + this.ConvertirDateSql( lxDespimpFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFecimpo ) + "'" >>, <<lxDespimpTimestamp >>, <<"'" + this.FormatearTextoSql( lxDespimpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpDespacho ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpIncoterms ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpFechaing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpMoneda ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpOficializ ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDespimpCantuni ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDespimpArribo ) + "'" >>, <<lxDespimpFob >>, <<lxDespimpFlete >>, <<lxDespimpSeguro >>, <<"'" + this.FormatearTextoSql( lxDespimpObs ) + "'" >>, <<lxDespimpFtotal >> )
		endtext
		loColeccion.cTabla = 'DESPIMP' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.DESPACHO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleArticulos
				if this.oEntidad.DetalleArticulos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxOficializacion = loItem.Oficializacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DespImpDet("NROITEM","Codigo","CodArt","Descrip","Oficializ" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxOficializacion ) + "'">> ) 
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
			local  lxDespimpFaltafw, lxDespimpFecexpo, lxDespimpFectrans, lxDespimpFmodifw, lxDespimpFecimpo, lxDespimpTimestamp, lxDespimpZadsfw, lxDespimpHmodifw, lxDespimpSaltafw, lxDespimpUmodifw, lxDespimpHoraimpo, lxDespimpUaltafw, lxDespimpVmodifw, lxDespimpValtafw, lxDespimpSmodifw, lxDespimpEsttrans, lxDespimpHoraexpo, lxDespimpBdaltafw, lxDespimpBdmodifw, lxDespimpHaltafw, lxDespimpDespacho, lxDespimpIncoterms, lxDespimpFechaing, lxDespimpMoneda, lxDespimpOficializ, lxDespimpCantuni, lxDespimpArribo, lxDespimpFob, lxDespimpFlete, lxDespimpSeguro, lxDespimpObs, lxDespimpFtotal
				lxDespimpFaltafw =  .Fechaaltafw			lxDespimpFecexpo =  .Fechaexpo			lxDespimpFectrans =  .Fechatransferencia			lxDespimpFmodifw =  .Fechamodificacionfw			lxDespimpFecimpo =  .Fechaimpo			lxDespimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDespimpZadsfw =  .Zadsfw			lxDespimpHmodifw =  .Horamodificacionfw			lxDespimpSaltafw =  .Seriealtafw			lxDespimpUmodifw =  .Usuariomodificacionfw			lxDespimpHoraimpo =  .Horaimpo			lxDespimpUaltafw =  .Usuarioaltafw			lxDespimpVmodifw =  .Versionmodificacionfw			lxDespimpValtafw =  .Versionaltafw			lxDespimpSmodifw =  .Seriemodificacionfw			lxDespimpEsttrans =  .Estadotransferencia			lxDespimpHoraexpo =  .Horaexpo			lxDespimpBdaltafw =  .Basededatosaltafw			lxDespimpBdmodifw =  .Basededatosmodificacionfw			lxDespimpHaltafw =  .Horaaltafw			lxDespimpDespacho =  .Despacho			lxDespimpIncoterms =  upper( .Incoterms_PK ) 			lxDespimpFechaing =  .Fechaing			lxDespimpMoneda =  upper( .Moneda_PK ) 			lxDespimpOficializ =  .Oficializacion			lxDespimpCantuni =  .Cantunidades			lxDespimpArribo =  .Arribo			lxDespimpFob =  .Fob			lxDespimpFlete =  .Flete			lxDespimpSeguro =  .Seguro			lxDespimpObs =  .Observacion			lxDespimpFtotal =  .Total
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.DESPACHO
			lcValorClavePrimariaString = "'" + this.oEntidad.DESPACHO + "'"

			lcFiltro = ["Despacho" = ] + lcValorClavePrimariaString  + [ and  DESPIMP.DESPACHO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.DESPIMP set "Faltafw" = <<"'" + this.ConvertirDateSql( lxDespimpFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDespimpFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxDespimpFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDespimpFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDespimpFecimpo ) + "'">>, "Timestamp" = <<lxDespimpTimestamp>>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxDespimpZadsfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxDespimpHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxDespimpSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxDespimpUmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxDespimpHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxDespimpUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxDespimpVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxDespimpValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxDespimpSmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxDespimpEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxDespimpHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDespimpBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDespimpBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxDespimpHaltafw ) + "'">>, "Despacho" = <<"'" + this.FormatearTextoSql( lxDespimpDespacho ) + "'">>, "Incoterms" = <<"'" + this.FormatearTextoSql( lxDespimpIncoterms ) + "'">>, "Fechaing" = <<"'" + this.ConvertirDateSql( lxDespimpFechaing ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxDespimpMoneda ) + "'">>, "Oficializ" = <<"'" + this.ConvertirDateSql( lxDespimpOficializ ) + "'">>, "Cantuni" = <<"'" + this.FormatearTextoSql( lxDespimpCantuni ) + "'">>, "Arribo" = <<"'" + this.ConvertirDateSql( lxDespimpArribo ) + "'">>, "Fob" = <<lxDespimpFob>>, "Flete" = <<lxDespimpFlete>>, "Seguro" = <<lxDespimpSeguro>>, "Obs" = <<"'" + this.FormatearTextoSql( lxDespimpObs ) + "'">>, "Ftotal" = <<lxDespimpFtotal>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'DESPIMP' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DespImpDet where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.DESPACHO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleArticulos
				if this.oEntidad.DetalleArticulos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxOficializacion = loItem.Oficializacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DespImpDet("NROITEM","Codigo","CodArt","Descrip","Oficializ" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxOficializacion ) + "'">> ) 
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
			lxValorClavePrimaria = this.oEntidad.DESPACHO
			lcValorClavePrimariaString = "'" + this.oEntidad.DESPACHO + "'"

			lcFiltro = ["Despacho" = ] + lcValorClavePrimariaString  + [ and  DESPIMP.DESPACHO != '']
		loColeccion.Agregar( 'delete from ZooLogic.DESPIMP where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DespImpDet where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.DESPACHO ) + "'")
			loColeccion.cTabla = 'DESPIMP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.DESPIMP where  DESPIMP.DESPACHO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.DESPIMP where Despacho = " + "'" + this.FormatearTextoSql( this.oEntidad.DESPACHO ) + "'"+ " and  DESPIMP.DESPACHO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DESPACHODEIMPORTACION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.DESPIMP Where Despacho = ] + "'" + this.FormatearTextoSql( &lcCursor..Despacho ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.DESPIMP set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Despacho = ] + "'" + this.FormatearTextoSql( &lcCursor..Despacho ) + "'"+ [, Incoterms = ] + "'" + this.FormatearTextoSql( &lcCursor..Incoterms ) + "'"+ [, FechaIng = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaIng ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Oficializ = ] + "'" + this.ConvertirDateSql( &lcCursor..Oficializ ) + "'"+ [, CantUni = ] + "'" + this.FormatearTextoSql( &lcCursor..CantUni ) + "'"+ [, Arribo = ] + "'" + this.ConvertirDateSql( &lcCursor..Arribo ) + "'"+ [, Fob = ] + transform( &lcCursor..Fob )+ [, Flete = ] + transform( &lcCursor..Flete )+ [, Seguro = ] + transform( &lcCursor..Seguro )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal ) + [ Where Despacho = ] + "'" + this.FormatearTextoSql( &lcCursor..Despacho ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FALTAFW, FECEXPO, FECTRANS, FMODIFW, FECIMPO, TIMESTAMP, ZADSFW, HMODIFW, SALTAFW, UMODIFW, HORAIMPO, UALTAFW, VMODIFW, VALTAFW, SMODIFW, ESTTRANS, HORAEXPO, BDALTAFW, BDMODIFW, HALTAFW, Despacho, Incoterms, FechaIng, Moneda, Oficializ, CantUni, Arribo, Fob, Flete, Seguro, Obs, FTotal
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Despacho ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Incoterms ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaIng ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Oficializ ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CantUni ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Arribo ) + "'" + ',' + transform( &lcCursor..Fob )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Flete ) + ',' + transform( &lcCursor..Seguro ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + transform( &lcCursor..FTotal )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.DESPIMP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DESPACHODEIMPORTACION'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Despacho','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Despacho')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DespImpDet Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSDESPACHO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Despacho from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","CodArt","Descrip","Oficializ"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DespImpDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodArt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.Oficializ  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Despacho C (16) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número despacho: ' + transform( &tcCursor..Despacho   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'DESPACHODEIMPORTACION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DESPACHODEIMPORTACION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DESPACHODEIMPORTACION_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSDESPACHO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_DespImp')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DESPACHODEIMPORTACION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Despacho
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DESPACHODEIMPORTACION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESPACHODEIMPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Despacho as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Despacho, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESPACHODEIMPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FechaIng  
		* Validar ANTERIORES A 1/1/1753  Oficializ 
		* Validar ANTERIORES A 1/1/1753  Arribo    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_DespImp') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_DespImp
Create Table ZooLogic.TablaTrabajo_DespImp ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"zadsfw" varchar(max)  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"despacho" char( 16 )  null, 
"incoterms" char( 3 )  null, 
"fechaing" datetime  null, 
"moneda" char( 10 )  null, 
"oficializ" datetime  null, 
"cantuni" char( 9 )  null, 
"arribo" datetime  null, 
"fob" numeric( 15, 2 )  null, 
"flete" numeric( 15, 2 )  null, 
"seguro" numeric( 15, 2 )  null, 
"obs" varchar(max)  null, 
"ftotal" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_DespImp' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_DespImp' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESPACHODEIMPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('despacho','despacho')
			.AgregarMapeo('incoterms','incoterms')
			.AgregarMapeo('fechaing','fechaing')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('oficializ','oficializ')
			.AgregarMapeo('cantuni','cantuni')
			.AgregarMapeo('arribo','arribo')
			.AgregarMapeo('fob','fob')
			.AgregarMapeo('flete','flete')
			.AgregarMapeo('seguro','seguro')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('ftotal','ftotal')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_DespImp'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.DESPACHO = isnull( d.DESPACHO, t.DESPACHO ),t.INCOTERMS = isnull( d.INCOTERMS, t.INCOTERMS ),t.FECHAING = isnull( d.FECHAING, t.FECHAING ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.OFICIALIZ = isnull( d.OFICIALIZ, t.OFICIALIZ ),t.CANTUNI = isnull( d.CANTUNI, t.CANTUNI ),t.ARRIBO = isnull( d.ARRIBO, t.ARRIBO ),t.FOB = isnull( d.FOB, t.FOB ),t.FLETE = isnull( d.FLETE, t.FLETE ),t.SEGURO = isnull( d.SEGURO, t.SEGURO ),t.OBS = isnull( d.OBS, t.OBS ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL )
					from ZooLogic.DESPIMP t inner join deleted d 
							 on t.Despacho = d.Despacho
				-- Fin Updates
				insert into ZooLogic.DESPIMP(Faltafw,Fecexpo,Fectrans,Fmodifw,Fecimpo,Timestamp,Zadsfw,Hmodifw,Saltafw,Umodifw,Horaimpo,Ualtafw,Vmodifw,Valtafw,Smodifw,Esttrans,Horaexpo,Bdaltafw,Bdmodifw,Haltafw,Despacho,Incoterms,Fechaing,Moneda,Oficializ,Cantuni,Arribo,Fob,Flete,Seguro,Obs,Ftotal)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.TIMESTAMP,0),isnull( d.ZADSFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.DESPACHO,''),isnull( d.INCOTERMS,''),isnull( d.FECHAING,''),isnull( d.MONEDA,''),isnull( d.OFICIALIZ,''),isnull( d.CANTUNI,''),isnull( d.ARRIBO,''),isnull( d.FOB,0),isnull( d.FLETE,0),isnull( d.SEGURO,0),isnull( d.OBS,''),isnull( d.FTOTAL,0)
						From deleted d left join ZooLogic.DESPIMP pk 
							 on d.Despacho = pk.Despacho
						Where pk.Despacho Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DespImpDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_DESPIMP_DespImpDet
ON ZooLogic.TablaTrabajo_DESPIMP_DespImpDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODART = isnull( d.CODART, t.CODART ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OFICIALIZ = isnull( d.OFICIALIZ, t.OFICIALIZ )
from ZooLogic.DespImpDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DespImpDet
( 
"NROITEM",
"CODIGO",
"CODART",
"DESCRIP",
"OFICIALIZ"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CODART,
d.DESCRIP,
d.OFICIALIZ
From deleted d left join ZooLogic.DespImpDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_DespImp') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_DespImp
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DESPACHODEIMPORTACION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESPACHODEIMPORTACION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESPACHODEIMPORTACION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESPACHODEIMPORTACION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESPACHODEIMPORTACION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESPACHODEIMPORTACION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_DESPACHODEIMPORTACION.Timestamp, 0 )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horamodificacionfw = nvl( c_DESPACHODEIMPORTACION.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_DESPACHODEIMPORTACION.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_DESPACHODEIMPORTACION.Usuariomodificacionfw, [] )
					.Horaimpo = nvl( c_DESPACHODEIMPORTACION.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_DESPACHODEIMPORTACION.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_DESPACHODEIMPORTACION.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_DESPACHODEIMPORTACION.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_DESPACHODEIMPORTACION.Seriemodificacionfw, [] )
					.Estadotransferencia = nvl( c_DESPACHODEIMPORTACION.Estadotransferencia, [] )
					.Horaexpo = nvl( c_DESPACHODEIMPORTACION.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_DESPACHODEIMPORTACION.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_DESPACHODEIMPORTACION.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_DESPACHODEIMPORTACION.Horaaltafw, [] )
					.Despacho = nvl( c_DESPACHODEIMPORTACION.Despacho, [] )
					.Incoterms_PK =  nvl( c_DESPACHODEIMPORTACION.Incoterms, [] )
					.Fechaing = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESPACHODEIMPORTACION.Fechaing, ctod( '  /  /    ' ) ) )
					.Moneda_PK =  nvl( c_DESPACHODEIMPORTACION.Moneda, [] )
					.Oficializacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESPACHODEIMPORTACION.Oficializacion, ctod( '  /  /    ' ) ) )
					.Cantunidades = nvl( c_DESPACHODEIMPORTACION.Cantunidades, [] )
					.Arribo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESPACHODEIMPORTACION.Arribo, ctod( '  /  /    ' ) ) )
					.Fob = nvl( c_DESPACHODEIMPORTACION.Fob, 0 )
					.Flete = nvl( c_DESPACHODEIMPORTACION.Flete, 0 )
					.Seguro = nvl( c_DESPACHODEIMPORTACION.Seguro, 0 )
					.Detallearticulos.Limpiar()
					.Detallearticulos.SetearEsNavegacion( .lProcesando )
					.Detallearticulos.Cargar()
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Total = nvl( c_DESPACHODEIMPORTACION.Total, 0 )
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
		
		loDetalle = this.oEntidad.DetalleArticulos
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
		return c_DESPACHODEIMPORTACION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.DESPIMP' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Despacho"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Despacho as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Despacho from (
							select * 
								from ZooLogic.DESPIMP 
								Where   DESPIMP.DESPACHO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "DESPIMP", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Despacho"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Despacho" as "Despacho", "Incoterms" as "Incoterms", "Fechaing" as "Fechaing", "Moneda" as "Moneda", "Oficializ" as "Oficializacion", "Cantuni" as "Cantunidades", "Arribo" as "Arribo", "Fob" as "Fob", "Flete" as "Flete", "Seguro" as "Seguro", "Obs" as "Observacion", "Ftotal" as "Total"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.DESPIMP 
								Where   DESPIMP.DESPACHO != ''
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
	Tabla = 'DESPIMP'
	Filtro = " DESPIMP.DESPACHO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " DESPIMP.DESPACHO != ''"
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
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FECHA                                   " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FECHAALTAFW                             " tabla="DESPIMP        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FECHAEXPO                               " tabla="DESPIMP        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FECHATRANSFERENCIA                      " tabla="DESPIMP        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FECHAMODIFICACIONFW                     " tabla="DESPIMP        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FECHAIMPO                               " tabla="DESPIMP        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="TIMESTAMP                               " tabla="DESPIMP        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="ZADSFW                                  " tabla="DESPIMP        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="HORAMODIFICACIONFW                      " tabla="DESPIMP        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="SERIEALTAFW                             " tabla="DESPIMP        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="USUARIOMODIFICACIONFW                   " tabla="DESPIMP        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="HORAIMPO                                " tabla="DESPIMP        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="USUARIOALTAFW                           " tabla="DESPIMP        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="VERSIONMODIFICACIONFW                   " tabla="DESPIMP        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="VERSIONALTAFW                           " tabla="DESPIMP        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="SERIEMODIFICACIONFW                     " tabla="DESPIMP        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="ESTADOTRANSFERENCIA                     " tabla="DESPIMP        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="HORAEXPO                                " tabla="DESPIMP        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="BASEDEDATOSALTAFW                       " tabla="DESPIMP        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="DESPIMP        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="HORAALTAFW                              " tabla="DESPIMP        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="DESPACHO                                " tabla="DESPIMP        " campo="DESPACHO  " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="16" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número despacho                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="INCOTERMS                               " tabla="DESPIMP        " campo="INCOTERMS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INCOTERMS                               " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Incoterms                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FECHAING                                " tabla="DESPIMP        " campo="FECHAING  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="402" etiqueta="Fecha ingreso                                                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="MONEDA                                  " tabla="DESPIMP        " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="OFICIALIZACION                          " tabla="DESPIMP        " campo="OFICIALIZ " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Oficialización                                                                                                                                                  " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="CANTUNIDADES                            " tabla="DESPIMP        " campo="CANTUNI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Cantidad unidades                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="ARRIBO                                  " tabla="DESPIMP        " campo="ARRIBO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Arribo                                                                                                                                                          " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FOB                                     " tabla="DESPIMP        " campo="FOB       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="FOB total                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="FLETE                                   " tabla="DESPIMP        " campo="FLETE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Flete total                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="SEGURO                                  " tabla="DESPIMP        " campo="SEGURO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Seguro total                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="DETALLEARTICULOS                        " tabla="DESPIMPDET     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Artículos                                                                                                                                                       " dominio="DETALLEITEMARTICULOSDESPACHO  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="70" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="OBSERVACION                             " tabla="DESPIMP        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="100" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="TOTAL                                   " tabla="DESPIMP        " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="110" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCOTERMS                               " atributo="DESCRIPCION                             " tabla="INCOT          " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Inc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INCOT On DESPIMP.INCOTERMS = INCOT.cod And  INCOT.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On DESPIMP.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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