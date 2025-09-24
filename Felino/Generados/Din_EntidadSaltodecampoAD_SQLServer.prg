
define class Din_EntidadSALTODECAMPOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SALTODECAMPO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Entidad + Atributo]
	cExpresionCCPorCampos = [#tabla#.Entidad + #tabla#.Atributo]
	cTagClaveCandidata = '_SDCCC'
	cTagClavePk = '_SDCPK'
	cTablaPrincipal = 'SALTODECAMPO'
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
			local  lxSaltodecampoFecexpo, lxSaltodecampoFaltafw, lxSaltodecampoFecimpo, lxSaltodecampoFectrans, lxSaltodecampoFmodifw, lxSaltodecampoTipagrupub, lxSaltodecampoZadsfw, lxSaltodecampoVmodifw, lxSaltodecampoUaltafw, lxSaltodecampoUmodifw, lxSaltodecampoHaltafw, lxSaltodecampoHoraimpo, lxSaltodecampoHmodifw, lxSaltodecampoSaltafw, lxSaltodecampoSmodifw, lxSaltodecampoHoraexpo, lxSaltodecampoValtafw, lxSaltodecampoBdmodifw, lxSaltodecampoEsttrans, lxSaltodecampoDetalle, lxSaltodecampoAtrdesc, lxSaltodecampoEntdesc, lxSaltodecampoBdaltafw, lxSaltodecampoCodigo, lxSaltodecampoObs, lxSaltodecampoUsaetiq, lxSaltodecampoUsavalsis, lxSaltodecampoEntidad, lxSaltodecampoUsavsant, lxSaltodecampoPersetiq, lxSaltodecampoAtributo, lxSaltodecampoVsugerido, lxSaltodecampoSalta, lxSaltodecampoObliga, lxSaltodecampoOcultar, lxSaltodecampoNoobligaap, lxSaltodecampoMostrar
				lxSaltodecampoFecexpo =  .Fechaexpo			lxSaltodecampoFaltafw =  .Fechaaltafw			lxSaltodecampoFecimpo =  .Fechaimpo			lxSaltodecampoFectrans =  .Fechatransferencia			lxSaltodecampoFmodifw =  .Fechamodificacionfw			lxSaltodecampoTipagrupub =  .Tipoagrupamientopublicaciones			lxSaltodecampoZadsfw =  .Zadsfw			lxSaltodecampoVmodifw =  .Versionmodificacionfw			lxSaltodecampoUaltafw =  .Usuarioaltafw			lxSaltodecampoUmodifw =  .Usuariomodificacionfw			lxSaltodecampoHaltafw =  .Horaaltafw			lxSaltodecampoHoraimpo =  .Horaimpo			lxSaltodecampoHmodifw =  .Horamodificacionfw			lxSaltodecampoSaltafw =  .Seriealtafw			lxSaltodecampoSmodifw =  .Seriemodificacionfw			lxSaltodecampoHoraexpo =  .Horaexpo			lxSaltodecampoValtafw =  .Versionaltafw			lxSaltodecampoBdmodifw =  .Basededatosmodificacionfw			lxSaltodecampoEsttrans =  .Estadotransferencia			lxSaltodecampoDetalle =  .Detalle			lxSaltodecampoAtrdesc =  .Atributodescripcion			lxSaltodecampoEntdesc =  .Entidaddescripcion			lxSaltodecampoBdaltafw =  .Basededatosaltafw			lxSaltodecampoCodigo =  .Codigo			lxSaltodecampoObs =  .Obs			lxSaltodecampoUsaetiq =  .Usaetiquetadeframework			lxSaltodecampoUsavalsis =  .Usavalorsugeridodeframework			lxSaltodecampoEntidad =  .Entidad			lxSaltodecampoUsavsant =  .Usavalorsugeridoelementoanterior			lxSaltodecampoPersetiq =  .Personalizacionetiqueta			lxSaltodecampoAtributo =  .Atributo			lxSaltodecampoVsugerido =  .Valorsugerido			lxSaltodecampoSalta =  .Salta			lxSaltodecampoObliga =  .Obligatorio			lxSaltodecampoOcultar =  .Ocultar			lxSaltodecampoNoobligaap =  .Noobligatorioarticulospack			lxSaltodecampoMostrar =  .Mostrar
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSaltodecampoCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.SALTODECAMPO ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Tipagrupub","Zadsfw","Vmodifw","Ualtafw","Umodifw","Haltafw","Horaimpo","Hmodifw","Saltafw","Smodifw","Horaexpo","Valtafw","Bdmodifw","Esttrans","Detalle","Atrdesc","Entdesc","Bdaltafw","Codigo","Obs","Usaetiq","Usavalsis","Entidad","Usavsant","Persetiq","Atributo","Vsugerido","Salta","Obliga","Ocultar","Noobligaap","Mostrar" ) values ( <<"'" + this.ConvertirDateSql( lxSaltodecampoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSaltodecampoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSaltodecampoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSaltodecampoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSaltodecampoFmodifw ) + "'" >>, <<lxSaltodecampoTipagrupub >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoDetalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoAtrdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoEntdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoObs ) + "'" >>, <<iif( lxSaltodecampoUsaetiq, 1, 0 ) >>, <<iif( lxSaltodecampoUsavalsis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoEntidad ) + "'" >>, <<iif( lxSaltodecampoUsavsant, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoPersetiq ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoAtributo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoVsugerido ) + "'" >>, <<iif( lxSaltodecampoSalta, 1, 0 ) >>, <<iif( lxSaltodecampoObliga, 1, 0 ) >>, <<iif( lxSaltodecampoOcultar, 1, 0 ) >>, <<iif( lxSaltodecampoNoobligaap, 1, 0 ) >>, <<iif( lxSaltodecampoMostrar, 1, 0 ) >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubSDC("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxSaltodecampoFecexpo, lxSaltodecampoFaltafw, lxSaltodecampoFecimpo, lxSaltodecampoFectrans, lxSaltodecampoFmodifw, lxSaltodecampoTipagrupub, lxSaltodecampoZadsfw, lxSaltodecampoVmodifw, lxSaltodecampoUaltafw, lxSaltodecampoUmodifw, lxSaltodecampoHaltafw, lxSaltodecampoHoraimpo, lxSaltodecampoHmodifw, lxSaltodecampoSaltafw, lxSaltodecampoSmodifw, lxSaltodecampoHoraexpo, lxSaltodecampoValtafw, lxSaltodecampoBdmodifw, lxSaltodecampoEsttrans, lxSaltodecampoDetalle, lxSaltodecampoAtrdesc, lxSaltodecampoEntdesc, lxSaltodecampoBdaltafw, lxSaltodecampoCodigo, lxSaltodecampoObs, lxSaltodecampoUsaetiq, lxSaltodecampoUsavalsis, lxSaltodecampoEntidad, lxSaltodecampoUsavsant, lxSaltodecampoPersetiq, lxSaltodecampoAtributo, lxSaltodecampoVsugerido, lxSaltodecampoSalta, lxSaltodecampoObliga, lxSaltodecampoOcultar, lxSaltodecampoNoobligaap, lxSaltodecampoMostrar
				lxSaltodecampoFecexpo =  .Fechaexpo			lxSaltodecampoFaltafw =  .Fechaaltafw			lxSaltodecampoFecimpo =  .Fechaimpo			lxSaltodecampoFectrans =  .Fechatransferencia			lxSaltodecampoFmodifw =  .Fechamodificacionfw			lxSaltodecampoTipagrupub =  .Tipoagrupamientopublicaciones			lxSaltodecampoZadsfw =  .Zadsfw			lxSaltodecampoVmodifw =  .Versionmodificacionfw			lxSaltodecampoUaltafw =  .Usuarioaltafw			lxSaltodecampoUmodifw =  .Usuariomodificacionfw			lxSaltodecampoHaltafw =  .Horaaltafw			lxSaltodecampoHoraimpo =  .Horaimpo			lxSaltodecampoHmodifw =  .Horamodificacionfw			lxSaltodecampoSaltafw =  .Seriealtafw			lxSaltodecampoSmodifw =  .Seriemodificacionfw			lxSaltodecampoHoraexpo =  .Horaexpo			lxSaltodecampoValtafw =  .Versionaltafw			lxSaltodecampoBdmodifw =  .Basededatosmodificacionfw			lxSaltodecampoEsttrans =  .Estadotransferencia			lxSaltodecampoDetalle =  .Detalle			lxSaltodecampoAtrdesc =  .Atributodescripcion			lxSaltodecampoEntdesc =  .Entidaddescripcion			lxSaltodecampoBdaltafw =  .Basededatosaltafw			lxSaltodecampoCodigo =  .Codigo			lxSaltodecampoObs =  .Obs			lxSaltodecampoUsaetiq =  .Usaetiquetadeframework			lxSaltodecampoUsavalsis =  .Usavalorsugeridodeframework			lxSaltodecampoEntidad =  .Entidad			lxSaltodecampoUsavsant =  .Usavalorsugeridoelementoanterior			lxSaltodecampoPersetiq =  .Personalizacionetiqueta			lxSaltodecampoAtributo =  .Atributo			lxSaltodecampoVsugerido =  .Valorsugerido			lxSaltodecampoSalta =  .Salta			lxSaltodecampoObliga =  .Obligatorio			lxSaltodecampoOcultar =  .Ocultar			lxSaltodecampoNoobligaap =  .Noobligatorioarticulospack			lxSaltodecampoMostrar =  .Mostrar
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.SALTODECAMPO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFmodifw ) + "'">>,"Tipagrupub" = <<lxSaltodecampoTipagrupub>>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoSmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoValtafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSaltodecampoEsttrans ) + "'">>,"Detalle" = <<"'" + this.FormatearTextoSql( lxSaltodecampoDetalle ) + "'">>,"Atrdesc" = <<"'" + this.FormatearTextoSql( lxSaltodecampoAtrdesc ) + "'">>,"Entdesc" = <<"'" + this.FormatearTextoSql( lxSaltodecampoEntdesc ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxSaltodecampoObs ) + "'">>,"Usaetiq" = <<iif( lxSaltodecampoUsaetiq, 1, 0 )>>,"Usavalsis" = <<iif( lxSaltodecampoUsavalsis, 1, 0 )>>,"Entidad" = <<"'" + this.FormatearTextoSql( lxSaltodecampoEntidad ) + "'">>,"Usavsant" = <<iif( lxSaltodecampoUsavsant, 1, 0 )>>,"Persetiq" = <<"'" + this.FormatearTextoSql( lxSaltodecampoPersetiq ) + "'">>,"Atributo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoAtributo ) + "'">>,"Vsugerido" = <<"'" + this.FormatearTextoSql( lxSaltodecampoVsugerido ) + "'">>,"Salta" = <<iif( lxSaltodecampoSalta, 1, 0 )>>,"Obliga" = <<iif( lxSaltodecampoObliga, 1, 0 )>>,"Ocultar" = <<iif( lxSaltodecampoOcultar, 1, 0 )>>,"Noobligaap" = <<iif( lxSaltodecampoNoobligaap, 1, 0 )>>,"Mostrar" = <<iif( lxSaltodecampoMostrar, 1, 0 )>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoCodigo ) + "'">> and  SALTODECAMPO.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubSDC where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubSDC("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.SALTODECAMPO where " + this.ConvertirFuncionesSql( " SALTODECAMPO.CODIGO != ''" ) )
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
			Local lxSaltodecampoCodigo
			lxSaltodecampoCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Detalle" as "Detalle", "Atrdesc" as "Atributodescripcion", "Entdesc" as "Entidaddescripcion", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Usaetiq" as "Usaetiquetadeframework", "Usavalsis" as "Usavalorsugeridodeframework", "Entidad" as "Entidad", "Usavsant" as "Usavalorsugeridoelementoanterior", "Persetiq" as "Personalizacionetiqueta", "Atributo" as "Atributo", "Vsugerido" as "Valorsugerido", "Salta" as "Salta", "Obliga" as "Obligatorio", "Ocultar" as "Ocultar", "Noobligaap" as "Noobligatorioarticulospack", "Mostrar" as "Mostrar" from ZooLogic.SALTODECAMPO where "Codigo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoCodigo ) + "'">> and  SALTODECAMPO.CODIGO != ''
			endtext
			use in select('c_SALTODECAMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SALTODECAMPO', set( 'Datasession' ) )

			if reccount( 'c_SALTODECAMPO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSDC where Codigo = <<"'" + this.FormatearTextoSql( c_SALTODECAMPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxSaltoDeCampoEntidad As Variant, lxSaltoDeCampoAtributo As Variant
			lxSaltoDeCampoEntidad = .Entidad
			lxSaltoDeCampoAtributo = .Atributo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Detalle" as "Detalle", "Atrdesc" as "Atributodescripcion", "Entdesc" as "Entidaddescripcion", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Usaetiq" as "Usaetiquetadeframework", "Usavalsis" as "Usavalorsugeridodeframework", "Entidad" as "Entidad", "Usavsant" as "Usavalorsugeridoelementoanterior", "Persetiq" as "Personalizacionetiqueta", "Atributo" as "Atributo", "Vsugerido" as "Valorsugerido", "Salta" as "Salta", "Obliga" as "Obligatorio", "Ocultar" as "Ocultar", "Noobligaap" as "Noobligatorioarticulospack", "Mostrar" as "Mostrar" from ZooLogic.SALTODECAMPO where  SALTODECAMPO.CODIGO != '' And Entidad = <<"'" + this.FormatearTextoSql( lxSaltoDeCampoEntidad ) + "'">> and Atributo = <<"'" + this.FormatearTextoSql( lxSaltoDeCampoAtributo ) + "'">>
			endtext
			use in select('c_SALTODECAMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SALTODECAMPO', set( 'Datasession' ) )
			if reccount( 'c_SALTODECAMPO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSDC where Codigo = <<"'" + this.FormatearTextoSql( c_SALTODECAMPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxSaltodecampoCodigo as Variant
		llRetorno = .t.
		lxSaltodecampoCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.SALTODECAMPO where "Codigo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoCodigo ) + "'">> and  SALTODECAMPO.CODIGO != ''
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
				lcOrden =  .Entidad + .Atributo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Detalle" as "Detalle", "Atrdesc" as "Atributodescripcion", "Entdesc" as "Entidaddescripcion", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Usaetiq" as "Usaetiquetadeframework", "Usavalsis" as "Usavalorsugeridodeframework", "Entidad" as "Entidad", "Usavsant" as "Usavalorsugeridoelementoanterior", "Persetiq" as "Personalizacionetiqueta", "Atributo" as "Atributo", "Vsugerido" as "Valorsugerido", "Salta" as "Salta", "Obliga" as "Obligatorio", "Ocultar" as "Ocultar", "Noobligaap" as "Noobligatorioarticulospack", "Mostrar" as "Mostrar" from ZooLogic.SALTODECAMPO where  SALTODECAMPO.CODIGO != '' order by Entidad,Atributo
			endtext
			use in select('c_SALTODECAMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SALTODECAMPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSDC where Codigo = <<"'" + this.FormatearTextoSql( c_SALTODECAMPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				lcOrden =  .Entidad + .Atributo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Detalle" as "Detalle", "Atrdesc" as "Atributodescripcion", "Entdesc" as "Entidaddescripcion", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Usaetiq" as "Usaetiquetadeframework", "Usavalsis" as "Usavalorsugeridodeframework", "Entidad" as "Entidad", "Usavsant" as "Usavalorsugeridoelementoanterior", "Persetiq" as "Personalizacionetiqueta", "Atributo" as "Atributo", "Vsugerido" as "Valorsugerido", "Salta" as "Salta", "Obliga" as "Obligatorio", "Ocultar" as "Ocultar", "Noobligaap" as "Noobligatorioarticulospack", "Mostrar" as "Mostrar" from ZooLogic.SALTODECAMPO where  funciones.padr( Entidad, 40, ' ' ) + funciones.padr( Atributo, 40, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SALTODECAMPO.CODIGO != '' order by Entidad,Atributo
			endtext
			use in select('c_SALTODECAMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SALTODECAMPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSDC where Codigo = <<"'" + this.FormatearTextoSql( c_SALTODECAMPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				lcOrden =  .Entidad + .Atributo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Detalle" as "Detalle", "Atrdesc" as "Atributodescripcion", "Entdesc" as "Entidaddescripcion", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Usaetiq" as "Usaetiquetadeframework", "Usavalsis" as "Usavalorsugeridodeframework", "Entidad" as "Entidad", "Usavsant" as "Usavalorsugeridoelementoanterior", "Persetiq" as "Personalizacionetiqueta", "Atributo" as "Atributo", "Vsugerido" as "Valorsugerido", "Salta" as "Salta", "Obliga" as "Obligatorio", "Ocultar" as "Ocultar", "Noobligaap" as "Noobligatorioarticulospack", "Mostrar" as "Mostrar" from ZooLogic.SALTODECAMPO where  funciones.padr( Entidad, 40, ' ' ) + funciones.padr( Atributo, 40, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SALTODECAMPO.CODIGO != '' order by Entidad desc,Atributo desc
			endtext
			use in select('c_SALTODECAMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SALTODECAMPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSDC where Codigo = <<"'" + this.FormatearTextoSql( c_SALTODECAMPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				lcOrden =  .Entidad + .Atributo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Detalle" as "Detalle", "Atrdesc" as "Atributodescripcion", "Entdesc" as "Entidaddescripcion", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Usaetiq" as "Usaetiquetadeframework", "Usavalsis" as "Usavalorsugeridodeframework", "Entidad" as "Entidad", "Usavsant" as "Usavalorsugeridoelementoanterior", "Persetiq" as "Personalizacionetiqueta", "Atributo" as "Atributo", "Vsugerido" as "Valorsugerido", "Salta" as "Salta", "Obliga" as "Obligatorio", "Ocultar" as "Ocultar", "Noobligaap" as "Noobligatorioarticulospack", "Mostrar" as "Mostrar" from ZooLogic.SALTODECAMPO where  SALTODECAMPO.CODIGO != '' order by Entidad desc,Atributo desc
			endtext
			use in select('c_SALTODECAMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SALTODECAMPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubSDC where Codigo = <<"'" + this.FormatearTextoSql( c_SALTODECAMPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Tipagrupub,Zadsfw,Vmodifw,Ualtafw,Umodifw,Haltafw,H" + ;
"oraimpo,Hmodifw,Saltafw,Smodifw,Horaexpo,Valtafw,Bdmodifw,Esttrans,Detalle,Atrdesc,Entdesc,Bdaltafw," + ;
"Codigo,Obs,Usaetiq,Usavalsis,Entidad,Usavsant,Persetiq,Atributo,Vsugerido,Salta,Obliga,Ocultar,Noobl" + ;
"igaap,Mostrar" + ;
" from ZooLogic.SALTODECAMPO where  SALTODECAMPO.CODIGO != '' and " + lcFiltro )
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
			local  lxSaltodecampoFecexpo, lxSaltodecampoFaltafw, lxSaltodecampoFecimpo, lxSaltodecampoFectrans, lxSaltodecampoFmodifw, lxSaltodecampoTipagrupub, lxSaltodecampoZadsfw, lxSaltodecampoVmodifw, lxSaltodecampoUaltafw, lxSaltodecampoUmodifw, lxSaltodecampoHaltafw, lxSaltodecampoHoraimpo, lxSaltodecampoHmodifw, lxSaltodecampoSaltafw, lxSaltodecampoSmodifw, lxSaltodecampoHoraexpo, lxSaltodecampoValtafw, lxSaltodecampoBdmodifw, lxSaltodecampoEsttrans, lxSaltodecampoDetalle, lxSaltodecampoAtrdesc, lxSaltodecampoEntdesc, lxSaltodecampoBdaltafw, lxSaltodecampoCodigo, lxSaltodecampoObs, lxSaltodecampoUsaetiq, lxSaltodecampoUsavalsis, lxSaltodecampoEntidad, lxSaltodecampoUsavsant, lxSaltodecampoPersetiq, lxSaltodecampoAtributo, lxSaltodecampoVsugerido, lxSaltodecampoSalta, lxSaltodecampoObliga, lxSaltodecampoOcultar, lxSaltodecampoNoobligaap, lxSaltodecampoMostrar
				lxSaltodecampoFecexpo = ctod( '  /  /    ' )			lxSaltodecampoFaltafw = ctod( '  /  /    ' )			lxSaltodecampoFecimpo = ctod( '  /  /    ' )			lxSaltodecampoFectrans = ctod( '  /  /    ' )			lxSaltodecampoFmodifw = ctod( '  /  /    ' )			lxSaltodecampoTipagrupub = 0			lxSaltodecampoZadsfw = []			lxSaltodecampoVmodifw = []			lxSaltodecampoUaltafw = []			lxSaltodecampoUmodifw = []			lxSaltodecampoHaltafw = []			lxSaltodecampoHoraimpo = []			lxSaltodecampoHmodifw = []			lxSaltodecampoSaltafw = []			lxSaltodecampoSmodifw = []			lxSaltodecampoHoraexpo = []			lxSaltodecampoValtafw = []			lxSaltodecampoBdmodifw = []			lxSaltodecampoEsttrans = []			lxSaltodecampoDetalle = []			lxSaltodecampoAtrdesc = []			lxSaltodecampoEntdesc = []			lxSaltodecampoBdaltafw = []			lxSaltodecampoCodigo = []			lxSaltodecampoObs = []			lxSaltodecampoUsaetiq = .F.			lxSaltodecampoUsavalsis = .F.			lxSaltodecampoEntidad = []			lxSaltodecampoUsavsant = .F.			lxSaltodecampoPersetiq = []			lxSaltodecampoAtributo = []			lxSaltodecampoVsugerido = []			lxSaltodecampoSalta = .F.			lxSaltodecampoObliga = .F.			lxSaltodecampoOcultar = .F.			lxSaltodecampoNoobligaap = .F.			lxSaltodecampoMostrar = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubSDC where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.SALTODECAMPO where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SALTODECAMPO' + '_' + tcCampo
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
		lcWhere = " Where  SALTODECAMPO.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Detalle" as "Detalle", "Atrdesc" as "Atributodescripcion", "Entdesc" as "Entidaddescripcion", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Usaetiq" as "Usaetiquetadeframework", "Usavalsis" as "Usavalorsugeridodeframework", "Entidad" as "Entidad", "Usavsant" as "Usavalorsugeridoelementoanterior", "Persetiq" as "Personalizacionetiqueta", "Atributo" as "Atributo", "Vsugerido" as "Valorsugerido", "Salta" as "Salta", "Obliga" as "Obligatorio", "Ocultar" as "Ocultar", "Noobligaap" as "Noobligatorioarticulospack", "Mostrar" as "Mostrar"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SALTODECAMPO', '', tnTope )
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
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBSDC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAgruPubliDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubSDC', 'AgruPubliDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAgruPubliDetalle( lcAtributo )
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
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'DETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DETALLE AS DETALLE'
				Case lcAtributo == 'ATRIBUTODESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ATRDESC AS ATRIBUTODESCRIPCION'
				Case lcAtributo == 'ENTIDADDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTDESC AS ENTIDADDESCRIPCION'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'USAETIQUETADEFRAMEWORK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USAETIQ AS USAETIQUETADEFRAMEWORK'
				Case lcAtributo == 'USAVALORSUGERIDODEFRAMEWORK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USAVALSIS AS USAVALORSUGERIDODEFRAMEWORK'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTIDAD AS ENTIDAD'
				Case lcAtributo == 'USAVALORSUGERIDOELEMENTOANTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USAVSANT AS USAVALORSUGERIDOELEMENTOANTERIOR'
				Case lcAtributo == 'PERSONALIZACIONETIQUETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSETIQ AS PERSONALIZACIONETIQUETA'
				Case lcAtributo == 'ATRIBUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ATRIBUTO AS ATRIBUTO'
				Case lcAtributo == 'VALORSUGERIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VSUGERIDO AS VALORSUGERIDO'
				Case lcAtributo == 'SALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTA AS SALTA'
				Case lcAtributo == 'OBLIGATORIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBLIGA AS OBLIGATORIO'
				Case lcAtributo == 'OCULTAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OCULTAR AS OCULTAR'
				Case lcAtributo == 'NOOBLIGATORIOARTICULOSPACK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOOBLIGAAP AS NOOBLIGATORIOARTICULOSPACK'
				Case lcAtributo == 'MOSTRAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOSTRAR AS MOSTRAR'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'AGRUPAMIENTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPDES AS AGRUPAMIENTODETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'DETALLE'
				lcCampo = 'DETALLE'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTODESCRIPCION'
				lcCampo = 'ATRDESC'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADDESCRIPCION'
				lcCampo = 'ENTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'USAETIQUETADEFRAMEWORK'
				lcCampo = 'USAETIQ'
			Case upper( alltrim( tcAtributo ) ) == 'USAVALORSUGERIDODEFRAMEWORK'
				lcCampo = 'USAVALSIS'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'ENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'USAVALORSUGERIDOELEMENTOANTERIOR'
				lcCampo = 'USAVSANT'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZACIONETIQUETA'
				lcCampo = 'PERSETIQ'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTO'
				lcCampo = 'ATRIBUTO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORSUGERIDO'
				lcCampo = 'VSUGERIDO'
			Case upper( alltrim( tcAtributo ) ) == 'SALTA'
				lcCampo = 'SALTA'
			Case upper( alltrim( tcAtributo ) ) == 'OBLIGATORIO'
				lcCampo = 'OBLIGA'
			Case upper( alltrim( tcAtributo ) ) == 'OCULTAR'
				lcCampo = 'OCULTAR'
			Case upper( alltrim( tcAtributo ) ) == 'NOOBLIGATORIOARTICULOSPACK'
				lcCampo = 'NOOBLIGAAP'
			Case upper( alltrim( tcAtributo ) ) == 'MOSTRAR'
				lcCampo = 'MOSTRAR'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAgruPubliDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTODETALLE'
				lcCampo = 'AGRUPDES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBSDC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxSaltodecampoFecexpo, lxSaltodecampoFaltafw, lxSaltodecampoFecimpo, lxSaltodecampoFectrans, lxSaltodecampoFmodifw, lxSaltodecampoTipagrupub, lxSaltodecampoZadsfw, lxSaltodecampoVmodifw, lxSaltodecampoUaltafw, lxSaltodecampoUmodifw, lxSaltodecampoHaltafw, lxSaltodecampoHoraimpo, lxSaltodecampoHmodifw, lxSaltodecampoSaltafw, lxSaltodecampoSmodifw, lxSaltodecampoHoraexpo, lxSaltodecampoValtafw, lxSaltodecampoBdmodifw, lxSaltodecampoEsttrans, lxSaltodecampoDetalle, lxSaltodecampoAtrdesc, lxSaltodecampoEntdesc, lxSaltodecampoBdaltafw, lxSaltodecampoCodigo, lxSaltodecampoObs, lxSaltodecampoUsaetiq, lxSaltodecampoUsavalsis, lxSaltodecampoEntidad, lxSaltodecampoUsavsant, lxSaltodecampoPersetiq, lxSaltodecampoAtributo, lxSaltodecampoVsugerido, lxSaltodecampoSalta, lxSaltodecampoObliga, lxSaltodecampoOcultar, lxSaltodecampoNoobligaap, lxSaltodecampoMostrar
				lxSaltodecampoFecexpo =  .Fechaexpo			lxSaltodecampoFaltafw =  .Fechaaltafw			lxSaltodecampoFecimpo =  .Fechaimpo			lxSaltodecampoFectrans =  .Fechatransferencia			lxSaltodecampoFmodifw =  .Fechamodificacionfw			lxSaltodecampoTipagrupub =  .Tipoagrupamientopublicaciones			lxSaltodecampoZadsfw =  .Zadsfw			lxSaltodecampoVmodifw =  .Versionmodificacionfw			lxSaltodecampoUaltafw =  .Usuarioaltafw			lxSaltodecampoUmodifw =  .Usuariomodificacionfw			lxSaltodecampoHaltafw =  .Horaaltafw			lxSaltodecampoHoraimpo =  .Horaimpo			lxSaltodecampoHmodifw =  .Horamodificacionfw			lxSaltodecampoSaltafw =  .Seriealtafw			lxSaltodecampoSmodifw =  .Seriemodificacionfw			lxSaltodecampoHoraexpo =  .Horaexpo			lxSaltodecampoValtafw =  .Versionaltafw			lxSaltodecampoBdmodifw =  .Basededatosmodificacionfw			lxSaltodecampoEsttrans =  .Estadotransferencia			lxSaltodecampoDetalle =  .Detalle			lxSaltodecampoAtrdesc =  .Atributodescripcion			lxSaltodecampoEntdesc =  .Entidaddescripcion			lxSaltodecampoBdaltafw =  .Basededatosaltafw			lxSaltodecampoCodigo =  .Codigo			lxSaltodecampoObs =  .Obs			lxSaltodecampoUsaetiq =  .Usaetiquetadeframework			lxSaltodecampoUsavalsis =  .Usavalorsugeridodeframework			lxSaltodecampoEntidad =  .Entidad			lxSaltodecampoUsavsant =  .Usavalorsugeridoelementoanterior			lxSaltodecampoPersetiq =  .Personalizacionetiqueta			lxSaltodecampoAtributo =  .Atributo			lxSaltodecampoVsugerido =  .Valorsugerido			lxSaltodecampoSalta =  .Salta			lxSaltodecampoObliga =  .Obligatorio			lxSaltodecampoOcultar =  .Ocultar			lxSaltodecampoNoobligaap =  .Noobligatorioarticulospack			lxSaltodecampoMostrar =  .Mostrar
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.SALTODECAMPO ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Tipagrupub","Zadsfw","Vmodifw","Ualtafw","Umodifw","Haltafw","Horaimpo","Hmodifw","Saltafw","Smodifw","Horaexpo","Valtafw","Bdmodifw","Esttrans","Detalle","Atrdesc","Entdesc","Bdaltafw","Codigo","Obs","Usaetiq","Usavalsis","Entidad","Usavsant","Persetiq","Atributo","Vsugerido","Salta","Obliga","Ocultar","Noobligaap","Mostrar" ) values ( <<"'" + this.ConvertirDateSql( lxSaltodecampoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSaltodecampoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSaltodecampoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSaltodecampoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSaltodecampoFmodifw ) + "'" >>, <<lxSaltodecampoTipagrupub >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoDetalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoAtrdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoEntdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoObs ) + "'" >>, <<iif( lxSaltodecampoUsaetiq, 1, 0 ) >>, <<iif( lxSaltodecampoUsavalsis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoEntidad ) + "'" >>, <<iif( lxSaltodecampoUsavsant, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoPersetiq ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoAtributo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSaltodecampoVsugerido ) + "'" >>, <<iif( lxSaltodecampoSalta, 1, 0 ) >>, <<iif( lxSaltodecampoObliga, 1, 0 ) >>, <<iif( lxSaltodecampoOcultar, 1, 0 ) >>, <<iif( lxSaltodecampoNoobligaap, 1, 0 ) >>, <<iif( lxSaltodecampoMostrar, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'SALTODECAMPO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubSDC("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxSaltodecampoFecexpo, lxSaltodecampoFaltafw, lxSaltodecampoFecimpo, lxSaltodecampoFectrans, lxSaltodecampoFmodifw, lxSaltodecampoTipagrupub, lxSaltodecampoZadsfw, lxSaltodecampoVmodifw, lxSaltodecampoUaltafw, lxSaltodecampoUmodifw, lxSaltodecampoHaltafw, lxSaltodecampoHoraimpo, lxSaltodecampoHmodifw, lxSaltodecampoSaltafw, lxSaltodecampoSmodifw, lxSaltodecampoHoraexpo, lxSaltodecampoValtafw, lxSaltodecampoBdmodifw, lxSaltodecampoEsttrans, lxSaltodecampoDetalle, lxSaltodecampoAtrdesc, lxSaltodecampoEntdesc, lxSaltodecampoBdaltafw, lxSaltodecampoCodigo, lxSaltodecampoObs, lxSaltodecampoUsaetiq, lxSaltodecampoUsavalsis, lxSaltodecampoEntidad, lxSaltodecampoUsavsant, lxSaltodecampoPersetiq, lxSaltodecampoAtributo, lxSaltodecampoVsugerido, lxSaltodecampoSalta, lxSaltodecampoObliga, lxSaltodecampoOcultar, lxSaltodecampoNoobligaap, lxSaltodecampoMostrar
				lxSaltodecampoFecexpo =  .Fechaexpo			lxSaltodecampoFaltafw =  .Fechaaltafw			lxSaltodecampoFecimpo =  .Fechaimpo			lxSaltodecampoFectrans =  .Fechatransferencia			lxSaltodecampoFmodifw =  .Fechamodificacionfw			lxSaltodecampoTipagrupub =  .Tipoagrupamientopublicaciones			lxSaltodecampoZadsfw =  .Zadsfw			lxSaltodecampoVmodifw =  .Versionmodificacionfw			lxSaltodecampoUaltafw =  .Usuarioaltafw			lxSaltodecampoUmodifw =  .Usuariomodificacionfw			lxSaltodecampoHaltafw =  .Horaaltafw			lxSaltodecampoHoraimpo =  .Horaimpo			lxSaltodecampoHmodifw =  .Horamodificacionfw			lxSaltodecampoSaltafw =  .Seriealtafw			lxSaltodecampoSmodifw =  .Seriemodificacionfw			lxSaltodecampoHoraexpo =  .Horaexpo			lxSaltodecampoValtafw =  .Versionaltafw			lxSaltodecampoBdmodifw =  .Basededatosmodificacionfw			lxSaltodecampoEsttrans =  .Estadotransferencia			lxSaltodecampoDetalle =  .Detalle			lxSaltodecampoAtrdesc =  .Atributodescripcion			lxSaltodecampoEntdesc =  .Entidaddescripcion			lxSaltodecampoBdaltafw =  .Basededatosaltafw			lxSaltodecampoCodigo =  .Codigo			lxSaltodecampoObs =  .Obs			lxSaltodecampoUsaetiq =  .Usaetiquetadeframework			lxSaltodecampoUsavalsis =  .Usavalorsugeridodeframework			lxSaltodecampoEntidad =  .Entidad			lxSaltodecampoUsavsant =  .Usavalorsugeridoelementoanterior			lxSaltodecampoPersetiq =  .Personalizacionetiqueta			lxSaltodecampoAtributo =  .Atributo			lxSaltodecampoVsugerido =  .Valorsugerido			lxSaltodecampoSalta =  .Salta			lxSaltodecampoObliga =  .Obligatorio			lxSaltodecampoOcultar =  .Ocultar			lxSaltodecampoNoobligaap =  .Noobligatorioarticulospack			lxSaltodecampoMostrar =  .Mostrar
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SALTODECAMPO.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.SALTODECAMPO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSaltodecampoFmodifw ) + "'">>, "Tipagrupub" = <<lxSaltodecampoTipagrupub>>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoSmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoValtafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSaltodecampoEsttrans ) + "'">>, "Detalle" = <<"'" + this.FormatearTextoSql( lxSaltodecampoDetalle ) + "'">>, "Atrdesc" = <<"'" + this.FormatearTextoSql( lxSaltodecampoAtrdesc ) + "'">>, "Entdesc" = <<"'" + this.FormatearTextoSql( lxSaltodecampoEntdesc ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSaltodecampoBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxSaltodecampoObs ) + "'">>, "Usaetiq" = <<iif( lxSaltodecampoUsaetiq, 1, 0 )>>, "Usavalsis" = <<iif( lxSaltodecampoUsavalsis, 1, 0 )>>, "Entidad" = <<"'" + this.FormatearTextoSql( lxSaltodecampoEntidad ) + "'">>, "Usavsant" = <<iif( lxSaltodecampoUsavsant, 1, 0 )>>, "Persetiq" = <<"'" + this.FormatearTextoSql( lxSaltodecampoPersetiq ) + "'">>, "Atributo" = <<"'" + this.FormatearTextoSql( lxSaltodecampoAtributo ) + "'">>, "Vsugerido" = <<"'" + this.FormatearTextoSql( lxSaltodecampoVsugerido ) + "'">>, "Salta" = <<iif( lxSaltodecampoSalta, 1, 0 )>>, "Obliga" = <<iif( lxSaltodecampoObliga, 1, 0 )>>, "Ocultar" = <<iif( lxSaltodecampoOcultar, 1, 0 )>>, "Noobligaap" = <<iif( lxSaltodecampoNoobligaap, 1, 0 )>>, "Mostrar" = <<iif( lxSaltodecampoMostrar, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SALTODECAMPO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.AgruPubSDC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubSDC("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SALTODECAMPO.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.SALTODECAMPO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPubSDC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'SALTODECAMPO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.SALTODECAMPO where  SALTODECAMPO.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.SALTODECAMPO where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SALTODECAMPO.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxSaltoDeCampoEntidad as variant, lxSaltoDeCampoAtributo as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SALTODECAMPO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.SALTODECAMPO Where  Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad    ) + "'" + [ and Atributo = ] + "'" + this.FormatearTextoSql( &lcCursor..Atributo   ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.SALTODECAMPO set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Detalle = ] + "'" + this.FormatearTextoSql( &lcCursor..Detalle ) + "'"+ [, AtrDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..AtrDesc ) + "'"+ [, EntDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..EntDesc ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, usaetiq = ] + Transform( iif( &lcCursor..usaetiq, 1, 0 ))+ [, UsaValSis = ] + Transform( iif( &lcCursor..UsaValSis, 1, 0 ))+ [, Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'"+ [, UsaVSAnt = ] + Transform( iif( &lcCursor..UsaVSAnt, 1, 0 ))+ [, persetiq = ] + "'" + this.FormatearTextoSql( &lcCursor..persetiq ) + "'"+ [, Atributo = ] + "'" + this.FormatearTextoSql( &lcCursor..Atributo ) + "'"+ [, VSugerido = ] + "'" + this.FormatearTextoSql( &lcCursor..VSugerido ) + "'"+ [, Salta = ] + Transform( iif( &lcCursor..Salta, 1, 0 ))+ [, Obliga = ] + Transform( iif( &lcCursor..Obliga, 1, 0 ))+ [, Ocultar = ] + Transform( iif( &lcCursor..Ocultar, 1, 0 ))+ [, NoObligaAP = ] + Transform( iif( &lcCursor..NoObligaAP, 1, 0 ))+ [, Mostrar = ] + Transform( iif( &lcCursor..Mostrar, 1, 0 )) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.SALTODECAMPO Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FECIMPO, FECTRANS, FMODIFW, tipagrupub, ZADSFW, VMODIFW, UALTAFW, UMODIFW, HALTAFW, HORAIMPO, HMODIFW, SALTAFW, SMODIFW, HORAEXPO, VALTAFW, BDMODIFW, ESTTRANS, Detalle, AtrDesc, EntDesc, BDALTAFW, Codigo, Obs, usaetiq, UsaValSis, Entidad, UsaVSAnt, persetiq, Atributo, VSugerido, Salta, Obliga, Ocultar, NoObligaAP, Mostrar
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Detalle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AtrDesc ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..EntDesc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + Transform( iif( &lcCursor..usaetiq, 1, 0 )) + ',' + Transform( iif( &lcCursor..UsaValSis, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..UsaVSAnt, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..persetiq ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Atributo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VSugerido ) + "'" + ',' + Transform( iif( &lcCursor..Salta, 1, 0 )) + ',' + Transform( iif( &lcCursor..Obliga, 1, 0 )) + ',' + Transform( iif( &lcCursor..Ocultar, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..NoObligaAP, 1, 0 )) + ',' + Transform( iif( &lcCursor..Mostrar, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.SALTODECAMPO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SALTODECAMPO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubSDC Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICSDC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubSDC ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'SALTODECAMPO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SALTODECAMPO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SALTODECAMPO_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICSDC'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_SaltoDeCampo')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SALTODECAMPO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Entidad ) or isnull( &lcCursor..Atributo )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SALTODECAMPO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SALTODECAMPO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,Entidad + Atributo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Entidad + Atributo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SALTODECAMPO'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SaltoDeCampo') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SaltoDeCampo
Create Table ZooLogic.TablaTrabajo_SaltoDeCampo ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"detalle" char( 40 )  null, 
"atrdesc" char( 160 )  null, 
"entdesc" char( 60 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"obs" varchar(max)  null, 
"usaetiq" bit  null, 
"usavalsis" bit  null, 
"entidad" char( 40 )  null, 
"usavsant" bit  null, 
"persetiq" char( 160 )  null, 
"atributo" char( 40 )  null, 
"vsugerido" char( 254 )  null, 
"salta" bit  null, 
"obliga" bit  null, 
"ocultar" bit  null, 
"noobligaap" bit  null, 
"mostrar" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_SaltoDeCampo' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_SaltoDeCampo' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SALTODECAMPO'
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
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('detalle','detalle')
			.AgregarMapeo('atrdesc','atrdesc')
			.AgregarMapeo('entdesc','entdesc')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('usaetiq','usaetiq')
			.AgregarMapeo('usavalsis','usavalsis')
			.AgregarMapeo('entidad','entidad')
			.AgregarMapeo('usavsant','usavsant')
			.AgregarMapeo('persetiq','persetiq')
			.AgregarMapeo('atributo','atributo')
			.AgregarMapeo('vsugerido','vsugerido')
			.AgregarMapeo('salta','salta')
			.AgregarMapeo('obliga','obliga')
			.AgregarMapeo('ocultar','ocultar')
			.AgregarMapeo('noobligaap','noobligaap')
			.AgregarMapeo('mostrar','mostrar')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_SaltoDeCampo'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.DETALLE = isnull( d.DETALLE, t.DETALLE ),t.ATRDESC = isnull( d.ATRDESC, t.ATRDESC ),t.ENTDESC = isnull( d.ENTDESC, t.ENTDESC ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.USAETIQ = isnull( d.USAETIQ, t.USAETIQ ),t.USAVALSIS = isnull( d.USAVALSIS, t.USAVALSIS ),t.ENTIDAD = isnull( d.ENTIDAD, t.ENTIDAD ),t.USAVSANT = isnull( d.USAVSANT, t.USAVSANT ),t.PERSETIQ = isnull( d.PERSETIQ, t.PERSETIQ ),t.ATRIBUTO = isnull( d.ATRIBUTO, t.ATRIBUTO ),t.VSUGERIDO = isnull( d.VSUGERIDO, t.VSUGERIDO ),t.SALTA = isnull( d.SALTA, t.SALTA ),t.OBLIGA = isnull( d.OBLIGA, t.OBLIGA ),t.OCULTAR = isnull( d.OCULTAR, t.OCULTAR ),t.NOOBLIGAAP = isnull( d.NOOBLIGAAP, t.NOOBLIGAAP ),t.MOSTRAR = isnull( d.MOSTRAR, t.MOSTRAR )
					from ZooLogic.SALTODECAMPO t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Entidad = d.Entidad
							 and  t.Atributo = d.Atributo
				-- Fin Updates
				insert into ZooLogic.SALTODECAMPO(Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Tipagrupub,Zadsfw,Vmodifw,Ualtafw,Umodifw,Haltafw,Horaimpo,Hmodifw,Saltafw,Smodifw,Horaexpo,Valtafw,Bdmodifw,Esttrans,Detalle,Atrdesc,Entdesc,Bdaltafw,Codigo,Obs,Usaetiq,Usavalsis,Entidad,Usavsant,Persetiq,Atributo,Vsugerido,Salta,Obliga,Ocultar,Noobligaap,Mostrar)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.TIPAGRUPUB,0),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.DETALLE,''),isnull( d.ATRDESC,''),isnull( d.ENTDESC,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.USAETIQ,0),isnull( d.USAVALSIS,0),isnull( d.ENTIDAD,''),isnull( d.USAVSANT,0),isnull( d.PERSETIQ,''),isnull( d.ATRIBUTO,''),isnull( d.VSUGERIDO,''),isnull( d.SALTA,0),isnull( d.OBLIGA,0),isnull( d.OCULTAR,0),isnull( d.NOOBLIGAAP,0),isnull( d.MOSTRAR,0)
						From deleted d left join ZooLogic.SALTODECAMPO pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.SALTODECAMPO cc 
							 on  d.Entidad = cc.Entidad
							 and  d.Atributo = cc.Atributo
						Where pk.Codigo Is Null 
							 and cc.Entidad Is Null 
							 and cc.Atributo Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ENTIDAD ' + cast( d.Entidad as Varchar(40) ) + ', ATRIBUTO ' + cast( d.Atributo as Varchar(40) ) + '','La clave principal no es la esperada'
					from ZooLogic.SALTODECAMPO t inner join deleted d 
							on   t.Entidad = d.Entidad
							 and  t.Atributo = d.Atributo
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ENTIDAD ' + cast( d.Entidad as Varchar(40) ) + ', ATRIBUTO ' + cast( d.Atributo as Varchar(40) ) + '','La clave principal a importar ya existe'
					from ZooLogic.SALTODECAMPO t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.Entidad = h.Entidad
							 and   t.Atributo = h.Atributo
							where   h.Entidad is null 
							 and   h.Atributo is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubSDC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_SALTODECAMPO_AgruPubSDC
ON ZooLogic.TablaTrabajo_SALTODECAMPO_AgruPubSDC
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubSDC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubSDC
( 
"NROITEM",
"CODIGO",
"AGRUP",
"AGRUPDES"
 )
Select 
d.NROITEM,
d.CODIGO,
d.AGRUP,
d.AGRUPDES
From deleted d left join ZooLogic.AgruPubSDC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SaltoDeCampo') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SaltoDeCampo
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SALTODECAMPO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SALTODECAMPO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SALTODECAMPO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SALTODECAMPO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SALTODECAMPO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SALTODECAMPO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Tipoagrupamientopublicaciones = nvl( c_SALTODECAMPO.Tipoagrupamientopublicaciones, 0 )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_SALTODECAMPO.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_SALTODECAMPO.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_SALTODECAMPO.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_SALTODECAMPO.Horaaltafw, [] )
					.Horaimpo = nvl( c_SALTODECAMPO.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_SALTODECAMPO.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_SALTODECAMPO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_SALTODECAMPO.Seriemodificacionfw, [] )
					.Horaexpo = nvl( c_SALTODECAMPO.Horaexpo, [] )
					.Versionaltafw = nvl( c_SALTODECAMPO.Versionaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_SALTODECAMPO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_SALTODECAMPO.Estadotransferencia, [] )
					.Detalle = nvl( c_SALTODECAMPO.Detalle, [] )
					.Atributodescripcion = nvl( c_SALTODECAMPO.Atributodescripcion, [] )
					.Entidaddescripcion = nvl( c_SALTODECAMPO.Entidaddescripcion, [] )
					.Basededatosaltafw = nvl( c_SALTODECAMPO.Basededatosaltafw, [] )
					.Codigo = nvl( c_SALTODECAMPO.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Usaetiquetadeframework = nvl( c_SALTODECAMPO.Usaetiquetadeframework, .F. )
					.Usavalorsugeridodeframework = nvl( c_SALTODECAMPO.Usavalorsugeridodeframework, .F. )
					.Entidad = nvl( c_SALTODECAMPO.Entidad, [] )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Usavalorsugeridoelementoanterior = nvl( c_SALTODECAMPO.Usavalorsugeridoelementoanterior, .F. )
					.Personalizacionetiqueta = nvl( c_SALTODECAMPO.Personalizacionetiqueta, [] )
					.Atributo = nvl( c_SALTODECAMPO.Atributo, [] )
					.Valorsugerido = nvl( c_SALTODECAMPO.Valorsugerido, [] )
					.Salta = nvl( c_SALTODECAMPO.Salta, .F. )
					.Obligatorio = nvl( c_SALTODECAMPO.Obligatorio, .F. )
					.Ocultar = nvl( c_SALTODECAMPO.Ocultar, .F. )
					.Noobligatorioarticulospack = nvl( c_SALTODECAMPO.Noobligatorioarticulospack, .F. )
					.Mostrar = nvl( c_SALTODECAMPO.Mostrar, .F. )
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
			lxRetorno = c_SALTODECAMPO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.AgruPubliDetalle
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
		return c_SALTODECAMPO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.SALTODECAMPO' )
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
								from ZooLogic.SALTODECAMPO 
								Where   SALTODECAMPO.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SALTODECAMPO", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Detalle" as "Detalle", "Atrdesc" as "Atributodescripcion", "Entdesc" as "Entidaddescripcion", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Usaetiq" as "Usaetiquetadeframework", "Usavalsis" as "Usavalorsugeridodeframework", "Entidad" as "Entidad", "Usavsant" as "Usavalorsugeridoelementoanterior", "Persetiq" as "Personalizacionetiqueta", "Atributo" as "Atributo", "Vsugerido" as "Valorsugerido", "Salta" as "Salta", "Obliga" as "Obligatorio", "Ocultar" as "Ocultar", "Noobligaap" as "Noobligatorioarticulospack", "Mostrar" as "Mostrar"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.SALTODECAMPO 
								Where   SALTODECAMPO.CODIGO != ''
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
	Tabla = 'SALTODECAMPO'
	Filtro = " SALTODECAMPO.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SALTODECAMPO.CODIGO != ''"
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
	<row entidad="SALTODECAMPO                            " atributo="FECHAEXPO                               " tabla="SALTODECAMPO   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="FECHAALTAFW                             " tabla="SALTODECAMPO   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="FECHAIMPO                               " tabla="SALTODECAMPO   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="FECHATRANSFERENCIA                      " tabla="SALTODECAMPO   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="FECHAMODIFICACIONFW                     " tabla="SALTODECAMPO   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="SALTODECAMPO   " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="ZADSFW                                  " tabla="SALTODECAMPO   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="VERSIONMODIFICACIONFW                   " tabla="SALTODECAMPO   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="USUARIOALTAFW                           " tabla="SALTODECAMPO   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="USUARIOMODIFICACIONFW                   " tabla="SALTODECAMPO   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="HORAALTAFW                              " tabla="SALTODECAMPO   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="HORAIMPO                                " tabla="SALTODECAMPO   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="HORAMODIFICACIONFW                      " tabla="SALTODECAMPO   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="SERIEALTAFW                             " tabla="SALTODECAMPO   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="SERIEMODIFICACIONFW                     " tabla="SALTODECAMPO   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="HORAEXPO                                " tabla="SALTODECAMPO   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="VERSIONALTAFW                           " tabla="SALTODECAMPO   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SALTODECAMPO   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="ESTADOTRANSFERENCIA                     " tabla="SALTODECAMPO   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="DETALLE                                 " tabla="SALTODECAMPO   " campo="DETALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="ATRIBUTODESCRIPCION                     " tabla="SALTODECAMPO   " campo="ATRDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="160" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="ENTIDADDESCRIPCION                      " tabla="SALTODECAMPO   " campo="ENTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="BASEDEDATOSALTAFW                       " tabla="SALTODECAMPO   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="CODIGO                                  " tabla="SALTODECAMPO   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="OBS                                     " tabla="SALTODECAMPO   " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="USAETIQUETADEFRAMEWORK                  " tabla="SALTODECAMPO   " campo="USAETIQ   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="201" etiqueta="Sistema                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="USAVALORSUGERIDODEFRAMEWORK             " tabla="SALTODECAMPO   " campo="USAVALSIS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="202" etiqueta="Sistema                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="ENTIDAD                                 " tabla="SALTODECAMPO   " campo="ENTIDAD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Entidad                                                                                                                                                         " dominio="COMBOENTIDADESCONSALTODECAMPO " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBSDC     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICSDC    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="USAVALORSUGERIDOELEMENTOANTERIOR        " tabla="SALTODECAMPO   " campo="USAVSANT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Elemento anterior                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="PERSONALIZACIONETIQUETA                 " tabla="SALTODECAMPO   " campo="PERSETIQ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="160" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Personalizado                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="ATRIBUTO                                " tabla="SALTODECAMPO   " campo="ATRIBUTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="3" etiqueta="Atributo                                                                                                                                                        " dominio="COMBOATRIBUTOSCONSALTODECAMPO " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="ATRIBUTOVIRTUAL                         " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="240" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="205" etiqueta="Atributo                                                                                                                                                        " dominio="COMBOATRIBUTOSCONSALTODECAMPO " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="VALORSUGERIDO                           " tabla="SALTODECAMPO   " campo="VSUGERIDO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Personalizado                                                                                                                                                   " dominio="EXPRESIONSIMPLE               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="SALTA                                   " tabla="SALTODECAMPO   " campo="SALTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="Saltar                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="OBLIGATORIO                             " tabla="SALTODECAMPO   " campo="OBLIGA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Obligatorio                                                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="OCULTAR                                 " tabla="SALTODECAMPO   " campo="OCULTAR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="Visible                                                                                                                                                         " dominio="SINOINVERTIDO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="NOOBLIGATORIOARTICULOSPACK              " tabla="SALTODECAMPO   " campo="NOOBLIGAAP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Omitir para artículos tipo pack                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SALTODECAMPO                            " atributo="MOSTRAR                                 " tabla="SALTODECAMPO   " campo="MOSTRAR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="6" etiqueta="Visible                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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