
define class Din_EntidadBOLSASYCAJASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_BOLSASYCAJAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.NUMERO, 8, 0)]
	cTagClaveCandidata = '_BYCCC'
	cTagClavePk = '_BYCPK'
	cTablaPrincipal = 'BOLYCAJ'
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
			local  lxBolycajFechaori, lxBolycajFaltafw, lxBolycajFecexpo, lxBolycajFecimpo, lxBolycajFmodifw, lxBolycajFectrans, lxBolycajVmodifw, lxBolycajValtafw, lxBolycajDescfw, lxBolycajZadsfw, lxBolycajUmodifw, lxBolycajHmodifw, lxBolycajSmodifw, lxBolycajUaltafw, lxBolycajSaltafw, lxBolycajHoraimpo, lxBolycajHoraexpo, lxBolycajEsttrans, lxBolycajDescrip, lxBolycajHaltafw, lxBolycajBdmodifw, lxBolycajBdaltafw, lxBolycajTimestamp, lxBolycajAnulado, lxBolycajCodigo, lxBolycajMobs, lxBolycajNumero, lxBolycajNumeroori, lxBolycajFecha, lxBolycajMotivo, lxBolycajVendedor, lxBolycajOrigtipo, lxBolycajOrigletra, lxBolycajOrigpvta, lxBolycajOrignro
				lxBolycajFechaori =  .Fechaoriginal			lxBolycajFaltafw =  .Fechaaltafw			lxBolycajFecexpo =  .Fechaexpo			lxBolycajFecimpo =  .Fechaimpo			lxBolycajFmodifw =  .Fechamodificacionfw			lxBolycajFectrans =  .Fechatransferencia			lxBolycajVmodifw =  .Versionmodificacionfw			lxBolycajValtafw =  .Versionaltafw			lxBolycajDescfw =  .Descripcionfw			lxBolycajZadsfw =  .Zadsfw			lxBolycajUmodifw =  .Usuariomodificacionfw			lxBolycajHmodifw =  .Horamodificacionfw			lxBolycajSmodifw =  .Seriemodificacionfw			lxBolycajUaltafw =  .Usuarioaltafw			lxBolycajSaltafw =  .Seriealtafw			lxBolycajHoraimpo =  .Horaimpo			lxBolycajHoraexpo =  .Horaexpo			lxBolycajEsttrans =  .Estadotransferencia			lxBolycajDescrip =  .Descripcion			lxBolycajHaltafw =  .Horaaltafw			lxBolycajBdmodifw =  .Basededatosmodificacionfw			lxBolycajBdaltafw =  .Basededatosaltafw			lxBolycajTimestamp = goLibrerias.ObtenerTimestamp()			lxBolycajAnulado =  .Anulado			lxBolycajCodigo =  .Codigo			lxBolycajMobs =  .Observacion			lxBolycajNumero =  .Numero			lxBolycajNumeroori =  .Numerooriginal			lxBolycajFecha =  .Fecha			lxBolycajMotivo =  upper( .Motivo_PK ) 			lxBolycajVendedor =  upper( .vendedor_PK ) 			lxBolycajOrigtipo =  .Origtipo			lxBolycajOrigletra =  .Origletra			lxBolycajOrigpvta =  .Origptovta			lxBolycajOrignro =  .Orignumero
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxBolycajCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.BOLYCAJ ( "Fechaori","Faltafw","Fecexpo","Fecimpo","Fmodifw","Fectrans","Vmodifw","Valtafw","Descfw","Zadsfw","Umodifw","Hmodifw","Smodifw","Ualtafw","Saltafw","Horaimpo","Horaexpo","Esttrans","Descrip","Haltafw","Bdmodifw","Bdaltafw","Timestamp","Anulado","Codigo","Mobs","Numero","Numeroori","Fecha","Motivo","Vendedor","Origtipo","Origletra","Origpvta","Orignro" ) values ( <<"'" + this.ConvertirDateSql( lxBolycajFechaori ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajBdaltafw ) + "'" >>, <<lxBolycajTimestamp >>, <<iif( lxBolycajAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxBolycajCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajMobs ) + "'" >>, <<lxBolycajNumero >>, <<lxBolycajNumeroori >>, <<"'" + this.ConvertirDateSql( lxBolycajFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajVendedor ) + "'" >>, <<lxBolycajOrigtipo >>, <<"'" + this.FormatearTextoSql( lxBolycajOrigletra ) + "'" >>, <<lxBolycajOrigpvta >>, <<lxBolycajOrignro >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MovimientoDetalle
				if this.oEntidad.MovimientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETBOLYCAJ("COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","ColTXT","TallTXT","Talle","CANTI" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
		this.oEntidad.Timestamp = lxBolycajTimestamp
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
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxBolycajFechaori, lxBolycajFaltafw, lxBolycajFecexpo, lxBolycajFecimpo, lxBolycajFmodifw, lxBolycajFectrans, lxBolycajVmodifw, lxBolycajValtafw, lxBolycajDescfw, lxBolycajZadsfw, lxBolycajUmodifw, lxBolycajHmodifw, lxBolycajSmodifw, lxBolycajUaltafw, lxBolycajSaltafw, lxBolycajHoraimpo, lxBolycajHoraexpo, lxBolycajEsttrans, lxBolycajDescrip, lxBolycajHaltafw, lxBolycajBdmodifw, lxBolycajBdaltafw, lxBolycajTimestamp, lxBolycajAnulado, lxBolycajCodigo, lxBolycajMobs, lxBolycajNumero, lxBolycajNumeroori, lxBolycajFecha, lxBolycajMotivo, lxBolycajVendedor, lxBolycajOrigtipo, lxBolycajOrigletra, lxBolycajOrigpvta, lxBolycajOrignro
				lxBolycajFechaori =  .Fechaoriginal			lxBolycajFaltafw =  .Fechaaltafw			lxBolycajFecexpo =  .Fechaexpo			lxBolycajFecimpo =  .Fechaimpo			lxBolycajFmodifw =  .Fechamodificacionfw			lxBolycajFectrans =  .Fechatransferencia			lxBolycajVmodifw =  .Versionmodificacionfw			lxBolycajValtafw =  .Versionaltafw			lxBolycajDescfw =  .Descripcionfw			lxBolycajZadsfw =  .Zadsfw			lxBolycajUmodifw =  .Usuariomodificacionfw			lxBolycajHmodifw =  .Horamodificacionfw			lxBolycajSmodifw =  .Seriemodificacionfw			lxBolycajUaltafw =  .Usuarioaltafw			lxBolycajSaltafw =  .Seriealtafw			lxBolycajHoraimpo =  .Horaimpo			lxBolycajHoraexpo =  .Horaexpo			lxBolycajEsttrans =  .Estadotransferencia			lxBolycajDescrip =  .Descripcion			lxBolycajHaltafw =  .Horaaltafw			lxBolycajBdmodifw =  .Basededatosmodificacionfw			lxBolycajBdaltafw =  .Basededatosaltafw			lxBolycajTimestamp = goLibrerias.ObtenerTimestamp()			lxBolycajAnulado =  .Anulado			lxBolycajCodigo =  .Codigo			lxBolycajMobs =  .Observacion			lxBolycajNumero =  .Numero			lxBolycajNumeroori =  .Numerooriginal			lxBolycajFecha =  .Fecha			lxBolycajMotivo =  upper( .Motivo_PK ) 			lxBolycajVendedor =  upper( .vendedor_PK ) 			lxBolycajOrigtipo =  .Origtipo			lxBolycajOrigletra =  .Origletra			lxBolycajOrigpvta =  .Origptovta			lxBolycajOrignro =  .Orignumero
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
				update ZooLogic.BOLYCAJ set "Fechaori" = <<"'" + this.ConvertirDateSql( lxBolycajFechaori ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxBolycajFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxBolycajFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxBolycajFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxBolycajFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxBolycajFectrans ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxBolycajVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxBolycajValtafw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxBolycajDescfw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxBolycajZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxBolycajUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxBolycajHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxBolycajSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxBolycajUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxBolycajSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxBolycajHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxBolycajHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxBolycajEsttrans ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxBolycajDescrip ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxBolycajHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxBolycajBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxBolycajBdaltafw ) + "'">>,"Timestamp" = <<lxBolycajTimestamp>>,"Anulado" = <<iif( lxBolycajAnulado, 1, 0 )>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxBolycajCodigo ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxBolycajMobs ) + "'">>,"Numero" = <<lxBolycajNumero>>,"Numeroori" = <<lxBolycajNumeroori>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxBolycajFecha ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxBolycajMotivo ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxBolycajVendedor ) + "'">>,"Origtipo" = <<lxBolycajOrigtipo>>,"Origletra" = <<"'" + this.FormatearTextoSql( lxBolycajOrigletra ) + "'">>,"Origpvta" = <<lxBolycajOrigpvta>>,"Orignro" = <<lxBolycajOrignro>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxBolycajCodigo ) + "'">> and  BOLYCAJ.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETBOLYCAJ where "NUMR" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MovimientoDetalle
				if this.oEntidad.MovimientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETBOLYCAJ("COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","ColTXT","TallTXT","Talle","CANTI" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
		this.oEntidad.Timestamp = lxBolycajTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.BOLYCAJ where " + this.ConvertirFuncionesSql( " BOLYCAJ.CODIGO != ''" ) )
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
			Local lxBolycajCodigo
			lxBolycajCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechaori" as "Fechaoriginal", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Descrip" as "Descripcion", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Origletra" as "Origletra", "Origpvta" as "Origptovta", "Orignro" as "Orignumero" from ZooLogic.BOLYCAJ where "Codigo" = <<"'" + this.FormatearTextoSql( lxBolycajCodigo ) + "'">> and  BOLYCAJ.CODIGO != ''
			endtext
			use in select('c_BOLSASYCAJAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BOLSASYCAJAS', set( 'Datasession' ) )

			if reccount( 'c_BOLSASYCAJAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad" from ZooLogic.DETBOLYCAJ where NUMR = <<"'" + this.FormatearTextoSql( c_BOLSASYCAJAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxBOLYCAJNUMERO As Variant
			lxBOLYCAJNUMERO = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechaori" as "Fechaoriginal", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Descrip" as "Descripcion", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Origletra" as "Origletra", "Origpvta" as "Origptovta", "Orignro" as "Orignumero" from ZooLogic.BOLYCAJ where  BOLYCAJ.CODIGO != '' And NUMERO = <<lxBOLYCAJNUMERO>>
			endtext
			use in select('c_BOLSASYCAJAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BOLSASYCAJAS', set( 'Datasession' ) )
			if reccount( 'c_BOLSASYCAJAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad" from ZooLogic.DETBOLYCAJ where NUMR = <<"'" + this.FormatearTextoSql( c_BOLSASYCAJAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxBolycajCodigo as Variant
		llRetorno = .t.
		lxBolycajCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.BOLYCAJ where "Codigo" = <<"'" + this.FormatearTextoSql( lxBolycajCodigo ) + "'">> and  BOLYCAJ.CODIGO != ''
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fechaori" as "Fechaoriginal", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Descrip" as "Descripcion", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Origletra" as "Origletra", "Origpvta" as "Origptovta", "Orignro" as "Orignumero" from ZooLogic.BOLYCAJ where  BOLYCAJ.CODIGO != '' order by NUMERO
			endtext
			use in select('c_BOLSASYCAJAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BOLSASYCAJAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad" from ZooLogic.DETBOLYCAJ where NUMR = <<"'" + this.FormatearTextoSql( c_BOLSASYCAJAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fechaori" as "Fechaoriginal", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Descrip" as "Descripcion", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Origletra" as "Origletra", "Origpvta" as "Origptovta", "Orignro" as "Orignumero" from ZooLogic.BOLYCAJ where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  BOLYCAJ.CODIGO != '' order by NUMERO
			endtext
			use in select('c_BOLSASYCAJAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BOLSASYCAJAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad" from ZooLogic.DETBOLYCAJ where NUMR = <<"'" + this.FormatearTextoSql( c_BOLSASYCAJAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fechaori" as "Fechaoriginal", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Descrip" as "Descripcion", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Origletra" as "Origletra", "Origpvta" as "Origptovta", "Orignro" as "Orignumero" from ZooLogic.BOLYCAJ where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  BOLYCAJ.CODIGO != '' order by NUMERO desc
			endtext
			use in select('c_BOLSASYCAJAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BOLSASYCAJAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad" from ZooLogic.DETBOLYCAJ where NUMR = <<"'" + this.FormatearTextoSql( c_BOLSASYCAJAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fechaori" as "Fechaoriginal", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Descrip" as "Descripcion", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Origletra" as "Origletra", "Origpvta" as "Origptovta", "Orignro" as "Orignumero" from ZooLogic.BOLYCAJ where  BOLYCAJ.CODIGO != '' order by NUMERO desc
			endtext
			use in select('c_BOLSASYCAJAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BOLSASYCAJAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad" from ZooLogic.DETBOLYCAJ where NUMR = <<"'" + this.FormatearTextoSql( c_BOLSASYCAJAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fechaori,Faltafw,Fecexpo,Fecimpo,Fmodifw,Fectrans,Vmodifw,Valtafw,Descfw,Zadsfw,Umodifw,Hmod" + ;
"ifw,Smodifw,Ualtafw,Saltafw,Horaimpo,Horaexpo,Esttrans,Descrip,Haltafw,Bdmodifw,Bdaltafw,Timestamp,A" + ;
"nulado,Codigo,Mobs,Numero,Numeroori,Fecha,Motivo,Vendedor,Origtipo,Origletra,Origpvta,Orignro" + ;
" from ZooLogic.BOLYCAJ where  BOLYCAJ.CODIGO != '' and " + lcFiltro )
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
			local  lxBolycajFechaori, lxBolycajFaltafw, lxBolycajFecexpo, lxBolycajFecimpo, lxBolycajFmodifw, lxBolycajFectrans, lxBolycajVmodifw, lxBolycajValtafw, lxBolycajDescfw, lxBolycajZadsfw, lxBolycajUmodifw, lxBolycajHmodifw, lxBolycajSmodifw, lxBolycajUaltafw, lxBolycajSaltafw, lxBolycajHoraimpo, lxBolycajHoraexpo, lxBolycajEsttrans, lxBolycajDescrip, lxBolycajHaltafw, lxBolycajBdmodifw, lxBolycajBdaltafw, lxBolycajTimestamp, lxBolycajAnulado, lxBolycajCodigo, lxBolycajMobs, lxBolycajNumero, lxBolycajNumeroori, lxBolycajFecha, lxBolycajMotivo, lxBolycajVendedor, lxBolycajOrigtipo, lxBolycajOrigletra, lxBolycajOrigpvta, lxBolycajOrignro
				lxBolycajFechaori = ctod( '  /  /    ' )			lxBolycajFaltafw = ctod( '  /  /    ' )			lxBolycajFecexpo = ctod( '  /  /    ' )			lxBolycajFecimpo = ctod( '  /  /    ' )			lxBolycajFmodifw = ctod( '  /  /    ' )			lxBolycajFectrans = ctod( '  /  /    ' )			lxBolycajVmodifw = []			lxBolycajValtafw = []			lxBolycajDescfw = []			lxBolycajZadsfw = []			lxBolycajUmodifw = []			lxBolycajHmodifw = []			lxBolycajSmodifw = []			lxBolycajUaltafw = []			lxBolycajSaltafw = []			lxBolycajHoraimpo = []			lxBolycajHoraexpo = []			lxBolycajEsttrans = []			lxBolycajDescrip = []			lxBolycajHaltafw = []			lxBolycajBdmodifw = []			lxBolycajBdaltafw = []			lxBolycajTimestamp = goLibrerias.ObtenerTimestamp()			lxBolycajAnulado = .F.			lxBolycajCodigo = []			lxBolycajMobs = []			lxBolycajNumero = 0			lxBolycajNumeroori = 0			lxBolycajFecha = ctod( '  /  /    ' )			lxBolycajMotivo = []			lxBolycajVendedor = []			lxBolycajOrigtipo = 0			lxBolycajOrigletra = []			lxBolycajOrigpvta = 0			lxBolycajOrignro = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETBOLYCAJ where "NUMR" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.BOLYCAJ where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'BOLYCAJ' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  BOLYCAJ.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fechaori" as "Fechaoriginal", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Descrip" as "Descripcion", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Origletra" as "Origletra", "Origpvta" as "Origptovta", "Orignro" as "Orignumero"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'BOLYCAJ', '', tnTope )
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
	Function ObtenerDatosDetalleMovimientoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETBOLYCAJ.NUMR != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleMovimientoDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETBOLYCAJ', 'MovimientoDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleMovimientoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleMovimientoDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAORI AS FECHAORIGINAL'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'NUMEROORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROORI AS NUMEROORIGINAL'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'ORIGTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGTIPO AS ORIGTIPO'
				Case lcAtributo == 'ORIGLETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGLETRA AS ORIGLETRA'
				Case lcAtributo == 'ORIGPTOVTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGPVTA AS ORIGPTOVTA'
				Case lcAtributo == 'ORIGNUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGNRO AS ORIGNUMERO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleMovimientoDetalle( tcCampos As String ) As String
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMR AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLTXT AS TALLEDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTI AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORIGINAL'
				lcCampo = 'FECHAORI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROORIGINAL'
				lcCampo = 'NUMEROORI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGTIPO'
				lcCampo = 'ORIGTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGLETRA'
				lcCampo = 'ORIGLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGPTOVTA'
				lcCampo = 'ORIGPVTA'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGNUMERO'
				lcCampo = 'ORIGNRO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleMovimientoDetalle( tcAtributo As String ) As String
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
				lcCampo = 'NUMR'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'MART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TALLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTI'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'MOVIMIENTODETALLE'
			lcRetorno = 'DETBOLYCAJ'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxBolycajFechaori, lxBolycajFaltafw, lxBolycajFecexpo, lxBolycajFecimpo, lxBolycajFmodifw, lxBolycajFectrans, lxBolycajVmodifw, lxBolycajValtafw, lxBolycajDescfw, lxBolycajZadsfw, lxBolycajUmodifw, lxBolycajHmodifw, lxBolycajSmodifw, lxBolycajUaltafw, lxBolycajSaltafw, lxBolycajHoraimpo, lxBolycajHoraexpo, lxBolycajEsttrans, lxBolycajDescrip, lxBolycajHaltafw, lxBolycajBdmodifw, lxBolycajBdaltafw, lxBolycajTimestamp, lxBolycajAnulado, lxBolycajCodigo, lxBolycajMobs, lxBolycajNumero, lxBolycajNumeroori, lxBolycajFecha, lxBolycajMotivo, lxBolycajVendedor, lxBolycajOrigtipo, lxBolycajOrigletra, lxBolycajOrigpvta, lxBolycajOrignro
				lxBolycajFechaori =  .Fechaoriginal			lxBolycajFaltafw =  .Fechaaltafw			lxBolycajFecexpo =  .Fechaexpo			lxBolycajFecimpo =  .Fechaimpo			lxBolycajFmodifw =  .Fechamodificacionfw			lxBolycajFectrans =  .Fechatransferencia			lxBolycajVmodifw =  .Versionmodificacionfw			lxBolycajValtafw =  .Versionaltafw			lxBolycajDescfw =  .Descripcionfw			lxBolycajZadsfw =  .Zadsfw			lxBolycajUmodifw =  .Usuariomodificacionfw			lxBolycajHmodifw =  .Horamodificacionfw			lxBolycajSmodifw =  .Seriemodificacionfw			lxBolycajUaltafw =  .Usuarioaltafw			lxBolycajSaltafw =  .Seriealtafw			lxBolycajHoraimpo =  .Horaimpo			lxBolycajHoraexpo =  .Horaexpo			lxBolycajEsttrans =  .Estadotransferencia			lxBolycajDescrip =  .Descripcion			lxBolycajHaltafw =  .Horaaltafw			lxBolycajBdmodifw =  .Basededatosmodificacionfw			lxBolycajBdaltafw =  .Basededatosaltafw			lxBolycajTimestamp = goLibrerias.ObtenerTimestamp()			lxBolycajAnulado =  .Anulado			lxBolycajCodigo =  .Codigo			lxBolycajMobs =  .Observacion			lxBolycajNumero =  .Numero			lxBolycajNumeroori =  .Numerooriginal			lxBolycajFecha =  .Fecha			lxBolycajMotivo =  upper( .Motivo_PK ) 			lxBolycajVendedor =  upper( .vendedor_PK ) 			lxBolycajOrigtipo =  .Origtipo			lxBolycajOrigletra =  .Origletra			lxBolycajOrigpvta =  .Origptovta			lxBolycajOrignro =  .Orignumero
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.BOLYCAJ ( "Fechaori","Faltafw","Fecexpo","Fecimpo","Fmodifw","Fectrans","Vmodifw","Valtafw","Descfw","Zadsfw","Umodifw","Hmodifw","Smodifw","Ualtafw","Saltafw","Horaimpo","Horaexpo","Esttrans","Descrip","Haltafw","Bdmodifw","Bdaltafw","Timestamp","Anulado","Codigo","Mobs","Numero","Numeroori","Fecha","Motivo","Vendedor","Origtipo","Origletra","Origpvta","Orignro" ) values ( <<"'" + this.ConvertirDateSql( lxBolycajFechaori ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxBolycajFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajBdaltafw ) + "'" >>, <<lxBolycajTimestamp >>, <<iif( lxBolycajAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxBolycajCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajMobs ) + "'" >>, <<lxBolycajNumero >>, <<lxBolycajNumeroori >>, <<"'" + this.ConvertirDateSql( lxBolycajFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxBolycajVendedor ) + "'" >>, <<lxBolycajOrigtipo >>, <<"'" + this.FormatearTextoSql( lxBolycajOrigletra ) + "'" >>, <<lxBolycajOrigpvta >>, <<lxBolycajOrignro >> )
		endtext
		loColeccion.cTabla = 'BOLYCAJ' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MovimientoDetalle
				if this.oEntidad.MovimientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETBOLYCAJ("COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","ColTXT","TallTXT","Talle","CANTI" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
			if .lAnular
				.oAtributosAnulacion = .CrearObjeto( 'zooColeccion' )
				.ObtenerAtributosAnulacion()
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxBolycajFechaori, lxBolycajFaltafw, lxBolycajFecexpo, lxBolycajFecimpo, lxBolycajFmodifw, lxBolycajFectrans, lxBolycajVmodifw, lxBolycajValtafw, lxBolycajDescfw, lxBolycajZadsfw, lxBolycajUmodifw, lxBolycajHmodifw, lxBolycajSmodifw, lxBolycajUaltafw, lxBolycajSaltafw, lxBolycajHoraimpo, lxBolycajHoraexpo, lxBolycajEsttrans, lxBolycajDescrip, lxBolycajHaltafw, lxBolycajBdmodifw, lxBolycajBdaltafw, lxBolycajTimestamp, lxBolycajAnulado, lxBolycajCodigo, lxBolycajMobs, lxBolycajNumero, lxBolycajNumeroori, lxBolycajFecha, lxBolycajMotivo, lxBolycajVendedor, lxBolycajOrigtipo, lxBolycajOrigletra, lxBolycajOrigpvta, lxBolycajOrignro
				lxBolycajFechaori =  .Fechaoriginal			lxBolycajFaltafw =  .Fechaaltafw			lxBolycajFecexpo =  .Fechaexpo			lxBolycajFecimpo =  .Fechaimpo			lxBolycajFmodifw =  .Fechamodificacionfw			lxBolycajFectrans =  .Fechatransferencia			lxBolycajVmodifw =  .Versionmodificacionfw			lxBolycajValtafw =  .Versionaltafw			lxBolycajDescfw =  .Descripcionfw			lxBolycajZadsfw =  .Zadsfw			lxBolycajUmodifw =  .Usuariomodificacionfw			lxBolycajHmodifw =  .Horamodificacionfw			lxBolycajSmodifw =  .Seriemodificacionfw			lxBolycajUaltafw =  .Usuarioaltafw			lxBolycajSaltafw =  .Seriealtafw			lxBolycajHoraimpo =  .Horaimpo			lxBolycajHoraexpo =  .Horaexpo			lxBolycajEsttrans =  .Estadotransferencia			lxBolycajDescrip =  .Descripcion			lxBolycajHaltafw =  .Horaaltafw			lxBolycajBdmodifw =  .Basededatosmodificacionfw			lxBolycajBdaltafw =  .Basededatosaltafw			lxBolycajTimestamp = goLibrerias.ObtenerTimestamp()			lxBolycajAnulado =  .Anulado			lxBolycajCodigo =  .Codigo			lxBolycajMobs =  .Observacion			lxBolycajNumero =  .Numero			lxBolycajNumeroori =  .Numerooriginal			lxBolycajFecha =  .Fecha			lxBolycajMotivo =  upper( .Motivo_PK ) 			lxBolycajVendedor =  upper( .vendedor_PK ) 			lxBolycajOrigtipo =  .Origtipo			lxBolycajOrigletra =  .Origletra			lxBolycajOrigpvta =  .Origptovta			lxBolycajOrignro =  .Orignumero
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  BOLYCAJ.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.BOLYCAJ set "Fechaori" = <<"'" + this.ConvertirDateSql( lxBolycajFechaori ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxBolycajFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxBolycajFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxBolycajFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxBolycajFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxBolycajFectrans ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxBolycajVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxBolycajValtafw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxBolycajDescfw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxBolycajZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxBolycajUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxBolycajHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxBolycajSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxBolycajUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxBolycajSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxBolycajHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxBolycajHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxBolycajEsttrans ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxBolycajDescrip ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxBolycajHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxBolycajBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxBolycajBdaltafw ) + "'">>, "Timestamp" = <<lxBolycajTimestamp>>, "Anulado" = <<iif( lxBolycajAnulado, 1, 0 )>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxBolycajCodigo ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxBolycajMobs ) + "'">>, "Numero" = <<lxBolycajNumero>>, "Numeroori" = <<lxBolycajNumeroori>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxBolycajFecha ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxBolycajMotivo ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxBolycajVendedor ) + "'">>, "Origtipo" = <<lxBolycajOrigtipo>>, "Origletra" = <<"'" + this.FormatearTextoSql( lxBolycajOrigletra ) + "'">>, "Origpvta" = <<lxBolycajOrigpvta>>, "Orignro" = <<lxBolycajOrignro>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'BOLYCAJ' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DETBOLYCAJ where "NUMR" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MovimientoDetalle
				if this.oEntidad.MovimientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETBOLYCAJ("COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","ColTXT","TallTXT","Talle","CANTI" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  BOLYCAJ.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.BOLYCAJ where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DETBOLYCAJ where "NUMR" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'BOLYCAJ' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.BOLYCAJ where  BOLYCAJ.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.BOLYCAJ where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  BOLYCAJ.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxBOLYCAJNUMERO as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'BOLSASYCAJAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.BOLYCAJ Where  NUMERO = ] + transform( &lcCursor..NUMERO     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						if this.oEntidad.cContexto == 'C'
							if curSeek.ANULADO
								Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.BOLYCAJ set  FECHAORI = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAORI ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, DESCRIP = ] + "'" + this.FormatearTextoSql( &lcCursor..DESCRIP ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, NUMEROORI = ] + transform( &lcCursor..NUMEROORI )+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, VENDEDOR = ] + "'" + this.FormatearTextoSql( &lcCursor..VENDEDOR ) + "'"+ [, ORIGTIPO = ] + transform( &lcCursor..ORIGTIPO )+ [, ORIGLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..ORIGLETRA ) + "'"+ [, ORIGPVTA = ] + transform( &lcCursor..ORIGPVTA )+ [, ORIGNRO = ] + transform( &lcCursor..ORIGNRO ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica anulado ).', tlLoguear )
							else
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe y no esta anulado.', tlLoguear )
							endif
						else
							this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe.', tlLoguear )
						endif
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.BOLYCAJ Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECHAORI, FALTAFW, FECEXPO, FECIMPO, FMODIFW, FECTRANS, VMODIFW, VALTAFW, DescFW, ZADSFW, UMODIFW, HMODIFW, SMODIFW, UALTAFW, SALTAFW, HORAIMPO, HORAEXPO, ESTTRANS, DESCRIP, HALTAFW, BDMODIFW, BDALTAFW, TIMESTAMP, Anulado, CODIGO, MObs, NUMERO, NUMEROORI, FECHA, MOTIVO, VENDEDOR, ORIGTIPO, ORIGLETRA, ORIGPVTA, ORIGNRO
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAORI ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DESCRIP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + transform( &lcCursor..NUMERO ) + ',' + transform( &lcCursor..NUMEROORI ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VENDEDOR ) + "'" + ',' + transform( &lcCursor..ORIGTIPO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ORIGLETRA ) + "'" + ',' + transform( &lcCursor..ORIGPVTA ) + ',' + transform( &lcCursor..ORIGNRO )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.BOLYCAJ ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'BOLSASYCAJAS'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DETBOLYCAJ Where NUMR] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMBOLSASYCAJAS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where NUMR in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","ColTXT","TallTXT","Talle","CANTI"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DETBOLYCAJ ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NUMR       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DESCRIP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TallTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.CANTI      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..NUMERO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'BOLSASYCAJAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'BOLSASYCAJAS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'BOLSASYCAJAS_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMBOLSASYCAJAS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_BOLYCAJ')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'BOLSASYCAJAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..NUMERO )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad BOLSASYCAJAS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BOLSASYCAJAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( NUMERO, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( NUMERO, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BOLSASYCAJAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECHAORI  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECHA     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_BOLYCAJ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_BOLYCAJ
Create Table ZooLogic.TablaTrabajo_BOLYCAJ ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fechaori" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"descrip" char( 40 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"anulado" bit  null, 
"codigo" char( 38 )  null, 
"mobs" varchar(max)  null, 
"numero" numeric( 8, 0 )  null, 
"numeroori" numeric( 8, 0 )  null, 
"fecha" datetime  null, 
"motivo" char( 3 )  null, 
"vendedor" char( 10 )  null, 
"origtipo" numeric( 2, 0 )  null, 
"origletra" char( 1 )  null, 
"origpvta" numeric( 4, 0 )  null, 
"orignro" numeric( 8, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_BOLYCAJ' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_BOLYCAJ' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BOLSASYCAJAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fechaori','fechaori')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('numeroori','numeroori')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('origtipo','origtipo')
			.AgregarMapeo('origletra','origletra')
			.AgregarMapeo('origpvta','origpvta')
			.AgregarMapeo('orignro','orignro')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_BOLYCAJ'
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
				Update t Set t.FECHAORI = isnull( d.FECHAORI, t.FECHAORI ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.NUMEROORI = isnull( d.NUMEROORI, t.NUMEROORI ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.ORIGTIPO = isnull( d.ORIGTIPO, t.ORIGTIPO ),t.ORIGLETRA = isnull( d.ORIGLETRA, t.ORIGLETRA ),t.ORIGPVTA = isnull( d.ORIGPVTA, t.ORIGPVTA ),t.ORIGNRO = isnull( d.ORIGNRO, t.ORIGNRO )
					from ZooLogic.BOLYCAJ t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.BOLYCAJ(Fechaori,Faltafw,Fecexpo,Fecimpo,Fmodifw,Fectrans,Vmodifw,Valtafw,Descfw,Zadsfw,Umodifw,Hmodifw,Smodifw,Ualtafw,Saltafw,Horaimpo,Horaexpo,Esttrans,Descrip,Haltafw,Bdmodifw,Bdaltafw,Timestamp,Anulado,Codigo,Mobs,Numero,Numeroori,Fecha,Motivo,Vendedor,Origtipo,Origletra,Origpvta,Orignro)
					Select isnull( d.FECHAORI,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.DESCFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),isnull( d.DESCRIP,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.TIMESTAMP,0),isnull( d.ANULADO,0),isnull( d.CODIGO,''),isnull( d.MOBS,''),isnull( d.NUMERO,0),isnull( d.NUMEROORI,0),isnull( d.FECHA,''),isnull( d.MOTIVO,''),isnull( d.VENDEDOR,''),isnull( d.ORIGTIPO,0),isnull( d.ORIGLETRA,''),isnull( d.ORIGPVTA,0),isnull( d.ORIGNRO,0)
						From deleted d left join ZooLogic.BOLYCAJ pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.BOLYCAJ cc 
							 on  d.NUMERO = cc.NUMERO
						Where pk.CODIGO Is Null 
							 and cc.NUMERO Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.BOLYCAJ t inner join deleted d 
							on   t.NUMERO = d.NUMERO
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.BOLYCAJ t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.NUMERO = h.NUMERO
							where   h.NUMERO is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETBOLYCAJ( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_BOLYCAJ_DETBOLYCAJ
ON ZooLogic.TablaTrabajo_BOLYCAJ_DETBOLYCAJ
AFTER DELETE
As
Begin
Update t Set 
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.NUMR = isnull( d.NUMR, t.NUMR ),
t.MART = isnull( d.MART, t.MART ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.COLTXT = isnull( d.COLTXT, t.COLTXT ),
t.TALLTXT = isnull( d.TALLTXT, t.TALLTXT ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.CANTI = isnull( d.CANTI, t.CANTI )
from ZooLogic.DETBOLYCAJ t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DETBOLYCAJ
( 
"COMP",
"NROITEM",
"PROCSTOCK",
"EQUIV",
"NUMR",
"MART",
"DESCRIP",
"CCOLOR",
"COLTXT",
"TALLTXT",
"TALLE",
"CANTI"
 )
Select 
d.COMP,
d.NROITEM,
d.PROCSTOCK,
d.EQUIV,
d.NUMR,
d.MART,
d.DESCRIP,
d.CCOLOR,
d.COLTXT,
d.TALLTXT,
d.TALLE,
d.CANTI
From deleted d left join ZooLogic.DETBOLYCAJ pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_BOLYCAJ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_BOLYCAJ
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_BOLSASYCAJAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaoriginal = GoLibrerias.ObtenerFechaFormateada( nvl( c_BOLSASYCAJAS.Fechaoriginal, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_BOLSASYCAJAS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_BOLSASYCAJAS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_BOLSASYCAJAS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_BOLSASYCAJAS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_BOLSASYCAJAS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Versionmodificacionfw = nvl( c_BOLSASYCAJAS.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_BOLSASYCAJAS.Versionaltafw, [] )
					.Descripcionfw = nvl( c_BOLSASYCAJAS.Descripcionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_BOLSASYCAJAS.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_BOLSASYCAJAS.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_BOLSASYCAJAS.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_BOLSASYCAJAS.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_BOLSASYCAJAS.Seriealtafw, [] )
					.Horaimpo = nvl( c_BOLSASYCAJAS.Horaimpo, [] )
					.Horaexpo = nvl( c_BOLSASYCAJAS.Horaexpo, [] )
					.Estadotransferencia = nvl( c_BOLSASYCAJAS.Estadotransferencia, [] )
					.Descripcion = nvl( c_BOLSASYCAJAS.Descripcion, [] )
					.Horaaltafw = nvl( c_BOLSASYCAJAS.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_BOLSASYCAJAS.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_BOLSASYCAJAS.Basededatosaltafw, [] )
					.Timestamp = nvl( c_BOLSASYCAJAS.Timestamp, 0 )
					.Anulado = nvl( c_BOLSASYCAJAS.Anulado, .F. )
					.Movimientodetalle.Limpiar()
					.Movimientodetalle.SetearEsNavegacion( .lProcesando )
					.Movimientodetalle.Cargar()
					.Codigo = nvl( c_BOLSASYCAJAS.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Numero = nvl( c_BOLSASYCAJAS.Numero, 0 )
					.Numerooriginal = nvl( c_BOLSASYCAJAS.Numerooriginal, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_BOLSASYCAJAS.Fecha, ctod( '  /  /    ' ) ) )
					.Motivo_PK =  nvl( c_BOLSASYCAJAS.Motivo, [] )
					.Vendedor_PK =  nvl( c_BOLSASYCAJAS.Vendedor, [] )
					.Origtipo = nvl( c_BOLSASYCAJAS.Origtipo, 0 )
					.Origletra = nvl( c_BOLSASYCAJAS.Origletra, [] )
					.Origptovta = nvl( c_BOLSASYCAJAS.Origptovta, 0 )
					.Orignumero = nvl( c_BOLSASYCAJAS.Orignumero, 0 )
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
			lxRetorno = c_BOLSASYCAJAS.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.MovimientoDetalle
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
		return c_BOLSASYCAJAS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.BOLYCAJ' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.BOLYCAJ 
								Where   BOLYCAJ.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "BOLYCAJ", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fechaori" as "Fechaoriginal", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Descrip" as "Descripcion", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Origletra" as "Origletra", "Origpvta" as "Origptovta", "Orignro" as "Orignumero"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.BOLYCAJ 
								Where   BOLYCAJ.CODIGO != ''
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
	Tabla = 'BOLYCAJ'
	Filtro = " BOLYCAJ.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " BOLYCAJ.CODIGO != ''"
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
	<row entidad="BOLSASYCAJAS                            " atributo="FECHAORIGINAL                           " tabla="BOLYCAJ        " campo="FECHAORI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha original                                                                                                                                                  " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="FECHAALTAFW                             " tabla="BOLYCAJ        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="FECHAEXPO                               " tabla="BOLYCAJ        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="FECHAIMPO                               " tabla="BOLYCAJ        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="FECHAMODIFICACIONFW                     " tabla="BOLYCAJ        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="FECHATRANSFERENCIA                      " tabla="BOLYCAJ        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="VERSIONMODIFICACIONFW                   " tabla="BOLYCAJ        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="VERSIONALTAFW                           " tabla="BOLYCAJ        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="DESCRIPCIONFW                           " tabla="BOLYCAJ        " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="ZADSFW                                  " tabla="BOLYCAJ        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="USUARIOMODIFICACIONFW                   " tabla="BOLYCAJ        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="HORAMODIFICACIONFW                      " tabla="BOLYCAJ        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="SERIEMODIFICACIONFW                     " tabla="BOLYCAJ        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="USUARIOALTAFW                           " tabla="BOLYCAJ        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="SERIEALTAFW                             " tabla="BOLYCAJ        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="HORAIMPO                                " tabla="BOLYCAJ        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="HORAEXPO                                " tabla="BOLYCAJ        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="ESTADOTRANSFERENCIA                     " tabla="BOLYCAJ        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="DESCRIPCION                             " tabla="BOLYCAJ        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="HORAALTAFW                              " tabla="BOLYCAJ        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="BOLYCAJ        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="BASEDEDATOSALTAFW                       " tabla="BOLYCAJ        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="TIMESTAMP                               " tabla="BOLYCAJ        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="ANULADO                                 " tabla="BOLYCAJ        " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="MOVIMIENTODETALLE                       " tabla="DETBOLYCAJ     " campo="NUMR      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículos                                                                                                                                                       " dominio="DETALLEITEMBOLSASYCAJAS       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="CODIGO                                  " tabla="BOLYCAJ        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="12" etiqueta="Código de bolsa                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="OBSERVACION                             " tabla="BOLYCAJ        " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="NUMERO                                  " tabla="BOLYCAJ        " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="NUMEROORIGINAL                          " tabla="BOLYCAJ        " campo="NUMEROORI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número original                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="FECHA                                   " tabla="BOLYCAJ        " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="MOTIVO                                  " tabla="BOLYCAJ        " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="VENDEDOR                                " tabla="BOLYCAJ        " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="ORIGTIPO                                " tabla="BOLYCAJ        " campo="ORIGTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo comprobante                                                                                                                                                " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="ORIGLETRA                               " tabla="BOLYCAJ        " campo="ORIGLETRA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra comprobante                                                                                                                                               " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="ORIGPTOVTA                              " tabla="BOLYCAJ        " campo="ORIGPVTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto venta comprobante                                                                                                                                         " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BOLSASYCAJAS                            " atributo="ORIGNUMERO                              " tabla="BOLYCAJ        " campo="ORIGNRO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número comprobante                                                                                                                                              " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On BOLYCAJ.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On BOLYCAJ.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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