
define class Din_EntidadESTADOSDEINTERACCIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ESTADOSDEINTERACCION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_EDIPK'
	cTablaPrincipal = 'ESTINTERAC'
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
			local  lxEstinteracFecexpo, lxEstinteracFmodifw, lxEstinteracFecimpo, lxEstinteracFaltafw, lxEstinteracFectrans, lxEstinteracSmodifw, lxEstinteracHmodifw, lxEstinteracSaltafw, lxEstinteracUaltafw, lxEstinteracUmodifw, lxEstinteracZadsfw, lxEstinteracValtafw, lxEstinteracVmodifw, lxEstinteracHoraexpo, lxEstinteracHoraimpo, lxEstinteracBdmodifw, lxEstinteracHaltafw, lxEstinteracBdaltafw, lxEstinteracEsttrans, lxEstinteracTipagrupub, lxEstinteracBloqreg, lxEstinteracCodigo, lxEstinteracDescri, lxEstinteracTipoorden, lxEstinteracReglaest, lxEstinteracReglafac, lxEstinteracObs
				lxEstinteracFecexpo =  .Fechaexpo			lxEstinteracFmodifw =  .Fechamodificacionfw			lxEstinteracFecimpo =  .Fechaimpo			lxEstinteracFaltafw =  .Fechaaltafw			lxEstinteracFectrans =  .Fechatransferencia			lxEstinteracSmodifw =  .Seriemodificacionfw			lxEstinteracHmodifw =  .Horamodificacionfw			lxEstinteracSaltafw =  .Seriealtafw			lxEstinteracUaltafw =  .Usuarioaltafw			lxEstinteracUmodifw =  .Usuariomodificacionfw			lxEstinteracZadsfw =  .Zadsfw			lxEstinteracValtafw =  .Versionaltafw			lxEstinteracVmodifw =  .Versionmodificacionfw			lxEstinteracHoraexpo =  .Horaexpo			lxEstinteracHoraimpo =  .Horaimpo			lxEstinteracBdmodifw =  .Basededatosmodificacionfw			lxEstinteracHaltafw =  .Horaaltafw			lxEstinteracBdaltafw =  .Basededatosaltafw			lxEstinteracEsttrans =  .Estadotransferencia			lxEstinteracTipagrupub =  .Tipoagrupamientopublicaciones			lxEstinteracBloqreg =  .Bloquearregistro			lxEstinteracCodigo =  .Codigo			lxEstinteracDescri =  .Descripcion			lxEstinteracTipoorden =  upper( .TipoDeOrden_PK ) 			lxEstinteracReglaest =  .Reglaestado			lxEstinteracReglafac =  .Reglafacturacion			lxEstinteracObs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxEstinteracCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ESTINTERAC ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Horaexpo","Horaimpo","Bdmodifw","Haltafw","Bdaltafw","Esttrans","Tipagrupub","Bloqreg","Codigo","Descri","Tipoorden","Reglaest","Reglafac","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxEstinteracFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEstinteracFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEstinteracFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEstinteracFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEstinteracFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracEsttrans ) + "'" >>, <<lxEstinteracTipagrupub >>, <<iif( lxEstinteracBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEstinteracCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracDescri ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracTipoorden ) + "'" >>, <<lxEstinteracReglaest >>, <<lxEstinteracReglafac >>, <<"'" + this.FormatearTextoSql( lxEstinteracObs ) + "'" >> )
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
						Insert into ZooLogic.AgruPubEDI("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxEstinteracFecexpo, lxEstinteracFmodifw, lxEstinteracFecimpo, lxEstinteracFaltafw, lxEstinteracFectrans, lxEstinteracSmodifw, lxEstinteracHmodifw, lxEstinteracSaltafw, lxEstinteracUaltafw, lxEstinteracUmodifw, lxEstinteracZadsfw, lxEstinteracValtafw, lxEstinteracVmodifw, lxEstinteracHoraexpo, lxEstinteracHoraimpo, lxEstinteracBdmodifw, lxEstinteracHaltafw, lxEstinteracBdaltafw, lxEstinteracEsttrans, lxEstinteracTipagrupub, lxEstinteracBloqreg, lxEstinteracCodigo, lxEstinteracDescri, lxEstinteracTipoorden, lxEstinteracReglaest, lxEstinteracReglafac, lxEstinteracObs
				lxEstinteracFecexpo =  .Fechaexpo			lxEstinteracFmodifw =  .Fechamodificacionfw			lxEstinteracFecimpo =  .Fechaimpo			lxEstinteracFaltafw =  .Fechaaltafw			lxEstinteracFectrans =  .Fechatransferencia			lxEstinteracSmodifw =  .Seriemodificacionfw			lxEstinteracHmodifw =  .Horamodificacionfw			lxEstinteracSaltafw =  .Seriealtafw			lxEstinteracUaltafw =  .Usuarioaltafw			lxEstinteracUmodifw =  .Usuariomodificacionfw			lxEstinteracZadsfw =  .Zadsfw			lxEstinteracValtafw =  .Versionaltafw			lxEstinteracVmodifw =  .Versionmodificacionfw			lxEstinteracHoraexpo =  .Horaexpo			lxEstinteracHoraimpo =  .Horaimpo			lxEstinteracBdmodifw =  .Basededatosmodificacionfw			lxEstinteracHaltafw =  .Horaaltafw			lxEstinteracBdaltafw =  .Basededatosaltafw			lxEstinteracEsttrans =  .Estadotransferencia			lxEstinteracTipagrupub =  .Tipoagrupamientopublicaciones			lxEstinteracBloqreg =  .Bloquearregistro			lxEstinteracCodigo =  .Codigo			lxEstinteracDescri =  .Descripcion			lxEstinteracTipoorden =  upper( .TipoDeOrden_PK ) 			lxEstinteracReglaest =  .Reglaestado			lxEstinteracReglafac =  .Reglafacturacion			lxEstinteracObs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ESTINTERAC set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxEstinteracFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxEstinteracFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxEstinteracFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxEstinteracFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxEstinteracFectrans ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxEstinteracSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxEstinteracUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxEstinteracZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxEstinteracValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxEstinteracHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxEstinteracHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxEstinteracHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEstinteracBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxEstinteracEsttrans ) + "'">>,"Tipagrupub" = <<lxEstinteracTipagrupub>>,"Bloqreg" = <<iif( lxEstinteracBloqreg, 1, 0 )>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxEstinteracCodigo ) + "'">>,"Descri" = <<"'" + this.FormatearTextoSql( lxEstinteracDescri ) + "'">>,"Tipoorden" = <<"'" + this.FormatearTextoSql( lxEstinteracTipoorden ) + "'">>,"Reglaest" = <<lxEstinteracReglaest>>,"Reglafac" = <<lxEstinteracReglafac>>,"Obs" = <<"'" + this.FormatearTextoSql( lxEstinteracObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxEstinteracCodigo ) + "'">> and  ESTINTERAC.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubEDI where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubEDI("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.ESTINTERAC where " + this.ConvertirFuncionesSql( " ESTINTERAC.CODIGO != ''" ) )
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
			Local lxEstinteracCodigo
			lxEstinteracCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Descri" as "Descripcion", "Tipoorden" as "Tipodeorden", "Reglaest" as "Reglaestado", "Reglafac" as "Reglafacturacion", "Obs" as "Obs" from ZooLogic.ESTINTERAC where "Codigo" = <<"'" + this.FormatearTextoSql( lxEstinteracCodigo ) + "'">> and  ESTINTERAC.CODIGO != ''
			endtext
			use in select('c_ESTADOSDEINTERACCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOSDEINTERACCION', set( 'Datasession' ) )

			if reccount( 'c_ESTADOSDEINTERACCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubEDI where Codigo = <<"'" + this.FormatearTextoSql( c_ESTADOSDEINTERACCION.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxEstinteracCodigo as Variant
		llRetorno = .t.
		lxEstinteracCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ESTINTERAC where "Codigo" = <<"'" + this.FormatearTextoSql( lxEstinteracCodigo ) + "'">> and  ESTINTERAC.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Descri" as "Descripcion", "Tipoorden" as "Tipodeorden", "Reglaest" as "Reglaestado", "Reglafac" as "Reglafacturacion", "Obs" as "Obs" from ZooLogic.ESTINTERAC where  ESTINTERAC.CODIGO != '' order by Codigo
			endtext
			use in select('c_ESTADOSDEINTERACCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOSDEINTERACCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubEDI where Codigo = <<"'" + this.FormatearTextoSql( c_ESTADOSDEINTERACCION.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Descri" as "Descripcion", "Tipoorden" as "Tipodeorden", "Reglaest" as "Reglaestado", "Reglafac" as "Reglafacturacion", "Obs" as "Obs" from ZooLogic.ESTINTERAC where  funciones.padr( Codigo, 30, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ESTINTERAC.CODIGO != '' order by Codigo
			endtext
			use in select('c_ESTADOSDEINTERACCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOSDEINTERACCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubEDI where Codigo = <<"'" + this.FormatearTextoSql( c_ESTADOSDEINTERACCION.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Descri" as "Descripcion", "Tipoorden" as "Tipodeorden", "Reglaest" as "Reglaestado", "Reglafac" as "Reglafacturacion", "Obs" as "Obs" from ZooLogic.ESTINTERAC where  funciones.padr( Codigo, 30, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ESTINTERAC.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_ESTADOSDEINTERACCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOSDEINTERACCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubEDI where Codigo = <<"'" + this.FormatearTextoSql( c_ESTADOSDEINTERACCION.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Descri" as "Descripcion", "Tipoorden" as "Tipodeorden", "Reglaest" as "Reglaestado", "Reglafac" as "Reglafacturacion", "Obs" as "Obs" from ZooLogic.ESTINTERAC where  ESTINTERAC.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_ESTADOSDEINTERACCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOSDEINTERACCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubEDI where Codigo = <<"'" + this.FormatearTextoSql( c_ESTADOSDEINTERACCION.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Zadsfw,Valt" + ;
"afw,Vmodifw,Horaexpo,Horaimpo,Bdmodifw,Haltafw,Bdaltafw,Esttrans,Tipagrupub,Bloqreg,Codigo,Descri,Ti" + ;
"poorden,Reglaest,Reglafac,Obs" + ;
" from ZooLogic.ESTINTERAC where  ESTINTERAC.CODIGO != '' and " + lcFiltro )
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
			local  lxEstinteracFecexpo, lxEstinteracFmodifw, lxEstinteracFecimpo, lxEstinteracFaltafw, lxEstinteracFectrans, lxEstinteracSmodifw, lxEstinteracHmodifw, lxEstinteracSaltafw, lxEstinteracUaltafw, lxEstinteracUmodifw, lxEstinteracZadsfw, lxEstinteracValtafw, lxEstinteracVmodifw, lxEstinteracHoraexpo, lxEstinteracHoraimpo, lxEstinteracBdmodifw, lxEstinteracHaltafw, lxEstinteracBdaltafw, lxEstinteracEsttrans, lxEstinteracTipagrupub, lxEstinteracBloqreg, lxEstinteracCodigo, lxEstinteracDescri, lxEstinteracTipoorden, lxEstinteracReglaest, lxEstinteracReglafac, lxEstinteracObs
				lxEstinteracFecexpo = ctod( '  /  /    ' )			lxEstinteracFmodifw = ctod( '  /  /    ' )			lxEstinteracFecimpo = ctod( '  /  /    ' )			lxEstinteracFaltafw = ctod( '  /  /    ' )			lxEstinteracFectrans = ctod( '  /  /    ' )			lxEstinteracSmodifw = []			lxEstinteracHmodifw = []			lxEstinteracSaltafw = []			lxEstinteracUaltafw = []			lxEstinteracUmodifw = []			lxEstinteracZadsfw = []			lxEstinteracValtafw = []			lxEstinteracVmodifw = []			lxEstinteracHoraexpo = []			lxEstinteracHoraimpo = []			lxEstinteracBdmodifw = []			lxEstinteracHaltafw = []			lxEstinteracBdaltafw = []			lxEstinteracEsttrans = []			lxEstinteracTipagrupub = 0			lxEstinteracBloqreg = .F.			lxEstinteracCodigo = []			lxEstinteracDescri = []			lxEstinteracTipoorden = []			lxEstinteracReglaest = 0			lxEstinteracReglafac = 0			lxEstinteracObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubEDI where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ESTINTERAC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ESTINTERAC' + '_' + tcCampo
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
		lcWhere = " Where  ESTINTERAC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Descri" as "Descripcion", "Tipoorden" as "Tipodeorden", "Reglaest" as "Reglaestado", "Reglafac" as "Reglafacturacion", "Obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ESTINTERAC', '', tnTope )
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
		lcWhere = " Where  AGRUPUBEDI.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubEDI', 'AgruPubliDetalle', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
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
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRIPCION'
				Case lcAtributo == 'TIPODEORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOORDEN AS TIPODEORDEN'
				Case lcAtributo == 'REGLAESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGLAEST AS REGLAESTADO'
				Case lcAtributo == 'REGLAFACTURACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGLAFAC AS REGLAFACTURACION'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
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
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEORDEN'
				lcCampo = 'TIPOORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'REGLAESTADO'
				lcCampo = 'REGLAEST'
			Case upper( alltrim( tcAtributo ) ) == 'REGLAFACTURACION'
				lcCampo = 'REGLAFAC'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
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
			lcRetorno = 'AGRUPUBEDI'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxEstinteracFecexpo, lxEstinteracFmodifw, lxEstinteracFecimpo, lxEstinteracFaltafw, lxEstinteracFectrans, lxEstinteracSmodifw, lxEstinteracHmodifw, lxEstinteracSaltafw, lxEstinteracUaltafw, lxEstinteracUmodifw, lxEstinteracZadsfw, lxEstinteracValtafw, lxEstinteracVmodifw, lxEstinteracHoraexpo, lxEstinteracHoraimpo, lxEstinteracBdmodifw, lxEstinteracHaltafw, lxEstinteracBdaltafw, lxEstinteracEsttrans, lxEstinteracTipagrupub, lxEstinteracBloqreg, lxEstinteracCodigo, lxEstinteracDescri, lxEstinteracTipoorden, lxEstinteracReglaest, lxEstinteracReglafac, lxEstinteracObs
				lxEstinteracFecexpo =  .Fechaexpo			lxEstinteracFmodifw =  .Fechamodificacionfw			lxEstinteracFecimpo =  .Fechaimpo			lxEstinteracFaltafw =  .Fechaaltafw			lxEstinteracFectrans =  .Fechatransferencia			lxEstinteracSmodifw =  .Seriemodificacionfw			lxEstinteracHmodifw =  .Horamodificacionfw			lxEstinteracSaltafw =  .Seriealtafw			lxEstinteracUaltafw =  .Usuarioaltafw			lxEstinteracUmodifw =  .Usuariomodificacionfw			lxEstinteracZadsfw =  .Zadsfw			lxEstinteracValtafw =  .Versionaltafw			lxEstinteracVmodifw =  .Versionmodificacionfw			lxEstinteracHoraexpo =  .Horaexpo			lxEstinteracHoraimpo =  .Horaimpo			lxEstinteracBdmodifw =  .Basededatosmodificacionfw			lxEstinteracHaltafw =  .Horaaltafw			lxEstinteracBdaltafw =  .Basededatosaltafw			lxEstinteracEsttrans =  .Estadotransferencia			lxEstinteracTipagrupub =  .Tipoagrupamientopublicaciones			lxEstinteracBloqreg =  .Bloquearregistro			lxEstinteracCodigo =  .Codigo			lxEstinteracDescri =  .Descripcion			lxEstinteracTipoorden =  upper( .TipoDeOrden_PK ) 			lxEstinteracReglaest =  .Reglaestado			lxEstinteracReglafac =  .Reglafacturacion			lxEstinteracObs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ESTINTERAC ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Horaexpo","Horaimpo","Bdmodifw","Haltafw","Bdaltafw","Esttrans","Tipagrupub","Bloqreg","Codigo","Descri","Tipoorden","Reglaest","Reglafac","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxEstinteracFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEstinteracFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEstinteracFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEstinteracFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEstinteracFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracEsttrans ) + "'" >>, <<lxEstinteracTipagrupub >>, <<iif( lxEstinteracBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEstinteracCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracDescri ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEstinteracTipoorden ) + "'" >>, <<lxEstinteracReglaest >>, <<lxEstinteracReglafac >>, <<"'" + this.FormatearTextoSql( lxEstinteracObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ESTINTERAC' 
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
						Insert into ZooLogic.AgruPubEDI("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxEstinteracFecexpo, lxEstinteracFmodifw, lxEstinteracFecimpo, lxEstinteracFaltafw, lxEstinteracFectrans, lxEstinteracSmodifw, lxEstinteracHmodifw, lxEstinteracSaltafw, lxEstinteracUaltafw, lxEstinteracUmodifw, lxEstinteracZadsfw, lxEstinteracValtafw, lxEstinteracVmodifw, lxEstinteracHoraexpo, lxEstinteracHoraimpo, lxEstinteracBdmodifw, lxEstinteracHaltafw, lxEstinteracBdaltafw, lxEstinteracEsttrans, lxEstinteracTipagrupub, lxEstinteracBloqreg, lxEstinteracCodigo, lxEstinteracDescri, lxEstinteracTipoorden, lxEstinteracReglaest, lxEstinteracReglafac, lxEstinteracObs
				lxEstinteracFecexpo =  .Fechaexpo			lxEstinteracFmodifw =  .Fechamodificacionfw			lxEstinteracFecimpo =  .Fechaimpo			lxEstinteracFaltafw =  .Fechaaltafw			lxEstinteracFectrans =  .Fechatransferencia			lxEstinteracSmodifw =  .Seriemodificacionfw			lxEstinteracHmodifw =  .Horamodificacionfw			lxEstinteracSaltafw =  .Seriealtafw			lxEstinteracUaltafw =  .Usuarioaltafw			lxEstinteracUmodifw =  .Usuariomodificacionfw			lxEstinteracZadsfw =  .Zadsfw			lxEstinteracValtafw =  .Versionaltafw			lxEstinteracVmodifw =  .Versionmodificacionfw			lxEstinteracHoraexpo =  .Horaexpo			lxEstinteracHoraimpo =  .Horaimpo			lxEstinteracBdmodifw =  .Basededatosmodificacionfw			lxEstinteracHaltafw =  .Horaaltafw			lxEstinteracBdaltafw =  .Basededatosaltafw			lxEstinteracEsttrans =  .Estadotransferencia			lxEstinteracTipagrupub =  .Tipoagrupamientopublicaciones			lxEstinteracBloqreg =  .Bloquearregistro			lxEstinteracCodigo =  .Codigo			lxEstinteracDescri =  .Descripcion			lxEstinteracTipoorden =  upper( .TipoDeOrden_PK ) 			lxEstinteracReglaest =  .Reglaestado			lxEstinteracReglafac =  .Reglafacturacion			lxEstinteracObs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ESTINTERAC.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ESTINTERAC set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxEstinteracFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxEstinteracFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxEstinteracFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxEstinteracFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxEstinteracFectrans ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxEstinteracSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxEstinteracUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxEstinteracZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxEstinteracValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxEstinteracHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxEstinteracHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEstinteracBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxEstinteracHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEstinteracBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxEstinteracEsttrans ) + "'">>, "Tipagrupub" = <<lxEstinteracTipagrupub>>, "Bloqreg" = <<iif( lxEstinteracBloqreg, 1, 0 )>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxEstinteracCodigo ) + "'">>, "Descri" = <<"'" + this.FormatearTextoSql( lxEstinteracDescri ) + "'">>, "Tipoorden" = <<"'" + this.FormatearTextoSql( lxEstinteracTipoorden ) + "'">>, "Reglaest" = <<lxEstinteracReglaest>>, "Reglafac" = <<lxEstinteracReglafac>>, "Obs" = <<"'" + this.FormatearTextoSql( lxEstinteracObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ESTINTERAC' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.AgruPubEDI where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubEDI("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ESTINTERAC.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.ESTINTERAC where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPubEDI where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ESTINTERAC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ESTINTERAC where  ESTINTERAC.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ESTINTERAC where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ESTINTERAC.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOSDEINTERACCION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ESTINTERAC Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ESTINTERAC set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descri = ] + "'" + this.FormatearTextoSql( &lcCursor..Descri ) + "'"+ [, TipoOrden = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoOrden ) + "'"+ [, ReglaEst = ] + transform( &lcCursor..ReglaEst )+ [, ReglaFac = ] + transform( &lcCursor..ReglaFac )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FMODIFW, FECIMPO, FALTAFW, FECTRANS, SMODIFW, HMODIFW, SALTAFW, UALTAFW, UMODIFW, ZADSFW, VALTAFW, VMODIFW, HORAEXPO, HORAIMPO, BDMODIFW, HALTAFW, BDALTAFW, ESTTRANS, tipagrupub, BLOQREG, Codigo, Descri, TipoOrden, ReglaEst, ReglaFac, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descri ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoOrden ) + "'" + ',' + transform( &lcCursor..ReglaEst ) + ',' + transform( &lcCursor..ReglaFac ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ESTINTERAC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOSDEINTERACCION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubEDI Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICEDI'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubEDI ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (30) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'ESTADOSDEINTERACCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ESTADOSDEINTERACCION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ESTADOSDEINTERACCION_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICEDI'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_EstInterac')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ESTADOSDEINTERACCION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ESTADOSDEINTERACCION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOSDEINTERACCION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOSDEINTERACCION'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_EstInterac') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_EstInterac
Create Table ZooLogic.TablaTrabajo_EstInterac ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"bloqreg" bit  null, 
"codigo" char( 30 )  null, 
"descri" char( 60 )  null, 
"tipoorden" char( 20 )  null, 
"reglaest" numeric( 1, 0 )  null, 
"reglafac" numeric( 1, 0 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_EstInterac' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_EstInterac' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOSDEINTERACCION'
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
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descri','descri')
			.AgregarMapeo('tipoorden','tipoorden')
			.AgregarMapeo('reglaest','reglaest')
			.AgregarMapeo('reglafac','reglafac')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_EstInterac'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRI = isnull( d.DESCRI, t.DESCRI ),t.TIPOORDEN = isnull( d.TIPOORDEN, t.TIPOORDEN ),t.REGLAEST = isnull( d.REGLAEST, t.REGLAEST ),t.REGLAFAC = isnull( d.REGLAFAC, t.REGLAFAC ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.ESTINTERAC t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.ESTINTERAC(Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Zadsfw,Valtafw,Vmodifw,Horaexpo,Horaimpo,Bdmodifw,Haltafw,Bdaltafw,Esttrans,Tipagrupub,Bloqreg,Codigo,Descri,Tipoorden,Reglaest,Reglafac,Obs)
					Select isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.TIPAGRUPUB,0),isnull( d.BLOQREG,0),isnull( d.CODIGO,''),isnull( d.DESCRI,''),isnull( d.TIPOORDEN,''),isnull( d.REGLAEST,0),isnull( d.REGLAFAC,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.ESTINTERAC pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubEDI( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ESTINTERAC_AgruPubEDI
ON ZooLogic.TablaTrabajo_ESTINTERAC_AgruPubEDI
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubEDI t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubEDI
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
From deleted d left join ZooLogic.AgruPubEDI pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_EstInterac') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_EstInterac
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ESTADOSDEINTERACCION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOSDEINTERACCION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOSDEINTERACCION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOSDEINTERACCION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOSDEINTERACCION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOSDEINTERACCION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Seriemodificacionfw = nvl( c_ESTADOSDEINTERACCION.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_ESTADOSDEINTERACCION.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_ESTADOSDEINTERACCION.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_ESTADOSDEINTERACCION.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ESTADOSDEINTERACCION.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ESTADOSDEINTERACCION.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_ESTADOSDEINTERACCION.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_ESTADOSDEINTERACCION.Horaexpo, [] )
					.Horaimpo = nvl( c_ESTADOSDEINTERACCION.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_ESTADOSDEINTERACCION.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_ESTADOSDEINTERACCION.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_ESTADOSDEINTERACCION.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_ESTADOSDEINTERACCION.Estadotransferencia, [] )
					.Tipoagrupamientopublicaciones = nvl( c_ESTADOSDEINTERACCION.Tipoagrupamientopublicaciones, 0 )
					.Bloquearregistro = nvl( c_ESTADOSDEINTERACCION.Bloquearregistro, .F. )
					.Codigo = nvl( c_ESTADOSDEINTERACCION.Codigo, [] )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Descripcion = nvl( c_ESTADOSDEINTERACCION.Descripcion, [] )
					.Tipodeorden_PK =  nvl( c_ESTADOSDEINTERACCION.Tipodeorden, [] )
					.Reglaestado = nvl( c_ESTADOSDEINTERACCION.Reglaestado, 0 )
					.Reglafacturacion = nvl( c_ESTADOSDEINTERACCION.Reglafacturacion, 0 )
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
		return c_ESTADOSDEINTERACCION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ESTINTERAC' )
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
								from ZooLogic.ESTINTERAC 
								Where   ESTINTERAC.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ESTINTERAC", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Descri" as "Descripcion", "Tipoorden" as "Tipodeorden", "Reglaest" as "Reglaestado", "Reglafac" as "Reglafacturacion", "Obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ESTINTERAC 
								Where   ESTINTERAC.CODIGO != ''
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
	Tabla = 'ESTINTERAC'
	Filtro = " ESTINTERAC.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ESTINTERAC.CODIGO != ''"
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
	<row entidad="ESTADOSDEINTERACCION                    " atributo="FECHAEXPO                               " tabla="ESTINTERAC     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="FECHAMODIFICACIONFW                     " tabla="ESTINTERAC     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="FECHAIMPO                               " tabla="ESTINTERAC     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="FECHAALTAFW                             " tabla="ESTINTERAC     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="FECHATRANSFERENCIA                      " tabla="ESTINTERAC     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="SERIEMODIFICACIONFW                     " tabla="ESTINTERAC     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="HORAMODIFICACIONFW                      " tabla="ESTINTERAC     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="SERIEALTAFW                             " tabla="ESTINTERAC     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="USUARIOALTAFW                           " tabla="ESTINTERAC     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="USUARIOMODIFICACIONFW                   " tabla="ESTINTERAC     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="ZADSFW                                  " tabla="ESTINTERAC     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="VERSIONALTAFW                           " tabla="ESTINTERAC     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="VERSIONMODIFICACIONFW                   " tabla="ESTINTERAC     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="HORAEXPO                                " tabla="ESTINTERAC     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="HORAIMPO                                " tabla="ESTINTERAC     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ESTINTERAC     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="HORAALTAFW                              " tabla="ESTINTERAC     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="BASEDEDATOSALTAFW                       " tabla="ESTINTERAC     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="ESTADOTRANSFERENCIA                     " tabla="ESTINTERAC     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="ESTINTERAC     " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="BLOQUEARREGISTRO                        " tabla="ESTINTERAC     " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="CODIGO                                  " tabla="ESTINTERAC     " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBEDI     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICEDI    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="DESCRIPCION                             " tabla="ESTINTERAC     " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="TIPODEORDEN                             " tabla="ESTINTERAC     " campo="TIPOORDEN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEORDEN                             " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Tipo de orden                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="REGLAESTADO                             " tabla="ESTINTERAC     " campo="REGLAEST  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Regla del estado                                                                                                                                                " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="REGLAFACTURACION                        " tabla="ESTINTERAC     " campo="REGLAFAC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Regla de facturación                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="OBS                                     " tabla="ESTINTERAC     " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEORDEN                             " atributo="DESCRIPCION                             " tabla="TIPOORDEN      " campo="DESCR     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOORDEN On ESTINTERAC.TIPOORDEN = TIPOORDEN.Codigo And  TIPOORDEN.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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