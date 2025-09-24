
define class Din_EntidadAJUSTEDEESTADOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_AJUSTEDEESTADOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AESPK'
	cTablaPrincipal = 'AJUESTADOS'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxAjuestadosFecexpo, lxAjuestadosFectrans, lxAjuestadosFmodifw, lxAjuestadosFaltafw, lxAjuestadosFecimpo, lxAjuestadosSmodifw, lxAjuestadosHmodifw, lxAjuestadosSaltafw, lxAjuestadosUaltafw, lxAjuestadosUmodifw, lxAjuestadosZadsfw, lxAjuestadosDescfw, lxAjuestadosVmodifw, lxAjuestadosHoraimpo, lxAjuestadosValtafw, lxAjuestadosHaltafw, lxAjuestadosHoraexpo, lxAjuestadosBdmodifw, lxAjuestadosBdaltafw, lxAjuestadosEsttrans, lxAjuestadosAjnumero, lxAjuestadosTipocomp, lxAjuestadosAjcodigo, lxAjuestadosAjobs, lxAjuestadosAjfecha
				lxAjuestadosFecexpo =  .Fechaexpo			lxAjuestadosFectrans =  .Fechatransferencia			lxAjuestadosFmodifw =  .Fechamodificacionfw			lxAjuestadosFaltafw =  .Fechaaltafw			lxAjuestadosFecimpo =  .Fechaimpo			lxAjuestadosSmodifw =  .Seriemodificacionfw			lxAjuestadosHmodifw =  .Horamodificacionfw			lxAjuestadosSaltafw =  .Seriealtafw			lxAjuestadosUaltafw =  .Usuarioaltafw			lxAjuestadosUmodifw =  .Usuariomodificacionfw			lxAjuestadosZadsfw =  .Zadsfw			lxAjuestadosDescfw =  .Descripcionfw			lxAjuestadosVmodifw =  .Versionmodificacionfw			lxAjuestadosHoraimpo =  .Horaimpo			lxAjuestadosValtafw =  .Versionaltafw			lxAjuestadosHaltafw =  .Horaaltafw			lxAjuestadosHoraexpo =  .Horaexpo			lxAjuestadosBdmodifw =  .Basededatosmodificacionfw			lxAjuestadosBdaltafw =  .Basededatosaltafw			lxAjuestadosEsttrans =  .Estadotransferencia			lxAjuestadosAjnumero =  .Numero			lxAjuestadosTipocomp =  .Tipo			lxAjuestadosAjcodigo =  .Codigo			lxAjuestadosAjobs =  .Obs			lxAjuestadosAjfecha =  .Fecha
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAjuestadosAjcodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.AJUESTADOS ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Zadsfw","Descfw","Vmodifw","Horaimpo","Valtafw","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Esttrans","Ajnumero","Tipocomp","Ajcodigo","Ajobs","Ajfecha" ) values ( <<"'" + this.ConvertirDateSql( lxAjuestadosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosEsttrans ) + "'" >>, <<lxAjuestadosAjnumero >>, <<lxAjuestadosTipocomp >>, <<"'" + this.FormatearTextoSql( lxAjuestadosAjcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosAjobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosAjfecha ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectado
				if this.oEntidad.StockAfectado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxSituacion = loItem.Situacion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajuestadosDet("COMP","NROITEM","ProcStock","ajdCodigo","Equiv","ajSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSituacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaComb
				if this.oEntidad.StockAfectadoAuditoriaComb.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxSituacion = loItem.Situacion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajEstAudCombDet("COMP","NROITEM","ajdCodigo","AjdSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSituacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobantesModificados
				if this.oEntidad.ComprobantesModificados.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxDetallemodificacion = loItem.Detallemodificacion
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxComprobante = loItem.Comprobante
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajCompDet("ajDetModif","COMP","NROITEM","ProcStock","Equiv","ajComprob","ajCompCod","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<"'" + this.FormatearTextoSql( lxDetallemodificacion ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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
			local  lxAjuestadosFecexpo, lxAjuestadosFectrans, lxAjuestadosFmodifw, lxAjuestadosFaltafw, lxAjuestadosFecimpo, lxAjuestadosSmodifw, lxAjuestadosHmodifw, lxAjuestadosSaltafw, lxAjuestadosUaltafw, lxAjuestadosUmodifw, lxAjuestadosZadsfw, lxAjuestadosDescfw, lxAjuestadosVmodifw, lxAjuestadosHoraimpo, lxAjuestadosValtafw, lxAjuestadosHaltafw, lxAjuestadosHoraexpo, lxAjuestadosBdmodifw, lxAjuestadosBdaltafw, lxAjuestadosEsttrans, lxAjuestadosAjnumero, lxAjuestadosTipocomp, lxAjuestadosAjcodigo, lxAjuestadosAjobs, lxAjuestadosAjfecha
				lxAjuestadosFecexpo =  .Fechaexpo			lxAjuestadosFectrans =  .Fechatransferencia			lxAjuestadosFmodifw =  .Fechamodificacionfw			lxAjuestadosFaltafw =  .Fechaaltafw			lxAjuestadosFecimpo =  .Fechaimpo			lxAjuestadosSmodifw =  .Seriemodificacionfw			lxAjuestadosHmodifw =  .Horamodificacionfw			lxAjuestadosSaltafw =  .Seriealtafw			lxAjuestadosUaltafw =  .Usuarioaltafw			lxAjuestadosUmodifw =  .Usuariomodificacionfw			lxAjuestadosZadsfw =  .Zadsfw			lxAjuestadosDescfw =  .Descripcionfw			lxAjuestadosVmodifw =  .Versionmodificacionfw			lxAjuestadosHoraimpo =  .Horaimpo			lxAjuestadosValtafw =  .Versionaltafw			lxAjuestadosHaltafw =  .Horaaltafw			lxAjuestadosHoraexpo =  .Horaexpo			lxAjuestadosBdmodifw =  .Basededatosmodificacionfw			lxAjuestadosBdaltafw =  .Basededatosaltafw			lxAjuestadosEsttrans =  .Estadotransferencia			lxAjuestadosAjnumero =  .Numero			lxAjuestadosTipocomp =  .Tipo			lxAjuestadosAjcodigo =  .Codigo			lxAjuestadosAjobs =  .Obs			lxAjuestadosAjfecha =  .Fecha
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.AJUESTADOS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAjuestadosFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAjuestadosFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAjuestadosFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAjuestadosFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAjuestadosFecimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAjuestadosZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxAjuestadosDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAjuestadosHoraimpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosValtafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAjuestadosHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAjuestadosEsttrans ) + "'">>,"Ajnumero" = <<lxAjuestadosAjnumero>>,"Tipocomp" = <<lxAjuestadosTipocomp>>,"Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjuestadosAjcodigo ) + "'">>,"Ajobs" = <<"'" + this.FormatearTextoSql( lxAjuestadosAjobs ) + "'">>,"Ajfecha" = <<"'" + this.ConvertirDateSql( lxAjuestadosAjfecha ) + "'">> where "Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjuestadosAjcodigo ) + "'">> and  AJUESTADOS.AJCODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajuestadosDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajEstAudCombDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajCompDet where "ajCompCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectado
				if this.oEntidad.StockAfectado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxSituacion = loItem.Situacion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajuestadosDet("COMP","NROITEM","ProcStock","ajdCodigo","Equiv","ajSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSituacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaComb
				if this.oEntidad.StockAfectadoAuditoriaComb.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxSituacion = loItem.Situacion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajEstAudCombDet("COMP","NROITEM","ajdCodigo","AjdSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSituacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobantesModificados
				if this.oEntidad.ComprobantesModificados.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxDetallemodificacion = loItem.Detallemodificacion
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxComprobante = loItem.Comprobante
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajCompDet("ajDetModif","COMP","NROITEM","ProcStock","Equiv","ajComprob","ajCompCod","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<"'" + this.FormatearTextoSql( lxDetallemodificacion ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ajCodigo from ZooLogic.AJUESTADOS where " + this.ConvertirFuncionesSql( " AJUESTADOS.AJCODIGO != ''" ) )
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
			Local lxAjuestadosAjcodigo
			lxAjuestadosAjcodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ajnumero" as "Numero", "Tipocomp" as "Tipo", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha" from ZooLogic.AJUESTADOS where "Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjuestadosAjcodigo ) + "'">> and  AJUESTADOS.AJCODIGO != ''
			endtext
			use in select('c_AJUSTEDEESTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDEESTADOS', set( 'Datasession' ) )

			if reccount( 'c_AJUSTEDEESTADOS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Ajdcodigo" as "Codigo", "Equiv" as "Equivalencia", "Ajsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuestadosDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajEstAudCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ajdetmodif" as "Detallemodificacion", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajcomprob" as "Comprobante", "Ajcompcod" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajCompDet where ajCompCod = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesModificados')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesModificados', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesModificados
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAjuestadosAjcodigo as Variant
		llRetorno = .t.
		lxAjuestadosAjcodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.AJUESTADOS where "Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjuestadosAjcodigo ) + "'">> and  AJUESTADOS.AJCODIGO != ''
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ajnumero" as "Numero", "Tipocomp" as "Tipo", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha" from ZooLogic.AJUESTADOS where  AJUESTADOS.AJCODIGO != '' order by ajnumero,ajCodigo
			endtext
			use in select('c_AJUSTEDEESTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDEESTADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Ajdcodigo" as "Codigo", "Equiv" as "Equivalencia", "Ajsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuestadosDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajEstAudCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ajdetmodif" as "Detallemodificacion", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajcomprob" as "Comprobante", "Ajcompcod" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajCompDet where ajCompCod = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesModificados')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesModificados', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesModificados
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ajnumero" as "Numero", "Tipocomp" as "Tipo", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha" from ZooLogic.AJUESTADOS where  str( ajnumero, 10, 0) + funciones.padr( ajCodigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AJUESTADOS.AJCODIGO != '' order by ajnumero,ajCodigo
			endtext
			use in select('c_AJUSTEDEESTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDEESTADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Ajdcodigo" as "Codigo", "Equiv" as "Equivalencia", "Ajsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuestadosDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajEstAudCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ajdetmodif" as "Detallemodificacion", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajcomprob" as "Comprobante", "Ajcompcod" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajCompDet where ajCompCod = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesModificados')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesModificados', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesModificados
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ajnumero" as "Numero", "Tipocomp" as "Tipo", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha" from ZooLogic.AJUESTADOS where  str( ajnumero, 10, 0) + funciones.padr( ajCodigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AJUESTADOS.AJCODIGO != '' order by ajnumero desc,ajCodigo desc
			endtext
			use in select('c_AJUSTEDEESTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDEESTADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Ajdcodigo" as "Codigo", "Equiv" as "Equivalencia", "Ajsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuestadosDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajEstAudCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ajdetmodif" as "Detallemodificacion", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajcomprob" as "Comprobante", "Ajcompcod" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajCompDet where ajCompCod = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesModificados')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesModificados', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesModificados
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
				lcOrden =  str( .Numero, 10, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ajnumero" as "Numero", "Tipocomp" as "Tipo", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha" from ZooLogic.AJUESTADOS where  AJUESTADOS.AJCODIGO != '' order by ajnumero desc,ajCodigo desc
			endtext
			use in select('c_AJUSTEDEESTADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDEESTADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Ajdcodigo" as "Codigo", "Equiv" as "Equivalencia", "Ajsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuestadosDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajEstAudCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ajdetmodif" as "Detallemodificacion", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajcomprob" as "Comprobante", "Ajcompcod" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajCompDet where ajCompCod = <<"'" + this.FormatearTextoSql( c_AJUSTEDEESTADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesModificados')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesModificados', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesModificados
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Zadsfw,Desc" + ;
"fw,Vmodifw,Horaimpo,Valtafw,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Esttrans,Ajnumero,Tipocomp,Ajcodigo,A" + ;
"jobs,Ajfecha" + ;
" from ZooLogic.AJUESTADOS where  AJUESTADOS.AJCODIGO != '' and " + lcFiltro )
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
			local  lxAjuestadosFecexpo, lxAjuestadosFectrans, lxAjuestadosFmodifw, lxAjuestadosFaltafw, lxAjuestadosFecimpo, lxAjuestadosSmodifw, lxAjuestadosHmodifw, lxAjuestadosSaltafw, lxAjuestadosUaltafw, lxAjuestadosUmodifw, lxAjuestadosZadsfw, lxAjuestadosDescfw, lxAjuestadosVmodifw, lxAjuestadosHoraimpo, lxAjuestadosValtafw, lxAjuestadosHaltafw, lxAjuestadosHoraexpo, lxAjuestadosBdmodifw, lxAjuestadosBdaltafw, lxAjuestadosEsttrans, lxAjuestadosAjnumero, lxAjuestadosTipocomp, lxAjuestadosAjcodigo, lxAjuestadosAjobs, lxAjuestadosAjfecha
				lxAjuestadosFecexpo = ctod( '  /  /    ' )			lxAjuestadosFectrans = ctod( '  /  /    ' )			lxAjuestadosFmodifw = ctod( '  /  /    ' )			lxAjuestadosFaltafw = ctod( '  /  /    ' )			lxAjuestadosFecimpo = ctod( '  /  /    ' )			lxAjuestadosSmodifw = []			lxAjuestadosHmodifw = []			lxAjuestadosSaltafw = []			lxAjuestadosUaltafw = []			lxAjuestadosUmodifw = []			lxAjuestadosZadsfw = []			lxAjuestadosDescfw = []			lxAjuestadosVmodifw = []			lxAjuestadosHoraimpo = []			lxAjuestadosValtafw = []			lxAjuestadosHaltafw = []			lxAjuestadosHoraexpo = []			lxAjuestadosBdmodifw = []			lxAjuestadosBdaltafw = []			lxAjuestadosEsttrans = []			lxAjuestadosAjnumero = 0			lxAjuestadosTipocomp = 0			lxAjuestadosAjcodigo = []			lxAjuestadosAjobs = []			lxAjuestadosAjfecha = ctod( '  /  /    ' )
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajuestadosDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajEstAudCombDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajCompDet where "ajCompCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.AJUESTADOS where "ajCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'AJUESTADOS' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where ajCodigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(ajCodigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJUESTADOS.AJCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ajnumero" as "Numero", "Tipocomp" as "Tipo", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AJUESTADOS', '', tnTope )
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
	Function ObtenerDatosDetalleStockAfectado( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJUESTADOSDET.AJDCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Ajdcodigo" as "Codigo", "Equiv" as "Equivalencia", "Ajsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleStockAfectado( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajuestadosDet', 'StockAfectado', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleStockAfectado( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleStockAfectado( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleStockAfectadoAuditoriaComb( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJESTAUDCOMBDET.AJDCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdsituac" as "Situacion", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleStockAfectadoAuditoriaComb( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajEstAudCombDet', 'StockAfectadoAuditoriaComb', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleStockAfectadoAuditoriaComb( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleStockAfectadoAuditoriaComb( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleComprobantesModificados( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJCOMPDET.AJCOMPCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Ajdetmodif" as "Detallemodificacion", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajcomprob" as "Comprobante", "Ajcompcod" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdtdesc" as "Talledetalle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleComprobantesModificados( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajCompDet', 'ComprobantesModificados', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleComprobantesModificados( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleComprobantesModificados( lcAtributo )
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
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
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
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJNUMERO AS NUMERO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJCODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJOBS AS OBS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJFECHA AS FECHA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleStockAfectado( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCODIGO AS CODIGO'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'SITUACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJSITUAC AS SITUACION'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDADESC AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCDESC AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDTDESC AS TALLEDETALLE'
				Case lcAtributo == 'STOCKACT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSTOCK AS STOCKACT'
				Case lcAtributo == 'STOCKPROY'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSTOCKSI AS STOCKPROY'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCANT AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleStockAfectadoAuditoriaComb( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCODIGO AS CODIGO'
				Case lcAtributo == 'SITUACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSITUAC AS SITUACION'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDADESC AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCDESC AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDTDESC AS TALLEDETALLE'
				Case lcAtributo == 'STOCKACT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSTOCK AS STOCKACT'
				Case lcAtributo == 'STOCKPROY'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSTOCKSI AS STOCKPROY'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCANT AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleComprobantesModificados( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'DETALLEMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDETMODIF AS DETALLEMODIFICACION'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJCOMPROB AS COMPROBANTE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJCOMPCOD AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDADESC AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCDESC AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDTDESC AS TALLEDETALLE'
				Case lcAtributo == 'STOCKACT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSTOCK AS STOCKACT'
				Case lcAtributo == 'STOCKPROY'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSTOCKSI AS STOCKPROY'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCANT AS CANTIDAD'
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
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'AJNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'AJOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'AJFECHA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleStockAfectado( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJDCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACION'
				lcCampo = 'AJSITUAC'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'AJDART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'AJDADESC'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'AJDCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'AJDCDESC'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'AJDTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'AJDTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKACT'
				lcCampo = 'AJDSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKPROY'
				lcCampo = 'AJDSTOCKSI'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'AJDCANT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleStockAfectadoAuditoriaComb( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJDCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACION'
				lcCampo = 'AJDSITUAC'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'AJDART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'AJDADESC'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'AJDCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'AJDCDESC'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'AJDTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'AJDTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKACT'
				lcCampo = 'AJDSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKPROY'
				lcCampo = 'AJDSTOCKSI'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'AJDCANT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleComprobantesModificados( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'DETALLEMODIFICACION'
				lcCampo = 'AJDETMODIF'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'AJCOMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJCOMPCOD'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'AJDART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'AJDADESC'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'AJDCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'AJDCDESC'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'AJDTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'AJDTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKACT'
				lcCampo = 'AJDSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKPROY'
				lcCampo = 'AJDSTOCKSI'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'AJDCANT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'STOCKAFECTADO'
			lcRetorno = 'AJUESTADOSDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'STOCKAFECTADOAUDITORIACOMB'
			lcRetorno = 'AJESTAUDCOMBDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'COMPROBANTESMODIFICADOS'
			lcRetorno = 'AJCOMPDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAjuestadosFecexpo, lxAjuestadosFectrans, lxAjuestadosFmodifw, lxAjuestadosFaltafw, lxAjuestadosFecimpo, lxAjuestadosSmodifw, lxAjuestadosHmodifw, lxAjuestadosSaltafw, lxAjuestadosUaltafw, lxAjuestadosUmodifw, lxAjuestadosZadsfw, lxAjuestadosDescfw, lxAjuestadosVmodifw, lxAjuestadosHoraimpo, lxAjuestadosValtafw, lxAjuestadosHaltafw, lxAjuestadosHoraexpo, lxAjuestadosBdmodifw, lxAjuestadosBdaltafw, lxAjuestadosEsttrans, lxAjuestadosAjnumero, lxAjuestadosTipocomp, lxAjuestadosAjcodigo, lxAjuestadosAjobs, lxAjuestadosAjfecha
				lxAjuestadosFecexpo =  .Fechaexpo			lxAjuestadosFectrans =  .Fechatransferencia			lxAjuestadosFmodifw =  .Fechamodificacionfw			lxAjuestadosFaltafw =  .Fechaaltafw			lxAjuestadosFecimpo =  .Fechaimpo			lxAjuestadosSmodifw =  .Seriemodificacionfw			lxAjuestadosHmodifw =  .Horamodificacionfw			lxAjuestadosSaltafw =  .Seriealtafw			lxAjuestadosUaltafw =  .Usuarioaltafw			lxAjuestadosUmodifw =  .Usuariomodificacionfw			lxAjuestadosZadsfw =  .Zadsfw			lxAjuestadosDescfw =  .Descripcionfw			lxAjuestadosVmodifw =  .Versionmodificacionfw			lxAjuestadosHoraimpo =  .Horaimpo			lxAjuestadosValtafw =  .Versionaltafw			lxAjuestadosHaltafw =  .Horaaltafw			lxAjuestadosHoraexpo =  .Horaexpo			lxAjuestadosBdmodifw =  .Basededatosmodificacionfw			lxAjuestadosBdaltafw =  .Basededatosaltafw			lxAjuestadosEsttrans =  .Estadotransferencia			lxAjuestadosAjnumero =  .Numero			lxAjuestadosTipocomp =  .Tipo			lxAjuestadosAjcodigo =  .Codigo			lxAjuestadosAjobs =  .Obs			lxAjuestadosAjfecha =  .Fecha
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.AJUESTADOS ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Zadsfw","Descfw","Vmodifw","Horaimpo","Valtafw","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Esttrans","Ajnumero","Tipocomp","Ajcodigo","Ajobs","Ajfecha" ) values ( <<"'" + this.ConvertirDateSql( lxAjuestadosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosEsttrans ) + "'" >>, <<lxAjuestadosAjnumero >>, <<lxAjuestadosTipocomp >>, <<"'" + this.FormatearTextoSql( lxAjuestadosAjcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjuestadosAjobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjuestadosAjfecha ) + "'" >> )
		endtext
		loColeccion.cTabla = 'AJUESTADOS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectado
				if this.oEntidad.StockAfectado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxSituacion = loItem.Situacion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajuestadosDet("COMP","NROITEM","ProcStock","ajdCodigo","Equiv","ajSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSituacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaComb
				if this.oEntidad.StockAfectadoAuditoriaComb.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxSituacion = loItem.Situacion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajEstAudCombDet("COMP","NROITEM","ajdCodigo","AjdSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSituacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobantesModificados
				if this.oEntidad.ComprobantesModificados.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxDetallemodificacion = loItem.Detallemodificacion
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxComprobante = loItem.Comprobante
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajCompDet("ajDetModif","COMP","NROITEM","ProcStock","Equiv","ajComprob","ajCompCod","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<"'" + this.FormatearTextoSql( lxDetallemodificacion ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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
			local  lxAjuestadosFecexpo, lxAjuestadosFectrans, lxAjuestadosFmodifw, lxAjuestadosFaltafw, lxAjuestadosFecimpo, lxAjuestadosSmodifw, lxAjuestadosHmodifw, lxAjuestadosSaltafw, lxAjuestadosUaltafw, lxAjuestadosUmodifw, lxAjuestadosZadsfw, lxAjuestadosDescfw, lxAjuestadosVmodifw, lxAjuestadosHoraimpo, lxAjuestadosValtafw, lxAjuestadosHaltafw, lxAjuestadosHoraexpo, lxAjuestadosBdmodifw, lxAjuestadosBdaltafw, lxAjuestadosEsttrans, lxAjuestadosAjnumero, lxAjuestadosTipocomp, lxAjuestadosAjcodigo, lxAjuestadosAjobs, lxAjuestadosAjfecha
				lxAjuestadosFecexpo =  .Fechaexpo			lxAjuestadosFectrans =  .Fechatransferencia			lxAjuestadosFmodifw =  .Fechamodificacionfw			lxAjuestadosFaltafw =  .Fechaaltafw			lxAjuestadosFecimpo =  .Fechaimpo			lxAjuestadosSmodifw =  .Seriemodificacionfw			lxAjuestadosHmodifw =  .Horamodificacionfw			lxAjuestadosSaltafw =  .Seriealtafw			lxAjuestadosUaltafw =  .Usuarioaltafw			lxAjuestadosUmodifw =  .Usuariomodificacionfw			lxAjuestadosZadsfw =  .Zadsfw			lxAjuestadosDescfw =  .Descripcionfw			lxAjuestadosVmodifw =  .Versionmodificacionfw			lxAjuestadosHoraimpo =  .Horaimpo			lxAjuestadosValtafw =  .Versionaltafw			lxAjuestadosHaltafw =  .Horaaltafw			lxAjuestadosHoraexpo =  .Horaexpo			lxAjuestadosBdmodifw =  .Basededatosmodificacionfw			lxAjuestadosBdaltafw =  .Basededatosaltafw			lxAjuestadosEsttrans =  .Estadotransferencia			lxAjuestadosAjnumero =  .Numero			lxAjuestadosTipocomp =  .Tipo			lxAjuestadosAjcodigo =  .Codigo			lxAjuestadosAjobs =  .Obs			lxAjuestadosAjfecha =  .Fecha
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ajcodigo" = ] + lcValorClavePrimariaString  + [ and  AJUESTADOS.AJCODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.AJUESTADOS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAjuestadosFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAjuestadosFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAjuestadosFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAjuestadosFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAjuestadosFecimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAjuestadosZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxAjuestadosDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAjuestadosHoraimpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosValtafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAjuestadosHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAjuestadosBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAjuestadosBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAjuestadosEsttrans ) + "'">>, "Ajnumero" = <<lxAjuestadosAjnumero>>, "Tipocomp" = <<lxAjuestadosTipocomp>>, "Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjuestadosAjcodigo ) + "'">>, "Ajobs" = <<"'" + this.FormatearTextoSql( lxAjuestadosAjobs ) + "'">>, "Ajfecha" = <<"'" + this.ConvertirDateSql( lxAjuestadosAjfecha ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'AJUESTADOS' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ajuestadosDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajEstAudCombDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajCompDet where "ajCompCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectado
				if this.oEntidad.StockAfectado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxSituacion = loItem.Situacion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajuestadosDet("COMP","NROITEM","ProcStock","ajdCodigo","Equiv","ajSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSituacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaComb
				if this.oEntidad.StockAfectadoAuditoriaComb.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxSituacion = loItem.Situacion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajEstAudCombDet("COMP","NROITEM","ajdCodigo","AjdSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSituacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobantesModificados
				if this.oEntidad.ComprobantesModificados.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxDetallemodificacion = loItem.Detallemodificacion
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxComprobante = loItem.Comprobante
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajCompDet("ajDetModif","COMP","NROITEM","ProcStock","Equiv","ajComprob","ajCompCod","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant" ) values ( <<"'" + this.FormatearTextoSql( lxDetallemodificacion ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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

			lcFiltro = ["Ajcodigo" = ] + lcValorClavePrimariaString  + [ and  AJUESTADOS.AJCODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.AJUESTADOS where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ajuestadosDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajEstAudCombDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajCompDet where "ajCompCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'AJUESTADOS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.AJUESTADOS where  AJUESTADOS.AJCODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.AJUESTADOS where ajCodigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  AJUESTADOS.AJCODIGO != ''" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMERO') ) and iif( type( '.NUMERO' ) = 'C', int( val( .NUMERO ) ),.NUMERO ) = .oNumeraciones.UltimoNumero( 'NUMERO' )
						.oNumeraciones.Actualizar( 'NUMERO' )
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
					.NUMERO = .oNumeraciones.grabar( 'NUMERO' )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDEESTADOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.AJUESTADOS Where ajCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ajCodigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.AJUESTADOS set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ajnumero = ] + transform( &lcCursor..ajnumero )+ [, tipocomp = ] + transform( &lcCursor..tipocomp )+ [, ajCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ajCodigo ) + "'"+ [, ajObs = ] + "'" + this.FormatearTextoSql( &lcCursor..ajObs ) + "'"+ [, ajfecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ajfecha ) + "'" + [ Where ajCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ajCodigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, SMODIFW, HMODIFW, SALTAFW, UALTAFW, UMODIFW, ZADSFW, DescFW, VMODIFW, HORAIMPO, VALTAFW, HALTAFW, HORAEXPO, BDMODIFW, BDALTAFW, ESTTRANS, ajnumero, tipocomp, ajCodigo, ajObs, ajfecha
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..ajnumero )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..tipocomp ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ajCodigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ajObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ajfecha ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.AJUESTADOS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDEESTADOS'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'ajCodigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','ajCodigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajuestadosDet Where ajdCodigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajEstAudCombDet Where ajdCodigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajCompDet Where ajCompCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJUSTEDEESTADOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajdCodigo in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"COMP","NROITEM","ProcStock","ajdCodigo","Equiv","ajSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajuestadosDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCodigo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajSituac   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdart     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTDesc   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdstocksi ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJESTADOSAUDCOMB'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajdCodigo in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"COMP","NROITEM","ajdCodigo","AjdSituac","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajEstAudCombDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCodigo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AjdSituac  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdart     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTDesc   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdstocksi ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJUSTECOMPROBANTES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajCompCod in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"ajDetModif","COMP","NROITEM","ProcStock","Equiv","ajComprob","ajCompCod","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdTDesc","ajdstock","ajdstocksi","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajCompDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.ajDetModif ) + "'" + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajComprob  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajCompCod  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdart     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTDesc   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdstocksi ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( ajCodigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..ajCodigo   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'AJUSTEDEESTADOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AJUSTEDEESTADOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AJUSTEDEESTADOS_AJOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJUSTEDEESTADOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJESTADOSAUDCOMB'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJUSTECOMPROBANTES'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ajuestados')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'AJUSTEDEESTADOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ajCodigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad AJUSTEDEESTADOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDEESTADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,ajCodigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( ajCodigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDEESTADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  ajfecha   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ajuestados') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ajuestados
Create Table ZooLogic.TablaTrabajo_ajuestados ( 
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
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"ajnumero" numeric( 10, 0 )  null, 
"tipocomp" numeric( 1, 0 )  null, 
"ajcodigo" char( 38 )  null, 
"ajobs" varchar(max)  null, 
"ajfecha" datetime  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ajuestados' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ajuestados' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDEESTADOS'
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
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('ajnumero','ajnumero')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('ajcodigo','ajcodigo')
			.AgregarMapeo('ajobs','ajobs')
			.AgregarMapeo('ajfecha','ajfecha')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ajuestados'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.AJNUMERO = isnull( d.AJNUMERO, t.AJNUMERO ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.AJCODIGO = isnull( d.AJCODIGO, t.AJCODIGO ),t.AJOBS = isnull( d.AJOBS, t.AJOBS ),t.AJFECHA = isnull( d.AJFECHA, t.AJFECHA )
					from ZooLogic.AJUESTADOS t inner join deleted d 
							 on t.ajCodigo = d.ajCodigo
				-- Fin Updates
				insert into ZooLogic.AJUESTADOS(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Zadsfw,Descfw,Vmodifw,Horaimpo,Valtafw,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Esttrans,Ajnumero,Tipocomp,Ajcodigo,Ajobs,Ajfecha)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.AJNUMERO,0),isnull( d.TIPOCOMP,0),isnull( d.AJCODIGO,''),isnull( d.AJOBS,''),isnull( d.AJFECHA,'')
						From deleted d left join ZooLogic.AJUESTADOS pk 
							 on d.ajCodigo = pk.ajCodigo
						Where pk.ajCodigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajuestadosDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUESTADOS_ajuestadosDet
ON ZooLogic.TablaTrabajo_AJUESTADOS_ajuestadosDet
AFTER DELETE
As
Begin
Update t Set 
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.AJDCODIGO = isnull( d.AJDCODIGO, t.AJDCODIGO ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.AJSITUAC = isnull( d.AJSITUAC, t.AJSITUAC ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDCOLOR = isnull( d.AJDCOLOR, t.AJDCOLOR ),
t.AJDCDESC = isnull( d.AJDCDESC, t.AJDCDESC ),
t.AJDTALLE = isnull( d.AJDTALLE, t.AJDTALLE ),
t.AJDTDESC = isnull( d.AJDTDESC, t.AJDTDESC ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDSTOCKSI = isnull( d.AJDSTOCKSI, t.AJDSTOCKSI ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajuestadosDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajuestadosDet
( 
"COMP",
"NROITEM",
"PROCSTOCK",
"AJDCODIGO",
"EQUIV",
"AJSITUAC",
"AJDART",
"AJDADESC",
"AJDCOLOR",
"AJDCDESC",
"AJDTALLE",
"AJDTDESC",
"AJDSTOCK",
"AJDSTOCKSI",
"AJDCANT"
 )
Select 
d.COMP,
d.NROITEM,
d.PROCSTOCK,
d.AJDCODIGO,
d.EQUIV,
d.AJSITUAC,
d.AJDART,
d.AJDADESC,
d.AJDCOLOR,
d.AJDCDESC,
d.AJDTALLE,
d.AJDTDESC,
d.AJDSTOCK,
d.AJDSTOCKSI,
d.AJDCANT
From deleted d left join ZooLogic.ajuestadosDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajEstAudCombDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUESTADOS_ajEstAudCombDet
ON ZooLogic.TablaTrabajo_AJUESTADOS_ajEstAudCombDet
AFTER DELETE
As
Begin
Update t Set 
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.AJDCODIGO = isnull( d.AJDCODIGO, t.AJDCODIGO ),
t.AJDSITUAC = isnull( d.AJDSITUAC, t.AJDSITUAC ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDCOLOR = isnull( d.AJDCOLOR, t.AJDCOLOR ),
t.AJDCDESC = isnull( d.AJDCDESC, t.AJDCDESC ),
t.AJDTALLE = isnull( d.AJDTALLE, t.AJDTALLE ),
t.AJDTDESC = isnull( d.AJDTDESC, t.AJDTDESC ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDSTOCKSI = isnull( d.AJDSTOCKSI, t.AJDSTOCKSI ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajEstAudCombDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajEstAudCombDet
( 
"COMP",
"NROITEM",
"AJDCODIGO",
"AJDSITUAC",
"AJDART",
"AJDADESC",
"AJDCOLOR",
"AJDCDESC",
"AJDTALLE",
"AJDTDESC",
"AJDSTOCK",
"AJDSTOCKSI",
"AJDCANT"
 )
Select 
d.COMP,
d.NROITEM,
d.AJDCODIGO,
d.AJDSITUAC,
d.AJDART,
d.AJDADESC,
d.AJDCOLOR,
d.AJDCDESC,
d.AJDTALLE,
d.AJDTDESC,
d.AJDSTOCK,
d.AJDSTOCKSI,
d.AJDCANT
From deleted d left join ZooLogic.ajEstAudCombDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajCompDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUESTADOS_ajCompDet
ON ZooLogic.TablaTrabajo_AJUESTADOS_ajCompDet
AFTER DELETE
As
Begin
Update t Set 
t.AJDETMODIF = isnull( d.AJDETMODIF, t.AJDETMODIF ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.AJCOMPROB = isnull( d.AJCOMPROB, t.AJCOMPROB ),
t.AJCOMPCOD = isnull( d.AJCOMPCOD, t.AJCOMPCOD ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDCOLOR = isnull( d.AJDCOLOR, t.AJDCOLOR ),
t.AJDCDESC = isnull( d.AJDCDESC, t.AJDCDESC ),
t.AJDTALLE = isnull( d.AJDTALLE, t.AJDTALLE ),
t.AJDTDESC = isnull( d.AJDTDESC, t.AJDTDESC ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDSTOCKSI = isnull( d.AJDSTOCKSI, t.AJDSTOCKSI ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajCompDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajCompDet
( 
"AJDETMODIF",
"COMP",
"NROITEM",
"PROCSTOCK",
"EQUIV",
"AJCOMPROB",
"AJCOMPCOD",
"AJDART",
"AJDADESC",
"AJDCOLOR",
"AJDCDESC",
"AJDTALLE",
"AJDTDESC",
"AJDSTOCK",
"AJDSTOCKSI",
"AJDCANT"
 )
Select 
d.AJDETMODIF,
d.COMP,
d.NROITEM,
d.PROCSTOCK,
d.EQUIV,
d.AJCOMPROB,
d.AJCOMPCOD,
d.AJDART,
d.AJDADESC,
d.AJDCOLOR,
d.AJDCDESC,
d.AJDTALLE,
d.AJDTDESC,
d.AJDSTOCK,
d.AJDSTOCKSI,
d.AJDCANT
From deleted d left join ZooLogic.ajCompDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ajuestados') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ajuestados
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_AJUSTEDEESTADOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDEESTADOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDEESTADOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDEESTADOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDEESTADOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDEESTADOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Seriemodificacionfw = nvl( c_AJUSTEDEESTADOS.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_AJUSTEDEESTADOS.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_AJUSTEDEESTADOS.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_AJUSTEDEESTADOS.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_AJUSTEDEESTADOS.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_AJUSTEDEESTADOS.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_AJUSTEDEESTADOS.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_AJUSTEDEESTADOS.Horaimpo, [] )
					.Versionaltafw = nvl( c_AJUSTEDEESTADOS.Versionaltafw, [] )
					.Horaaltafw = nvl( c_AJUSTEDEESTADOS.Horaaltafw, [] )
					.Horaexpo = nvl( c_AJUSTEDEESTADOS.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_AJUSTEDEESTADOS.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_AJUSTEDEESTADOS.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_AJUSTEDEESTADOS.Estadotransferencia, [] )
					.Numero = nvl( c_AJUSTEDEESTADOS.Numero, 0 )
					.Tipo = nvl( c_AJUSTEDEESTADOS.Tipo, 0 )
					.Stockafectado.Limpiar()
					.Stockafectado.SetearEsNavegacion( .lProcesando )
					.Stockafectado.Cargar()
					.Stockafectadoauditoriacomb.Limpiar()
					.Stockafectadoauditoriacomb.SetearEsNavegacion( .lProcesando )
					.Stockafectadoauditoriacomb.Cargar()
					.Comprobantesmodificados.Limpiar()
					.Comprobantesmodificados.SetearEsNavegacion( .lProcesando )
					.Comprobantesmodificados.Cargar()
					.Codigo = nvl( c_AJUSTEDEESTADOS.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDEESTADOS.Fecha, ctod( '  /  /    ' ) ) )
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
		
		loDetalle = this.oEntidad.StockAfectado
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

		loDetalle = this.oEntidad.StockAfectadoAuditoriaComb
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

		loDetalle = this.oEntidad.ComprobantesModificados
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
		return c_AJUSTEDEESTADOS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.AJUESTADOS' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ajCodigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,ajCodigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    ajCodigo from (
							select * 
								from ZooLogic.AJUESTADOS 
								Where   AJUESTADOS.AJCODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "AJUESTADOS", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ajCodigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ajnumero" as "Numero", "Tipocomp" as "Tipo", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.AJUESTADOS 
								Where   AJUESTADOS.AJCODIGO != ''
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
	Tabla = 'AJUESTADOS'
	Filtro = " AJUESTADOS.AJCODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " AJUESTADOS.AJCODIGO != ''"
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
	<row entidad="AJUSTEDEESTADOS                         " atributo="FECHAEXPO                               " tabla="AJUESTADOS     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="FECHATRANSFERENCIA                      " tabla="AJUESTADOS     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="FECHAMODIFICACIONFW                     " tabla="AJUESTADOS     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="FECHAALTAFW                             " tabla="AJUESTADOS     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="FECHAIMPO                               " tabla="AJUESTADOS     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="SERIEMODIFICACIONFW                     " tabla="AJUESTADOS     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="HORAMODIFICACIONFW                      " tabla="AJUESTADOS     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="SERIEALTAFW                             " tabla="AJUESTADOS     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="USUARIOALTAFW                           " tabla="AJUESTADOS     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="USUARIOMODIFICACIONFW                   " tabla="AJUESTADOS     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="ZADSFW                                  " tabla="AJUESTADOS     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="DESCRIPCIONFW                           " tabla="AJUESTADOS     " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="VERSIONMODIFICACIONFW                   " tabla="AJUESTADOS     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="HORAIMPO                                " tabla="AJUESTADOS     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="VERSIONALTAFW                           " tabla="AJUESTADOS     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="HORAALTAFW                              " tabla="AJUESTADOS     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="HORAEXPO                                " tabla="AJUESTADOS     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="AJUESTADOS     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="BASEDEDATOSALTAFW                       " tabla="AJUESTADOS     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="ESTADOTRANSFERENCIA                     " tabla="AJUESTADOS     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="NUMERO                                  " tabla="AJUESTADOS     " campo="AJNUMERO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="TIPO                                    " tabla="AJUESTADOS     " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="STOCKAFECTADO                           " tabla="AJUESTADOSDET  " campo="AJDCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMAJUSTEDEESTADOS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="STOCKAFECTADOAUDITORIACOMB              " tabla="AJESTAUDCOMBDET" campo="AJDCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMAJESTADOSAUDCOMB   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="COMPROBANTESMODIFICADOS                 " tabla="AJCOMPDET      " campo="AJCOMPCOD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMAJUSTECOMPROBANTES " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="CODIGO                                  " tabla="AJUESTADOS     " campo="AJCODIGO  " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="OBS                                     " tabla="AJUESTADOS     " campo="AJOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDEESTADOS                         " atributo="FECHA                                   " tabla="AJUESTADOS     " campo="AJFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="204" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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