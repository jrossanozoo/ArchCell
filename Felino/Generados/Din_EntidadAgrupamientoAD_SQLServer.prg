
define class Din_EntidadAGRUPAMIENTOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_AGRUPAMIENTO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AGRPK'
	cTablaPrincipal = 'AGRUPAMIENTO'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'PUESTO'
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'PUESTO'
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
			local  lxAgrupamientoFecexpo, lxAgrupamientoFmodifw, lxAgrupamientoFecimpo, lxAgrupamientoFaltafw, lxAgrupamientoFectrans, lxAgrupamientoTimestamp, lxAgrupamientoUaltafw, lxAgrupamientoSmodifw, lxAgrupamientoUmodifw, lxAgrupamientoValtafw, lxAgrupamientoSaltafw, lxAgrupamientoZadsfw, lxAgrupamientoVmodifw, lxAgrupamientoHoraexpo, lxAgrupamientoHmodifw, lxAgrupamientoEsttrans, lxAgrupamientoHoraimpo, lxAgrupamientoBdmodifw, lxAgrupamientoBdaltafw, lxAgrupamientoHaltafw, lxAgrupamientoObs, lxAgrupamientoCodigo, lxAgrupamientoDescrip
				lxAgrupamientoFecexpo =  .Fechaexpo			lxAgrupamientoFmodifw =  .Fechamodificacionfw			lxAgrupamientoFecimpo =  .Fechaimpo			lxAgrupamientoFaltafw =  .Fechaaltafw			lxAgrupamientoFectrans =  .Fechatransferencia			lxAgrupamientoTimestamp = goLibrerias.ObtenerTimestamp()			lxAgrupamientoUaltafw =  .Usuarioaltafw			lxAgrupamientoSmodifw =  .Seriemodificacionfw			lxAgrupamientoUmodifw =  .Usuariomodificacionfw			lxAgrupamientoValtafw =  .Versionaltafw			lxAgrupamientoSaltafw =  .Seriealtafw			lxAgrupamientoZadsfw =  .Zadsfw			lxAgrupamientoVmodifw =  .Versionmodificacionfw			lxAgrupamientoHoraexpo =  .Horaexpo			lxAgrupamientoHmodifw =  .Horamodificacionfw			lxAgrupamientoEsttrans =  .Estadotransferencia			lxAgrupamientoHoraimpo =  .Horaimpo			lxAgrupamientoBdmodifw =  .Basededatosmodificacionfw			lxAgrupamientoBdaltafw =  .Basededatosaltafw			lxAgrupamientoHaltafw =  .Horaaltafw			lxAgrupamientoObs =  .Obs			lxAgrupamientoCodigo =  .Codigo			lxAgrupamientoDescrip =  .Descripcion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAgrupamientoCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into PUESTO.AGRUPAMIENTO ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Timestamp","Ualtafw","Smodifw","Umodifw","Valtafw","Saltafw","Zadsfw","Vmodifw","Horaexpo","Hmodifw","Esttrans","Horaimpo","Bdmodifw","Bdaltafw","Haltafw","Obs","Codigo","Descrip" ) values ( <<"'" + this.ConvertirDateSql( lxAgrupamientoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrupamientoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrupamientoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrupamientoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrupamientoFectrans ) + "'" >>, <<lxAgrupamientoTimestamp >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoDescrip ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgrupamientoDetalle
				if this.oEntidad.AgrupamientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIncluye = loItem.Incluye
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into PUESTO.AgrupAG("NROITEM","Codigo","incluye","Agrup","Descrip" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<iif( lxIncluye, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.BaseDeDatosDetalle
				if this.oEntidad.BaseDeDatosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIncluye = loItem.Incluye
					lxBasededatos_PK = loItem.Basededatos_PK
					lxBasededatosdetalle = loItem.Basededatosdetalle
					Text to lcCadena noshow textmerge
						Insert into PUESTO.AgrupBD("NROITEM","Codigo","incluye","Basededato","Ruta" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<iif( lxIncluye, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxBasededatos_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosdetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxAgrupamientoTimestamp
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
			local  lxAgrupamientoFecexpo, lxAgrupamientoFmodifw, lxAgrupamientoFecimpo, lxAgrupamientoFaltafw, lxAgrupamientoFectrans, lxAgrupamientoTimestamp, lxAgrupamientoUaltafw, lxAgrupamientoSmodifw, lxAgrupamientoUmodifw, lxAgrupamientoValtafw, lxAgrupamientoSaltafw, lxAgrupamientoZadsfw, lxAgrupamientoVmodifw, lxAgrupamientoHoraexpo, lxAgrupamientoHmodifw, lxAgrupamientoEsttrans, lxAgrupamientoHoraimpo, lxAgrupamientoBdmodifw, lxAgrupamientoBdaltafw, lxAgrupamientoHaltafw, lxAgrupamientoObs, lxAgrupamientoCodigo, lxAgrupamientoDescrip
				lxAgrupamientoFecexpo =  .Fechaexpo			lxAgrupamientoFmodifw =  .Fechamodificacionfw			lxAgrupamientoFecimpo =  .Fechaimpo			lxAgrupamientoFaltafw =  .Fechaaltafw			lxAgrupamientoFectrans =  .Fechatransferencia			lxAgrupamientoTimestamp = goLibrerias.ObtenerTimestamp()			lxAgrupamientoUaltafw =  .Usuarioaltafw			lxAgrupamientoSmodifw =  .Seriemodificacionfw			lxAgrupamientoUmodifw =  .Usuariomodificacionfw			lxAgrupamientoValtafw =  .Versionaltafw			lxAgrupamientoSaltafw =  .Seriealtafw			lxAgrupamientoZadsfw =  .Zadsfw			lxAgrupamientoVmodifw =  .Versionmodificacionfw			lxAgrupamientoHoraexpo =  .Horaexpo			lxAgrupamientoHmodifw =  .Horamodificacionfw			lxAgrupamientoEsttrans =  .Estadotransferencia			lxAgrupamientoHoraimpo =  .Horaimpo			lxAgrupamientoBdmodifw =  .Basededatosmodificacionfw			lxAgrupamientoBdaltafw =  .Basededatosaltafw			lxAgrupamientoHaltafw =  .Horaaltafw			lxAgrupamientoObs =  .Obs			lxAgrupamientoCodigo =  .Codigo			lxAgrupamientoDescrip =  .Descripcion
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
				update PUESTO.AGRUPAMIENTO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFectrans ) + "'">>,"Timestamp" = <<lxAgrupamientoTimestamp>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAgrupamientoEsttrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoHaltafw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxAgrupamientoObs ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxAgrupamientoDescrip ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoCodigo ) + "'">> and  AGRUPAMIENTO.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from PUESTO.AgrupAG where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from PUESTO.AgrupBD where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgrupamientoDetalle
				if this.oEntidad.AgrupamientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIncluye = loItem.Incluye
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into PUESTO.AgrupAG("NROITEM","Codigo","incluye","Agrup","Descrip" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<iif( lxIncluye, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.BaseDeDatosDetalle
				if this.oEntidad.BaseDeDatosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIncluye = loItem.Incluye
					lxBasededatos_PK = loItem.Basededatos_PK
					lxBasededatosdetalle = loItem.Basededatosdetalle
					Text to lcCadena noshow textmerge
						Insert into PUESTO.AgrupBD("NROITEM","Codigo","incluye","Basededato","Ruta" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<iif( lxIncluye, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxBasededatos_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosdetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxAgrupamientoTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from PUESTO.AGRUPAMIENTO where " + this.ConvertirFuncionesSql( " AGRUPAMIENTO.CODIGO != ''" ) )
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
			Local lxAgrupamientoCodigo
			lxAgrupamientoCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion" from PUESTO.AGRUPAMIENTO where "Codigo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoCodigo ) + "'">> and  AGRUPAMIENTO.CODIGO != ''
			endtext
			use in select('c_AGRUPAMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPAMIENTO', set( 'Datasession' ) )

			if reccount( 'c_AGRUPAMIENTO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Agrup" as "Agrupamiento", "Descrip" as "Agrupamientodetalle" from PUESTO.AgrupAG where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgrupamientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgrupamientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgrupamientoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Basededato" as "Basededatos", "Ruta" as "Basededatosdetalle" from PUESTO.AgrupBD where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_BaseDeDatosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BaseDeDatosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_BaseDeDatosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAgrupamientoCodigo as Variant
		llRetorno = .t.
		lxAgrupamientoCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from PUESTO.AGRUPAMIENTO where "Codigo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoCodigo ) + "'">> and  AGRUPAMIENTO.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion" from PUESTO.AGRUPAMIENTO where  AGRUPAMIENTO.CODIGO != '' order by Codigo
			endtext
			use in select('c_AGRUPAMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPAMIENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Agrup" as "Agrupamiento", "Descrip" as "Agrupamientodetalle" from PUESTO.AgrupAG where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgrupamientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgrupamientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgrupamientoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Basededato" as "Basededatos", "Ruta" as "Basededatosdetalle" from PUESTO.AgrupBD where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_BaseDeDatosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BaseDeDatosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_BaseDeDatosDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion" from PUESTO.AGRUPAMIENTO where  funciones.padr( Codigo, 21, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AGRUPAMIENTO.CODIGO != '' order by Codigo
			endtext
			use in select('c_AGRUPAMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPAMIENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Agrup" as "Agrupamiento", "Descrip" as "Agrupamientodetalle" from PUESTO.AgrupAG where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgrupamientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgrupamientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgrupamientoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Basededato" as "Basededatos", "Ruta" as "Basededatosdetalle" from PUESTO.AgrupBD where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_BaseDeDatosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BaseDeDatosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_BaseDeDatosDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion" from PUESTO.AGRUPAMIENTO where  funciones.padr( Codigo, 21, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AGRUPAMIENTO.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_AGRUPAMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPAMIENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Agrup" as "Agrupamiento", "Descrip" as "Agrupamientodetalle" from PUESTO.AgrupAG where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgrupamientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgrupamientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgrupamientoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Basededato" as "Basededatos", "Ruta" as "Basededatosdetalle" from PUESTO.AgrupBD where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_BaseDeDatosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BaseDeDatosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_BaseDeDatosDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion" from PUESTO.AGRUPAMIENTO where  AGRUPAMIENTO.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_AGRUPAMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AGRUPAMIENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Agrup" as "Agrupamiento", "Descrip" as "Agrupamientodetalle" from PUESTO.AgrupAG where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgrupamientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgrupamientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgrupamientoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Basededato" as "Basededatos", "Ruta" as "Basededatosdetalle" from PUESTO.AgrupBD where Codigo = <<"'" + this.FormatearTextoSql( c_AGRUPAMIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_BaseDeDatosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BaseDeDatosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_BaseDeDatosDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Timestamp,Ualtafw,Smodifw,Umodifw,Valtafw,Saltafw,Z" + ;
"adsfw,Vmodifw,Horaexpo,Hmodifw,Esttrans,Horaimpo,Bdmodifw,Bdaltafw,Haltafw,Obs,Codigo,Descrip" + ;
" from PUESTO.AGRUPAMIENTO where  AGRUPAMIENTO.CODIGO != '' and " + lcFiltro )
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
			local  lxAgrupamientoFecexpo, lxAgrupamientoFmodifw, lxAgrupamientoFecimpo, lxAgrupamientoFaltafw, lxAgrupamientoFectrans, lxAgrupamientoTimestamp, lxAgrupamientoUaltafw, lxAgrupamientoSmodifw, lxAgrupamientoUmodifw, lxAgrupamientoValtafw, lxAgrupamientoSaltafw, lxAgrupamientoZadsfw, lxAgrupamientoVmodifw, lxAgrupamientoHoraexpo, lxAgrupamientoHmodifw, lxAgrupamientoEsttrans, lxAgrupamientoHoraimpo, lxAgrupamientoBdmodifw, lxAgrupamientoBdaltafw, lxAgrupamientoHaltafw, lxAgrupamientoObs, lxAgrupamientoCodigo, lxAgrupamientoDescrip
				lxAgrupamientoFecexpo = ctod( '  /  /    ' )			lxAgrupamientoFmodifw = ctod( '  /  /    ' )			lxAgrupamientoFecimpo = ctod( '  /  /    ' )			lxAgrupamientoFaltafw = ctod( '  /  /    ' )			lxAgrupamientoFectrans = ctod( '  /  /    ' )			lxAgrupamientoTimestamp = goLibrerias.ObtenerTimestamp()			lxAgrupamientoUaltafw = []			lxAgrupamientoSmodifw = []			lxAgrupamientoUmodifw = []			lxAgrupamientoValtafw = []			lxAgrupamientoSaltafw = []			lxAgrupamientoZadsfw = []			lxAgrupamientoVmodifw = []			lxAgrupamientoHoraexpo = []			lxAgrupamientoHmodifw = []			lxAgrupamientoEsttrans = []			lxAgrupamientoHoraimpo = []			lxAgrupamientoBdmodifw = []			lxAgrupamientoBdaltafw = []			lxAgrupamientoHaltafw = []			lxAgrupamientoObs = []			lxAgrupamientoCodigo = []			lxAgrupamientoDescrip = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from PUESTO.AgrupAG where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from PUESTO.AgrupBD where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from PUESTO.AGRUPAMIENTO where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'AGRUPAMIENTO' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPAMIENTO.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AGRUPAMIENTO', '', tnTope )
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
	Function ObtenerDatosDetalleAgrupamientoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPAG.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Agrup" as "Agrupamiento", "Descrip" as "Agrupamientodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAgrupamientoDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgrupAG', 'AgrupamientoDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAgrupamientoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAgrupamientoDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleBaseDeDatosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPBD.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Incluye" as "Incluye", "Basededato" as "Basededatos", "Ruta" as "Basededatosdetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleBaseDeDatosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgrupBD', 'BaseDeDatosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleBaseDeDatosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleBaseDeDatosDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAgrupamientoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'INCLUYE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INCLUYE AS INCLUYE'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'AGRUPAMIENTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS AGRUPAMIENTODETALLE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleBaseDeDatosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'INCLUYE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INCLUYE AS INCLUYE'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDEDATO AS BASEDEDATOS'
				Case lcAtributo == 'BASEDEDATOSDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUTA AS BASEDEDATOSDETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAgrupamientoDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'INCLUYE'
				lcCampo = 'INCLUYE'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTODETALLE'
				lcCampo = 'DESCRIP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleBaseDeDatosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'INCLUYE'
				lcCampo = 'INCLUYE'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASEDEDATO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSDETALLE'
				lcCampo = 'RUTA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AGRUPAMIENTODETALLE'
			lcRetorno = 'AGRUPAG'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'BASEDEDATOSDETALLE'
			lcRetorno = 'AGRUPBD'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAgrupamientoFecexpo, lxAgrupamientoFmodifw, lxAgrupamientoFecimpo, lxAgrupamientoFaltafw, lxAgrupamientoFectrans, lxAgrupamientoTimestamp, lxAgrupamientoUaltafw, lxAgrupamientoSmodifw, lxAgrupamientoUmodifw, lxAgrupamientoValtafw, lxAgrupamientoSaltafw, lxAgrupamientoZadsfw, lxAgrupamientoVmodifw, lxAgrupamientoHoraexpo, lxAgrupamientoHmodifw, lxAgrupamientoEsttrans, lxAgrupamientoHoraimpo, lxAgrupamientoBdmodifw, lxAgrupamientoBdaltafw, lxAgrupamientoHaltafw, lxAgrupamientoObs, lxAgrupamientoCodigo, lxAgrupamientoDescrip
				lxAgrupamientoFecexpo =  .Fechaexpo			lxAgrupamientoFmodifw =  .Fechamodificacionfw			lxAgrupamientoFecimpo =  .Fechaimpo			lxAgrupamientoFaltafw =  .Fechaaltafw			lxAgrupamientoFectrans =  .Fechatransferencia			lxAgrupamientoTimestamp = goLibrerias.ObtenerTimestamp()			lxAgrupamientoUaltafw =  .Usuarioaltafw			lxAgrupamientoSmodifw =  .Seriemodificacionfw			lxAgrupamientoUmodifw =  .Usuariomodificacionfw			lxAgrupamientoValtafw =  .Versionaltafw			lxAgrupamientoSaltafw =  .Seriealtafw			lxAgrupamientoZadsfw =  .Zadsfw			lxAgrupamientoVmodifw =  .Versionmodificacionfw			lxAgrupamientoHoraexpo =  .Horaexpo			lxAgrupamientoHmodifw =  .Horamodificacionfw			lxAgrupamientoEsttrans =  .Estadotransferencia			lxAgrupamientoHoraimpo =  .Horaimpo			lxAgrupamientoBdmodifw =  .Basededatosmodificacionfw			lxAgrupamientoBdaltafw =  .Basededatosaltafw			lxAgrupamientoHaltafw =  .Horaaltafw			lxAgrupamientoObs =  .Obs			lxAgrupamientoCodigo =  .Codigo			lxAgrupamientoDescrip =  .Descripcion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into PUESTO.AGRUPAMIENTO ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Timestamp","Ualtafw","Smodifw","Umodifw","Valtafw","Saltafw","Zadsfw","Vmodifw","Horaexpo","Hmodifw","Esttrans","Horaimpo","Bdmodifw","Bdaltafw","Haltafw","Obs","Codigo","Descrip" ) values ( <<"'" + this.ConvertirDateSql( lxAgrupamientoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrupamientoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrupamientoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrupamientoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAgrupamientoFectrans ) + "'" >>, <<lxAgrupamientoTimestamp >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAgrupamientoDescrip ) + "'" >> )
		endtext
		loColeccion.cTabla = 'AGRUPAMIENTO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgrupamientoDetalle
				if this.oEntidad.AgrupamientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIncluye = loItem.Incluye
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into PUESTO.AgrupAG("NROITEM","Codigo","incluye","Agrup","Descrip" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<iif( lxIncluye, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.BaseDeDatosDetalle
				if this.oEntidad.BaseDeDatosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIncluye = loItem.Incluye
					lxBasededatos_PK = loItem.Basededatos_PK
					lxBasededatosdetalle = loItem.Basededatosdetalle
					Text to lcCadena noshow textmerge
						Insert into PUESTO.AgrupBD("NROITEM","Codigo","incluye","Basededato","Ruta" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<iif( lxIncluye, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxBasededatos_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosdetalle ) + "'">> ) 
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
			local  lxAgrupamientoFecexpo, lxAgrupamientoFmodifw, lxAgrupamientoFecimpo, lxAgrupamientoFaltafw, lxAgrupamientoFectrans, lxAgrupamientoTimestamp, lxAgrupamientoUaltafw, lxAgrupamientoSmodifw, lxAgrupamientoUmodifw, lxAgrupamientoValtafw, lxAgrupamientoSaltafw, lxAgrupamientoZadsfw, lxAgrupamientoVmodifw, lxAgrupamientoHoraexpo, lxAgrupamientoHmodifw, lxAgrupamientoEsttrans, lxAgrupamientoHoraimpo, lxAgrupamientoBdmodifw, lxAgrupamientoBdaltafw, lxAgrupamientoHaltafw, lxAgrupamientoObs, lxAgrupamientoCodigo, lxAgrupamientoDescrip
				lxAgrupamientoFecexpo =  .Fechaexpo			lxAgrupamientoFmodifw =  .Fechamodificacionfw			lxAgrupamientoFecimpo =  .Fechaimpo			lxAgrupamientoFaltafw =  .Fechaaltafw			lxAgrupamientoFectrans =  .Fechatransferencia			lxAgrupamientoTimestamp = goLibrerias.ObtenerTimestamp()			lxAgrupamientoUaltafw =  .Usuarioaltafw			lxAgrupamientoSmodifw =  .Seriemodificacionfw			lxAgrupamientoUmodifw =  .Usuariomodificacionfw			lxAgrupamientoValtafw =  .Versionaltafw			lxAgrupamientoSaltafw =  .Seriealtafw			lxAgrupamientoZadsfw =  .Zadsfw			lxAgrupamientoVmodifw =  .Versionmodificacionfw			lxAgrupamientoHoraexpo =  .Horaexpo			lxAgrupamientoHmodifw =  .Horamodificacionfw			lxAgrupamientoEsttrans =  .Estadotransferencia			lxAgrupamientoHoraimpo =  .Horaimpo			lxAgrupamientoBdmodifw =  .Basededatosmodificacionfw			lxAgrupamientoBdaltafw =  .Basededatosaltafw			lxAgrupamientoHaltafw =  .Horaaltafw			lxAgrupamientoObs =  .Obs			lxAgrupamientoCodigo =  .Codigo			lxAgrupamientoDescrip =  .Descripcion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  AGRUPAMIENTO.CODIGO != '']
			text to lcSentencia noshow textmerge
				update PUESTO.AGRUPAMIENTO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAgrupamientoFectrans ) + "'">>, "Timestamp" = <<lxAgrupamientoTimestamp>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAgrupamientoEsttrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAgrupamientoHaltafw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxAgrupamientoObs ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAgrupamientoCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxAgrupamientoDescrip ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'AGRUPAMIENTO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from PUESTO.AgrupAG where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from PUESTO.AgrupBD where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgrupamientoDetalle
				if this.oEntidad.AgrupamientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIncluye = loItem.Incluye
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into PUESTO.AgrupAG("NROITEM","Codigo","incluye","Agrup","Descrip" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<iif( lxIncluye, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.BaseDeDatosDetalle
				if this.oEntidad.BaseDeDatosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIncluye = loItem.Incluye
					lxBasededatos_PK = loItem.Basededatos_PK
					lxBasededatosdetalle = loItem.Basededatosdetalle
					Text to lcCadena noshow textmerge
						Insert into PUESTO.AgrupBD("NROITEM","Codigo","incluye","Basededato","Ruta" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<iif( lxIncluye, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxBasededatos_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosdetalle ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  AGRUPAMIENTO.CODIGO != '']
		loColeccion.Agregar( 'delete from PUESTO.AGRUPAMIENTO where ' + lcFiltro )
			loColeccion.Agregar([delete from PUESTO.AgrupAG where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from PUESTO.AgrupBD where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'AGRUPAMIENTO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from PUESTO.AGRUPAMIENTO where  AGRUPAMIENTO.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from PUESTO.AGRUPAMIENTO where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  AGRUPAMIENTO.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPAMIENTO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From PUESTO.AGRUPAMIENTO Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE PUESTO.AGRUPAMIENTO set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FMODIFW, FECIMPO, FALTAFW, FECTRANS, TIMESTAMP, UALTAFW, SMODIFW, UMODIFW, VALTAFW, SALTAFW, ZADSFW, VMODIFW, HORAEXPO, HMODIFW, ESTTRANS, HORAIMPO, BDMODIFW, BDALTAFW, HALTAFW, Obs, Codigo, Descrip
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into PUESTO.AGRUPAMIENTO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPAMIENTO'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From PUESTO.AgrupAG Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From PUESTO.AgrupBD Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAMIENTO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","incluye","Agrup","Descrip"
		endText
		this.oConexion.EjecutarSql( [Insert into PUESTO.AgrupAG ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + Transform( iif( cDetallesExistentes.incluye   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMBASEDEDATOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","incluye","Basededato","Ruta"
		endText
		this.oConexion.EjecutarSql( [Insert into PUESTO.AgrupBD ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + Transform( iif( cDetallesExistentes.incluye   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Basededato ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Ruta       ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (21) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'AGRUPAMIENTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AGRUPAMIENTO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AGRUPAMIENTO_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAMIENTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMBASEDEDATOS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From PUESTO.TablaTrabajo_Agrupamiento')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'AGRUPAMIENTO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad AGRUPAMIENTO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPAMIENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPAMIENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PUESTO.TablaTrabajo_Agrupamiento') AND type in ('U')) DROP TABLE PUESTO.TablaTrabajo_Agrupamiento
Create Table PUESTO.TablaTrabajo_Agrupamiento ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"obs" varchar(max)  null, 
"codigo" char( 21 )  null, 
"descrip" char( 40 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_Agrupamiento' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_Agrupamiento' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AGRUPAMIENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'PUESTO.TablaTrabajo_Agrupamiento'
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
			CREATE TRIGGER PUESTO.DELETE_<<lcTabla>>
				ON PUESTO.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.OBS = isnull( d.OBS, t.OBS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP )
					from PUESTO.AGRUPAMIENTO t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into PUESTO.AGRUPAMIENTO(Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Timestamp,Ualtafw,Smodifw,Umodifw,Valtafw,Saltafw,Zadsfw,Vmodifw,Horaexpo,Hmodifw,Esttrans,Horaimpo,Bdmodifw,Bdaltafw,Haltafw,Obs,Codigo,Descrip)
					Select isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.OBS,''),isnull( d.CODIGO,''),isnull( d.DESCRIP,'')
						From deleted d left join PUESTO.AGRUPAMIENTO pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgrupAG( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER PUESTO.DELETE_TablaTrabajo_AGRUPAMIENTO_AgrupAG
ON PUESTO.TablaTrabajo_AGRUPAMIENTO_AgrupAG
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.INCLUYE = isnull( d.INCLUYE, t.INCLUYE ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP )
from PUESTO.AgrupAG t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into PUESTO.AgrupAG
( 
"NROITEM",
"CODIGO",
"INCLUYE",
"AGRUP",
"DESCRIP"
 )
Select 
d.NROITEM,
d.CODIGO,
d.INCLUYE,
d.AGRUP,
d.DESCRIP
From deleted d left join PUESTO.AgrupAG pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgrupBD( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER PUESTO.DELETE_TablaTrabajo_AGRUPAMIENTO_AgrupBD
ON PUESTO.TablaTrabajo_AGRUPAMIENTO_AgrupBD
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.INCLUYE = isnull( d.INCLUYE, t.INCLUYE ),
t.BASEDEDATO = isnull( d.BASEDEDATO, t.BASEDEDATO ),
t.RUTA = isnull( d.RUTA, t.RUTA )
from PUESTO.AgrupBD t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into PUESTO.AgrupBD
( 
"NROITEM",
"CODIGO",
"INCLUYE",
"BASEDEDATO",
"RUTA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.INCLUYE,
d.BASEDEDATO,
d.RUTA
From deleted d left join PUESTO.AgrupBD pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PUESTO.TablaTrabajo_Agrupamiento') AND type in ('U')) DROP TABLE PUESTO.TablaTrabajo_Agrupamiento
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_AGRUPAMIENTO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPAMIENTO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPAMIENTO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPAMIENTO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPAMIENTO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_AGRUPAMIENTO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_AGRUPAMIENTO.Timestamp, 0 )
					.Usuarioaltafw = nvl( c_AGRUPAMIENTO.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_AGRUPAMIENTO.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_AGRUPAMIENTO.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_AGRUPAMIENTO.Versionaltafw, [] )
					.Seriealtafw = nvl( c_AGRUPAMIENTO.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_AGRUPAMIENTO.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_AGRUPAMIENTO.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_AGRUPAMIENTO.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_AGRUPAMIENTO.Estadotransferencia, [] )
					.Horaimpo = nvl( c_AGRUPAMIENTO.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_AGRUPAMIENTO.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_AGRUPAMIENTO.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_AGRUPAMIENTO.Horaaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Codigo = nvl( c_AGRUPAMIENTO.Codigo, [] )
					.Descripcion = nvl( c_AGRUPAMIENTO.Descripcion, [] )
					.Agrupamientodetalle.Limpiar()
					.Agrupamientodetalle.SetearEsNavegacion( .lProcesando )
					.Agrupamientodetalle.Cargar()
					.Basededatosdetalle.Limpiar()
					.Basededatosdetalle.SetearEsNavegacion( .lProcesando )
					.Basededatosdetalle.Cargar()
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
		
		loDetalle = this.oEntidad.AgrupamientoDetalle
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

		loDetalle = this.oEntidad.BaseDeDatosDetalle
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
		return c_AGRUPAMIENTO.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.PUESTO.AGRUPAMIENTO' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Codigo from (
							select * 
								from PUESTO.AGRUPAMIENTO 
								Where   AGRUPAMIENTO.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "AGRUPAMIENTO", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from PUESTO.AGRUPAMIENTO 
								Where   AGRUPAMIENTO.CODIGO != ''
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
	Tabla = 'AGRUPAMIENTO'
	Filtro = " AGRUPAMIENTO.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " AGRUPAMIENTO.CODIGO != ''"
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
	<row entidad="AGRUPAMIENTO                            " atributo="FECHAEXPO                               " tabla="AGRUPAMIENTO   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="FECHAMODIFICACIONFW                     " tabla="AGRUPAMIENTO   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="FECHAIMPO                               " tabla="AGRUPAMIENTO   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="FECHAALTAFW                             " tabla="AGRUPAMIENTO   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="FECHATRANSFERENCIA                      " tabla="AGRUPAMIENTO   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="TIMESTAMP                               " tabla="AGRUPAMIENTO   " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="USUARIOALTAFW                           " tabla="AGRUPAMIENTO   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="SERIEMODIFICACIONFW                     " tabla="AGRUPAMIENTO   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="USUARIOMODIFICACIONFW                   " tabla="AGRUPAMIENTO   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="VERSIONALTAFW                           " tabla="AGRUPAMIENTO   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="SERIEALTAFW                             " tabla="AGRUPAMIENTO   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="ZADSFW                                  " tabla="AGRUPAMIENTO   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="VERSIONMODIFICACIONFW                   " tabla="AGRUPAMIENTO   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="HORAEXPO                                " tabla="AGRUPAMIENTO   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="HORAMODIFICACIONFW                      " tabla="AGRUPAMIENTO   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="ESTADOTRANSFERENCIA                     " tabla="AGRUPAMIENTO   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="HORAIMPO                                " tabla="AGRUPAMIENTO   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="AGRUPAMIENTO   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="BASEDEDATOSALTAFW                       " tabla="AGRUPAMIENTO   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="HORAALTAFW                              " tabla="AGRUPAMIENTO   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="OBS                                     " tabla="AGRUPAMIENTO   " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="CODIGO                                  " tabla="AGRUPAMIENTO   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGOCONALTASCENTRALIZADAS   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="DESCRIPCION                             " tabla="AGRUPAMIENTO   " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="AGRUPAMIENTODETALLE                     " tabla="AGRUPAG        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMAGRUPAMIENTO       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AGRUPAMIENTO                            " atributo="BASEDEDATOSDETALLE                      " tabla="AGRUPBD        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMBASEDEDATOS        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
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