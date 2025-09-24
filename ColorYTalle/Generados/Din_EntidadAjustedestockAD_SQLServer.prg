
define class Din_EntidadAJUSTEDESTOCKAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_AJUSTEDESTOCK'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AJSPK'
	cTablaPrincipal = 'AJUSTOCK'
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
			local  lxAjustockFmodifw, lxAjustockFecimpo, lxAjustockFectrans, lxAjustockFaltafw, lxAjustockFecexpo, lxAjustockHoraexpo, lxAjustockHaltafw, lxAjustockHoraimpo, lxAjustockUaltafw, lxAjustockHmodifw, lxAjustockZadsfw, lxAjustockDescfw, lxAjustockVmodifw, lxAjustockValtafw, lxAjustockSmodifw, lxAjustockUmodifw, lxAjustockSaltafw, lxAjustockBdmodifw, lxAjustockEsttrans, lxAjustockBdaltafw, lxAjustockTipocomp, lxAjustockAjnumero, lxAjustockAjcodigo, lxAjustockAjobs, lxAjustockAjfecha, lxAjustockAjfedesde, lxAjustockAjfehasta, lxAjustockAjdhora, lxAjustockAjserie, lxAjustockAjdusuario
				lxAjustockFmodifw =  .Fechamodificacionfw			lxAjustockFecimpo =  .Fechaimpo			lxAjustockFectrans =  .Fechatransferencia			lxAjustockFaltafw =  .Fechaaltafw			lxAjustockFecexpo =  .Fechaexpo			lxAjustockHoraexpo =  .Horaexpo			lxAjustockHaltafw =  .Horaaltafw			lxAjustockHoraimpo =  .Horaimpo			lxAjustockUaltafw =  .Usuarioaltafw			lxAjustockHmodifw =  .Horamodificacionfw			lxAjustockZadsfw =  .Zadsfw			lxAjustockDescfw =  .Descripcionfw			lxAjustockVmodifw =  .Versionmodificacionfw			lxAjustockValtafw =  .Versionaltafw			lxAjustockSmodifw =  .Seriemodificacionfw			lxAjustockUmodifw =  .Usuariomodificacionfw			lxAjustockSaltafw =  .Seriealtafw			lxAjustockBdmodifw =  .Basededatosmodificacionfw			lxAjustockEsttrans =  .Estadotransferencia			lxAjustockBdaltafw =  .Basededatosaltafw			lxAjustockTipocomp =  .Tipo			lxAjustockAjnumero =  .Numero			lxAjustockAjcodigo =  .Codigo			lxAjustockAjobs =  .Obs			lxAjustockAjfecha =  .Fecha			lxAjustockAjfedesde =  .Fechadesde			lxAjustockAjfehasta =  .Fechahasta			lxAjustockAjdhora =  .Hora			lxAjustockAjserie =  .Serie			lxAjustockAjdusuario =  .Usuario
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAjustockAjcodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.AJUSTOCK ( "Fmodifw","Fecimpo","Fectrans","Faltafw","Fecexpo","Horaexpo","Haltafw","Horaimpo","Ualtafw","Hmodifw","Zadsfw","Descfw","Vmodifw","Valtafw","Smodifw","Umodifw","Saltafw","Bdmodifw","Esttrans","Bdaltafw","Tipocomp","Ajnumero","Ajcodigo","Ajobs","Ajfecha","Ajfedesde","Ajfehasta","Ajdhora","Ajserie","Ajdusuario" ) values ( <<"'" + this.ConvertirDateSql( lxAjustockFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockBdaltafw ) + "'" >>, <<lxAjustockTipocomp >>, <<lxAjustockAjnumero >>, <<"'" + this.FormatearTextoSql( lxAjustockAjcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockAjobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockAjfecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockAjfedesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockAjfehasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockAjdhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockAjserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockAjdusuario ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.stockafectado
				if this.oEntidad.stockafectado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajustockDet("COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoArticulo
				if this.oEntidad.StockAfectadoArticulo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajustockDeta("NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAudiCombDet("NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaArt
				if this.oEntidad.StockAfectadoAuditoriaArt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAudiArtdet("NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.stockafectadoEnTransito
				if this.oEntidad.stockafectadoEnTransito.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajuEnTranDet("COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaEnTransito
				if this.oEntidad.StockAfectadoAuditoriaEnTransito.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAuEnTranDet("NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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
			local  lxAjustockFmodifw, lxAjustockFecimpo, lxAjustockFectrans, lxAjustockFaltafw, lxAjustockFecexpo, lxAjustockHoraexpo, lxAjustockHaltafw, lxAjustockHoraimpo, lxAjustockUaltafw, lxAjustockHmodifw, lxAjustockZadsfw, lxAjustockDescfw, lxAjustockVmodifw, lxAjustockValtafw, lxAjustockSmodifw, lxAjustockUmodifw, lxAjustockSaltafw, lxAjustockBdmodifw, lxAjustockEsttrans, lxAjustockBdaltafw, lxAjustockTipocomp, lxAjustockAjnumero, lxAjustockAjcodigo, lxAjustockAjobs, lxAjustockAjfecha, lxAjustockAjfedesde, lxAjustockAjfehasta, lxAjustockAjdhora, lxAjustockAjserie, lxAjustockAjdusuario
				lxAjustockFmodifw =  .Fechamodificacionfw			lxAjustockFecimpo =  .Fechaimpo			lxAjustockFectrans =  .Fechatransferencia			lxAjustockFaltafw =  .Fechaaltafw			lxAjustockFecexpo =  .Fechaexpo			lxAjustockHoraexpo =  .Horaexpo			lxAjustockHaltafw =  .Horaaltafw			lxAjustockHoraimpo =  .Horaimpo			lxAjustockUaltafw =  .Usuarioaltafw			lxAjustockHmodifw =  .Horamodificacionfw			lxAjustockZadsfw =  .Zadsfw			lxAjustockDescfw =  .Descripcionfw			lxAjustockVmodifw =  .Versionmodificacionfw			lxAjustockValtafw =  .Versionaltafw			lxAjustockSmodifw =  .Seriemodificacionfw			lxAjustockUmodifw =  .Usuariomodificacionfw			lxAjustockSaltafw =  .Seriealtafw			lxAjustockBdmodifw =  .Basededatosmodificacionfw			lxAjustockEsttrans =  .Estadotransferencia			lxAjustockBdaltafw =  .Basededatosaltafw			lxAjustockTipocomp =  .Tipo			lxAjustockAjnumero =  .Numero			lxAjustockAjcodigo =  .Codigo			lxAjustockAjobs =  .Obs			lxAjustockAjfecha =  .Fecha			lxAjustockAjfedesde =  .Fechadesde			lxAjustockAjfehasta =  .Fechahasta			lxAjustockAjdhora =  .Hora			lxAjustockAjserie =  .Serie			lxAjustockAjdusuario =  .Usuario
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.AJUSTOCK set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAjustockFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAjustockFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAjustockFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAjustockFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAjustockFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAjustockHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAjustockHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAjustockHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAjustockUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAjustockHmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAjustockZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxAjustockDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAjustockVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAjustockValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAjustockSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAjustockUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAjustockSaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAjustockBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAjustockEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAjustockBdaltafw ) + "'">>,"Tipocomp" = <<lxAjustockTipocomp>>,"Ajnumero" = <<lxAjustockAjnumero>>,"Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjustockAjcodigo ) + "'">>,"Ajobs" = <<"'" + this.FormatearTextoSql( lxAjustockAjobs ) + "'">>,"Ajfecha" = <<"'" + this.ConvertirDateSql( lxAjustockAjfecha ) + "'">>,"Ajfedesde" = <<"'" + this.ConvertirDateSql( lxAjustockAjfedesde ) + "'">>,"Ajfehasta" = <<"'" + this.ConvertirDateSql( lxAjustockAjfehasta ) + "'">>,"Ajdhora" = <<"'" + this.FormatearTextoSql( lxAjustockAjdhora ) + "'">>,"Ajserie" = <<"'" + this.FormatearTextoSql( lxAjustockAjserie ) + "'">>,"Ajdusuario" = <<"'" + this.FormatearTextoSql( lxAjustockAjdusuario ) + "'">> where "Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjustockAjcodigo ) + "'">> and  AJUSTOCK.AJCODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajustockDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajustockDeta where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajAudiCombDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajAudiArtdet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajuEnTranDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajAuEnTranDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.stockafectado
				if this.oEntidad.stockafectado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajustockDet("COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoArticulo
				if this.oEntidad.StockAfectadoArticulo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajustockDeta("NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAudiCombDet("NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaArt
				if this.oEntidad.StockAfectadoAuditoriaArt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAudiArtdet("NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.stockafectadoEnTransito
				if this.oEntidad.stockafectadoEnTransito.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajuEnTranDet("COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaEnTransito
				if this.oEntidad.StockAfectadoAuditoriaEnTransito.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAuEnTranDet("NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ajCodigo from ZooLogic.AJUSTOCK where " + this.ConvertirFuncionesSql( " AJUSTOCK.AJCODIGO != ''" ) )
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
			Local lxAjustockAjcodigo
			lxAjustockAjcodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Tipocomp" as "Tipo", "Ajnumero" as "Numero", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha", "Ajfedesde" as "Fechadesde", "Ajfehasta" as "Fechahasta", "Ajdhora" as "Hora", "Ajserie" as "Serie", "Ajdusuario" as "Usuario" from ZooLogic.AJUSTOCK where "Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjustockAjcodigo ) + "'">> and  AJUSTOCK.AJCODIGO != ''
			endtext
			use in select('c_AJUSTEDESTOCK')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDESTOCK', set( 'Datasession' ) )

			if reccount( 'c_AJUSTEDESTOCK' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDeta where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoArticulo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoArticulo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoArticulo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiArtdet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaArt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaArt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectadoEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectadoEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectadoEnTransito
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaEnTransito
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAjustockAjcodigo as Variant
		llRetorno = .t.
		lxAjustockAjcodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.AJUSTOCK where "Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjustockAjcodigo ) + "'">> and  AJUSTOCK.AJCODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Tipocomp" as "Tipo", "Ajnumero" as "Numero", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha", "Ajfedesde" as "Fechadesde", "Ajfehasta" as "Fechahasta", "Ajdhora" as "Hora", "Ajserie" as "Serie", "Ajdusuario" as "Usuario" from ZooLogic.AJUSTOCK where  AJUSTOCK.AJCODIGO != '' order by ajnumero,ajCodigo
			endtext
			use in select('c_AJUSTEDESTOCK')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDESTOCK', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDeta where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoArticulo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoArticulo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoArticulo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiArtdet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaArt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaArt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectadoEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectadoEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectadoEnTransito
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaEnTransito
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Tipocomp" as "Tipo", "Ajnumero" as "Numero", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha", "Ajfedesde" as "Fechadesde", "Ajfehasta" as "Fechahasta", "Ajdhora" as "Hora", "Ajserie" as "Serie", "Ajdusuario" as "Usuario" from ZooLogic.AJUSTOCK where  str( ajnumero, 10, 0) + funciones.padr( ajCodigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AJUSTOCK.AJCODIGO != '' order by ajnumero,ajCodigo
			endtext
			use in select('c_AJUSTEDESTOCK')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDESTOCK', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDeta where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoArticulo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoArticulo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoArticulo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiArtdet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaArt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaArt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectadoEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectadoEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectadoEnTransito
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaEnTransito
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Tipocomp" as "Tipo", "Ajnumero" as "Numero", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha", "Ajfedesde" as "Fechadesde", "Ajfehasta" as "Fechahasta", "Ajdhora" as "Hora", "Ajserie" as "Serie", "Ajdusuario" as "Usuario" from ZooLogic.AJUSTOCK where  str( ajnumero, 10, 0) + funciones.padr( ajCodigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AJUSTOCK.AJCODIGO != '' order by ajnumero desc,ajCodigo desc
			endtext
			use in select('c_AJUSTEDESTOCK')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDESTOCK', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDeta where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoArticulo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoArticulo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoArticulo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiArtdet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaArt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaArt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectadoEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectadoEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectadoEnTransito
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaEnTransito
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Tipocomp" as "Tipo", "Ajnumero" as "Numero", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha", "Ajfedesde" as "Fechadesde", "Ajfehasta" as "Fechahasta", "Ajdhora" as "Hora", "Ajserie" as "Serie", "Ajdusuario" as "Usuario" from ZooLogic.AJUSTOCK where  AJUSTOCK.AJCODIGO != '' order by ajnumero desc,ajCodigo desc
			endtext
			use in select('c_AJUSTEDESTOCK')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTEDESTOCK', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajustockDeta where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoArticulo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoArticulo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoArticulo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiCombDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaComb')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaComb', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaComb
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAudiArtdet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaArt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaArt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_stockafectadoEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_stockafectadoEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_stockafectadoEnTransito
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad" from ZooLogic.ajAuEnTranDet where ajdCodigo = <<"'" + this.FormatearTextoSql( c_AJUSTEDESTOCK.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_StockAfectadoAuditoriaEnTransito')
			this.oConexion.EjecutarSql( lcSentencia, 'c_StockAfectadoAuditoriaEnTransito', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_StockAfectadoAuditoriaEnTransito
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecimpo,Fectrans,Faltafw,Fecexpo,Horaexpo,Haltafw,Horaimpo,Ualtafw,Hmodifw,Zadsfw,De" + ;
"scfw,Vmodifw,Valtafw,Smodifw,Umodifw,Saltafw,Bdmodifw,Esttrans,Bdaltafw,Tipocomp,Ajnumero,Ajcodigo,A" + ;
"jobs,Ajfecha,Ajfedesde,Ajfehasta,Ajdhora,Ajserie,Ajdusuario" + ;
" from ZooLogic.AJUSTOCK where  AJUSTOCK.AJCODIGO != '' and " + lcFiltro )
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
			local  lxAjustockFmodifw, lxAjustockFecimpo, lxAjustockFectrans, lxAjustockFaltafw, lxAjustockFecexpo, lxAjustockHoraexpo, lxAjustockHaltafw, lxAjustockHoraimpo, lxAjustockUaltafw, lxAjustockHmodifw, lxAjustockZadsfw, lxAjustockDescfw, lxAjustockVmodifw, lxAjustockValtafw, lxAjustockSmodifw, lxAjustockUmodifw, lxAjustockSaltafw, lxAjustockBdmodifw, lxAjustockEsttrans, lxAjustockBdaltafw, lxAjustockTipocomp, lxAjustockAjnumero, lxAjustockAjcodigo, lxAjustockAjobs, lxAjustockAjfecha, lxAjustockAjfedesde, lxAjustockAjfehasta, lxAjustockAjdhora, lxAjustockAjserie, lxAjustockAjdusuario
				lxAjustockFmodifw = ctod( '  /  /    ' )			lxAjustockFecimpo = ctod( '  /  /    ' )			lxAjustockFectrans = ctod( '  /  /    ' )			lxAjustockFaltafw = ctod( '  /  /    ' )			lxAjustockFecexpo = ctod( '  /  /    ' )			lxAjustockHoraexpo = []			lxAjustockHaltafw = []			lxAjustockHoraimpo = []			lxAjustockUaltafw = []			lxAjustockHmodifw = []			lxAjustockZadsfw = []			lxAjustockDescfw = []			lxAjustockVmodifw = []			lxAjustockValtafw = []			lxAjustockSmodifw = []			lxAjustockUmodifw = []			lxAjustockSaltafw = []			lxAjustockBdmodifw = []			lxAjustockEsttrans = []			lxAjustockBdaltafw = []			lxAjustockTipocomp = 0			lxAjustockAjnumero = 0			lxAjustockAjcodigo = []			lxAjustockAjobs = []			lxAjustockAjfecha = ctod( '  /  /    ' )			lxAjustockAjfedesde = ctod( '  /  /    ' )			lxAjustockAjfehasta = ctod( '  /  /    ' )			lxAjustockAjdhora = []			lxAjustockAjserie = []			lxAjustockAjdusuario = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajustockDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajustockDeta where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajAudiCombDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajAudiArtdet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajuEnTranDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ajAuEnTranDet where "ajdCodigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.AJUSTOCK where "ajCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'AJUSTOCK' + '_' + tcCampo
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
		lcWhere = " Where  AJUSTOCK.AJCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Tipocomp" as "Tipo", "Ajnumero" as "Numero", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha", "Ajfedesde" as "Fechadesde", "Ajfehasta" as "Fechahasta", "Ajdhora" as "Hora", "Ajserie" as "Serie", "Ajdusuario" as "Usuario"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AJUSTOCK', '', tnTope )
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
	Function ObtenerDatosDetallestockafectado( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJUSTOCKDET.AJDCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallestockafectado( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajustockDet', 'stockafectado', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallestockafectado( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallestockafectado( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleStockAfectadoArticulo( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJUSTOCKDETA.AJDCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleStockAfectadoArticulo( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajustockDeta', 'StockAfectadoArticulo', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleStockAfectadoArticulo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleStockAfectadoArticulo( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleStockAfectadoAuditoriaComb( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJAUDICOMBDET.AJDCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleStockAfectadoAuditoriaComb( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajAudiCombDet', 'StockAfectadoAuditoriaComb', tnTope )
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
	Function ObtenerDatosDetalleStockAfectadoAuditoriaArt( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJAUDIARTDET.AJDCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdstock" as "Stockact", "Ajdproy" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleStockAfectadoAuditoriaArt( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajAudiArtdet', 'StockAfectadoAuditoriaArt', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleStockAfectadoAuditoriaArt( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleStockAfectadoAuditoriaArt( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetallestockafectadoEnTransito( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJUENTRANDET.AJDCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallestockafectadoEnTransito( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajuEnTranDet', 'stockafectadoEnTransito', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallestockafectadoEnTransito( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallestockafectadoEnTransito( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleStockAfectadoAuditoriaEnTransito( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJAUENTRANDET.AJDCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Ajdcodigo" as "Codigo", "Ajdart" as "Articulo", "Ajdadesc" as "Articulodetalle", "Ajdcolor" as "Color", "Ajdcdesc" as "Colordetalle", "Ajdtalle" as "Talle", "Ajdstock" as "Stockact", "Ajdstocksi" as "Stockproy", "Ajdcant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleStockAfectadoAuditoriaEnTransito( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ajAuEnTranDet', 'StockAfectadoAuditoriaEnTransito', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleStockAfectadoAuditoriaEnTransito( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleStockAfectadoAuditoriaEnTransito( lcAtributo )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJNUMERO AS NUMERO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJCODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJOBS AS OBS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJFECHA AS FECHA'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJFEDESDE AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJFEHASTA AS FECHAHASTA'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDHORA AS HORA'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJSERIE AS SERIE'
				Case lcAtributo == 'USUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDUSUARIO AS USUARIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetallestockafectado( tcCampos As String ) As String
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
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCODIGO AS CODIGO'
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
	Function ObtenerCamposSelectDetalleStockAfectadoArticulo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDADESC AS ARTICULODETALLE'
				Case lcAtributo == 'STOCKACT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSTOCK AS STOCKACT'
				Case lcAtributo == 'STOCKPROY'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDPROY AS STOCKPROY'
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
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCODIGO AS CODIGO'
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
	Function ObtenerCamposSelectDetalleStockAfectadoAuditoriaArt( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDADESC AS ARTICULODETALLE'
				Case lcAtributo == 'STOCKACT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDSTOCK AS STOCKACT'
				Case lcAtributo == 'STOCKPROY'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDPROY AS STOCKPROY'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCANT AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetallestockafectadoEnTransito( tcCampos As String ) As String
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
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCODIGO AS CODIGO'
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
	Function ObtenerCamposSelectDetalleStockAfectadoAuditoriaEnTransito( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJDCODIGO AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'AJNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'AJOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'AJFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'AJFEDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'AJFEHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'AJDHORA'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'AJSERIE'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIO'
				lcCampo = 'AJDUSUARIO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetallestockafectado( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJDCODIGO'
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
	Function ObtenerCampoDetalleStockAfectadoArticulo( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJDCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'AJDART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'AJDADESC'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKACT'
				lcCampo = 'AJDSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKPROY'
				lcCampo = 'AJDPROY'
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
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJDCODIGO'
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
	Function ObtenerCampoDetalleStockAfectadoAuditoriaArt( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJDCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'AJDART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'AJDADESC'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKACT'
				lcCampo = 'AJDSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'STOCKPROY'
				lcCampo = 'AJDPROY'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'AJDCANT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetallestockafectadoEnTransito( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJDCODIGO'
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
	Function ObtenerCampoDetalleStockAfectadoAuditoriaEnTransito( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'AJDCODIGO'
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
			lcRetorno = 'AJUSTOCKDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'STOCKAFECTADOARTICULO'
			lcRetorno = 'AJUSTOCKDETA'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'STOCKAFECTADOAUDITORIACOMB'
			lcRetorno = 'AJAUDICOMBDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'STOCKAFECTADOAUDITORIAART'
			lcRetorno = 'AJAUDIARTDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'STOCKAFECTADOENTRANSITO'
			lcRetorno = 'AJUENTRANDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'STOCKAFECTADOAUDITORIAENTRANSITO'
			lcRetorno = 'AJAUENTRANDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAjustockFmodifw, lxAjustockFecimpo, lxAjustockFectrans, lxAjustockFaltafw, lxAjustockFecexpo, lxAjustockHoraexpo, lxAjustockHaltafw, lxAjustockHoraimpo, lxAjustockUaltafw, lxAjustockHmodifw, lxAjustockZadsfw, lxAjustockDescfw, lxAjustockVmodifw, lxAjustockValtafw, lxAjustockSmodifw, lxAjustockUmodifw, lxAjustockSaltafw, lxAjustockBdmodifw, lxAjustockEsttrans, lxAjustockBdaltafw, lxAjustockTipocomp, lxAjustockAjnumero, lxAjustockAjcodigo, lxAjustockAjobs, lxAjustockAjfecha, lxAjustockAjfedesde, lxAjustockAjfehasta, lxAjustockAjdhora, lxAjustockAjserie, lxAjustockAjdusuario
				lxAjustockFmodifw =  .Fechamodificacionfw			lxAjustockFecimpo =  .Fechaimpo			lxAjustockFectrans =  .Fechatransferencia			lxAjustockFaltafw =  .Fechaaltafw			lxAjustockFecexpo =  .Fechaexpo			lxAjustockHoraexpo =  .Horaexpo			lxAjustockHaltafw =  .Horaaltafw			lxAjustockHoraimpo =  .Horaimpo			lxAjustockUaltafw =  .Usuarioaltafw			lxAjustockHmodifw =  .Horamodificacionfw			lxAjustockZadsfw =  .Zadsfw			lxAjustockDescfw =  .Descripcionfw			lxAjustockVmodifw =  .Versionmodificacionfw			lxAjustockValtafw =  .Versionaltafw			lxAjustockSmodifw =  .Seriemodificacionfw			lxAjustockUmodifw =  .Usuariomodificacionfw			lxAjustockSaltafw =  .Seriealtafw			lxAjustockBdmodifw =  .Basededatosmodificacionfw			lxAjustockEsttrans =  .Estadotransferencia			lxAjustockBdaltafw =  .Basededatosaltafw			lxAjustockTipocomp =  .Tipo			lxAjustockAjnumero =  .Numero			lxAjustockAjcodigo =  .Codigo			lxAjustockAjobs =  .Obs			lxAjustockAjfecha =  .Fecha			lxAjustockAjfedesde =  .Fechadesde			lxAjustockAjfehasta =  .Fechahasta			lxAjustockAjdhora =  .Hora			lxAjustockAjserie =  .Serie			lxAjustockAjdusuario =  .Usuario
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.AJUSTOCK ( "Fmodifw","Fecimpo","Fectrans","Faltafw","Fecexpo","Horaexpo","Haltafw","Horaimpo","Ualtafw","Hmodifw","Zadsfw","Descfw","Vmodifw","Valtafw","Smodifw","Umodifw","Saltafw","Bdmodifw","Esttrans","Bdaltafw","Tipocomp","Ajnumero","Ajcodigo","Ajobs","Ajfecha","Ajfedesde","Ajfehasta","Ajdhora","Ajserie","Ajdusuario" ) values ( <<"'" + this.ConvertirDateSql( lxAjustockFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockBdaltafw ) + "'" >>, <<lxAjustockTipocomp >>, <<lxAjustockAjnumero >>, <<"'" + this.FormatearTextoSql( lxAjustockAjcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockAjobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockAjfecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockAjfedesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjustockAjfehasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockAjdhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockAjserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjustockAjdusuario ) + "'" >> )
		endtext
		loColeccion.cTabla = 'AJUSTOCK' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.stockafectado
				if this.oEntidad.stockafectado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajustockDet("COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoArticulo
				if this.oEntidad.StockAfectadoArticulo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajustockDeta("NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaComb
				if this.oEntidad.StockAfectadoAuditoriaComb.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAudiCombDet("NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxNroitem>>, <<lxComportamiento>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaArt
				if this.oEntidad.StockAfectadoAuditoriaArt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAudiArtdet("NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.stockafectadoEnTransito
				if this.oEntidad.stockafectadoEnTransito.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajuEnTranDet("COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaEnTransito
				if this.oEntidad.StockAfectadoAuditoriaEnTransito.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAuEnTranDet("NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxNroitem>>, <<lxComportamiento>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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
			local  lxAjustockFmodifw, lxAjustockFecimpo, lxAjustockFectrans, lxAjustockFaltafw, lxAjustockFecexpo, lxAjustockHoraexpo, lxAjustockHaltafw, lxAjustockHoraimpo, lxAjustockUaltafw, lxAjustockHmodifw, lxAjustockZadsfw, lxAjustockDescfw, lxAjustockVmodifw, lxAjustockValtafw, lxAjustockSmodifw, lxAjustockUmodifw, lxAjustockSaltafw, lxAjustockBdmodifw, lxAjustockEsttrans, lxAjustockBdaltafw, lxAjustockTipocomp, lxAjustockAjnumero, lxAjustockAjcodigo, lxAjustockAjobs, lxAjustockAjfecha, lxAjustockAjfedesde, lxAjustockAjfehasta, lxAjustockAjdhora, lxAjustockAjserie, lxAjustockAjdusuario
				lxAjustockFmodifw =  .Fechamodificacionfw			lxAjustockFecimpo =  .Fechaimpo			lxAjustockFectrans =  .Fechatransferencia			lxAjustockFaltafw =  .Fechaaltafw			lxAjustockFecexpo =  .Fechaexpo			lxAjustockHoraexpo =  .Horaexpo			lxAjustockHaltafw =  .Horaaltafw			lxAjustockHoraimpo =  .Horaimpo			lxAjustockUaltafw =  .Usuarioaltafw			lxAjustockHmodifw =  .Horamodificacionfw			lxAjustockZadsfw =  .Zadsfw			lxAjustockDescfw =  .Descripcionfw			lxAjustockVmodifw =  .Versionmodificacionfw			lxAjustockValtafw =  .Versionaltafw			lxAjustockSmodifw =  .Seriemodificacionfw			lxAjustockUmodifw =  .Usuariomodificacionfw			lxAjustockSaltafw =  .Seriealtafw			lxAjustockBdmodifw =  .Basededatosmodificacionfw			lxAjustockEsttrans =  .Estadotransferencia			lxAjustockBdaltafw =  .Basededatosaltafw			lxAjustockTipocomp =  .Tipo			lxAjustockAjnumero =  .Numero			lxAjustockAjcodigo =  .Codigo			lxAjustockAjobs =  .Obs			lxAjustockAjfecha =  .Fecha			lxAjustockAjfedesde =  .Fechadesde			lxAjustockAjfehasta =  .Fechahasta			lxAjustockAjdhora =  .Hora			lxAjustockAjserie =  .Serie			lxAjustockAjdusuario =  .Usuario
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ajcodigo" = ] + lcValorClavePrimariaString  + [ and  AJUSTOCK.AJCODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.AJUSTOCK set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAjustockFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAjustockFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAjustockFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAjustockFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAjustockFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAjustockHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAjustockHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAjustockHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAjustockUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAjustockHmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAjustockZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxAjustockDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAjustockVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAjustockValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAjustockSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAjustockUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAjustockSaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAjustockBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAjustockEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAjustockBdaltafw ) + "'">>, "Tipocomp" = <<lxAjustockTipocomp>>, "Ajnumero" = <<lxAjustockAjnumero>>, "Ajcodigo" = <<"'" + this.FormatearTextoSql( lxAjustockAjcodigo ) + "'">>, "Ajobs" = <<"'" + this.FormatearTextoSql( lxAjustockAjobs ) + "'">>, "Ajfecha" = <<"'" + this.ConvertirDateSql( lxAjustockAjfecha ) + "'">>, "Ajfedesde" = <<"'" + this.ConvertirDateSql( lxAjustockAjfedesde ) + "'">>, "Ajfehasta" = <<"'" + this.ConvertirDateSql( lxAjustockAjfehasta ) + "'">>, "Ajdhora" = <<"'" + this.FormatearTextoSql( lxAjustockAjdhora ) + "'">>, "Ajserie" = <<"'" + this.FormatearTextoSql( lxAjustockAjserie ) + "'">>, "Ajdusuario" = <<"'" + this.FormatearTextoSql( lxAjustockAjdusuario ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'AJUSTOCK' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ajustockDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajustockDeta where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajAudiCombDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajAudiArtdet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajuEnTranDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajAuEnTranDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.stockafectado
				if this.oEntidad.stockafectado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajustockDet("COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoArticulo
				if this.oEntidad.StockAfectadoArticulo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajustockDeta("NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaComb
				if this.oEntidad.StockAfectadoAuditoriaComb.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAudiCombDet("NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxNroitem>>, <<lxComportamiento>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaArt
				if this.oEntidad.StockAfectadoAuditoriaArt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAudiArtdet("NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.stockafectadoEnTransito
				if this.oEntidad.stockafectadoEnTransito.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajuEnTranDet("COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.StockAfectadoAuditoriaEnTransito
				if this.oEntidad.StockAfectadoAuditoriaEnTransito.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxStockact = loItem.Stockact
					lxStockproy = loItem.Stockproy
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ajAuEnTranDet("NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant" ) values ( <<lxNroitem>>, <<lxComportamiento>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxStockact>>, <<lxStockproy>>, <<lxCantidad>> ) 
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

			lcFiltro = ["Ajcodigo" = ] + lcValorClavePrimariaString  + [ and  AJUSTOCK.AJCODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.AJUSTOCK where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ajustockDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajustockDeta where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajAudiCombDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajAudiArtdet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajuEnTranDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ajAuEnTranDet where "ajdCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'AJUSTOCK' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.AJUSTOCK where  AJUSTOCK.AJCODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.AJUSTOCK where ajCodigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  AJUSTOCK.AJCODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDESTOCK'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.AJUSTOCK Where ajCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ajCodigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.AJUSTOCK set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, tipocomp = ] + transform( &lcCursor..tipocomp )+ [, ajnumero = ] + transform( &lcCursor..ajnumero )+ [, ajCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ajCodigo ) + "'"+ [, ajObs = ] + "'" + this.FormatearTextoSql( &lcCursor..ajObs ) + "'"+ [, ajfecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ajfecha ) + "'"+ [, ajfedesde = ] + "'" + this.ConvertirDateSql( &lcCursor..ajfedesde ) + "'"+ [, ajfehasta = ] + "'" + this.ConvertirDateSql( &lcCursor..ajfehasta ) + "'"+ [, ajdHora = ] + "'" + this.FormatearTextoSql( &lcCursor..ajdHora ) + "'"+ [, ajSerie = ] + "'" + this.FormatearTextoSql( &lcCursor..ajSerie ) + "'"+ [, ajdUsuario = ] + "'" + this.FormatearTextoSql( &lcCursor..ajdUsuario ) + "'" + [ Where ajCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ajCodigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECIMPO, FECTRANS, FALTAFW, FECEXPO, HORAEXPO, HALTAFW, HORAIMPO, UALTAFW, HMODIFW, ZADSFW, DescFW, VMODIFW, VALTAFW, SMODIFW, UMODIFW, SALTAFW, BDMODIFW, ESTTRANS, BDALTAFW, tipocomp, ajnumero, ajCodigo, ajObs, ajfecha, ajfedesde, ajfehasta, ajdHora, ajSerie, ajdUsuario
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + transform( &lcCursor..tipocomp )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ajnumero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ajCodigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ajObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ajfecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ajfedesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ajfehasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ajdHora ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ajSerie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ajdUsuario ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.AJUSTOCK ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDESTOCK'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajustockDet Where ajdCodigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajustockDeta Where ajdCodigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajAudiCombDet Where ajdCodigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajAudiArtdet Where ajdCodigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajuEnTranDet Where ajdCodigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ajAuEnTranDet Where ajdCodigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJUSTEDESTOCK'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajdCodigo in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajustockDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCodigo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdart     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTalle   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdstocksi ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJSTOCKART'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajdCodigo in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajustockDeta ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCodigo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdArt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdProy    ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJAUDICOMBINACION'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajdCodigo in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajAudiCombDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCodigo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdart     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTalle   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdstocksi ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJAUDIARTICULOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajdCodigo in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","ajdCodigo","ajdArt","ajdADesc","ajdstock","ajdProy","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajAudiArtdet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCodigo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdArt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdProy    ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJUSTOCKENTRANSITO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajdCodigo in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"COMP","NROITEM","ProcStock","Equiv","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajuEnTranDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCodigo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdart     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTalle   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdstocksi ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJAUDIENTRANSITO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where ajdCodigo in ( select ajCodigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","COMP","ajdCodigo","ajdart","ajdADesc","ajdColor","ajdCDesc","ajdTalle","ajdstock","ajdstocksi","ajdCant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ajAuEnTranDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCodigo  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdart     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdADesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdCDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ajdTalle   ) + "'" + ',' + transform( cDetallesExistentes.ajdstock   ) + ',' + transform( cDetallesExistentes.ajdstocksi ) + ',' + transform( cDetallesExistentes.ajdCant    ) + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'AJUSTEDESTOCK'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AJUSTEDESTOCK_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AJUSTEDESTOCK_AJOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJUSTEDESTOCK'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJSTOCKART'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJAUDICOMBINACION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJAUDIARTICULOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJUSTOCKENTRANSITO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJAUDIENTRANSITO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ajustock')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'AJUSTEDESTOCK'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ajCodigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad AJUSTEDESTOCK. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDESTOCK'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDESTOCK'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  ajfecha   
		* Validar ANTERIORES A 1/1/1753  ajfedesde 
		* Validar ANTERIORES A 1/1/1753  ajfehasta 
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ajustock') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ajustock
Create Table ZooLogic.TablaTrabajo_ajustock ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"tipocomp" numeric( 1, 0 )  null, 
"ajnumero" numeric( 10, 0 )  null, 
"ajcodigo" char( 38 )  null, 
"ajobs" varchar(max)  null, 
"ajfecha" datetime  null, 
"ajfedesde" datetime  null, 
"ajfehasta" datetime  null, 
"ajdhora" char( 8 )  null, 
"ajserie" char( 7 )  null, 
"ajdusuario" char( 100 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ajustock' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ajustock' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTEDESTOCK'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('ajnumero','ajnumero')
			.AgregarMapeo('ajcodigo','ajcodigo')
			.AgregarMapeo('ajobs','ajobs')
			.AgregarMapeo('ajfecha','ajfecha')
			.AgregarMapeo('ajfedesde','ajfedesde')
			.AgregarMapeo('ajfehasta','ajfehasta')
			.AgregarMapeo('ajdhora','ajdhora')
			.AgregarMapeo('ajserie','ajserie')
			.AgregarMapeo('ajdusuario','ajdusuario')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ajustock'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.AJNUMERO = isnull( d.AJNUMERO, t.AJNUMERO ),t.AJCODIGO = isnull( d.AJCODIGO, t.AJCODIGO ),t.AJOBS = isnull( d.AJOBS, t.AJOBS ),t.AJFECHA = isnull( d.AJFECHA, t.AJFECHA ),t.AJFEDESDE = isnull( d.AJFEDESDE, t.AJFEDESDE ),t.AJFEHASTA = isnull( d.AJFEHASTA, t.AJFEHASTA ),t.AJDHORA = isnull( d.AJDHORA, t.AJDHORA ),t.AJSERIE = isnull( d.AJSERIE, t.AJSERIE ),t.AJDUSUARIO = isnull( d.AJDUSUARIO, t.AJDUSUARIO )
					from ZooLogic.AJUSTOCK t inner join deleted d 
							 on t.ajCodigo = d.ajCodigo
				-- Fin Updates
				insert into ZooLogic.AJUSTOCK(Fmodifw,Fecimpo,Fectrans,Faltafw,Fecexpo,Horaexpo,Haltafw,Horaimpo,Ualtafw,Hmodifw,Zadsfw,Descfw,Vmodifw,Valtafw,Smodifw,Umodifw,Saltafw,Bdmodifw,Esttrans,Bdaltafw,Tipocomp,Ajnumero,Ajcodigo,Ajobs,Ajfecha,Ajfedesde,Ajfehasta,Ajdhora,Ajserie,Ajdusuario)
					Select isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.TIPOCOMP,0),isnull( d.AJNUMERO,0),isnull( d.AJCODIGO,''),isnull( d.AJOBS,''),isnull( d.AJFECHA,''),isnull( d.AJFEDESDE,''),isnull( d.AJFEHASTA,''),isnull( d.AJDHORA,''),isnull( d.AJSERIE,''),isnull( d.AJDUSUARIO,'')
						From deleted d left join ZooLogic.AJUSTOCK pk 
							 on d.ajCodigo = pk.ajCodigo
						Where pk.ajCodigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajustockDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUSTOCK_ajustockDet
ON ZooLogic.TablaTrabajo_AJUSTOCK_ajustockDet
AFTER DELETE
As
Begin
Update t Set 
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.AJDCODIGO = isnull( d.AJDCODIGO, t.AJDCODIGO ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDCOLOR = isnull( d.AJDCOLOR, t.AJDCOLOR ),
t.AJDCDESC = isnull( d.AJDCDESC, t.AJDCDESC ),
t.AJDTALLE = isnull( d.AJDTALLE, t.AJDTALLE ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDSTOCKSI = isnull( d.AJDSTOCKSI, t.AJDSTOCKSI ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajustockDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajustockDet
( 
"COMP",
"NROITEM",
"PROCSTOCK",
"EQUIV",
"AJDCODIGO",
"AJDART",
"AJDADESC",
"AJDCOLOR",
"AJDCDESC",
"AJDTALLE",
"AJDSTOCK",
"AJDSTOCKSI",
"AJDCANT"
 )
Select 
d.COMP,
d.NROITEM,
d.PROCSTOCK,
d.EQUIV,
d.AJDCODIGO,
d.AJDART,
d.AJDADESC,
d.AJDCOLOR,
d.AJDCDESC,
d.AJDTALLE,
d.AJDSTOCK,
d.AJDSTOCKSI,
d.AJDCANT
From deleted d left join ZooLogic.ajustockDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajustockDeta( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUSTOCK_ajustockDeta
ON ZooLogic.TablaTrabajo_AJUSTOCK_ajustockDeta
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.AJDCODIGO = isnull( d.AJDCODIGO, t.AJDCODIGO ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDPROY = isnull( d.AJDPROY, t.AJDPROY ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajustockDeta t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajustockDeta
( 
"NROITEM",
"AJDCODIGO",
"AJDART",
"AJDADESC",
"AJDSTOCK",
"AJDPROY",
"AJDCANT"
 )
Select 
d.NROITEM,
d.AJDCODIGO,
d.AJDART,
d.AJDADESC,
d.AJDSTOCK,
d.AJDPROY,
d.AJDCANT
From deleted d left join ZooLogic.ajustockDeta pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajAudiCombDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUSTOCK_ajAudiCombDet
ON ZooLogic.TablaTrabajo_AJUSTOCK_ajAudiCombDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.AJDCODIGO = isnull( d.AJDCODIGO, t.AJDCODIGO ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDCOLOR = isnull( d.AJDCOLOR, t.AJDCOLOR ),
t.AJDCDESC = isnull( d.AJDCDESC, t.AJDCDESC ),
t.AJDTALLE = isnull( d.AJDTALLE, t.AJDTALLE ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDSTOCKSI = isnull( d.AJDSTOCKSI, t.AJDSTOCKSI ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajAudiCombDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajAudiCombDet
( 
"NROITEM",
"COMP",
"AJDCODIGO",
"AJDART",
"AJDADESC",
"AJDCOLOR",
"AJDCDESC",
"AJDTALLE",
"AJDSTOCK",
"AJDSTOCKSI",
"AJDCANT"
 )
Select 
d.NROITEM,
d.COMP,
d.AJDCODIGO,
d.AJDART,
d.AJDADESC,
d.AJDCOLOR,
d.AJDCDESC,
d.AJDTALLE,
d.AJDSTOCK,
d.AJDSTOCKSI,
d.AJDCANT
From deleted d left join ZooLogic.ajAudiCombDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajAudiArtdet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUSTOCK_ajAudiArtdet
ON ZooLogic.TablaTrabajo_AJUSTOCK_ajAudiArtdet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.AJDCODIGO = isnull( d.AJDCODIGO, t.AJDCODIGO ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDPROY = isnull( d.AJDPROY, t.AJDPROY ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajAudiArtdet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajAudiArtdet
( 
"NROITEM",
"AJDCODIGO",
"AJDART",
"AJDADESC",
"AJDSTOCK",
"AJDPROY",
"AJDCANT"
 )
Select 
d.NROITEM,
d.AJDCODIGO,
d.AJDART,
d.AJDADESC,
d.AJDSTOCK,
d.AJDPROY,
d.AJDCANT
From deleted d left join ZooLogic.ajAudiArtdet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajuEnTranDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUSTOCK_ajuEnTranDet
ON ZooLogic.TablaTrabajo_AJUSTOCK_ajuEnTranDet
AFTER DELETE
As
Begin
Update t Set 
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.AJDCODIGO = isnull( d.AJDCODIGO, t.AJDCODIGO ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDCOLOR = isnull( d.AJDCOLOR, t.AJDCOLOR ),
t.AJDCDESC = isnull( d.AJDCDESC, t.AJDCDESC ),
t.AJDTALLE = isnull( d.AJDTALLE, t.AJDTALLE ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDSTOCKSI = isnull( d.AJDSTOCKSI, t.AJDSTOCKSI ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajuEnTranDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajuEnTranDet
( 
"COMP",
"NROITEM",
"PROCSTOCK",
"EQUIV",
"AJDCODIGO",
"AJDART",
"AJDADESC",
"AJDCOLOR",
"AJDCDESC",
"AJDTALLE",
"AJDSTOCK",
"AJDSTOCKSI",
"AJDCANT"
 )
Select 
d.COMP,
d.NROITEM,
d.PROCSTOCK,
d.EQUIV,
d.AJDCODIGO,
d.AJDART,
d.AJDADESC,
d.AJDCOLOR,
d.AJDCDESC,
d.AJDTALLE,
d.AJDSTOCK,
d.AJDSTOCKSI,
d.AJDCANT
From deleted d left join ZooLogic.ajuEnTranDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ajAuEnTranDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUSTOCK_ajAuEnTranDet
ON ZooLogic.TablaTrabajo_AJUSTOCK_ajAuEnTranDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.AJDCODIGO = isnull( d.AJDCODIGO, t.AJDCODIGO ),
t.AJDART = isnull( d.AJDART, t.AJDART ),
t.AJDADESC = isnull( d.AJDADESC, t.AJDADESC ),
t.AJDCOLOR = isnull( d.AJDCOLOR, t.AJDCOLOR ),
t.AJDCDESC = isnull( d.AJDCDESC, t.AJDCDESC ),
t.AJDTALLE = isnull( d.AJDTALLE, t.AJDTALLE ),
t.AJDSTOCK = isnull( d.AJDSTOCK, t.AJDSTOCK ),
t.AJDSTOCKSI = isnull( d.AJDSTOCKSI, t.AJDSTOCKSI ),
t.AJDCANT = isnull( d.AJDCANT, t.AJDCANT )
from ZooLogic.ajAuEnTranDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ajAuEnTranDet
( 
"NROITEM",
"COMP",
"AJDCODIGO",
"AJDART",
"AJDADESC",
"AJDCOLOR",
"AJDCDESC",
"AJDTALLE",
"AJDSTOCK",
"AJDSTOCKSI",
"AJDCANT"
 )
Select 
d.NROITEM,
d.COMP,
d.AJDCODIGO,
d.AJDART,
d.AJDADESC,
d.AJDCOLOR,
d.AJDCDESC,
d.AJDTALLE,
d.AJDSTOCK,
d.AJDSTOCKSI,
d.AJDCANT
From deleted d left join ZooLogic.ajAuEnTranDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ajustock') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ajustock
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_AJUSTEDESTOCK' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDESTOCK.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDESTOCK.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDESTOCK.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDESTOCK.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDESTOCK.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Stockafectado.Limpiar()
					.Stockafectado.SetearEsNavegacion( .lProcesando )
					.Stockafectado.Cargar()
					.Horaexpo = nvl( c_AJUSTEDESTOCK.Horaexpo, [] )
					.Horaaltafw = nvl( c_AJUSTEDESTOCK.Horaaltafw, [] )
					.Horaimpo = nvl( c_AJUSTEDESTOCK.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_AJUSTEDESTOCK.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_AJUSTEDESTOCK.Horamodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_AJUSTEDESTOCK.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_AJUSTEDESTOCK.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_AJUSTEDESTOCK.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_AJUSTEDESTOCK.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_AJUSTEDESTOCK.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_AJUSTEDESTOCK.Seriealtafw, [] )
					.Basededatosmodificacionfw = nvl( c_AJUSTEDESTOCK.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_AJUSTEDESTOCK.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_AJUSTEDESTOCK.Basededatosaltafw, [] )
					.Tipo = nvl( c_AJUSTEDESTOCK.Tipo, 0 )
					.Numero = nvl( c_AJUSTEDESTOCK.Numero, 0 )
					.Stockafectadoarticulo.Limpiar()
					.Stockafectadoarticulo.SetearEsNavegacion( .lProcesando )
					.Stockafectadoarticulo.Cargar()
					.Stockafectadoauditoriacomb.Limpiar()
					.Stockafectadoauditoriacomb.SetearEsNavegacion( .lProcesando )
					.Stockafectadoauditoriacomb.Cargar()
					.Stockafectadoauditoriaart.Limpiar()
					.Stockafectadoauditoriaart.SetearEsNavegacion( .lProcesando )
					.Stockafectadoauditoriaart.Cargar()
					.Codigo = nvl( c_AJUSTEDESTOCK.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Stockafectadoentransito.Limpiar()
					.Stockafectadoentransito.SetearEsNavegacion( .lProcesando )
					.Stockafectadoentransito.Cargar()
					.Stockafectadoauditoriaentransito.Limpiar()
					.Stockafectadoauditoriaentransito.SetearEsNavegacion( .lProcesando )
					.Stockafectadoauditoriaentransito.Cargar()
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDESTOCK.Fecha, ctod( '  /  /    ' ) ) )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDESTOCK.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTEDESTOCK.Fechahasta, ctod( '  /  /    ' ) ) )
					.Hora = nvl( c_AJUSTEDESTOCK.Hora, [] )
					.Serie = nvl( c_AJUSTEDESTOCK.Serie, [] )
					.Usuario = nvl( c_AJUSTEDESTOCK.Usuario, [] )
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
		
		loDetalle = this.oEntidad.stockafectado
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

		loDetalle = this.oEntidad.StockAfectadoArticulo
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

		loDetalle = this.oEntidad.StockAfectadoAuditoriaArt
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

		loDetalle = this.oEntidad.stockafectadoEnTransito
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

		loDetalle = this.oEntidad.StockAfectadoAuditoriaEnTransito
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
		return c_AJUSTEDESTOCK.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.AJUSTOCK' )
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
								from ZooLogic.AJUSTOCK 
								Where   AJUSTOCK.AJCODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "AJUSTOCK", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Tipocomp" as "Tipo", "Ajnumero" as "Numero", "Ajcodigo" as "Codigo", "Ajobs" as "Obs", "Ajfecha" as "Fecha", "Ajfedesde" as "Fechadesde", "Ajfehasta" as "Fechahasta", "Ajdhora" as "Hora", "Ajserie" as "Serie", "Ajdusuario" as "Usuario"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.AJUSTOCK 
								Where   AJUSTOCK.AJCODIGO != ''
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
	Tabla = 'AJUSTOCK'
	Filtro = " AJUSTOCK.AJCODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " AJUSTOCK.AJCODIGO != ''"
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
	<row entidad="AJUSTEDESTOCK                           " atributo="FECHAMODIFICACIONFW                     " tabla="AJUSTOCK       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="FECHAIMPO                               " tabla="AJUSTOCK       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="FECHATRANSFERENCIA                      " tabla="AJUSTOCK       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="FECHAALTAFW                             " tabla="AJUSTOCK       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="FECHAEXPO                               " tabla="AJUSTOCK       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="STOCKAFECTADO                           " tabla="AJUSTOCKDET    " campo="AJDCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Detalle combinaciones                                                                                                                                           " dominio="DETALLEITEMAJUSTEDESTOCK      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="HORAEXPO                                " tabla="AJUSTOCK       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="HORAALTAFW                              " tabla="AJUSTOCK       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="HORAIMPO                                " tabla="AJUSTOCK       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="USUARIOALTAFW                           " tabla="AJUSTOCK       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="HORAMODIFICACIONFW                      " tabla="AJUSTOCK       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="ZADSFW                                  " tabla="AJUSTOCK       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="DESCRIPCIONFW                           " tabla="AJUSTOCK       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="VERSIONMODIFICACIONFW                   " tabla="AJUSTOCK       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="VERSIONALTAFW                           " tabla="AJUSTOCK       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="SERIEMODIFICACIONFW                     " tabla="AJUSTOCK       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="USUARIOMODIFICACIONFW                   " tabla="AJUSTOCK       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="SERIEALTAFW                             " tabla="AJUSTOCK       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="AJUSTOCK       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="ESTADOTRANSFERENCIA                     " tabla="AJUSTOCK       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="BASEDEDATOSALTAFW                       " tabla="AJUSTOCK       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="TIPO                                    " tabla="AJUSTOCK       " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="NUMERO                                  " tabla="AJUSTOCK       " campo="AJNUMERO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="STOCKAFECTADOARTICULO                   " tabla="AJUSTOCKDETA   " campo="AJDCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMAJSTOCKART         " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="STOCKAFECTADOAUDITORIACOMB              " tabla="AJAUDICOMBDET  " campo="AJDCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Detalle auditoría                                                                                                                                               " dominio="DETALLEITEMAJAUDICOMBINACION  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="STOCKAFECTADOAUDITORIAART               " tabla="AJAUDIARTDET   " campo="AJDCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMAJAUDIARTICULOS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="CODIGO                                  " tabla="AJUSTOCK       " campo="AJCODIGO  " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="OBS                                     " tabla="AJUSTOCK       " campo="AJOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="STOCKAFECTADOENTRANSITO                 " tabla="AJUENTRANDET   " campo="AJDCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Detalle en tránsito                                                                                                                                             " dominio="DETALLEITEMAJUSTOCKENTRANSITO " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="STOCKAFECTADOAUDITORIAENTRANSITO        " tabla="AJAUENTRANDET  " campo="AJDCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Detalle auditoría en tránsito                                                                                                                                   " dominio="DETALLEITEMAJAUDIENTRANSITO   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="6" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="FECHA                                   " tabla="AJUSTOCK       " campo="AJFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="205" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="FECHADESDE                              " tabla="AJUSTOCK       " campo="AJFEDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=Iif( goServicios.librerias.ObtenerFecha() &lt; goParametros.Felino.GestionDeVentas.MovMer.FechaUltimaTomaDeInventario, goServicios.librerias.ObtenerFecha(), goParametros.Felino.GestionDeVentas.MovMer.FechaUltimaTomaDeInventario)                            " obligatorio="false" admitebusqueda="206" etiqueta="Desde                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="FECHAHASTA                              " tabla="AJUSTOCK       " campo="AJFEHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="207" etiqueta="Hasta                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="HORA                                    " tabla="AJUSTOCK       " campo="AJDHORA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="208" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="SERIE                                   " tabla="AJUSTOCK       " campo="AJSERIE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="=_Screen.Zoo.App.cSerie                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="209" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTEDESTOCK                           " atributo="USUARIO                                 " tabla="AJUSTOCK       " campo="AJDUSUARIO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="210" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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