
define class Din_EntidadACCIONESAUTOMATICASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ACCIONESAUTOMATICAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Entidad]
	cExpresionCCPorCampos = [#tabla#.Entidad]
	cTagClaveCandidata = '_AACC'
	cTagClavePk = '_AAPK'
	cTablaPrincipal = 'ACCAUT'
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
			local  lxAccautFecexpo, lxAccautFectrans, lxAccautFmodifw, lxAccautFaltafw, lxAccautFecimpo, lxAccautSmodifw, lxAccautHmodifw, lxAccautSaltafw, lxAccautUaltafw, lxAccautUmodifw, lxAccautVmodifw, lxAccautHoraimpo, lxAccautValtafw, lxAccautZadsfw, lxAccautHaltafw, lxAccautEsttrans, lxAccautBdaltafw, lxAccautBdmodifw, lxAccautHoraexpo, lxAccautNuevodg, lxAccautCodigo, lxAccautEntidad, lxAccautValocier, lxAccautRestpick, lxAccautObs
				lxAccautFecexpo =  .Fechaexpo			lxAccautFectrans =  .Fechatransferencia			lxAccautFmodifw =  .Fechamodificacionfw			lxAccautFaltafw =  .Fechaaltafw			lxAccautFecimpo =  .Fechaimpo			lxAccautSmodifw =  .Seriemodificacionfw			lxAccautHmodifw =  .Horamodificacionfw			lxAccautSaltafw =  .Seriealtafw			lxAccautUaltafw =  .Usuarioaltafw			lxAccautUmodifw =  .Usuariomodificacionfw			lxAccautVmodifw =  .Versionmodificacionfw			lxAccautHoraimpo =  .Horaimpo			lxAccautValtafw =  .Versionaltafw			lxAccautZadsfw =  .Zadsfw			lxAccautHaltafw =  .Horaaltafw			lxAccautEsttrans =  .Estadotransferencia			lxAccautBdaltafw =  .Basededatosaltafw			lxAccautBdmodifw =  .Basededatosmodificacionfw			lxAccautHoraexpo =  .Horaexpo			lxAccautNuevodg =  .Nuevodespuesdegrabar			lxAccautCodigo =  .Codigo			lxAccautEntidad =  .Entidad			lxAccautValocier =  upper( .ValorDeCierre_PK ) 			lxAccautRestpick =  .Restringirpicking			lxAccautObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAccautCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ACCAUT ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Vmodifw","Horaimpo","Valtafw","Zadsfw","Haltafw","Esttrans","Bdaltafw","Bdmodifw","Horaexpo","Nuevodg","Codigo","Entidad","Valocier","Restpick","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxAccautFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAccautFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAccautFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAccautFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAccautFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautHoraexpo ) + "'" >>, <<iif( lxAccautNuevodg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAccautCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautEntidad ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautValocier ) + "'" >>, <<iif( lxAccautRestpick, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAccautObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AccionesDetalle
				if this.oEntidad.AccionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMetodo = loItem.Metodo
					lxAccion = loItem.Accion
					lxExpresion = loItem.Expresion
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DACCAUT("NROITEM","Codigo","Metodo","Accion","Expr","Orden" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxMetodo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxExpresion ) + "'">>, <<lxOrden>> ) 
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
			local  lxAccautFecexpo, lxAccautFectrans, lxAccautFmodifw, lxAccautFaltafw, lxAccautFecimpo, lxAccautSmodifw, lxAccautHmodifw, lxAccautSaltafw, lxAccautUaltafw, lxAccautUmodifw, lxAccautVmodifw, lxAccautHoraimpo, lxAccautValtafw, lxAccautZadsfw, lxAccautHaltafw, lxAccautEsttrans, lxAccautBdaltafw, lxAccautBdmodifw, lxAccautHoraexpo, lxAccautNuevodg, lxAccautCodigo, lxAccautEntidad, lxAccautValocier, lxAccautRestpick, lxAccautObs
				lxAccautFecexpo =  .Fechaexpo			lxAccautFectrans =  .Fechatransferencia			lxAccautFmodifw =  .Fechamodificacionfw			lxAccautFaltafw =  .Fechaaltafw			lxAccautFecimpo =  .Fechaimpo			lxAccautSmodifw =  .Seriemodificacionfw			lxAccautHmodifw =  .Horamodificacionfw			lxAccautSaltafw =  .Seriealtafw			lxAccautUaltafw =  .Usuarioaltafw			lxAccautUmodifw =  .Usuariomodificacionfw			lxAccautVmodifw =  .Versionmodificacionfw			lxAccautHoraimpo =  .Horaimpo			lxAccautValtafw =  .Versionaltafw			lxAccautZadsfw =  .Zadsfw			lxAccautHaltafw =  .Horaaltafw			lxAccautEsttrans =  .Estadotransferencia			lxAccautBdaltafw =  .Basededatosaltafw			lxAccautBdmodifw =  .Basededatosmodificacionfw			lxAccautHoraexpo =  .Horaexpo			lxAccautNuevodg =  .Nuevodespuesdegrabar			lxAccautCodigo =  .Codigo			lxAccautEntidad =  .Entidad			lxAccautValocier =  upper( .ValorDeCierre_PK ) 			lxAccautRestpick =  .Restringirpicking			lxAccautObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ACCAUT set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAccautFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAccautFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAccautFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAccautFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAccautFecimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAccautSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAccautHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAccautSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAccautUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAccautUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAccautVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAccautHoraimpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAccautValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAccautZadsfw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAccautHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAccautEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAccautBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAccautBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAccautHoraexpo ) + "'">>,"Nuevodg" = <<iif( lxAccautNuevodg, 1, 0 )>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAccautCodigo ) + "'">>,"Entidad" = <<"'" + this.FormatearTextoSql( lxAccautEntidad ) + "'">>,"Valocier" = <<"'" + this.FormatearTextoSql( lxAccautValocier ) + "'">>,"Restpick" = <<iif( lxAccautRestpick, 1, 0 )>>,"Obs" = <<"'" + this.FormatearTextoSql( lxAccautObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxAccautCodigo ) + "'">> and  ACCAUT.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DACCAUT where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AccionesDetalle
				if this.oEntidad.AccionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMetodo = loItem.Metodo
					lxAccion = loItem.Accion
					lxExpresion = loItem.Expresion
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DACCAUT("NROITEM","Codigo","Metodo","Accion","Expr","Orden" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxMetodo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxExpresion ) + "'">>, <<lxOrden>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.ACCAUT where " + this.ConvertirFuncionesSql( " ACCAUT.CODIGO != ''" ) )
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
			Local lxAccautCodigo
			lxAccautCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Nuevodg" as "Nuevodespuesdegrabar", "Codigo" as "Codigo", "Entidad" as "Entidad", "Valocier" as "Valordecierre", "Restpick" as "Restringirpicking", "Obs" as "Observacion" from ZooLogic.ACCAUT where "Codigo" = <<"'" + this.FormatearTextoSql( lxAccautCodigo ) + "'">> and  ACCAUT.CODIGO != ''
			endtext
			use in select('c_ACCIONESAUTOMATICAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ACCIONESAUTOMATICAS', set( 'Datasession' ) )

			if reccount( 'c_ACCIONESAUTOMATICAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Metodo" as "Metodo", "Accion" as "Accion", "Expr" as "Expresion", "Orden" as "Orden" from ZooLogic.DACCAUT where Codigo = <<"'" + this.FormatearTextoSql( c_ACCIONESAUTOMATICAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AccionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AccionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AccionesDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxACCAUTEntidad As Variant
			lxACCAUTEntidad = .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Nuevodg" as "Nuevodespuesdegrabar", "Codigo" as "Codigo", "Entidad" as "Entidad", "Valocier" as "Valordecierre", "Restpick" as "Restringirpicking", "Obs" as "Observacion" from ZooLogic.ACCAUT where  ACCAUT.CODIGO != '' And Entidad = <<"'" + this.FormatearTextoSql( lxACCAUTEntidad ) + "'">>
			endtext
			use in select('c_ACCIONESAUTOMATICAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ACCIONESAUTOMATICAS', set( 'Datasession' ) )
			if reccount( 'c_ACCIONESAUTOMATICAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Metodo" as "Metodo", "Accion" as "Accion", "Expr" as "Expresion", "Orden" as "Orden" from ZooLogic.DACCAUT where Codigo = <<"'" + this.FormatearTextoSql( c_ACCIONESAUTOMATICAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AccionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AccionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AccionesDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAccautCodigo as Variant
		llRetorno = .t.
		lxAccautCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ACCAUT where "Codigo" = <<"'" + this.FormatearTextoSql( lxAccautCodigo ) + "'">> and  ACCAUT.CODIGO != ''
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
				lcOrden =  .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Nuevodg" as "Nuevodespuesdegrabar", "Codigo" as "Codigo", "Entidad" as "Entidad", "Valocier" as "Valordecierre", "Restpick" as "Restringirpicking", "Obs" as "Observacion" from ZooLogic.ACCAUT where  ACCAUT.CODIGO != '' order by Entidad
			endtext
			use in select('c_ACCIONESAUTOMATICAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ACCIONESAUTOMATICAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Metodo" as "Metodo", "Accion" as "Accion", "Expr" as "Expresion", "Orden" as "Orden" from ZooLogic.DACCAUT where Codigo = <<"'" + this.FormatearTextoSql( c_ACCIONESAUTOMATICAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AccionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AccionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AccionesDetalle
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
				lcOrden =  .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Nuevodg" as "Nuevodespuesdegrabar", "Codigo" as "Codigo", "Entidad" as "Entidad", "Valocier" as "Valordecierre", "Restpick" as "Restringirpicking", "Obs" as "Observacion" from ZooLogic.ACCAUT where  funciones.padr( Entidad, 40, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ACCAUT.CODIGO != '' order by Entidad
			endtext
			use in select('c_ACCIONESAUTOMATICAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ACCIONESAUTOMATICAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Metodo" as "Metodo", "Accion" as "Accion", "Expr" as "Expresion", "Orden" as "Orden" from ZooLogic.DACCAUT where Codigo = <<"'" + this.FormatearTextoSql( c_ACCIONESAUTOMATICAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AccionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AccionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AccionesDetalle
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
				lcOrden =  .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Nuevodg" as "Nuevodespuesdegrabar", "Codigo" as "Codigo", "Entidad" as "Entidad", "Valocier" as "Valordecierre", "Restpick" as "Restringirpicking", "Obs" as "Observacion" from ZooLogic.ACCAUT where  funciones.padr( Entidad, 40, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ACCAUT.CODIGO != '' order by Entidad desc
			endtext
			use in select('c_ACCIONESAUTOMATICAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ACCIONESAUTOMATICAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Metodo" as "Metodo", "Accion" as "Accion", "Expr" as "Expresion", "Orden" as "Orden" from ZooLogic.DACCAUT where Codigo = <<"'" + this.FormatearTextoSql( c_ACCIONESAUTOMATICAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AccionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AccionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AccionesDetalle
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
				lcOrden =  .Entidad
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Nuevodg" as "Nuevodespuesdegrabar", "Codigo" as "Codigo", "Entidad" as "Entidad", "Valocier" as "Valordecierre", "Restpick" as "Restringirpicking", "Obs" as "Observacion" from ZooLogic.ACCAUT where  ACCAUT.CODIGO != '' order by Entidad desc
			endtext
			use in select('c_ACCIONESAUTOMATICAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ACCIONESAUTOMATICAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Metodo" as "Metodo", "Accion" as "Accion", "Expr" as "Expresion", "Orden" as "Orden" from ZooLogic.DACCAUT where Codigo = <<"'" + this.FormatearTextoSql( c_ACCIONESAUTOMATICAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AccionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AccionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AccionesDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Vmodifw,Hor" + ;
"aimpo,Valtafw,Zadsfw,Haltafw,Esttrans,Bdaltafw,Bdmodifw,Horaexpo,Nuevodg,Codigo,Entidad,Valocier,Res" + ;
"tpick,Obs" + ;
" from ZooLogic.ACCAUT where  ACCAUT.CODIGO != '' and " + lcFiltro )
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
			local  lxAccautFecexpo, lxAccautFectrans, lxAccautFmodifw, lxAccautFaltafw, lxAccautFecimpo, lxAccautSmodifw, lxAccautHmodifw, lxAccautSaltafw, lxAccautUaltafw, lxAccautUmodifw, lxAccautVmodifw, lxAccautHoraimpo, lxAccautValtafw, lxAccautZadsfw, lxAccautHaltafw, lxAccautEsttrans, lxAccautBdaltafw, lxAccautBdmodifw, lxAccautHoraexpo, lxAccautNuevodg, lxAccautCodigo, lxAccautEntidad, lxAccautValocier, lxAccautRestpick, lxAccautObs
				lxAccautFecexpo = ctod( '  /  /    ' )			lxAccautFectrans = ctod( '  /  /    ' )			lxAccautFmodifw = ctod( '  /  /    ' )			lxAccautFaltafw = ctod( '  /  /    ' )			lxAccautFecimpo = ctod( '  /  /    ' )			lxAccautSmodifw = []			lxAccautHmodifw = []			lxAccautSaltafw = []			lxAccautUaltafw = []			lxAccautUmodifw = []			lxAccautVmodifw = []			lxAccautHoraimpo = []			lxAccautValtafw = []			lxAccautZadsfw = []			lxAccautHaltafw = []			lxAccautEsttrans = []			lxAccautBdaltafw = []			lxAccautBdmodifw = []			lxAccautHoraexpo = []			lxAccautNuevodg = .F.			lxAccautCodigo = []			lxAccautEntidad = []			lxAccautValocier = []			lxAccautRestpick = .F.			lxAccautObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DACCAUT where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ACCAUT where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ACCAUT' + '_' + tcCampo
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
		lcWhere = " Where  ACCAUT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Nuevodg" as "Nuevodespuesdegrabar", "Codigo" as "Codigo", "Entidad" as "Entidad", "Valocier" as "Valordecierre", "Restpick" as "Restringirpicking", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ACCAUT', '', tnTope )
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
	Function ObtenerDatosDetalleAccionesDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DACCAUT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Metodo" as "Metodo", "Accion" as "Accion", "Expr" as "Expresion", "Orden" as "Orden"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAccionesDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DACCAUT', 'AccionesDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAccionesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAccionesDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'NUEVODESPUESDEGRABAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUEVODG AS NUEVODESPUESDEGRABAR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTIDAD AS ENTIDAD'
				Case lcAtributo == 'VALORDECIERRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOCIER AS VALORDECIERRE'
				Case lcAtributo == 'RESTRINGIRPICKING'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESTPICK AS RESTRINGIRPICKING'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAccionesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'METODO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'METODO AS METODO'
				Case lcAtributo == 'ACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCION AS ACCION'
				Case lcAtributo == 'EXPRESION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPR AS EXPRESION'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDEN'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'NUEVODESPUESDEGRABAR'
				lcCampo = 'NUEVODG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'ENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDECIERRE'
				lcCampo = 'VALOCIER'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRPICKING'
				lcCampo = 'RESTPICK'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAccionesDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'METODO'
				lcCampo = 'METODO'
			Case upper( alltrim( tcAtributo ) ) == 'ACCION'
				lcCampo = 'ACCION'
			Case upper( alltrim( tcAtributo ) ) == 'EXPRESION'
				lcCampo = 'EXPR'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'ORDEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ACCIONESDETALLE'
			lcRetorno = 'DACCAUT'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAccautFecexpo, lxAccautFectrans, lxAccautFmodifw, lxAccautFaltafw, lxAccautFecimpo, lxAccautSmodifw, lxAccautHmodifw, lxAccautSaltafw, lxAccautUaltafw, lxAccautUmodifw, lxAccautVmodifw, lxAccautHoraimpo, lxAccautValtafw, lxAccautZadsfw, lxAccautHaltafw, lxAccautEsttrans, lxAccautBdaltafw, lxAccautBdmodifw, lxAccautHoraexpo, lxAccautNuevodg, lxAccautCodigo, lxAccautEntidad, lxAccautValocier, lxAccautRestpick, lxAccautObs
				lxAccautFecexpo =  .Fechaexpo			lxAccautFectrans =  .Fechatransferencia			lxAccautFmodifw =  .Fechamodificacionfw			lxAccautFaltafw =  .Fechaaltafw			lxAccautFecimpo =  .Fechaimpo			lxAccautSmodifw =  .Seriemodificacionfw			lxAccautHmodifw =  .Horamodificacionfw			lxAccautSaltafw =  .Seriealtafw			lxAccautUaltafw =  .Usuarioaltafw			lxAccautUmodifw =  .Usuariomodificacionfw			lxAccautVmodifw =  .Versionmodificacionfw			lxAccautHoraimpo =  .Horaimpo			lxAccautValtafw =  .Versionaltafw			lxAccautZadsfw =  .Zadsfw			lxAccautHaltafw =  .Horaaltafw			lxAccautEsttrans =  .Estadotransferencia			lxAccautBdaltafw =  .Basededatosaltafw			lxAccautBdmodifw =  .Basededatosmodificacionfw			lxAccautHoraexpo =  .Horaexpo			lxAccautNuevodg =  .Nuevodespuesdegrabar			lxAccautCodigo =  .Codigo			lxAccautEntidad =  .Entidad			lxAccautValocier =  upper( .ValorDeCierre_PK ) 			lxAccautRestpick =  .Restringirpicking			lxAccautObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ACCAUT ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Vmodifw","Horaimpo","Valtafw","Zadsfw","Haltafw","Esttrans","Bdaltafw","Bdmodifw","Horaexpo","Nuevodg","Codigo","Entidad","Valocier","Restpick","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxAccautFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAccautFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAccautFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAccautFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAccautFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautHoraexpo ) + "'" >>, <<iif( lxAccautNuevodg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAccautCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautEntidad ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAccautValocier ) + "'" >>, <<iif( lxAccautRestpick, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAccautObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ACCAUT' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AccionesDetalle
				if this.oEntidad.AccionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMetodo = loItem.Metodo
					lxAccion = loItem.Accion
					lxExpresion = loItem.Expresion
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DACCAUT("NROITEM","Codigo","Metodo","Accion","Expr","Orden" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxMetodo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxExpresion ) + "'">>, <<lxOrden>> ) 
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
			local  lxAccautFecexpo, lxAccautFectrans, lxAccautFmodifw, lxAccautFaltafw, lxAccautFecimpo, lxAccautSmodifw, lxAccautHmodifw, lxAccautSaltafw, lxAccautUaltafw, lxAccautUmodifw, lxAccautVmodifw, lxAccautHoraimpo, lxAccautValtafw, lxAccautZadsfw, lxAccautHaltafw, lxAccautEsttrans, lxAccautBdaltafw, lxAccautBdmodifw, lxAccautHoraexpo, lxAccautNuevodg, lxAccautCodigo, lxAccautEntidad, lxAccautValocier, lxAccautRestpick, lxAccautObs
				lxAccautFecexpo =  .Fechaexpo			lxAccautFectrans =  .Fechatransferencia			lxAccautFmodifw =  .Fechamodificacionfw			lxAccautFaltafw =  .Fechaaltafw			lxAccautFecimpo =  .Fechaimpo			lxAccautSmodifw =  .Seriemodificacionfw			lxAccautHmodifw =  .Horamodificacionfw			lxAccautSaltafw =  .Seriealtafw			lxAccautUaltafw =  .Usuarioaltafw			lxAccautUmodifw =  .Usuariomodificacionfw			lxAccautVmodifw =  .Versionmodificacionfw			lxAccautHoraimpo =  .Horaimpo			lxAccautValtafw =  .Versionaltafw			lxAccautZadsfw =  .Zadsfw			lxAccautHaltafw =  .Horaaltafw			lxAccautEsttrans =  .Estadotransferencia			lxAccautBdaltafw =  .Basededatosaltafw			lxAccautBdmodifw =  .Basededatosmodificacionfw			lxAccautHoraexpo =  .Horaexpo			lxAccautNuevodg =  .Nuevodespuesdegrabar			lxAccautCodigo =  .Codigo			lxAccautEntidad =  .Entidad			lxAccautValocier =  upper( .ValorDeCierre_PK ) 			lxAccautRestpick =  .Restringirpicking			lxAccautObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ACCAUT.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ACCAUT set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAccautFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAccautFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAccautFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAccautFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAccautFecimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAccautSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAccautHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAccautSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAccautUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAccautUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAccautVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAccautHoraimpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAccautValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAccautZadsfw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAccautHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAccautEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAccautBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAccautBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAccautHoraexpo ) + "'">>, "Nuevodg" = <<iif( lxAccautNuevodg, 1, 0 )>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAccautCodigo ) + "'">>, "Entidad" = <<"'" + this.FormatearTextoSql( lxAccautEntidad ) + "'">>, "Valocier" = <<"'" + this.FormatearTextoSql( lxAccautValocier ) + "'">>, "Restpick" = <<iif( lxAccautRestpick, 1, 0 )>>, "Obs" = <<"'" + this.FormatearTextoSql( lxAccautObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ACCAUT' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DACCAUT where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AccionesDetalle
				if this.oEntidad.AccionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMetodo = loItem.Metodo
					lxAccion = loItem.Accion
					lxExpresion = loItem.Expresion
					lxOrden = loItem.Orden
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DACCAUT("NROITEM","Codigo","Metodo","Accion","Expr","Orden" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxMetodo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxExpresion ) + "'">>, <<lxOrden>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ACCAUT.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.ACCAUT where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DACCAUT where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ACCAUT' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ACCAUT where  ACCAUT.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ACCAUT where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ACCAUT.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxACCAUTEntidad as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ACCIONESAUTOMATICAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ACCAUT Where  Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad    ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.ACCAUT set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, NuevoDG = ] + Transform( iif( &lcCursor..NuevoDG, 1, 0 ))+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'"+ [, ValoCier = ] + "'" + this.FormatearTextoSql( &lcCursor..ValoCier ) + "'"+ [, RestPick = ] + Transform( iif( &lcCursor..RestPick, 1, 0 ))+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.ACCAUT Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, SMODIFW, HMODIFW, SALTAFW, UALTAFW, UMODIFW, VMODIFW, HORAIMPO, VALTAFW, ZADSFW, HALTAFW, ESTTRANS, BDALTAFW, BDMODIFW, HORAEXPO, NuevoDG, Codigo, Entidad, ValoCier, RestPick, Obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + Transform( iif( &lcCursor..NuevoDG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValoCier ) + "'" + ',' + Transform( iif( &lcCursor..RestPick, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.ACCAUT ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ACCIONESAUTOMATICAS'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DACCAUT Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMACCIONESAUTOMATICAS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Metodo","Accion","Expr","Orden"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DACCAUT ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Metodo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Accion     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Expr       ) + "'" + ',' + transform( cDetallesExistentes.Orden      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (40) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Entidad: ' + transform( &tcCursor..Entidad    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ACCIONESAUTOMATICAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ACCIONESAUTOMATICAS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ACCIONESAUTOMATICAS_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMACCIONESAUTOMATICAS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ACCAUT')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ACCIONESAUTOMATICAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Entidad )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ACCIONESAUTOMATICAS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ACCIONESAUTOMATICAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,Entidad as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Entidad, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ACCIONESAUTOMATICAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ACCAUT') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ACCAUT
Create Table ZooLogic.TablaTrabajo_ACCAUT ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"nuevodg" bit  null, 
"codigo" char( 40 )  null, 
"entidad" char( 40 )  null, 
"valocier" char( 5 )  null, 
"restpick" bit  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ACCAUT' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ACCAUT' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ACCIONESAUTOMATICAS'
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('nuevodg','nuevodg')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('entidad','entidad')
			.AgregarMapeo('valocier','valocier')
			.AgregarMapeo('restpick','restpick')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ACCAUT'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.NUEVODG = isnull( d.NUEVODG, t.NUEVODG ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.ENTIDAD = isnull( d.ENTIDAD, t.ENTIDAD ),t.VALOCIER = isnull( d.VALOCIER, t.VALOCIER ),t.RESTPICK = isnull( d.RESTPICK, t.RESTPICK ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.ACCAUT t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Entidad = d.Entidad
				-- Fin Updates
				insert into ZooLogic.ACCAUT(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Vmodifw,Horaimpo,Valtafw,Zadsfw,Haltafw,Esttrans,Bdaltafw,Bdmodifw,Horaexpo,Nuevodg,Codigo,Entidad,Valocier,Restpick,Obs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.NUEVODG,0),isnull( d.CODIGO,''),isnull( d.ENTIDAD,''),isnull( d.VALOCIER,''),isnull( d.RESTPICK,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.ACCAUT pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.ACCAUT cc 
							 on  d.Entidad = cc.Entidad
						Where pk.Codigo Is Null 
							 and cc.Entidad Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ENTIDAD ' + cast( d.Entidad as Varchar(40) ) + '','La clave principal no es la esperada'
					from ZooLogic.ACCAUT t inner join deleted d 
							on   t.Entidad = d.Entidad
						left join deleted h 
							 on t.Codigo = h.Codigo
							 where h.Codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ENTIDAD ' + cast( d.Entidad as Varchar(40) ) + '','La clave principal a importar ya existe'
					from ZooLogic.ACCAUT t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.Entidad = h.Entidad
							where   h.Entidad is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DACCAUT( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ACCAUT_DACCAUT
ON ZooLogic.TablaTrabajo_ACCAUT_DACCAUT
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.METODO = isnull( d.METODO, t.METODO ),
t.ACCION = isnull( d.ACCION, t.ACCION ),
t.EXPR = isnull( d.EXPR, t.EXPR ),
t.ORDEN = isnull( d.ORDEN, t.ORDEN )
from ZooLogic.DACCAUT t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DACCAUT
( 
"NROITEM",
"CODIGO",
"METODO",
"ACCION",
"EXPR",
"ORDEN"
 )
Select 
d.NROITEM,
d.CODIGO,
d.METODO,
d.ACCION,
d.EXPR,
d.ORDEN
From deleted d left join ZooLogic.DACCAUT pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ACCAUT') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ACCAUT
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ACCIONESAUTOMATICAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ACCIONESAUTOMATICAS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ACCIONESAUTOMATICAS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ACCIONESAUTOMATICAS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ACCIONESAUTOMATICAS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ACCIONESAUTOMATICAS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Seriemodificacionfw = nvl( c_ACCIONESAUTOMATICAS.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_ACCIONESAUTOMATICAS.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_ACCIONESAUTOMATICAS.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_ACCIONESAUTOMATICAS.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ACCIONESAUTOMATICAS.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ACCIONESAUTOMATICAS.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_ACCIONESAUTOMATICAS.Horaimpo, [] )
					.Versionaltafw = nvl( c_ACCIONESAUTOMATICAS.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaaltafw = nvl( c_ACCIONESAUTOMATICAS.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_ACCIONESAUTOMATICAS.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_ACCIONESAUTOMATICAS.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ACCIONESAUTOMATICAS.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_ACCIONESAUTOMATICAS.Horaexpo, [] )
					.Accionesdetalle.Limpiar()
					.Accionesdetalle.SetearEsNavegacion( .lProcesando )
					.Accionesdetalle.Cargar()
					.Nuevodespuesdegrabar = nvl( c_ACCIONESAUTOMATICAS.Nuevodespuesdegrabar, .F. )
					.Codigo = nvl( c_ACCIONESAUTOMATICAS.Codigo, [] )
					.Entidad = nvl( c_ACCIONESAUTOMATICAS.Entidad, [] )
					.Valordecierre_PK =  nvl( c_ACCIONESAUTOMATICAS.Valordecierre, [] )
					.Restringirpicking = nvl( c_ACCIONESAUTOMATICAS.Restringirpicking, .F. )
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
			lxRetorno = c_ACCIONESAUTOMATICAS.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.AccionesDetalle
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
		return c_ACCIONESAUTOMATICAS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ACCAUT' )
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
								from ZooLogic.ACCAUT 
								Where   ACCAUT.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ACCAUT", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Nuevodg" as "Nuevodespuesdegrabar", "Codigo" as "Codigo", "Entidad" as "Entidad", "Valocier" as "Valordecierre", "Restpick" as "Restringirpicking", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ACCAUT 
								Where   ACCAUT.CODIGO != ''
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
	Tabla = 'ACCAUT'
	Filtro = " ACCAUT.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ACCAUT.CODIGO != ''"
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
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="FECHAEXPO                               " tabla="ACCAUT         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="FECHATRANSFERENCIA                      " tabla="ACCAUT         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="FECHAMODIFICACIONFW                     " tabla="ACCAUT         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="FECHAALTAFW                             " tabla="ACCAUT         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="FECHAIMPO                               " tabla="ACCAUT         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="SERIEMODIFICACIONFW                     " tabla="ACCAUT         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="HORAMODIFICACIONFW                      " tabla="ACCAUT         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="SERIEALTAFW                             " tabla="ACCAUT         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="USUARIOALTAFW                           " tabla="ACCAUT         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="USUARIOMODIFICACIONFW                   " tabla="ACCAUT         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="VERSIONMODIFICACIONFW                   " tabla="ACCAUT         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="HORAIMPO                                " tabla="ACCAUT         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="VERSIONALTAFW                           " tabla="ACCAUT         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="ZADSFW                                  " tabla="ACCAUT         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="HORAALTAFW                              " tabla="ACCAUT         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="ESTADOTRANSFERENCIA                     " tabla="ACCAUT         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="BASEDEDATOSALTAFW                       " tabla="ACCAUT         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ACCAUT         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="HORAEXPO                                " tabla="ACCAUT         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="ACCIONESDETALLE                         " tabla="DACCAUT        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Detalle                                                                                                                                                         " dominio="DETALLEITEMACCIONESAUTOMATICAS" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="NUEVODESPUESDEGRABAR                    " tabla="ACCAUT         " campo="NUEVODG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Inicia nuevo después de grabar                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="CODIGO                                  " tabla="ACCAUT         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Codigo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="ENTIDAD                                 " tabla="ACCAUT         " campo="ENTIDAD   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Entidad                                                                                                                                                         " dominio="COMBOENTIDADESVISIBLES        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="VALORDECIERRE                           " tabla="ACCAUT         " campo="VALOCIER  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Valor utilizado para finalizar un comprobante                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="RESTRINGIRPICKING                       " tabla="ACCAUT         " campo="RESTPICK  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Restringir picking a comprobante origen                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ACCIONESAUTOMATICAS                     " atributo="OBSERVACION                             " tabla="ACCAUT         " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVALORES       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVALORES On ACCAUT.VALOCIER = XVALORES.CLCOD And  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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