
define class Din_EntidadLIQUIDACIONDIARIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_LIQUIDACIONDIARIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_LDTPK'
	cTablaPrincipal = 'LIQDIARIA'
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
			local  lxLiqdiariaFecexpo, lxLiqdiariaFectrans, lxLiqdiariaFmodifw, lxLiqdiariaFaltafw, lxLiqdiariaFecimpo, lxLiqdiariaSaltafw, lxLiqdiariaHmodifw, lxLiqdiariaSmodifw, lxLiqdiariaUmodifw, lxLiqdiariaUaltafw, lxLiqdiariaZadsfw, lxLiqdiariaValtafw, lxLiqdiariaVmodifw, lxLiqdiariaHoraimpo, lxLiqdiariaHaltafw, lxLiqdiariaHoraexpo, lxLiqdiariaBdmodifw, lxLiqdiariaBdaltafw, lxLiqdiariaEsttrans, lxLiqdiariaFecha, lxLiqdiariaTotalliq, lxLiqdiariaDescuentos, lxLiqdiariaCodigo, lxLiqdiariaOperadora, lxLiqdiariaMonto, lxLiqdiariaObs
				lxLiqdiariaFecexpo =  .Fechaexpo			lxLiqdiariaFectrans =  .Fechatransferencia			lxLiqdiariaFmodifw =  .Fechamodificacionfw			lxLiqdiariaFaltafw =  .Fechaaltafw			lxLiqdiariaFecimpo =  .Fechaimpo			lxLiqdiariaSaltafw =  .Seriealtafw			lxLiqdiariaHmodifw =  .Horamodificacionfw			lxLiqdiariaSmodifw =  .Seriemodificacionfw			lxLiqdiariaUmodifw =  .Usuariomodificacionfw			lxLiqdiariaUaltafw =  .Usuarioaltafw			lxLiqdiariaZadsfw =  .Zadsfw			lxLiqdiariaValtafw =  .Versionaltafw			lxLiqdiariaVmodifw =  .Versionmodificacionfw			lxLiqdiariaHoraimpo =  .Horaimpo			lxLiqdiariaHaltafw =  .Horaaltafw			lxLiqdiariaHoraexpo =  .Horaexpo			lxLiqdiariaBdmodifw =  .Basededatosmodificacionfw			lxLiqdiariaBdaltafw =  .Basededatosaltafw			lxLiqdiariaEsttrans =  .Estadotransferencia			lxLiqdiariaFecha =  .Fecha			lxLiqdiariaTotalliq =  .Total			lxLiqdiariaDescuentos =  .Descuentos			lxLiqdiariaCodigo =  .Codigo			lxLiqdiariaOperadora =  upper( .Operadora_PK ) 			lxLiqdiariaMonto =  .Monto			lxLiqdiariaObs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxLiqdiariaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.LIQDIARIA ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Esttrans","Fecha","Totalliq","Descuentos","Codigo","Operadora","Monto","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxLiqdiariaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaEsttrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFecha ) + "'" >>, <<lxLiqdiariaTotalliq >>, <<lxLiqdiariaDescuentos >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaOperadora ) + "'" >>, <<lxLiqdiariaMonto >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptos
				if this.oEntidad.Conceptos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxMonto = loItem.Monto
					lxSuma = loItem.Suma
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqdiariaDet("NROITEM","codigo","Concepto","ConDescri","monto","Suma" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxMonto>>, <<iif( lxSuma, 1, 0 )>> ) 
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
			local  lxLiqdiariaFecexpo, lxLiqdiariaFectrans, lxLiqdiariaFmodifw, lxLiqdiariaFaltafw, lxLiqdiariaFecimpo, lxLiqdiariaSaltafw, lxLiqdiariaHmodifw, lxLiqdiariaSmodifw, lxLiqdiariaUmodifw, lxLiqdiariaUaltafw, lxLiqdiariaZadsfw, lxLiqdiariaValtafw, lxLiqdiariaVmodifw, lxLiqdiariaHoraimpo, lxLiqdiariaHaltafw, lxLiqdiariaHoraexpo, lxLiqdiariaBdmodifw, lxLiqdiariaBdaltafw, lxLiqdiariaEsttrans, lxLiqdiariaFecha, lxLiqdiariaTotalliq, lxLiqdiariaDescuentos, lxLiqdiariaCodigo, lxLiqdiariaOperadora, lxLiqdiariaMonto, lxLiqdiariaObs
				lxLiqdiariaFecexpo =  .Fechaexpo			lxLiqdiariaFectrans =  .Fechatransferencia			lxLiqdiariaFmodifw =  .Fechamodificacionfw			lxLiqdiariaFaltafw =  .Fechaaltafw			lxLiqdiariaFecimpo =  .Fechaimpo			lxLiqdiariaSaltafw =  .Seriealtafw			lxLiqdiariaHmodifw =  .Horamodificacionfw			lxLiqdiariaSmodifw =  .Seriemodificacionfw			lxLiqdiariaUmodifw =  .Usuariomodificacionfw			lxLiqdiariaUaltafw =  .Usuarioaltafw			lxLiqdiariaZadsfw =  .Zadsfw			lxLiqdiariaValtafw =  .Versionaltafw			lxLiqdiariaVmodifw =  .Versionmodificacionfw			lxLiqdiariaHoraimpo =  .Horaimpo			lxLiqdiariaHaltafw =  .Horaaltafw			lxLiqdiariaHoraexpo =  .Horaexpo			lxLiqdiariaBdmodifw =  .Basededatosmodificacionfw			lxLiqdiariaBdaltafw =  .Basededatosaltafw			lxLiqdiariaEsttrans =  .Estadotransferencia			lxLiqdiariaFecha =  .Fecha			lxLiqdiariaTotalliq =  .Total			lxLiqdiariaDescuentos =  .Descuentos			lxLiqdiariaCodigo =  .Codigo			lxLiqdiariaOperadora =  upper( .Operadora_PK ) 			lxLiqdiariaMonto =  .Monto			lxLiqdiariaObs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.LIQDIARIA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFecimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxLiqdiariaEsttrans ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFecha ) + "'">>,"Totalliq" = <<lxLiqdiariaTotalliq>>,"Descuentos" = <<lxLiqdiariaDescuentos>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaCodigo ) + "'">>,"Operadora" = <<"'" + this.FormatearTextoSql( lxLiqdiariaOperadora ) + "'">>,"Monto" = <<lxLiqdiariaMonto>>,"Obs" = <<"'" + this.FormatearTextoSql( lxLiqdiariaObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaCodigo ) + "'">> and  LIQDIARIA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.liqdiariaDet where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptos
				if this.oEntidad.Conceptos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxMonto = loItem.Monto
					lxSuma = loItem.Suma
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqdiariaDet("NROITEM","codigo","Concepto","ConDescri","monto","Suma" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxMonto>>, <<iif( lxSuma, 1, 0 )>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ZooLogic.LIQDIARIA where " + this.ConvertirFuncionesSql( " LIQDIARIA.CODIGO != ''" ) )
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
			Local lxLiqdiariaCodigo
			lxLiqdiariaCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fecha" as "Fecha", "Totalliq" as "Total", "Descuentos" as "Descuentos", "Codigo" as "Codigo", "Operadora" as "Operadora", "Monto" as "Monto", "Obs" as "Obs" from ZooLogic.LIQDIARIA where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaCodigo ) + "'">> and  LIQDIARIA.CODIGO != ''
			endtext
			use in select('c_LIQUIDACIONDIARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDIARIA', set( 'Datasession' ) )

			if reccount( 'c_LIQUIDACIONDIARIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Condescri" as "Conceptodetalle", "Monto" as "Monto", "Suma" as "Suma" from ZooLogic.liqdiariaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDIARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxLiqdiariaCodigo as Variant
		llRetorno = .t.
		lxLiqdiariaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.LIQDIARIA where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaCodigo ) + "'">> and  LIQDIARIA.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fecha" as "Fecha", "Totalliq" as "Total", "Descuentos" as "Descuentos", "Codigo" as "Codigo", "Operadora" as "Operadora", "Monto" as "Monto", "Obs" as "Obs" from ZooLogic.LIQDIARIA where  LIQDIARIA.CODIGO != '' order by codigo
			endtext
			use in select('c_LIQUIDACIONDIARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDIARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Condescri" as "Conceptodetalle", "Monto" as "Monto", "Suma" as "Suma" from ZooLogic.liqdiariaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDIARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptos
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fecha" as "Fecha", "Totalliq" as "Total", "Descuentos" as "Descuentos", "Codigo" as "Codigo", "Operadora" as "Operadora", "Monto" as "Monto", "Obs" as "Obs" from ZooLogic.LIQDIARIA where  funciones.padr( codigo, 24, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LIQDIARIA.CODIGO != '' order by codigo
			endtext
			use in select('c_LIQUIDACIONDIARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDIARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Condescri" as "Conceptodetalle", "Monto" as "Monto", "Suma" as "Suma" from ZooLogic.liqdiariaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDIARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptos
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fecha" as "Fecha", "Totalliq" as "Total", "Descuentos" as "Descuentos", "Codigo" as "Codigo", "Operadora" as "Operadora", "Monto" as "Monto", "Obs" as "Obs" from ZooLogic.LIQDIARIA where  funciones.padr( codigo, 24, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LIQDIARIA.CODIGO != '' order by codigo desc
			endtext
			use in select('c_LIQUIDACIONDIARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDIARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Condescri" as "Conceptodetalle", "Monto" as "Monto", "Suma" as "Suma" from ZooLogic.liqdiariaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDIARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptos
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fecha" as "Fecha", "Totalliq" as "Total", "Descuentos" as "Descuentos", "Codigo" as "Codigo", "Operadora" as "Operadora", "Monto" as "Monto", "Obs" as "Obs" from ZooLogic.LIQDIARIA where  LIQDIARIA.CODIGO != '' order by codigo desc
			endtext
			use in select('c_LIQUIDACIONDIARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDIARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Condescri" as "Conceptodetalle", "Monto" as "Monto", "Suma" as "Suma" from ZooLogic.liqdiariaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDIARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptos
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valt" + ;
"afw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Esttrans,Fecha,Totalliq,Descuentos,Codigo,Op" + ;
"eradora,Monto,Obs" + ;
" from ZooLogic.LIQDIARIA where  LIQDIARIA.CODIGO != '' and " + lcFiltro )
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
			local  lxLiqdiariaFecexpo, lxLiqdiariaFectrans, lxLiqdiariaFmodifw, lxLiqdiariaFaltafw, lxLiqdiariaFecimpo, lxLiqdiariaSaltafw, lxLiqdiariaHmodifw, lxLiqdiariaSmodifw, lxLiqdiariaUmodifw, lxLiqdiariaUaltafw, lxLiqdiariaZadsfw, lxLiqdiariaValtafw, lxLiqdiariaVmodifw, lxLiqdiariaHoraimpo, lxLiqdiariaHaltafw, lxLiqdiariaHoraexpo, lxLiqdiariaBdmodifw, lxLiqdiariaBdaltafw, lxLiqdiariaEsttrans, lxLiqdiariaFecha, lxLiqdiariaTotalliq, lxLiqdiariaDescuentos, lxLiqdiariaCodigo, lxLiqdiariaOperadora, lxLiqdiariaMonto, lxLiqdiariaObs
				lxLiqdiariaFecexpo = ctod( '  /  /    ' )			lxLiqdiariaFectrans = ctod( '  /  /    ' )			lxLiqdiariaFmodifw = ctod( '  /  /    ' )			lxLiqdiariaFaltafw = ctod( '  /  /    ' )			lxLiqdiariaFecimpo = ctod( '  /  /    ' )			lxLiqdiariaSaltafw = []			lxLiqdiariaHmodifw = []			lxLiqdiariaSmodifw = []			lxLiqdiariaUmodifw = []			lxLiqdiariaUaltafw = []			lxLiqdiariaZadsfw = []			lxLiqdiariaValtafw = []			lxLiqdiariaVmodifw = []			lxLiqdiariaHoraimpo = []			lxLiqdiariaHaltafw = []			lxLiqdiariaHoraexpo = []			lxLiqdiariaBdmodifw = []			lxLiqdiariaBdaltafw = []			lxLiqdiariaEsttrans = []			lxLiqdiariaFecha = ctod( '  /  /    ' )			lxLiqdiariaTotalliq = 0			lxLiqdiariaDescuentos = 0			lxLiqdiariaCodigo = []			lxLiqdiariaOperadora = []			lxLiqdiariaMonto = 0			lxLiqdiariaObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.liqdiariaDet where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.LIQDIARIA where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'LIQDIARIA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQDIARIA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fecha" as "Fecha", "Totalliq" as "Total", "Descuentos" as "Descuentos", "Codigo" as "Codigo", "Operadora" as "Operadora", "Monto" as "Monto", "Obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LIQDIARIA', '', tnTope )
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
	Function ObtenerDatosDetalleConceptos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQDIARIADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Condescri" as "Conceptodetalle", "Monto" as "Monto", "Suma" as "Suma"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleConceptos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'liqdiariaDet', 'Conceptos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleConceptos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleConceptos( lcAtributo )
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
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALLIQ AS TOTAL'
				Case lcAtributo == 'DESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCUENTOS AS DESCUENTOS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleConceptos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'CONCEPTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDESCRI AS CONCEPTODETALLE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'SUMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUMA AS SUMA'
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
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'TOTALLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOS'
				lcCampo = 'DESCUENTOS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleConceptos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTODETALLE'
				lcCampo = 'CONDESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'SUMA'
				lcCampo = 'SUMA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'CONCEPTOS'
			lcRetorno = 'LIQDIARIADET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxLiqdiariaFecexpo, lxLiqdiariaFectrans, lxLiqdiariaFmodifw, lxLiqdiariaFaltafw, lxLiqdiariaFecimpo, lxLiqdiariaSaltafw, lxLiqdiariaHmodifw, lxLiqdiariaSmodifw, lxLiqdiariaUmodifw, lxLiqdiariaUaltafw, lxLiqdiariaZadsfw, lxLiqdiariaValtafw, lxLiqdiariaVmodifw, lxLiqdiariaHoraimpo, lxLiqdiariaHaltafw, lxLiqdiariaHoraexpo, lxLiqdiariaBdmodifw, lxLiqdiariaBdaltafw, lxLiqdiariaEsttrans, lxLiqdiariaFecha, lxLiqdiariaTotalliq, lxLiqdiariaDescuentos, lxLiqdiariaCodigo, lxLiqdiariaOperadora, lxLiqdiariaMonto, lxLiqdiariaObs
				lxLiqdiariaFecexpo =  .Fechaexpo			lxLiqdiariaFectrans =  .Fechatransferencia			lxLiqdiariaFmodifw =  .Fechamodificacionfw			lxLiqdiariaFaltafw =  .Fechaaltafw			lxLiqdiariaFecimpo =  .Fechaimpo			lxLiqdiariaSaltafw =  .Seriealtafw			lxLiqdiariaHmodifw =  .Horamodificacionfw			lxLiqdiariaSmodifw =  .Seriemodificacionfw			lxLiqdiariaUmodifw =  .Usuariomodificacionfw			lxLiqdiariaUaltafw =  .Usuarioaltafw			lxLiqdiariaZadsfw =  .Zadsfw			lxLiqdiariaValtafw =  .Versionaltafw			lxLiqdiariaVmodifw =  .Versionmodificacionfw			lxLiqdiariaHoraimpo =  .Horaimpo			lxLiqdiariaHaltafw =  .Horaaltafw			lxLiqdiariaHoraexpo =  .Horaexpo			lxLiqdiariaBdmodifw =  .Basededatosmodificacionfw			lxLiqdiariaBdaltafw =  .Basededatosaltafw			lxLiqdiariaEsttrans =  .Estadotransferencia			lxLiqdiariaFecha =  .Fecha			lxLiqdiariaTotalliq =  .Total			lxLiqdiariaDescuentos =  .Descuentos			lxLiqdiariaCodigo =  .Codigo			lxLiqdiariaOperadora =  upper( .Operadora_PK ) 			lxLiqdiariaMonto =  .Monto			lxLiqdiariaObs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.LIQDIARIA ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Esttrans","Fecha","Totalliq","Descuentos","Codigo","Operadora","Monto","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxLiqdiariaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaEsttrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqdiariaFecha ) + "'" >>, <<lxLiqdiariaTotalliq >>, <<lxLiqdiariaDescuentos >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaOperadora ) + "'" >>, <<lxLiqdiariaMonto >>, <<"'" + this.FormatearTextoSql( lxLiqdiariaObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'LIQDIARIA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptos
				if this.oEntidad.Conceptos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxMonto = loItem.Monto
					lxSuma = loItem.Suma
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqdiariaDet("NROITEM","codigo","Concepto","ConDescri","monto","Suma" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxMonto>>, <<iif( lxSuma, 1, 0 )>> ) 
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
			local  lxLiqdiariaFecexpo, lxLiqdiariaFectrans, lxLiqdiariaFmodifw, lxLiqdiariaFaltafw, lxLiqdiariaFecimpo, lxLiqdiariaSaltafw, lxLiqdiariaHmodifw, lxLiqdiariaSmodifw, lxLiqdiariaUmodifw, lxLiqdiariaUaltafw, lxLiqdiariaZadsfw, lxLiqdiariaValtafw, lxLiqdiariaVmodifw, lxLiqdiariaHoraimpo, lxLiqdiariaHaltafw, lxLiqdiariaHoraexpo, lxLiqdiariaBdmodifw, lxLiqdiariaBdaltafw, lxLiqdiariaEsttrans, lxLiqdiariaFecha, lxLiqdiariaTotalliq, lxLiqdiariaDescuentos, lxLiqdiariaCodigo, lxLiqdiariaOperadora, lxLiqdiariaMonto, lxLiqdiariaObs
				lxLiqdiariaFecexpo =  .Fechaexpo			lxLiqdiariaFectrans =  .Fechatransferencia			lxLiqdiariaFmodifw =  .Fechamodificacionfw			lxLiqdiariaFaltafw =  .Fechaaltafw			lxLiqdiariaFecimpo =  .Fechaimpo			lxLiqdiariaSaltafw =  .Seriealtafw			lxLiqdiariaHmodifw =  .Horamodificacionfw			lxLiqdiariaSmodifw =  .Seriemodificacionfw			lxLiqdiariaUmodifw =  .Usuariomodificacionfw			lxLiqdiariaUaltafw =  .Usuarioaltafw			lxLiqdiariaZadsfw =  .Zadsfw			lxLiqdiariaValtafw =  .Versionaltafw			lxLiqdiariaVmodifw =  .Versionmodificacionfw			lxLiqdiariaHoraimpo =  .Horaimpo			lxLiqdiariaHaltafw =  .Horaaltafw			lxLiqdiariaHoraexpo =  .Horaexpo			lxLiqdiariaBdmodifw =  .Basededatosmodificacionfw			lxLiqdiariaBdaltafw =  .Basededatosaltafw			lxLiqdiariaEsttrans =  .Estadotransferencia			lxLiqdiariaFecha =  .Fecha			lxLiqdiariaTotalliq =  .Total			lxLiqdiariaDescuentos =  .Descuentos			lxLiqdiariaCodigo =  .Codigo			lxLiqdiariaOperadora =  upper( .Operadora_PK ) 			lxLiqdiariaMonto =  .Monto			lxLiqdiariaObs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  LIQDIARIA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.LIQDIARIA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFecimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLiqdiariaBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxLiqdiariaEsttrans ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxLiqdiariaFecha ) + "'">>, "Totalliq" = <<lxLiqdiariaTotalliq>>, "Descuentos" = <<lxLiqdiariaDescuentos>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqdiariaCodigo ) + "'">>, "Operadora" = <<"'" + this.FormatearTextoSql( lxLiqdiariaOperadora ) + "'">>, "Monto" = <<lxLiqdiariaMonto>>, "Obs" = <<"'" + this.FormatearTextoSql( lxLiqdiariaObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'LIQDIARIA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.liqdiariaDet where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptos
				if this.oEntidad.Conceptos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxMonto = loItem.Monto
					lxSuma = loItem.Suma
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqdiariaDet("NROITEM","codigo","Concepto","ConDescri","monto","Suma" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxMonto>>, <<iif( lxSuma, 1, 0 )>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  LIQDIARIA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.LIQDIARIA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.liqdiariaDet where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'LIQDIARIA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.LIQDIARIA where  LIQDIARIA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.LIQDIARIA where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  LIQDIARIA.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDIARIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.LIQDIARIA Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.LIQDIARIA set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..fecha ) + "'"+ [, Totalliq = ] + transform( &lcCursor..Totalliq )+ [, Descuentos = ] + transform( &lcCursor..Descuentos )+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, operadora = ] + "'" + this.FormatearTextoSql( &lcCursor..operadora ) + "'"+ [, monto = ] + transform( &lcCursor..monto )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, SALTAFW, HMODIFW, SMODIFW, UMODIFW, UALTAFW, ZADSFW, VALTAFW, VMODIFW, HORAIMPO, HALTAFW, HORAEXPO, BDMODIFW, BDALTAFW, ESTTRANS, fecha, Totalliq, Descuentos, codigo, operadora, monto, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..fecha ) + "'" + ',' + transform( &lcCursor..Totalliq )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Descuentos ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..operadora ) + "'" + ',' + transform( &lcCursor..monto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.LIQDIARIA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDIARIA'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.liqdiariaDet Where codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCONCEPTOLIQ'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","codigo","Concepto","ConDescri","monto","Suma"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.liqdiariaDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Concepto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ConDescri  ) + "'" + ',' + transform( cDetallesExistentes.monto      ) + ',' + Transform( iif( cDetallesExistentes.Suma      , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (24) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONDIARIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONDIARIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONDIARIA_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCONCEPTOLIQ'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_liqdiaria')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'LIQUIDACIONDIARIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad LIQUIDACIONDIARIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDIARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDIARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_liqdiaria') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_liqdiaria
Create Table ZooLogic.TablaTrabajo_liqdiaria ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"fecha" datetime  null, 
"totalliq" numeric( 15, 2 )  null, 
"descuentos" numeric( 15, 2 )  null, 
"codigo" char( 24 )  null, 
"operadora" char( 15 )  null, 
"monto" numeric( 15, 2 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_liqdiaria' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_liqdiaria' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDIARIA'
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
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('totalliq','totalliq')
			.AgregarMapeo('descuentos','descuentos')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('operadora','operadora')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_liqdiaria'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.TOTALLIQ = isnull( d.TOTALLIQ, t.TOTALLIQ ),t.DESCUENTOS = isnull( d.DESCUENTOS, t.DESCUENTOS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.LIQDIARIA t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ZooLogic.LIQDIARIA(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Esttrans,Fecha,Totalliq,Descuentos,Codigo,Operadora,Monto,Obs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.FECHA,''),isnull( d.TOTALLIQ,0),isnull( d.DESCUENTOS,0),isnull( d.CODIGO,''),isnull( d.OPERADORA,''),isnull( d.MONTO,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.LIQDIARIA pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_liqdiariaDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQDIARIA_liqdiariaDet
ON ZooLogic.TablaTrabajo_LIQDIARIA_liqdiariaDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),
t.CONDESCRI = isnull( d.CONDESCRI, t.CONDESCRI ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.SUMA = isnull( d.SUMA, t.SUMA )
from ZooLogic.liqdiariaDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.liqdiariaDet
( 
"NROITEM",
"CODIGO",
"CONCEPTO",
"CONDESCRI",
"MONTO",
"SUMA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CONCEPTO,
d.CONDESCRI,
d.MONTO,
d.SUMA
From deleted d left join ZooLogic.liqdiariaDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_liqdiaria') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_liqdiaria
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_LIQUIDACIONDIARIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDIARIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDIARIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDIARIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDIARIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDIARIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_LIQUIDACIONDIARIA.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_LIQUIDACIONDIARIA.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_LIQUIDACIONDIARIA.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_LIQUIDACIONDIARIA.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_LIQUIDACIONDIARIA.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_LIQUIDACIONDIARIA.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_LIQUIDACIONDIARIA.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_LIQUIDACIONDIARIA.Horaimpo, [] )
					.Horaaltafw = nvl( c_LIQUIDACIONDIARIA.Horaaltafw, [] )
					.Horaexpo = nvl( c_LIQUIDACIONDIARIA.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_LIQUIDACIONDIARIA.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_LIQUIDACIONDIARIA.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_LIQUIDACIONDIARIA.Estadotransferencia, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDIARIA.Fecha, ctod( '  /  /    ' ) ) )
					.Total = nvl( c_LIQUIDACIONDIARIA.Total, 0 )
					.Descuentos = nvl( c_LIQUIDACIONDIARIA.Descuentos, 0 )
					.Codigo = nvl( c_LIQUIDACIONDIARIA.Codigo, [] )
					.Conceptos.Limpiar()
					.Conceptos.SetearEsNavegacion( .lProcesando )
					.Conceptos.Cargar()
					.Operadora_PK =  nvl( c_LIQUIDACIONDIARIA.Operadora, [] )
					.Monto = nvl( c_LIQUIDACIONDIARIA.Monto, 0 )
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
		
		loDetalle = this.oEntidad.Conceptos
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
		return c_LIQUIDACIONDIARIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.LIQDIARIA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    codigo from (
							select * 
								from ZooLogic.LIQDIARIA 
								Where   LIQDIARIA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "LIQDIARIA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fecha" as "Fecha", "Totalliq" as "Total", "Descuentos" as "Descuentos", "Codigo" as "Codigo", "Operadora" as "Operadora", "Monto" as "Monto", "Obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.LIQDIARIA 
								Where   LIQDIARIA.CODIGO != ''
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
	Tabla = 'LIQDIARIA'
	Filtro = " LIQDIARIA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " LIQDIARIA.CODIGO != ''"
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
	<row entidad="LIQUIDACIONDIARIA                       " atributo="FECHAEXPO                               " tabla="LIQDIARIA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="FECHATRANSFERENCIA                      " tabla="LIQDIARIA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="FECHAMODIFICACIONFW                     " tabla="LIQDIARIA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="FECHAALTAFW                             " tabla="LIQDIARIA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="FECHAIMPO                               " tabla="LIQDIARIA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="SERIEALTAFW                             " tabla="LIQDIARIA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="HORAMODIFICACIONFW                      " tabla="LIQDIARIA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="SERIEMODIFICACIONFW                     " tabla="LIQDIARIA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="USUARIOMODIFICACIONFW                   " tabla="LIQDIARIA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="USUARIOALTAFW                           " tabla="LIQDIARIA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="ZADSFW                                  " tabla="LIQDIARIA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="VERSIONALTAFW                           " tabla="LIQDIARIA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="VERSIONMODIFICACIONFW                   " tabla="LIQDIARIA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="HORAIMPO                                " tabla="LIQDIARIA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="HORAALTAFW                              " tabla="LIQDIARIA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="HORAEXPO                                " tabla="LIQDIARIA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="LIQDIARIA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="BASEDEDATOSALTAFW                       " tabla="LIQDIARIA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="ESTADOTRANSFERENCIA                     " tabla="LIQDIARIA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="FECHA                                   " tabla="LIQDIARIA      " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="TOTAL                                   " tabla="LIQDIARIA      " campo="TOTALLIQ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="DESCUENTOS                              " tabla="LIQDIARIA      " campo="DESCUENTOS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="CODIGO                                  " tabla="LIQDIARIA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="24" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="CONCEPTOS                               " tabla="LIQDIARIADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="24" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Conceptos                                                                                                                                                       " dominio="DETALLEITEMCONCEPTOLIQ        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="OPERADORA                               " tabla="LIQDIARIA      " campo="OPERADORA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="OPERADORADETARJETA                      " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="406" etiqueta="Operadora                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="MONTO                                   " tabla="LIQDIARIA      " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de la liquidación                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDIARIA                       " atributo="OBS                                     " tabla="LIQDIARIA      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERADORADETARJETA                      " atributo="DESCRIPCION                             " tabla="OPETAR         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Ope.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPETAR On LIQDIARIA.OPERADORA = OPETAR.Codigo And  OPETAR.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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