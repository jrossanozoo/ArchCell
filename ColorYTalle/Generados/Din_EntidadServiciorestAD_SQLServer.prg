
define class Din_EntidadSERVICIORESTAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SERVICIOREST'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_RSTPK'
	cTablaPrincipal = 'SERVREST'
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
			local  lxServrestFmodifw, lxServrestFaltafw, lxServrestFectrans, lxServrestFecimpo, lxServrestFecexpo, lxServrestHoraexpo, lxServrestHaltafw, lxServrestHmodifw, lxServrestHoraimpo, lxServrestVmodifw, lxServrestZadsfw, lxServrestValtafw, lxServrestUmodifw, lxServrestSmodifw, lxServrestUaltafw, lxServrestSaltafw, lxServrestBdmodifw, lxServrestBdaltafw, lxServrestEsttrans, lxServrestCodigo, lxServrestObs, lxServrestImpresora, lxServrestPuerto, lxServrestDescrip, lxServrestBasedatos, lxServrestOrigcomp, lxServrestPuesto, lxServrestTipocomp, lxServrestCaja, lxServrestActivo, lxServrestOcvtas, lxServrestLoghasta, lxServrestPercctacte, lxServrestValor
				lxServrestFmodifw =  .Fechamodificacionfw			lxServrestFaltafw =  .Fechaaltafw			lxServrestFectrans =  .Fechatransferencia			lxServrestFecimpo =  .Fechaimpo			lxServrestFecexpo =  .Fechaexpo			lxServrestHoraexpo =  .Horaexpo			lxServrestHaltafw =  .Horaaltafw			lxServrestHmodifw =  .Horamodificacionfw			lxServrestHoraimpo =  .Horaimpo			lxServrestVmodifw =  .Versionmodificacionfw			lxServrestZadsfw =  .Zadsfw			lxServrestValtafw =  .Versionaltafw			lxServrestUmodifw =  .Usuariomodificacionfw			lxServrestSmodifw =  .Seriemodificacionfw			lxServrestUaltafw =  .Usuarioaltafw			lxServrestSaltafw =  .Seriealtafw			lxServrestBdmodifw =  .Basededatosmodificacionfw			lxServrestBdaltafw =  .Basededatosaltafw			lxServrestEsttrans =  .Estadotransferencia			lxServrestCodigo =  .Codigo			lxServrestObs =  .Obs			lxServrestImpresora =  .Impresorapredeterminada			lxServrestPuerto =  .Puerto			lxServrestDescrip =  .Descripcion			lxServrestBasedatos =  .Basededatos			lxServrestOrigcomp =  .Origencomprobante			lxServrestPuesto =  .Puesto			lxServrestTipocomp =  .Tipocomprobante			lxServrestCaja =  .Cajaactiva_PK 			lxServrestActivo =  .Activo			lxServrestOcvtas =  .Ocultarventasenapp			lxServrestLoghasta =  .Logueoshasta			lxServrestPercctacte =  .Percepcionesactacte			lxServrestValor =  upper( .Valor_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxServrestCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.SERVREST ( "Fmodifw","Faltafw","Fectrans","Fecimpo","Fecexpo","Horaexpo","Haltafw","Hmodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Obs","Impresora","Puerto","Descrip","Basedatos","Origcomp","Puesto","Tipocomp","Caja","Activo","Ocvtas","Loghasta","Percctacte","Valor" ) values ( <<"'" + this.ConvertirDateSql( lxServrestFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxServrestFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxServrestFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxServrestFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxServrestFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestImpresora ) + "'" >>, <<lxServrestPuerto >>, <<"'" + this.FormatearTextoSql( lxServrestDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestBasedatos ) + "'" >>, <<lxServrestOrigcomp >>, <<"'" + this.FormatearTextoSql( lxServrestPuesto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestTipocomp ) + "'" >>, <<lxServrestCaja >>, <<iif( lxServrestActivo, 1, 0 ) >>, <<iif( lxServrestOcvtas, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxServrestLoghasta ) + "'" >>, <<iif( lxServrestPercctacte, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxServrestValor ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.dominiosCORS
				if this.oEntidad.dominiosCORS.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxRuta = loItem.Ruta
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.SERVRESTCORS("ruta","NROITEM","Codigo" ) values ( <<"'" + this.FormatearTextoSql( lxRuta ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
			local  lxServrestFmodifw, lxServrestFaltafw, lxServrestFectrans, lxServrestFecimpo, lxServrestFecexpo, lxServrestHoraexpo, lxServrestHaltafw, lxServrestHmodifw, lxServrestHoraimpo, lxServrestVmodifw, lxServrestZadsfw, lxServrestValtafw, lxServrestUmodifw, lxServrestSmodifw, lxServrestUaltafw, lxServrestSaltafw, lxServrestBdmodifw, lxServrestBdaltafw, lxServrestEsttrans, lxServrestCodigo, lxServrestObs, lxServrestImpresora, lxServrestPuerto, lxServrestDescrip, lxServrestBasedatos, lxServrestOrigcomp, lxServrestPuesto, lxServrestTipocomp, lxServrestCaja, lxServrestActivo, lxServrestOcvtas, lxServrestLoghasta, lxServrestPercctacte, lxServrestValor
				lxServrestFmodifw =  .Fechamodificacionfw			lxServrestFaltafw =  .Fechaaltafw			lxServrestFectrans =  .Fechatransferencia			lxServrestFecimpo =  .Fechaimpo			lxServrestFecexpo =  .Fechaexpo			lxServrestHoraexpo =  .Horaexpo			lxServrestHaltafw =  .Horaaltafw			lxServrestHmodifw =  .Horamodificacionfw			lxServrestHoraimpo =  .Horaimpo			lxServrestVmodifw =  .Versionmodificacionfw			lxServrestZadsfw =  .Zadsfw			lxServrestValtafw =  .Versionaltafw			lxServrestUmodifw =  .Usuariomodificacionfw			lxServrestSmodifw =  .Seriemodificacionfw			lxServrestUaltafw =  .Usuarioaltafw			lxServrestSaltafw =  .Seriealtafw			lxServrestBdmodifw =  .Basededatosmodificacionfw			lxServrestBdaltafw =  .Basededatosaltafw			lxServrestEsttrans =  .Estadotransferencia			lxServrestCodigo =  .Codigo			lxServrestObs =  .Obs			lxServrestImpresora =  .Impresorapredeterminada			lxServrestPuerto =  .Puerto			lxServrestDescrip =  .Descripcion			lxServrestBasedatos =  .Basededatos			lxServrestOrigcomp =  .Origencomprobante			lxServrestPuesto =  .Puesto			lxServrestTipocomp =  .Tipocomprobante			lxServrestCaja =  .Cajaactiva_PK 			lxServrestActivo =  .Activo			lxServrestOcvtas =  .Ocultarventasenapp			lxServrestLoghasta =  .Logueoshasta			lxServrestPercctacte =  .Percepcionesactacte			lxServrestValor =  upper( .Valor_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.SERVREST set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxServrestFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxServrestFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxServrestFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxServrestFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxServrestFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxServrestHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxServrestHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxServrestHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxServrestHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxServrestVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxServrestZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxServrestValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxServrestUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxServrestSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxServrestUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxServrestSaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxServrestBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxServrestBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxServrestEsttrans ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxServrestCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxServrestObs ) + "'">>,"Impresora" = <<"'" + this.FormatearTextoSql( lxServrestImpresora ) + "'">>,"Puerto" = <<lxServrestPuerto>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxServrestDescrip ) + "'">>,"Basedatos" = <<"'" + this.FormatearTextoSql( lxServrestBasedatos ) + "'">>,"Origcomp" = <<lxServrestOrigcomp>>,"Puesto" = <<"'" + this.FormatearTextoSql( lxServrestPuesto ) + "'">>,"Tipocomp" = <<"'" + this.FormatearTextoSql( lxServrestTipocomp ) + "'">>,"Caja" = <<lxServrestCaja>>,"Activo" = <<iif( lxServrestActivo, 1, 0 )>>,"Ocvtas" = <<iif( lxServrestOcvtas, 1, 0 )>>,"Loghasta" = <<"'" + this.ConvertirDateSql( lxServrestLoghasta ) + "'">>,"Percctacte" = <<iif( lxServrestPercctacte, 1, 0 )>>,"Valor" = <<"'" + this.FormatearTextoSql( lxServrestValor ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxServrestCodigo ) + "'">> and  SERVREST.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.SERVRESTCORS where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.dominiosCORS
				if this.oEntidad.dominiosCORS.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxRuta = loItem.Ruta
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.SERVRESTCORS("ruta","NROITEM","Codigo" ) values ( <<"'" + this.FormatearTextoSql( lxRuta ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ORGANIZACION.SERVREST where " + this.ConvertirFuncionesSql( " SERVREST.CODIGO != ''" ) )
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
			Local lxServrestCodigo
			lxServrestCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Impresora" as "Impresorapredeterminada", "Puerto" as "Puerto", "Descrip" as "Descripcion", "Basedatos" as "Basededatos", "Origcomp" as "Origencomprobante", "Puesto" as "Puesto", "Tipocomp" as "Tipocomprobante", "Caja" as "Cajaactiva", "Activo" as "Activo", "Ocvtas" as "Ocultarventasenapp", "Loghasta" as "Logueoshasta", "Percctacte" as "Percepcionesactacte", "Valor" as "Valor" from ORGANIZACION.SERVREST where "Codigo" = <<"'" + this.FormatearTextoSql( lxServrestCodigo ) + "'">> and  SERVREST.CODIGO != ''
			endtext
			use in select('c_SERVICIOREST')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SERVICIOREST', set( 'Datasession' ) )

			if reccount( 'c_SERVICIOREST' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ruta" as "Ruta", "Nroitem" as "Nroitem", "Codigo" as "Codigo" from ORGANIZACION.SERVRESTCORS where Codigo = <<"'" + this.FormatearTextoSql( c_SERVICIOREST.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_dominiosCORS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_dominiosCORS', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_dominiosCORS
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxServrestCodigo as Variant
		llRetorno = .t.
		lxServrestCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.SERVREST where "Codigo" = <<"'" + this.FormatearTextoSql( lxServrestCodigo ) + "'">> and  SERVREST.CODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Impresora" as "Impresorapredeterminada", "Puerto" as "Puerto", "Descrip" as "Descripcion", "Basedatos" as "Basededatos", "Origcomp" as "Origencomprobante", "Puesto" as "Puesto", "Tipocomp" as "Tipocomprobante", "Caja" as "Cajaactiva", "Activo" as "Activo", "Ocvtas" as "Ocultarventasenapp", "Loghasta" as "Logueoshasta", "Percctacte" as "Percepcionesactacte", "Valor" as "Valor" from ORGANIZACION.SERVREST where  SERVREST.CODIGO != '' order by Codigo
			endtext
			use in select('c_SERVICIOREST')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SERVICIOREST', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ruta" as "Ruta", "Nroitem" as "Nroitem", "Codigo" as "Codigo" from ORGANIZACION.SERVRESTCORS where Codigo = <<"'" + this.FormatearTextoSql( c_SERVICIOREST.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_dominiosCORS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_dominiosCORS', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_dominiosCORS
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Impresora" as "Impresorapredeterminada", "Puerto" as "Puerto", "Descrip" as "Descripcion", "Basedatos" as "Basededatos", "Origcomp" as "Origencomprobante", "Puesto" as "Puesto", "Tipocomp" as "Tipocomprobante", "Caja" as "Cajaactiva", "Activo" as "Activo", "Ocvtas" as "Ocultarventasenapp", "Loghasta" as "Logueoshasta", "Percctacte" as "Percepcionesactacte", "Valor" as "Valor" from ORGANIZACION.SERVREST where  funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SERVREST.CODIGO != '' order by Codigo
			endtext
			use in select('c_SERVICIOREST')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SERVICIOREST', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ruta" as "Ruta", "Nroitem" as "Nroitem", "Codigo" as "Codigo" from ORGANIZACION.SERVRESTCORS where Codigo = <<"'" + this.FormatearTextoSql( c_SERVICIOREST.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_dominiosCORS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_dominiosCORS', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_dominiosCORS
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Impresora" as "Impresorapredeterminada", "Puerto" as "Puerto", "Descrip" as "Descripcion", "Basedatos" as "Basededatos", "Origcomp" as "Origencomprobante", "Puesto" as "Puesto", "Tipocomp" as "Tipocomprobante", "Caja" as "Cajaactiva", "Activo" as "Activo", "Ocvtas" as "Ocultarventasenapp", "Loghasta" as "Logueoshasta", "Percctacte" as "Percepcionesactacte", "Valor" as "Valor" from ORGANIZACION.SERVREST where  funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SERVREST.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_SERVICIOREST')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SERVICIOREST', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ruta" as "Ruta", "Nroitem" as "Nroitem", "Codigo" as "Codigo" from ORGANIZACION.SERVRESTCORS where Codigo = <<"'" + this.FormatearTextoSql( c_SERVICIOREST.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_dominiosCORS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_dominiosCORS', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_dominiosCORS
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Impresora" as "Impresorapredeterminada", "Puerto" as "Puerto", "Descrip" as "Descripcion", "Basedatos" as "Basededatos", "Origcomp" as "Origencomprobante", "Puesto" as "Puesto", "Tipocomp" as "Tipocomprobante", "Caja" as "Cajaactiva", "Activo" as "Activo", "Ocvtas" as "Ocultarventasenapp", "Loghasta" as "Logueoshasta", "Percctacte" as "Percepcionesactacte", "Valor" as "Valor" from ORGANIZACION.SERVREST where  SERVREST.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_SERVICIOREST')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SERVICIOREST', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ruta" as "Ruta", "Nroitem" as "Nroitem", "Codigo" as "Codigo" from ORGANIZACION.SERVRESTCORS where Codigo = <<"'" + this.FormatearTextoSql( c_SERVICIOREST.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_dominiosCORS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_dominiosCORS', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_dominiosCORS
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Faltafw,Fectrans,Fecimpo,Fecexpo,Horaexpo,Haltafw,Hmodifw,Horaimpo,Vmodifw,Zadsfw,Va" + ;
"ltafw,Umodifw,Smodifw,Ualtafw,Saltafw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Obs,Impresora,Puerto,Descrip" + ;
",Basedatos,Origcomp,Puesto,Tipocomp,Caja,Activo,Ocvtas,Loghasta,Percctacte,Valor" + ;
" from ORGANIZACION.SERVREST where  SERVREST.CODIGO != '' and " + lcFiltro )
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
			local  lxServrestFmodifw, lxServrestFaltafw, lxServrestFectrans, lxServrestFecimpo, lxServrestFecexpo, lxServrestHoraexpo, lxServrestHaltafw, lxServrestHmodifw, lxServrestHoraimpo, lxServrestVmodifw, lxServrestZadsfw, lxServrestValtafw, lxServrestUmodifw, lxServrestSmodifw, lxServrestUaltafw, lxServrestSaltafw, lxServrestBdmodifw, lxServrestBdaltafw, lxServrestEsttrans, lxServrestCodigo, lxServrestObs, lxServrestImpresora, lxServrestPuerto, lxServrestDescrip, lxServrestBasedatos, lxServrestOrigcomp, lxServrestPuesto, lxServrestTipocomp, lxServrestCaja, lxServrestActivo, lxServrestOcvtas, lxServrestLoghasta, lxServrestPercctacte, lxServrestValor
				lxServrestFmodifw = ctod( '  /  /    ' )			lxServrestFaltafw = ctod( '  /  /    ' )			lxServrestFectrans = ctod( '  /  /    ' )			lxServrestFecimpo = ctod( '  /  /    ' )			lxServrestFecexpo = ctod( '  /  /    ' )			lxServrestHoraexpo = []			lxServrestHaltafw = []			lxServrestHmodifw = []			lxServrestHoraimpo = []			lxServrestVmodifw = []			lxServrestZadsfw = []			lxServrestValtafw = []			lxServrestUmodifw = []			lxServrestSmodifw = []			lxServrestUaltafw = []			lxServrestSaltafw = []			lxServrestBdmodifw = []			lxServrestBdaltafw = []			lxServrestEsttrans = []			lxServrestCodigo = []			lxServrestObs = []			lxServrestImpresora = []			lxServrestPuerto = 0			lxServrestDescrip = []			lxServrestBasedatos = []			lxServrestOrigcomp = 0			lxServrestPuesto = []			lxServrestTipocomp = []			lxServrestCaja = 0			lxServrestActivo = .F.			lxServrestOcvtas = .F.			lxServrestLoghasta = ctod( '  /  /    ' )			lxServrestPercctacte = .F.			lxServrestValor = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.SERVRESTCORS where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.SERVREST where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SERVREST' + '_' + tcCampo
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
		lcWhere = " Where  SERVREST.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Impresora" as "Impresorapredeterminada", "Puerto" as "Puerto", "Descrip" as "Descripcion", "Basedatos" as "Basededatos", "Origcomp" as "Origencomprobante", "Puesto" as "Puesto", "Tipocomp" as "Tipocomprobante", "Caja" as "Cajaactiva", "Activo" as "Activo", "Ocvtas" as "Ocultarventasenapp", "Loghasta" as "Logueoshasta", "Percctacte" as "Percepcionesactacte", "Valor" as "Valor"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SERVREST', '', tnTope )
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
	Function ObtenerDatosDetalledominiosCORS( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  SERVRESTCORS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Ruta" as "Ruta", "Nroitem" as "Nroitem", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalledominiosCORS( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SERVRESTCORS', 'dominiosCORS', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalledominiosCORS( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalledominiosCORS( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'IMPRESORAPREDETERMINADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPRESORA AS IMPRESORAPREDETERMINADA'
				Case lcAtributo == 'PUERTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUERTO AS PUERTO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOS AS BASEDEDATOS'
				Case lcAtributo == 'ORIGENCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGCOMP AS ORIGENCOMPROBANTE'
				Case lcAtributo == 'PUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUESTO AS PUESTO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'CAJAACTIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJA AS CAJAACTIVA'
				Case lcAtributo == 'ACTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACTIVO AS ACTIVO'
				Case lcAtributo == 'OCULTARVENTASENAPP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OCVTAS AS OCULTARVENTASENAPP'
				Case lcAtributo == 'LOGUEOSHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LOGHASTA AS LOGUEOSHASTA'
				Case lcAtributo == 'PERCEPCIONESACTACTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERCCTACTE AS PERCEPCIONESACTACTE'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalledominiosCORS( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'RUTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUTA AS RUTA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRESORAPREDETERMINADA'
				lcCampo = 'IMPRESORA'
			Case upper( alltrim( tcAtributo ) ) == 'PUERTO'
				lcCampo = 'PUERTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASEDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENCOMPROBANTE'
				lcCampo = 'ORIGCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PUESTO'
				lcCampo = 'PUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAACTIVA'
				lcCampo = 'CAJA'
			Case upper( alltrim( tcAtributo ) ) == 'ACTIVO'
				lcCampo = 'ACTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'OCULTARVENTASENAPP'
				lcCampo = 'OCVTAS'
			Case upper( alltrim( tcAtributo ) ) == 'LOGUEOSHASTA'
				lcCampo = 'LOGHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONESACTACTE'
				lcCampo = 'PERCCTACTE'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalledominiosCORS( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'RUTA'
				lcCampo = 'RUTA'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DOMINIOSCORS'
			lcRetorno = 'SERVRESTCORS'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxServrestFmodifw, lxServrestFaltafw, lxServrestFectrans, lxServrestFecimpo, lxServrestFecexpo, lxServrestHoraexpo, lxServrestHaltafw, lxServrestHmodifw, lxServrestHoraimpo, lxServrestVmodifw, lxServrestZadsfw, lxServrestValtafw, lxServrestUmodifw, lxServrestSmodifw, lxServrestUaltafw, lxServrestSaltafw, lxServrestBdmodifw, lxServrestBdaltafw, lxServrestEsttrans, lxServrestCodigo, lxServrestObs, lxServrestImpresora, lxServrestPuerto, lxServrestDescrip, lxServrestBasedatos, lxServrestOrigcomp, lxServrestPuesto, lxServrestTipocomp, lxServrestCaja, lxServrestActivo, lxServrestOcvtas, lxServrestLoghasta, lxServrestPercctacte, lxServrestValor
				lxServrestFmodifw =  .Fechamodificacionfw			lxServrestFaltafw =  .Fechaaltafw			lxServrestFectrans =  .Fechatransferencia			lxServrestFecimpo =  .Fechaimpo			lxServrestFecexpo =  .Fechaexpo			lxServrestHoraexpo =  .Horaexpo			lxServrestHaltafw =  .Horaaltafw			lxServrestHmodifw =  .Horamodificacionfw			lxServrestHoraimpo =  .Horaimpo			lxServrestVmodifw =  .Versionmodificacionfw			lxServrestZadsfw =  .Zadsfw			lxServrestValtafw =  .Versionaltafw			lxServrestUmodifw =  .Usuariomodificacionfw			lxServrestSmodifw =  .Seriemodificacionfw			lxServrestUaltafw =  .Usuarioaltafw			lxServrestSaltafw =  .Seriealtafw			lxServrestBdmodifw =  .Basededatosmodificacionfw			lxServrestBdaltafw =  .Basededatosaltafw			lxServrestEsttrans =  .Estadotransferencia			lxServrestCodigo =  .Codigo			lxServrestObs =  .Obs			lxServrestImpresora =  .Impresorapredeterminada			lxServrestPuerto =  .Puerto			lxServrestDescrip =  .Descripcion			lxServrestBasedatos =  .Basededatos			lxServrestOrigcomp =  .Origencomprobante			lxServrestPuesto =  .Puesto			lxServrestTipocomp =  .Tipocomprobante			lxServrestCaja =  .Cajaactiva_PK 			lxServrestActivo =  .Activo			lxServrestOcvtas =  .Ocultarventasenapp			lxServrestLoghasta =  .Logueoshasta			lxServrestPercctacte =  .Percepcionesactacte			lxServrestValor =  upper( .Valor_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.SERVREST ( "Fmodifw","Faltafw","Fectrans","Fecimpo","Fecexpo","Horaexpo","Haltafw","Hmodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Obs","Impresora","Puerto","Descrip","Basedatos","Origcomp","Puesto","Tipocomp","Caja","Activo","Ocvtas","Loghasta","Percctacte","Valor" ) values ( <<"'" + this.ConvertirDateSql( lxServrestFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxServrestFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxServrestFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxServrestFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxServrestFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestImpresora ) + "'" >>, <<lxServrestPuerto >>, <<"'" + this.FormatearTextoSql( lxServrestDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestBasedatos ) + "'" >>, <<lxServrestOrigcomp >>, <<"'" + this.FormatearTextoSql( lxServrestPuesto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxServrestTipocomp ) + "'" >>, <<lxServrestCaja >>, <<iif( lxServrestActivo, 1, 0 ) >>, <<iif( lxServrestOcvtas, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxServrestLoghasta ) + "'" >>, <<iif( lxServrestPercctacte, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxServrestValor ) + "'" >> )
		endtext
		loColeccion.cTabla = 'SERVREST' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.dominiosCORS
				if this.oEntidad.dominiosCORS.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxRuta = loItem.Ruta
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.SERVRESTCORS("ruta","NROITEM","Codigo" ) values ( <<"'" + this.FormatearTextoSql( lxRuta ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >> ) 
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
			local  lxServrestFmodifw, lxServrestFaltafw, lxServrestFectrans, lxServrestFecimpo, lxServrestFecexpo, lxServrestHoraexpo, lxServrestHaltafw, lxServrestHmodifw, lxServrestHoraimpo, lxServrestVmodifw, lxServrestZadsfw, lxServrestValtafw, lxServrestUmodifw, lxServrestSmodifw, lxServrestUaltafw, lxServrestSaltafw, lxServrestBdmodifw, lxServrestBdaltafw, lxServrestEsttrans, lxServrestCodigo, lxServrestObs, lxServrestImpresora, lxServrestPuerto, lxServrestDescrip, lxServrestBasedatos, lxServrestOrigcomp, lxServrestPuesto, lxServrestTipocomp, lxServrestCaja, lxServrestActivo, lxServrestOcvtas, lxServrestLoghasta, lxServrestPercctacte, lxServrestValor
				lxServrestFmodifw =  .Fechamodificacionfw			lxServrestFaltafw =  .Fechaaltafw			lxServrestFectrans =  .Fechatransferencia			lxServrestFecimpo =  .Fechaimpo			lxServrestFecexpo =  .Fechaexpo			lxServrestHoraexpo =  .Horaexpo			lxServrestHaltafw =  .Horaaltafw			lxServrestHmodifw =  .Horamodificacionfw			lxServrestHoraimpo =  .Horaimpo			lxServrestVmodifw =  .Versionmodificacionfw			lxServrestZadsfw =  .Zadsfw			lxServrestValtafw =  .Versionaltafw			lxServrestUmodifw =  .Usuariomodificacionfw			lxServrestSmodifw =  .Seriemodificacionfw			lxServrestUaltafw =  .Usuarioaltafw			lxServrestSaltafw =  .Seriealtafw			lxServrestBdmodifw =  .Basededatosmodificacionfw			lxServrestBdaltafw =  .Basededatosaltafw			lxServrestEsttrans =  .Estadotransferencia			lxServrestCodigo =  .Codigo			lxServrestObs =  .Obs			lxServrestImpresora =  .Impresorapredeterminada			lxServrestPuerto =  .Puerto			lxServrestDescrip =  .Descripcion			lxServrestBasedatos =  .Basededatos			lxServrestOrigcomp =  .Origencomprobante			lxServrestPuesto =  .Puesto			lxServrestTipocomp =  .Tipocomprobante			lxServrestCaja =  .Cajaactiva_PK 			lxServrestActivo =  .Activo			lxServrestOcvtas =  .Ocultarventasenapp			lxServrestLoghasta =  .Logueoshasta			lxServrestPercctacte =  .Percepcionesactacte			lxServrestValor =  upper( .Valor_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SERVREST.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.SERVREST set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxServrestFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxServrestFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxServrestFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxServrestFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxServrestFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxServrestHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxServrestHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxServrestHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxServrestHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxServrestVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxServrestZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxServrestValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxServrestUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxServrestSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxServrestUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxServrestSaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxServrestBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxServrestBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxServrestEsttrans ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxServrestCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxServrestObs ) + "'">>, "Impresora" = <<"'" + this.FormatearTextoSql( lxServrestImpresora ) + "'">>, "Puerto" = <<lxServrestPuerto>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxServrestDescrip ) + "'">>, "Basedatos" = <<"'" + this.FormatearTextoSql( lxServrestBasedatos ) + "'">>, "Origcomp" = <<lxServrestOrigcomp>>, "Puesto" = <<"'" + this.FormatearTextoSql( lxServrestPuesto ) + "'">>, "Tipocomp" = <<"'" + this.FormatearTextoSql( lxServrestTipocomp ) + "'">>, "Caja" = <<lxServrestCaja>>, "Activo" = <<iif( lxServrestActivo, 1, 0 )>>, "Ocvtas" = <<iif( lxServrestOcvtas, 1, 0 )>>, "Loghasta" = <<"'" + this.ConvertirDateSql( lxServrestLoghasta ) + "'">>, "Percctacte" = <<iif( lxServrestPercctacte, 1, 0 )>>, "Valor" = <<"'" + this.FormatearTextoSql( lxServrestValor ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SERVREST' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ORGANIZACION.SERVRESTCORS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.dominiosCORS
				if this.oEntidad.dominiosCORS.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxRuta = loItem.Ruta
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.SERVRESTCORS("ruta","NROITEM","Codigo" ) values ( <<"'" + this.FormatearTextoSql( lxRuta ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SERVREST.CODIGO != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.SERVREST where ' + lcFiltro )
			loColeccion.Agregar([delete from ORGANIZACION.SERVRESTCORS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'SERVREST' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.SERVREST where  SERVREST.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.SERVREST where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SERVREST.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SERVICIOREST'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.SERVREST Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.SERVREST set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"+ [, impresora = ] + "'" + this.FormatearTextoSql( &lcCursor..impresora ) + "'"+ [, Puerto = ] + transform( &lcCursor..Puerto )+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, BaseDatos = ] + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'"+ [, origComp = ] + transform( &lcCursor..origComp )+ [, puesto = ] + "'" + this.FormatearTextoSql( &lcCursor..puesto ) + "'"+ [, tipoComp = ] + "'" + this.FormatearTextoSql( &lcCursor..tipoComp ) + "'"+ [, Caja = ] + transform( &lcCursor..Caja )+ [, activo = ] + Transform( iif( &lcCursor..activo, 1, 0 ))+ [, ocVtas = ] + Transform( iif( &lcCursor..ocVtas, 1, 0 ))+ [, LogHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..LogHasta ) + "'"+ [, PercCtaCte = ] + Transform( iif( &lcCursor..PercCtaCte, 1, 0 ))+ [, Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FALTAFW, FECTRANS, FECIMPO, FECEXPO, HORAEXPO, HALTAFW, HMODIFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, SALTAFW, BDMODIFW, BDALTAFW, ESTTRANS, Codigo, OBS, impresora, Puerto, Descrip, BaseDatos, origComp, puesto, tipoComp, Caja, activo, ocVtas, LogHasta, PercCtaCte, Valor
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..impresora ) + "'" + ',' + transform( &lcCursor..Puerto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'" + ',' + transform( &lcCursor..origComp ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..puesto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipoComp ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Caja ) + ',' + Transform( iif( &lcCursor..activo, 1, 0 )) + ',' + Transform( iif( &lcCursor..ocVtas, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..LogHasta ) + "'" + ',' + Transform( iif( &lcCursor..PercCtaCte, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.SERVREST ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SERVICIOREST'
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
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.SERVRESTCORS Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDOMINIOSCORS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"ruta","NROITEM","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.SERVRESTCORS ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.ruta       ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (20) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'SERVICIOREST'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SERVICIOREST_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SERVICIOREST_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDOMINIOSCORS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_SERVREST')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SERVICIOREST'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SERVICIOREST. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SERVICIOREST'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SERVICIOREST'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  LogHasta  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_SERVREST') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_SERVREST
Create Table ORGANIZACION.TablaTrabajo_SERVREST ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codigo" char( 20 )  null, 
"obs" varchar(max)  null, 
"impresora" char( 240 )  null, 
"puerto" numeric( 5, 0 )  null, 
"descrip" char( 40 )  null, 
"basedatos" char( 8 )  null, 
"origcomp" numeric( 2, 0 )  null, 
"puesto" char( 50 )  null, 
"tipocomp" char( 40 )  null, 
"caja" numeric( 2, 0 )  null, 
"activo" bit  null, 
"ocvtas" bit  null, 
"loghasta" datetime  null, 
"percctacte" bit  null, 
"valor" char( 5 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_SERVREST' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_SERVREST' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SERVICIOREST'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('impresora','impresora')
			.AgregarMapeo('puerto','puerto')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('basedatos','basedatos')
			.AgregarMapeo('origcomp','origcomp')
			.AgregarMapeo('puesto','puesto')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('caja','caja')
			.AgregarMapeo('activo','activo')
			.AgregarMapeo('ocvtas','ocvtas')
			.AgregarMapeo('loghasta','loghasta')
			.AgregarMapeo('percctacte','percctacte')
			.AgregarMapeo('valor','valor')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_SERVREST'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.IMPRESORA = isnull( d.IMPRESORA, t.IMPRESORA ),t.PUERTO = isnull( d.PUERTO, t.PUERTO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.BASEDATOS = isnull( d.BASEDATOS, t.BASEDATOS ),t.ORIGCOMP = isnull( d.ORIGCOMP, t.ORIGCOMP ),t.PUESTO = isnull( d.PUESTO, t.PUESTO ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.CAJA = isnull( d.CAJA, t.CAJA ),t.ACTIVO = isnull( d.ACTIVO, t.ACTIVO ),t.OCVTAS = isnull( d.OCVTAS, t.OCVTAS ),t.LOGHASTA = isnull( d.LOGHASTA, t.LOGHASTA ),t.PERCCTACTE = isnull( d.PERCCTACTE, t.PERCCTACTE ),t.VALOR = isnull( d.VALOR, t.VALOR )
					from ORGANIZACION.SERVREST t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ORGANIZACION.SERVREST(Fmodifw,Faltafw,Fectrans,Fecimpo,Fecexpo,Horaexpo,Haltafw,Hmodifw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Saltafw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Obs,Impresora,Puerto,Descrip,Basedatos,Origcomp,Puesto,Tipocomp,Caja,Activo,Ocvtas,Loghasta,Percctacte,Valor)
					Select isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.IMPRESORA,''),isnull( d.PUERTO,0),isnull( d.DESCRIP,''),isnull( d.BASEDATOS,''),isnull( d.ORIGCOMP,0),isnull( d.PUESTO,''),isnull( d.TIPOCOMP,''),isnull( d.CAJA,0),isnull( d.ACTIVO,0),isnull( d.OCVTAS,0),isnull( d.LOGHASTA,''),isnull( d.PERCCTACTE,0),isnull( d.VALOR,'')
						From deleted d left join ORGANIZACION.SERVREST pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_SERVRESTCORS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_SERVREST_SERVRESTCORS
ON ORGANIZACION.TablaTrabajo_SERVREST_SERVRESTCORS
AFTER DELETE
As
Begin
Update t Set 
t.RUTA = isnull( d.RUTA, t.RUTA ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO )
from ORGANIZACION.SERVRESTCORS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.SERVRESTCORS
( 
"RUTA",
"NROITEM",
"CODIGO"
 )
Select 
d.RUTA,
d.NROITEM,
d.CODIGO
From deleted d left join ORGANIZACION.SERVRESTCORS pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_SERVREST') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_SERVREST
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SERVICIOREST' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SERVICIOREST.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SERVICIOREST.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SERVICIOREST.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SERVICIOREST.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SERVICIOREST.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_SERVICIOREST.Horaexpo, [] )
					.Horaaltafw = nvl( c_SERVICIOREST.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_SERVICIOREST.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_SERVICIOREST.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_SERVICIOREST.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_SERVICIOREST.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_SERVICIOREST.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_SERVICIOREST.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_SERVICIOREST.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_SERVICIOREST.Seriealtafw, [] )
					.Basededatosmodificacionfw = nvl( c_SERVICIOREST.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_SERVICIOREST.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_SERVICIOREST.Estadotransferencia, [] )
					.Codigo = nvl( c_SERVICIOREST.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Dominioscors.Limpiar()
					.Dominioscors.SetearEsNavegacion( .lProcesando )
					.Dominioscors.Cargar()
					.Impresorapredeterminada = nvl( c_SERVICIOREST.Impresorapredeterminada, [] )
					.Puerto = nvl( c_SERVICIOREST.Puerto, 0 )
					.Descripcion = nvl( c_SERVICIOREST.Descripcion, [] )
					.Basededatos = nvl( c_SERVICIOREST.Basededatos, [] )
					.Origencomprobante = nvl( c_SERVICIOREST.Origencomprobante, 0 )
					.Puesto = nvl( c_SERVICIOREST.Puesto, [] )
					.Tipocomprobante = nvl( c_SERVICIOREST.Tipocomprobante, [] )
					.Cajaactiva_PK =  nvl( c_SERVICIOREST.Cajaactiva, 0 )
					.Activo = nvl( c_SERVICIOREST.Activo, .F. )
					.Ocultarventasenapp = nvl( c_SERVICIOREST.Ocultarventasenapp, .F. )
					.Logueoshasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_SERVICIOREST.Logueoshasta, ctod( '  /  /    ' ) ) )
					.Percepcionesactacte = nvl( c_SERVICIOREST.Percepcionesactacte, .F. )
					.Valor_PK =  nvl( c_SERVICIOREST.Valor, [] )
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
		
		loDetalle = this.oEntidad.dominiosCORS
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
		return c_SERVICIOREST.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.SERVREST' )
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
								from ORGANIZACION.SERVREST 
								Where   SERVREST.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SERVREST", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Impresora" as "Impresorapredeterminada", "Puerto" as "Puerto", "Descrip" as "Descripcion", "Basedatos" as "Basededatos", "Origcomp" as "Origencomprobante", "Puesto" as "Puesto", "Tipocomp" as "Tipocomprobante", "Caja" as "Cajaactiva", "Activo" as "Activo", "Ocvtas" as "Ocultarventasenapp", "Loghasta" as "Logueoshasta", "Percctacte" as "Percepcionesactacte", "Valor" as "Valor"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.SERVREST 
								Where   SERVREST.CODIGO != ''
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
	Tabla = 'SERVREST'
	Filtro = " SERVREST.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SERVREST.CODIGO != ''"
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
	<row entidad="SERVICIOREST                            " atributo="FECHAMODIFICACIONFW                     " tabla="SERVREST       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="FECHAALTAFW                             " tabla="SERVREST       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="FECHATRANSFERENCIA                      " tabla="SERVREST       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="FECHAIMPO                               " tabla="SERVREST       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="FECHAEXPO                               " tabla="SERVREST       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="HORAEXPO                                " tabla="SERVREST       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="HORAALTAFW                              " tabla="SERVREST       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="HORAMODIFICACIONFW                      " tabla="SERVREST       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="HORAIMPO                                " tabla="SERVREST       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="VERSIONMODIFICACIONFW                   " tabla="SERVREST       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="ZADSFW                                  " tabla="SERVREST       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="VERSIONALTAFW                           " tabla="SERVREST       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="USUARIOMODIFICACIONFW                   " tabla="SERVREST       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="SERIEMODIFICACIONFW                     " tabla="SERVREST       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="USUARIOALTAFW                           " tabla="SERVREST       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="SERIEALTAFW                             " tabla="SERVREST       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SERVREST       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="BASEDEDATOSALTAFW                       " tabla="SERVREST       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="ESTADOTRANSFERENCIA                     " tabla="SERVREST       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="CODIGO                                  " tabla="SERVREST       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="OBS                                     " tabla="SERVREST       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="DOMINIOSCORS                            " tabla="SERVRESTCORS   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMDOMINIOSCORS       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="IMPRESORAPREDETERMINADA                 " tabla="SERVREST       " campo="IMPRESORA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="240" decimales="0" valorsugerido="@ObtenerImpresoraPredeterminadaDelSistema()                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="402" etiqueta="Impresora                                                                                                                                                       " dominio="COMBOIMPRESORAS               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="PUERTO                                  " tabla="SERVREST       " campo="PUERTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="8008                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="404" etiqueta="Puerto de escucha                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="DESCRIPCION                             " tabla="SERVREST       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="BASEDEDATOS                             " tabla="SERVREST       " campo="BASEDATOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Base de datos                                                                                                                                                   " dominio="COMBOBASEDEDATOS              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="ORIGENCOMPROBANTE                       " tabla="SERVREST       " campo="ORIGCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="408" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="PUESTO                                  " tabla="SERVREST       " campo="PUESTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerNombrePuesto()                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="410" etiqueta="Puesto                                                                                                                                                          " dominio="COMBOPUESTOS                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="TIPOCOMPROBANTE                         " tabla="SERVREST       " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="COMBOCOMPROBANTESREST         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="CAJAACTIVA                              " tabla="SERVREST       " campo="CAJA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="goParametros.Felino.GestionDeVentas.NumeroDeCaja                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Caja activa                                                                                                                                                     " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="ACTIVO                                  " tabla="SERVREST       " campo="ACTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="414" etiqueta="Activo                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="OCULTARVENTASENAPP                      " tabla="SERVREST       " campo="OCVTAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Ocultar información de ventas en el home                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="LOGUEOSHASTA                            " tabla="SERVREST       " campo="LOGHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Logueos detallados hasta la fecha                                                                                                                               " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="PERCEPCIONESACTACTE                     " tabla="SERVREST       " campo="PERCCTACTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Enviar diferencia por percepciones a cta. cte.                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SERVICIOREST                            " atributo="VALOR                                   " tabla="SERVREST       " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Valor a utilizar en diferencia por percepciones                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Caj.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAJAESTA On SERVREST.CAJA = CAJAESTA.NumCaja And  CAJAESTA.NUMCAJA != 0                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVAL           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVAL On SERVREST.VALOR = XVAL.CLCOD And  XVAL.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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