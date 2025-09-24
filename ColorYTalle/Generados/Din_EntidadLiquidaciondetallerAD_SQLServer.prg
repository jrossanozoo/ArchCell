
define class Din_EntidadLIQUIDACIONDETALLERAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_LIQUIDACIONDETALLER'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 12, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 12, 0)]
	cTagClaveCandidata = '_LTPCC'
	cTagClavePk = '_LTPPK'
	cTablaPrincipal = 'LIQTALLER'
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
			local  lxLiqtallerFecimpo, lxLiqtallerFecexpo, lxLiqtallerFmodifw, lxLiqtallerFaltafw, lxLiqtallerFectrans, lxLiqtallerBdmodifw, lxLiqtallerEsttrans, lxLiqtallerValtafw, lxLiqtallerBdaltafw, lxLiqtallerHaltafw, lxLiqtallerVmodifw, lxLiqtallerHoraexpo, lxLiqtallerSmodifw, lxLiqtallerUaltafw, lxLiqtallerHmodifw, lxLiqtallerSaltafw, lxLiqtallerUmodifw, lxLiqtallerHoraimpo, lxLiqtallerZadsfw, lxLiqtallerCodigo, lxLiqtallerTaller, lxLiqtallerProveedor, lxLiqtallerOrdendesde, lxLiqtallerOrdenhasta, lxLiqtallerProcdesde, lxLiqtallerProchasta, lxLiqtallerGestdesde, lxLiqtallerGesthasta, lxLiqtallerFecdesde, lxLiqtallerFechasta, lxLiqtallerNumero, lxLiqtallerDescartes, lxLiqtallerMoneda, lxLiqtallerInsumos, lxLiqtallerListacosto, lxLiqtallerCobs, lxLiqtallerFtotal, lxLiqtallerComprob, lxLiqtallerLetracomp, lxLiqtallerPuntocomp, lxLiqtallerNumerocomp
				lxLiqtallerFecimpo =  .Fechaimpo			lxLiqtallerFecexpo =  .Fechaexpo			lxLiqtallerFmodifw =  .Fechamodificacionfw			lxLiqtallerFaltafw =  .Fechaaltafw			lxLiqtallerFectrans =  .Fechatransferencia			lxLiqtallerBdmodifw =  .Basededatosmodificacionfw			lxLiqtallerEsttrans =  .Estadotransferencia			lxLiqtallerValtafw =  .Versionaltafw			lxLiqtallerBdaltafw =  .Basededatosaltafw			lxLiqtallerHaltafw =  .Horaaltafw			lxLiqtallerVmodifw =  .Versionmodificacionfw			lxLiqtallerHoraexpo =  .Horaexpo			lxLiqtallerSmodifw =  .Seriemodificacionfw			lxLiqtallerUaltafw =  .Usuarioaltafw			lxLiqtallerHmodifw =  .Horamodificacionfw			lxLiqtallerSaltafw =  .Seriealtafw			lxLiqtallerUmodifw =  .Usuariomodificacionfw			lxLiqtallerHoraimpo =  .Horaimpo			lxLiqtallerZadsfw =  .Zadsfw			lxLiqtallerCodigo =  .Codigo			lxLiqtallerTaller =  upper( .Taller_PK ) 			lxLiqtallerProveedor =  upper( .Proveedor_PK ) 			lxLiqtallerOrdendesde =  .Ordendesde			lxLiqtallerOrdenhasta =  .Ordenhasta			lxLiqtallerProcdesde =  upper( .ProcesoDesde_PK ) 			lxLiqtallerProchasta =  upper( .ProcesoHasta_PK ) 			lxLiqtallerGestdesde =  .Gestiondesde			lxLiqtallerGesthasta =  .Gestionhasta			lxLiqtallerFecdesde =  .Fechadesde			lxLiqtallerFechasta =  .Fechahasta			lxLiqtallerNumero =  .Numero			lxLiqtallerDescartes =  .Descartes			lxLiqtallerMoneda =  upper( .Moneda_PK ) 			lxLiqtallerInsumos =  .Insumos			lxLiqtallerListacosto =  upper( .ListaDeCosto_PK ) 			lxLiqtallerCobs =  .Observ			lxLiqtallerFtotal =  .Total			lxLiqtallerComprob =  .Comprobante			lxLiqtallerLetracomp =  .Letracomprobante			lxLiqtallerPuntocomp =  .Puntodeventacomprobante			lxLiqtallerNumerocomp =  .Numerocomprobante
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxLiqtallerCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.LIQTALLER ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Bdmodifw","Esttrans","Valtafw","Bdaltafw","Haltafw","Vmodifw","Horaexpo","Smodifw","Ualtafw","Hmodifw","Saltafw","Umodifw","Horaimpo","Zadsfw","Codigo","Taller","Proveedor","Ordendesde","Ordenhasta","Procdesde","Prochasta","Gestdesde","Gesthasta","Fecdesde","Fechasta","Numero","Descartes","Moneda","Insumos","Listacosto","Cobs","Ftotal","Comprob","Letracomp","Puntocomp","Numerocomp" ) values ( <<"'" + this.ConvertirDateSql( lxLiqtallerFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerTaller ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerProveedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerOrdendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerOrdenhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerProcdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerProchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerGestdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerGesthasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFecdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFechasta ) + "'" >>, <<lxLiqtallerNumero >>, <<lxLiqtallerDescartes >>, <<"'" + this.FormatearTextoSql( lxLiqtallerMoneda ) + "'" >>, <<lxLiqtallerInsumos >>, <<"'" + this.FormatearTextoSql( lxLiqtallerListacosto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerCobs ) + "'" >>, <<lxLiqtallerFtotal >>, <<"'" + this.FormatearTextoSql( lxLiqtallerComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerLetracomp ) + "'" >>, <<lxLiqtallerPuntocomp >>, <<lxLiqtallerNumerocomp >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionDeProduccion
				if this.oEntidad.GestionDeProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerProduccion
				if this.oEntidad.LiquidacionTallerProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTPROD("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerDescarte
				if this.oEntidad.LiquidacionTallerDescarte.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTDESC("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerInsumos
				if this.oEntidad.LiquidacionTallerInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTINS("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerAdicionales
				if this.oEntidad.LiquidacionTallerAdicionales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulo = loItem.Iditemarticulo
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCantidad = loItem.Cantidad
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTADIC("IdItem","NROITEM","Codigo","ArtLiq","ArtDesc","Cantidad","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCantidad>>, <<lxCosto>>, <<lxMonto>> ) 
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
			local  lxLiqtallerFecimpo, lxLiqtallerFecexpo, lxLiqtallerFmodifw, lxLiqtallerFaltafw, lxLiqtallerFectrans, lxLiqtallerBdmodifw, lxLiqtallerEsttrans, lxLiqtallerValtafw, lxLiqtallerBdaltafw, lxLiqtallerHaltafw, lxLiqtallerVmodifw, lxLiqtallerHoraexpo, lxLiqtallerSmodifw, lxLiqtallerUaltafw, lxLiqtallerHmodifw, lxLiqtallerSaltafw, lxLiqtallerUmodifw, lxLiqtallerHoraimpo, lxLiqtallerZadsfw, lxLiqtallerCodigo, lxLiqtallerTaller, lxLiqtallerProveedor, lxLiqtallerOrdendesde, lxLiqtallerOrdenhasta, lxLiqtallerProcdesde, lxLiqtallerProchasta, lxLiqtallerGestdesde, lxLiqtallerGesthasta, lxLiqtallerFecdesde, lxLiqtallerFechasta, lxLiqtallerNumero, lxLiqtallerDescartes, lxLiqtallerMoneda, lxLiqtallerInsumos, lxLiqtallerListacosto, lxLiqtallerCobs, lxLiqtallerFtotal, lxLiqtallerComprob, lxLiqtallerLetracomp, lxLiqtallerPuntocomp, lxLiqtallerNumerocomp
				lxLiqtallerFecimpo =  .Fechaimpo			lxLiqtallerFecexpo =  .Fechaexpo			lxLiqtallerFmodifw =  .Fechamodificacionfw			lxLiqtallerFaltafw =  .Fechaaltafw			lxLiqtallerFectrans =  .Fechatransferencia			lxLiqtallerBdmodifw =  .Basededatosmodificacionfw			lxLiqtallerEsttrans =  .Estadotransferencia			lxLiqtallerValtafw =  .Versionaltafw			lxLiqtallerBdaltafw =  .Basededatosaltafw			lxLiqtallerHaltafw =  .Horaaltafw			lxLiqtallerVmodifw =  .Versionmodificacionfw			lxLiqtallerHoraexpo =  .Horaexpo			lxLiqtallerSmodifw =  .Seriemodificacionfw			lxLiqtallerUaltafw =  .Usuarioaltafw			lxLiqtallerHmodifw =  .Horamodificacionfw			lxLiqtallerSaltafw =  .Seriealtafw			lxLiqtallerUmodifw =  .Usuariomodificacionfw			lxLiqtallerHoraimpo =  .Horaimpo			lxLiqtallerZadsfw =  .Zadsfw			lxLiqtallerCodigo =  .Codigo			lxLiqtallerTaller =  upper( .Taller_PK ) 			lxLiqtallerProveedor =  upper( .Proveedor_PK ) 			lxLiqtallerOrdendesde =  .Ordendesde			lxLiqtallerOrdenhasta =  .Ordenhasta			lxLiqtallerProcdesde =  upper( .ProcesoDesde_PK ) 			lxLiqtallerProchasta =  upper( .ProcesoHasta_PK ) 			lxLiqtallerGestdesde =  .Gestiondesde			lxLiqtallerGesthasta =  .Gestionhasta			lxLiqtallerFecdesde =  .Fechadesde			lxLiqtallerFechasta =  .Fechahasta			lxLiqtallerNumero =  .Numero			lxLiqtallerDescartes =  .Descartes			lxLiqtallerMoneda =  upper( .Moneda_PK ) 			lxLiqtallerInsumos =  .Insumos			lxLiqtallerListacosto =  upper( .ListaDeCosto_PK ) 			lxLiqtallerCobs =  .Observ			lxLiqtallerFtotal =  .Total			lxLiqtallerComprob =  .Comprobante			lxLiqtallerLetracomp =  .Letracomprobante			lxLiqtallerPuntocomp =  .Puntodeventacomprobante			lxLiqtallerNumerocomp =  .Numerocomprobante
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.LIQTALLER set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLiqtallerFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxLiqtallerFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxLiqtallerFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxLiqtallerFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxLiqtallerFectrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxLiqtallerEsttrans ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerValtafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerHaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxLiqtallerHoraexpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerUmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxLiqtallerHoraimpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxLiqtallerZadsfw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxLiqtallerCodigo ) + "'">>,"Taller" = <<"'" + this.FormatearTextoSql( lxLiqtallerTaller ) + "'">>,"Proveedor" = <<"'" + this.FormatearTextoSql( lxLiqtallerProveedor ) + "'">>,"Ordendesde" = <<"'" + this.FormatearTextoSql( lxLiqtallerOrdendesde ) + "'">>,"Ordenhasta" = <<"'" + this.FormatearTextoSql( lxLiqtallerOrdenhasta ) + "'">>,"Procdesde" = <<"'" + this.FormatearTextoSql( lxLiqtallerProcdesde ) + "'">>,"Prochasta" = <<"'" + this.FormatearTextoSql( lxLiqtallerProchasta ) + "'">>,"Gestdesde" = <<"'" + this.FormatearTextoSql( lxLiqtallerGestdesde ) + "'">>,"Gesthasta" = <<"'" + this.FormatearTextoSql( lxLiqtallerGesthasta ) + "'">>,"Fecdesde" = <<"'" + this.ConvertirDateSql( lxLiqtallerFecdesde ) + "'">>,"Fechasta" = <<"'" + this.ConvertirDateSql( lxLiqtallerFechasta ) + "'">>,"Numero" = <<lxLiqtallerNumero>>,"Descartes" = <<lxLiqtallerDescartes>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxLiqtallerMoneda ) + "'">>,"Insumos" = <<lxLiqtallerInsumos>>,"Listacosto" = <<"'" + this.FormatearTextoSql( lxLiqtallerListacosto ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxLiqtallerCobs ) + "'">>,"Ftotal" = <<lxLiqtallerFtotal>>,"Comprob" = <<"'" + this.FormatearTextoSql( lxLiqtallerComprob ) + "'">>,"Letracomp" = <<"'" + this.FormatearTextoSql( lxLiqtallerLetracomp ) + "'">>,"Puntocomp" = <<lxLiqtallerPuntocomp>>,"Numerocomp" = <<lxLiqtallerNumerocomp>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqtallerCodigo ) + "'">> and  LIQTALLER.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LIQTPROD where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LIQTDESC where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LIQTINS where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LIQTADIC where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionDeProduccion
				if this.oEntidad.GestionDeProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerProduccion
				if this.oEntidad.LiquidacionTallerProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTPROD("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerDescarte
				if this.oEntidad.LiquidacionTallerDescarte.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTDESC("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerInsumos
				if this.oEntidad.LiquidacionTallerInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTINS("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerAdicionales
				if this.oEntidad.LiquidacionTallerAdicionales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulo = loItem.Iditemarticulo
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCantidad = loItem.Cantidad
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTADIC("IdItem","NROITEM","Codigo","ArtLiq","ArtDesc","Cantidad","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCantidad>>, <<lxCosto>>, <<lxMonto>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.LIQTALLER where " + this.ConvertirFuncionesSql( " LIQTALLER.CODIGO != ''" ) )
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
			Local lxLiqtallerCodigo
			lxLiqtallerCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Codigo" as "Codigo", "Taller" as "Taller", "Proveedor" as "Proveedor", "Ordendesde" as "Ordendesde", "Ordenhasta" as "Ordenhasta", "Procdesde" as "Procesodesde", "Prochasta" as "Procesohasta", "Gestdesde" as "Gestiondesde", "Gesthasta" as "Gestionhasta", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Numero" as "Numero", "Descartes" as "Descartes", "Moneda" as "Moneda", "Insumos" as "Insumos", "Listacosto" as "Listadecosto", "Cobs" as "Observ", "Ftotal" as "Total", "Comprob" as "Comprobante", "Letracomp" as "Letracomprobante", "Puntocomp" as "Puntodeventacomprobante", "Numerocomp" as "Numerocomprobante" from ZooLogic.LIQTALLER where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqtallerCodigo ) + "'">> and  LIQTALLER.CODIGO != ''
			endtext
			use in select('c_LIQUIDACIONDETALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDETALLER', set( 'Datasession' ) )

			if reccount( 'c_LIQUIDACIONDETALLER' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDeProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDeProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDeProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTPROD where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTDESC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTINS where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTADIC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerAdicionales
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxLIQTALLERNumero As Variant
			lxLIQTALLERNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Codigo" as "Codigo", "Taller" as "Taller", "Proveedor" as "Proveedor", "Ordendesde" as "Ordendesde", "Ordenhasta" as "Ordenhasta", "Procdesde" as "Procesodesde", "Prochasta" as "Procesohasta", "Gestdesde" as "Gestiondesde", "Gesthasta" as "Gestionhasta", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Numero" as "Numero", "Descartes" as "Descartes", "Moneda" as "Moneda", "Insumos" as "Insumos", "Listacosto" as "Listadecosto", "Cobs" as "Observ", "Ftotal" as "Total", "Comprob" as "Comprobante", "Letracomp" as "Letracomprobante", "Puntocomp" as "Puntodeventacomprobante", "Numerocomp" as "Numerocomprobante" from ZooLogic.LIQTALLER where  LIQTALLER.CODIGO != '' And Numero = <<lxLIQTALLERNumero>>
			endtext
			use in select('c_LIQUIDACIONDETALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDETALLER', set( 'Datasession' ) )
			if reccount( 'c_LIQUIDACIONDETALLER' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDeProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDeProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDeProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTPROD where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTDESC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTINS where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTADIC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerAdicionales
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxLiqtallerCodigo as Variant
		llRetorno = .t.
		lxLiqtallerCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.LIQTALLER where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqtallerCodigo ) + "'">> and  LIQTALLER.CODIGO != ''
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
				lcOrden =  str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Codigo" as "Codigo", "Taller" as "Taller", "Proveedor" as "Proveedor", "Ordendesde" as "Ordendesde", "Ordenhasta" as "Ordenhasta", "Procdesde" as "Procesodesde", "Prochasta" as "Procesohasta", "Gestdesde" as "Gestiondesde", "Gesthasta" as "Gestionhasta", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Numero" as "Numero", "Descartes" as "Descartes", "Moneda" as "Moneda", "Insumos" as "Insumos", "Listacosto" as "Listadecosto", "Cobs" as "Observ", "Ftotal" as "Total", "Comprob" as "Comprobante", "Letracomp" as "Letracomprobante", "Puntocomp" as "Puntodeventacomprobante", "Numerocomp" as "Numerocomprobante" from ZooLogic.LIQTALLER where  LIQTALLER.CODIGO != '' order by Numero
			endtext
			use in select('c_LIQUIDACIONDETALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDETALLER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDeProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDeProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDeProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTPROD where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTDESC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTINS where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTADIC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerAdicionales
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
				lcOrden =  str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Codigo" as "Codigo", "Taller" as "Taller", "Proveedor" as "Proveedor", "Ordendesde" as "Ordendesde", "Ordenhasta" as "Ordenhasta", "Procdesde" as "Procesodesde", "Prochasta" as "Procesohasta", "Gestdesde" as "Gestiondesde", "Gesthasta" as "Gestionhasta", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Numero" as "Numero", "Descartes" as "Descartes", "Moneda" as "Moneda", "Insumos" as "Insumos", "Listacosto" as "Listadecosto", "Cobs" as "Observ", "Ftotal" as "Total", "Comprob" as "Comprobante", "Letracomp" as "Letracomprobante", "Puntocomp" as "Puntodeventacomprobante", "Numerocomp" as "Numerocomprobante" from ZooLogic.LIQTALLER where  str( Numero, 12, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LIQTALLER.CODIGO != '' order by Numero
			endtext
			use in select('c_LIQUIDACIONDETALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDETALLER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDeProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDeProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDeProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTPROD where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTDESC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTINS where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTADIC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerAdicionales
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
				lcOrden =  str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Codigo" as "Codigo", "Taller" as "Taller", "Proveedor" as "Proveedor", "Ordendesde" as "Ordendesde", "Ordenhasta" as "Ordenhasta", "Procdesde" as "Procesodesde", "Prochasta" as "Procesohasta", "Gestdesde" as "Gestiondesde", "Gesthasta" as "Gestionhasta", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Numero" as "Numero", "Descartes" as "Descartes", "Moneda" as "Moneda", "Insumos" as "Insumos", "Listacosto" as "Listadecosto", "Cobs" as "Observ", "Ftotal" as "Total", "Comprob" as "Comprobante", "Letracomp" as "Letracomprobante", "Puntocomp" as "Puntodeventacomprobante", "Numerocomp" as "Numerocomprobante" from ZooLogic.LIQTALLER where  str( Numero, 12, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LIQTALLER.CODIGO != '' order by Numero desc
			endtext
			use in select('c_LIQUIDACIONDETALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDETALLER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDeProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDeProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDeProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTPROD where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTDESC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTINS where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTADIC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerAdicionales
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
				lcOrden =  str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Codigo" as "Codigo", "Taller" as "Taller", "Proveedor" as "Proveedor", "Ordendesde" as "Ordendesde", "Ordenhasta" as "Ordenhasta", "Procdesde" as "Procesodesde", "Prochasta" as "Procesohasta", "Gestdesde" as "Gestiondesde", "Gesthasta" as "Gestionhasta", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Numero" as "Numero", "Descartes" as "Descartes", "Moneda" as "Moneda", "Insumos" as "Insumos", "Listacosto" as "Listadecosto", "Cobs" as "Observ", "Ftotal" as "Total", "Comprob" as "Comprobante", "Letracomp" as "Letracomprobante", "Puntocomp" as "Puntodeventacomprobante", "Numerocomp" as "Numerocomprobante" from ZooLogic.LIQTALLER where  LIQTALLER.CODIGO != '' order by Numero desc
			endtext
			use in select('c_LIQUIDACIONDETALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONDETALLER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDeProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDeProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDeProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTPROD where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTDESC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTINS where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.LIQTADIC where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONDETALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_LiquidacionTallerAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LiquidacionTallerAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_LiquidacionTallerAdicionales
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Bdmodifw,Esttrans,Valtafw,Bdaltafw,Haltafw,Vmodifw," + ;
"Horaexpo,Smodifw,Ualtafw,Hmodifw,Saltafw,Umodifw,Horaimpo,Zadsfw,Codigo,Taller,Proveedor,Ordendesde," + ;
"Ordenhasta,Procdesde,Prochasta,Gestdesde,Gesthasta,Fecdesde,Fechasta,Numero,Descartes,Moneda,Insumos" + ;
",Listacosto,Cobs,Ftotal,Comprob,Letracomp,Puntocomp,Numerocomp" + ;
" from ZooLogic.LIQTALLER where  LIQTALLER.CODIGO != '' and " + lcFiltro )
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
			local  lxLiqtallerFecimpo, lxLiqtallerFecexpo, lxLiqtallerFmodifw, lxLiqtallerFaltafw, lxLiqtallerFectrans, lxLiqtallerBdmodifw, lxLiqtallerEsttrans, lxLiqtallerValtafw, lxLiqtallerBdaltafw, lxLiqtallerHaltafw, lxLiqtallerVmodifw, lxLiqtallerHoraexpo, lxLiqtallerSmodifw, lxLiqtallerUaltafw, lxLiqtallerHmodifw, lxLiqtallerSaltafw, lxLiqtallerUmodifw, lxLiqtallerHoraimpo, lxLiqtallerZadsfw, lxLiqtallerCodigo, lxLiqtallerTaller, lxLiqtallerProveedor, lxLiqtallerOrdendesde, lxLiqtallerOrdenhasta, lxLiqtallerProcdesde, lxLiqtallerProchasta, lxLiqtallerGestdesde, lxLiqtallerGesthasta, lxLiqtallerFecdesde, lxLiqtallerFechasta, lxLiqtallerNumero, lxLiqtallerDescartes, lxLiqtallerMoneda, lxLiqtallerInsumos, lxLiqtallerListacosto, lxLiqtallerCobs, lxLiqtallerFtotal, lxLiqtallerComprob, lxLiqtallerLetracomp, lxLiqtallerPuntocomp, lxLiqtallerNumerocomp
				lxLiqtallerFecimpo = ctod( '  /  /    ' )			lxLiqtallerFecexpo = ctod( '  /  /    ' )			lxLiqtallerFmodifw = ctod( '  /  /    ' )			lxLiqtallerFaltafw = ctod( '  /  /    ' )			lxLiqtallerFectrans = ctod( '  /  /    ' )			lxLiqtallerBdmodifw = []			lxLiqtallerEsttrans = []			lxLiqtallerValtafw = []			lxLiqtallerBdaltafw = []			lxLiqtallerHaltafw = []			lxLiqtallerVmodifw = []			lxLiqtallerHoraexpo = []			lxLiqtallerSmodifw = []			lxLiqtallerUaltafw = []			lxLiqtallerHmodifw = []			lxLiqtallerSaltafw = []			lxLiqtallerUmodifw = []			lxLiqtallerHoraimpo = []			lxLiqtallerZadsfw = []			lxLiqtallerCodigo = []			lxLiqtallerTaller = []			lxLiqtallerProveedor = []			lxLiqtallerOrdendesde = []			lxLiqtallerOrdenhasta = []			lxLiqtallerProcdesde = []			lxLiqtallerProchasta = []			lxLiqtallerGestdesde = []			lxLiqtallerGesthasta = []			lxLiqtallerFecdesde = ctod( '  /  /    ' )			lxLiqtallerFechasta = ctod( '  /  /    ' )			lxLiqtallerNumero = 0			lxLiqtallerDescartes = 0			lxLiqtallerMoneda = []			lxLiqtallerInsumos = 0			lxLiqtallerListacosto = []			lxLiqtallerCobs = []			lxLiqtallerFtotal = 0			lxLiqtallerComprob = []			lxLiqtallerLetracomp = []			lxLiqtallerPuntocomp = 0			lxLiqtallerNumerocomp = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LIQTPROD where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LIQTDESC where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LIQTINS where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LIQTADIC where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.LIQTALLER where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'LIQTALLER' + '_' + tcCampo
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
		lcWhere = " Where  LIQTALLER.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Codigo" as "Codigo", "Taller" as "Taller", "Proveedor" as "Proveedor", "Ordendesde" as "Ordendesde", "Ordenhasta" as "Ordenhasta", "Procdesde" as "Procesodesde", "Prochasta" as "Procesohasta", "Gestdesde" as "Gestiondesde", "Gesthasta" as "Gestionhasta", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Numero" as "Numero", "Descartes" as "Descartes", "Moneda" as "Moneda", "Insumos" as "Insumos", "Listacosto" as "Listadecosto", "Cobs" as "Observ", "Ftotal" as "Total", "Comprob" as "Comprobante", "Letracomp" as "Letracomprobante", "Puntocomp" as "Puntodeventacomprobante", "Numerocomp" as "Numerocomprobante"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LIQTALLER', '', tnTope )
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
	Function ObtenerDatosDetalleGestionDeProduccion( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPAFE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleGestionDeProduccion( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompAfe', 'GestionDeProduccion', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleGestionDeProduccion( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleGestionDeProduccion( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleLiquidacionTallerProduccion( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQTPROD.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleLiquidacionTallerProduccion( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LIQTPROD', 'LiquidacionTallerProduccion', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleLiquidacionTallerProduccion( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleLiquidacionTallerProduccion( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleLiquidacionTallerDescarte( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQTDESC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleLiquidacionTallerDescarte( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LIQTDESC', 'LiquidacionTallerDescarte', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleLiquidacionTallerDescarte( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleLiquidacionTallerDescarte( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleLiquidacionTallerInsumos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQTINS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleLiquidacionTallerInsumos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LIQTINS', 'LiquidacionTallerInsumos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleLiquidacionTallerInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleLiquidacionTallerInsumos( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleLiquidacionTallerAdicionales( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQTADIC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleLiquidacionTallerAdicionales( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LIQTADIC', 'LiquidacionTallerAdicionales', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleLiquidacionTallerAdicionales( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleLiquidacionTallerAdicionales( lcAtributo )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDOR AS PROVEEDOR'
				Case lcAtributo == 'ORDENDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDENDESDE AS ORDENDESDE'
				Case lcAtributo == 'ORDENHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDENHASTA AS ORDENHASTA'
				Case lcAtributo == 'PROCESODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCDESDE AS PROCESODESDE'
				Case lcAtributo == 'PROCESOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCHASTA AS PROCESOHASTA'
				Case lcAtributo == 'GESTIONDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GESTDESDE AS GESTIONDESDE'
				Case lcAtributo == 'GESTIONHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GESTHASTA AS GESTIONHASTA'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECDESDE AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHASTA AS FECHAHASTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCARTES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCARTES AS DESCARTES'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDA'
				Case lcAtributo == 'INSUMOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMOS AS INSUMOS'
				Case lcAtributo == 'LISTADECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTACOSTO AS LISTADECOSTO'
				Case lcAtributo == 'OBSERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERV'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPROB AS COMPROBANTE'
				Case lcAtributo == 'LETRACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRACOMP AS LETRACOMPROBANTE'
				Case lcAtributo == 'PUNTODEVENTACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUNTOCOMP AS PUNTODEVENTACOMPROBANTE'
				Case lcAtributo == 'NUMEROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROCOMP AS NUMEROCOMPROBANTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleGestionDeProduccion( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS TIPOCOMPROBANTE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIPOCOMPCARACTER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECOMPROB AS TIPOCOMPCARACTER'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEFECHA AS FECHA'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETOTAL AS TOTAL'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEVEND AS VENDEDOR'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPO AS TIPO'
				Case lcAtributo == 'AFECTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECTA AS AFECTA'
				Case lcAtributo == 'INTERVINIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCINTER AS INTERVINIENTE'
				Case lcAtributo == 'NOMBREENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMINTER AS NOMBREENTIDAD'
				Case lcAtributo == 'CODIGOENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINTER AS CODIGOENTIDAD'
				Case lcAtributo == 'ORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGEN AS ORIGEN'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleLiquidacionTallerProduccion( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMINSUMO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'PROCESODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCDETA AS PROCESODETALLE'
				Case lcAtributo == 'SEMIELABORADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIELAB AS SEMIELABORADO'
				Case lcAtributo == 'SEMIELABORADODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIDETA AS SEMIELABORADODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORDETA AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLEDETA AS TALLEDETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTLIQ AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESC AS ARTICULODETALLE'
				Case lcAtributo == 'COSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTO AS COSTO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleLiquidacionTallerDescarte( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMINSUMO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'PROCESODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCDETA AS PROCESODETALLE'
				Case lcAtributo == 'SEMIELABORADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIELAB AS SEMIELABORADO'
				Case lcAtributo == 'SEMIELABORADODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIDETA AS SEMIELABORADODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORDETA AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLEDETA AS TALLEDETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTLIQ AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESC AS ARTICULODETALLE'
				Case lcAtributo == 'COSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTO AS COSTO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleLiquidacionTallerInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMINSUMO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'PROCESODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCDETA AS PROCESODETALLE'
				Case lcAtributo == 'INSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMO AS INSUMO'
				Case lcAtributo == 'INSUMODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSDETA AS INSUMODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORDETA AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLEDETA AS TALLEDETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTLIQ AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESC AS ARTICULODETALLE'
				Case lcAtributo == 'COSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTO AS COSTO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleLiquidacionTallerAdicionales( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTLIQ AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESC AS ARTICULODETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'COSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTO AS COSTO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVEEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDESDE'
				lcCampo = 'ORDENDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENHASTA'
				lcCampo = 'ORDENHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODESDE'
				lcCampo = 'PROCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESOHASTA'
				lcCampo = 'PROCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'GESTIONDESDE'
				lcCampo = 'GESTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'GESTIONHASTA'
				lcCampo = 'GESTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCARTES'
				lcCampo = 'DESCARTES'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMOS'
				lcCampo = 'INSUMOS'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADECOSTO'
				lcCampo = 'LISTACOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERV'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'LETRACOMPROBANTE'
				lcCampo = 'LETRACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTACOMPROBANTE'
				lcCampo = 'PUNTOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMPROBANTE'
				lcCampo = 'NUMEROCOMP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleGestionDeProduccion( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPCARACTER'
				lcCampo = 'AFECOMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'AFEFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'AFETOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'AFEVEND'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'AFETIPO'
			Case upper( alltrim( tcAtributo ) ) == 'AFECTA'
				lcCampo = 'AFECTA'
			Case upper( alltrim( tcAtributo ) ) == 'INTERVINIENTE'
				lcCampo = 'DESCINTER'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBREENTIDAD'
				lcCampo = 'NOMINTER'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOENTIDAD'
				lcCampo = 'CODINTER'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGEN'
				lcCampo = 'ORIGEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleLiquidacionTallerProduccion( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMINSUMO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODETALLE'
				lcCampo = 'PROCDETA'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADO'
				lcCampo = 'SEMIELAB'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADODETALLE'
				lcCampo = 'SEMIDETA'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLORDETA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TALLEDETA'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'ARTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'COSTO'
				lcCampo = 'COSTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleLiquidacionTallerDescarte( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMINSUMO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODETALLE'
				lcCampo = 'PROCDETA'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADO'
				lcCampo = 'SEMIELAB'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADODETALLE'
				lcCampo = 'SEMIDETA'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLORDETA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TALLEDETA'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'ARTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'COSTO'
				lcCampo = 'COSTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleLiquidacionTallerInsumos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMINSUMO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODETALLE'
				lcCampo = 'PROCDETA'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMO'
				lcCampo = 'INSUMO'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMODETALLE'
				lcCampo = 'INSDETA'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLORDETA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TALLEDETA'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'ARTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'COSTO'
				lcCampo = 'COSTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleLiquidacionTallerAdicionales( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'ARTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'COSTO'
				lcCampo = 'COSTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'GESTIONDEPRODUCCION'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'LIQUIDACIONTALLERPRODUCCION'
			lcRetorno = 'LIQTPROD'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'LIQUIDACIONTALLERDESCARTE'
			lcRetorno = 'LIQTDESC'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'LIQUIDACIONTALLERINSUMOS'
			lcRetorno = 'LIQTINS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'LIQUIDACIONTALLERADICIONALES'
			lcRetorno = 'LIQTADIC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxLiqtallerFecimpo, lxLiqtallerFecexpo, lxLiqtallerFmodifw, lxLiqtallerFaltafw, lxLiqtallerFectrans, lxLiqtallerBdmodifw, lxLiqtallerEsttrans, lxLiqtallerValtafw, lxLiqtallerBdaltafw, lxLiqtallerHaltafw, lxLiqtallerVmodifw, lxLiqtallerHoraexpo, lxLiqtallerSmodifw, lxLiqtallerUaltafw, lxLiqtallerHmodifw, lxLiqtallerSaltafw, lxLiqtallerUmodifw, lxLiqtallerHoraimpo, lxLiqtallerZadsfw, lxLiqtallerCodigo, lxLiqtallerTaller, lxLiqtallerProveedor, lxLiqtallerOrdendesde, lxLiqtallerOrdenhasta, lxLiqtallerProcdesde, lxLiqtallerProchasta, lxLiqtallerGestdesde, lxLiqtallerGesthasta, lxLiqtallerFecdesde, lxLiqtallerFechasta, lxLiqtallerNumero, lxLiqtallerDescartes, lxLiqtallerMoneda, lxLiqtallerInsumos, lxLiqtallerListacosto, lxLiqtallerCobs, lxLiqtallerFtotal, lxLiqtallerComprob, lxLiqtallerLetracomp, lxLiqtallerPuntocomp, lxLiqtallerNumerocomp
				lxLiqtallerFecimpo =  .Fechaimpo			lxLiqtallerFecexpo =  .Fechaexpo			lxLiqtallerFmodifw =  .Fechamodificacionfw			lxLiqtallerFaltafw =  .Fechaaltafw			lxLiqtallerFectrans =  .Fechatransferencia			lxLiqtallerBdmodifw =  .Basededatosmodificacionfw			lxLiqtallerEsttrans =  .Estadotransferencia			lxLiqtallerValtafw =  .Versionaltafw			lxLiqtallerBdaltafw =  .Basededatosaltafw			lxLiqtallerHaltafw =  .Horaaltafw			lxLiqtallerVmodifw =  .Versionmodificacionfw			lxLiqtallerHoraexpo =  .Horaexpo			lxLiqtallerSmodifw =  .Seriemodificacionfw			lxLiqtallerUaltafw =  .Usuarioaltafw			lxLiqtallerHmodifw =  .Horamodificacionfw			lxLiqtallerSaltafw =  .Seriealtafw			lxLiqtallerUmodifw =  .Usuariomodificacionfw			lxLiqtallerHoraimpo =  .Horaimpo			lxLiqtallerZadsfw =  .Zadsfw			lxLiqtallerCodigo =  .Codigo			lxLiqtallerTaller =  upper( .Taller_PK ) 			lxLiqtallerProveedor =  upper( .Proveedor_PK ) 			lxLiqtallerOrdendesde =  .Ordendesde			lxLiqtallerOrdenhasta =  .Ordenhasta			lxLiqtallerProcdesde =  upper( .ProcesoDesde_PK ) 			lxLiqtallerProchasta =  upper( .ProcesoHasta_PK ) 			lxLiqtallerGestdesde =  .Gestiondesde			lxLiqtallerGesthasta =  .Gestionhasta			lxLiqtallerFecdesde =  .Fechadesde			lxLiqtallerFechasta =  .Fechahasta			lxLiqtallerNumero =  .Numero			lxLiqtallerDescartes =  .Descartes			lxLiqtallerMoneda =  upper( .Moneda_PK ) 			lxLiqtallerInsumos =  .Insumos			lxLiqtallerListacosto =  upper( .ListaDeCosto_PK ) 			lxLiqtallerCobs =  .Observ			lxLiqtallerFtotal =  .Total			lxLiqtallerComprob =  .Comprobante			lxLiqtallerLetracomp =  .Letracomprobante			lxLiqtallerPuntocomp =  .Puntodeventacomprobante			lxLiqtallerNumerocomp =  .Numerocomprobante
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.LIQTALLER ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Bdmodifw","Esttrans","Valtafw","Bdaltafw","Haltafw","Vmodifw","Horaexpo","Smodifw","Ualtafw","Hmodifw","Saltafw","Umodifw","Horaimpo","Zadsfw","Codigo","Taller","Proveedor","Ordendesde","Ordenhasta","Procdesde","Prochasta","Gestdesde","Gesthasta","Fecdesde","Fechasta","Numero","Descartes","Moneda","Insumos","Listacosto","Cobs","Ftotal","Comprob","Letracomp","Puntocomp","Numerocomp" ) values ( <<"'" + this.ConvertirDateSql( lxLiqtallerFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerTaller ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerProveedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerOrdendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerOrdenhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerProcdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerProchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerGestdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerGesthasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFecdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqtallerFechasta ) + "'" >>, <<lxLiqtallerNumero >>, <<lxLiqtallerDescartes >>, <<"'" + this.FormatearTextoSql( lxLiqtallerMoneda ) + "'" >>, <<lxLiqtallerInsumos >>, <<"'" + this.FormatearTextoSql( lxLiqtallerListacosto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerCobs ) + "'" >>, <<lxLiqtallerFtotal >>, <<"'" + this.FormatearTextoSql( lxLiqtallerComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqtallerLetracomp ) + "'" >>, <<lxLiqtallerPuntocomp >>, <<lxLiqtallerNumerocomp >> )
		endtext
		loColeccion.cTabla = 'LIQTALLER' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionDeProduccion
				if this.oEntidad.GestionDeProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerProduccion
				if this.oEntidad.LiquidacionTallerProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTPROD("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerDescarte
				if this.oEntidad.LiquidacionTallerDescarte.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTDESC("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerInsumos
				if this.oEntidad.LiquidacionTallerInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTINS("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerAdicionales
				if this.oEntidad.LiquidacionTallerAdicionales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulo = loItem.Iditemarticulo
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCantidad = loItem.Cantidad
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTADIC("IdItem","NROITEM","Codigo","ArtLiq","ArtDesc","Cantidad","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCantidad>>, <<lxCosto>>, <<lxMonto>> ) 
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
			local  lxLiqtallerFecimpo, lxLiqtallerFecexpo, lxLiqtallerFmodifw, lxLiqtallerFaltafw, lxLiqtallerFectrans, lxLiqtallerBdmodifw, lxLiqtallerEsttrans, lxLiqtallerValtafw, lxLiqtallerBdaltafw, lxLiqtallerHaltafw, lxLiqtallerVmodifw, lxLiqtallerHoraexpo, lxLiqtallerSmodifw, lxLiqtallerUaltafw, lxLiqtallerHmodifw, lxLiqtallerSaltafw, lxLiqtallerUmodifw, lxLiqtallerHoraimpo, lxLiqtallerZadsfw, lxLiqtallerCodigo, lxLiqtallerTaller, lxLiqtallerProveedor, lxLiqtallerOrdendesde, lxLiqtallerOrdenhasta, lxLiqtallerProcdesde, lxLiqtallerProchasta, lxLiqtallerGestdesde, lxLiqtallerGesthasta, lxLiqtallerFecdesde, lxLiqtallerFechasta, lxLiqtallerNumero, lxLiqtallerDescartes, lxLiqtallerMoneda, lxLiqtallerInsumos, lxLiqtallerListacosto, lxLiqtallerCobs, lxLiqtallerFtotal, lxLiqtallerComprob, lxLiqtallerLetracomp, lxLiqtallerPuntocomp, lxLiqtallerNumerocomp
				lxLiqtallerFecimpo =  .Fechaimpo			lxLiqtallerFecexpo =  .Fechaexpo			lxLiqtallerFmodifw =  .Fechamodificacionfw			lxLiqtallerFaltafw =  .Fechaaltafw			lxLiqtallerFectrans =  .Fechatransferencia			lxLiqtallerBdmodifw =  .Basededatosmodificacionfw			lxLiqtallerEsttrans =  .Estadotransferencia			lxLiqtallerValtafw =  .Versionaltafw			lxLiqtallerBdaltafw =  .Basededatosaltafw			lxLiqtallerHaltafw =  .Horaaltafw			lxLiqtallerVmodifw =  .Versionmodificacionfw			lxLiqtallerHoraexpo =  .Horaexpo			lxLiqtallerSmodifw =  .Seriemodificacionfw			lxLiqtallerUaltafw =  .Usuarioaltafw			lxLiqtallerHmodifw =  .Horamodificacionfw			lxLiqtallerSaltafw =  .Seriealtafw			lxLiqtallerUmodifw =  .Usuariomodificacionfw			lxLiqtallerHoraimpo =  .Horaimpo			lxLiqtallerZadsfw =  .Zadsfw			lxLiqtallerCodigo =  .Codigo			lxLiqtallerTaller =  upper( .Taller_PK ) 			lxLiqtallerProveedor =  upper( .Proveedor_PK ) 			lxLiqtallerOrdendesde =  .Ordendesde			lxLiqtallerOrdenhasta =  .Ordenhasta			lxLiqtallerProcdesde =  upper( .ProcesoDesde_PK ) 			lxLiqtallerProchasta =  upper( .ProcesoHasta_PK ) 			lxLiqtallerGestdesde =  .Gestiondesde			lxLiqtallerGesthasta =  .Gestionhasta			lxLiqtallerFecdesde =  .Fechadesde			lxLiqtallerFechasta =  .Fechahasta			lxLiqtallerNumero =  .Numero			lxLiqtallerDescartes =  .Descartes			lxLiqtallerMoneda =  upper( .Moneda_PK ) 			lxLiqtallerInsumos =  .Insumos			lxLiqtallerListacosto =  upper( .ListaDeCosto_PK ) 			lxLiqtallerCobs =  .Observ			lxLiqtallerFtotal =  .Total			lxLiqtallerComprob =  .Comprobante			lxLiqtallerLetracomp =  .Letracomprobante			lxLiqtallerPuntocomp =  .Puntodeventacomprobante			lxLiqtallerNumerocomp =  .Numerocomprobante
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  LIQTALLER.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.LIQTALLER set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLiqtallerFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLiqtallerFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLiqtallerFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxLiqtallerFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxLiqtallerFectrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxLiqtallerEsttrans ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerValtafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerHaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxLiqtallerHoraexpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxLiqtallerSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxLiqtallerUmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxLiqtallerHoraimpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxLiqtallerZadsfw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqtallerCodigo ) + "'">>, "Taller" = <<"'" + this.FormatearTextoSql( lxLiqtallerTaller ) + "'">>, "Proveedor" = <<"'" + this.FormatearTextoSql( lxLiqtallerProveedor ) + "'">>, "Ordendesde" = <<"'" + this.FormatearTextoSql( lxLiqtallerOrdendesde ) + "'">>, "Ordenhasta" = <<"'" + this.FormatearTextoSql( lxLiqtallerOrdenhasta ) + "'">>, "Procdesde" = <<"'" + this.FormatearTextoSql( lxLiqtallerProcdesde ) + "'">>, "Prochasta" = <<"'" + this.FormatearTextoSql( lxLiqtallerProchasta ) + "'">>, "Gestdesde" = <<"'" + this.FormatearTextoSql( lxLiqtallerGestdesde ) + "'">>, "Gesthasta" = <<"'" + this.FormatearTextoSql( lxLiqtallerGesthasta ) + "'">>, "Fecdesde" = <<"'" + this.ConvertirDateSql( lxLiqtallerFecdesde ) + "'">>, "Fechasta" = <<"'" + this.ConvertirDateSql( lxLiqtallerFechasta ) + "'">>, "Numero" = <<lxLiqtallerNumero>>, "Descartes" = <<lxLiqtallerDescartes>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxLiqtallerMoneda ) + "'">>, "Insumos" = <<lxLiqtallerInsumos>>, "Listacosto" = <<"'" + this.FormatearTextoSql( lxLiqtallerListacosto ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxLiqtallerCobs ) + "'">>, "Ftotal" = <<lxLiqtallerFtotal>>, "Comprob" = <<"'" + this.FormatearTextoSql( lxLiqtallerComprob ) + "'">>, "Letracomp" = <<"'" + this.FormatearTextoSql( lxLiqtallerLetracomp ) + "'">>, "Puntocomp" = <<lxLiqtallerPuntocomp>>, "Numerocomp" = <<lxLiqtallerNumerocomp>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'LIQTALLER' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LIQTPROD where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LIQTDESC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LIQTINS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LIQTADIC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionDeProduccion
				if this.oEntidad.GestionDeProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerProduccion
				if this.oEntidad.LiquidacionTallerProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTPROD("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerDescarte
				if this.oEntidad.LiquidacionTallerDescarte.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTDESC("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerInsumos
				if this.oEntidad.LiquidacionTallerInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTINS("IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.LiquidacionTallerAdicionales
				if this.oEntidad.LiquidacionTallerAdicionales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulo = loItem.Iditemarticulo
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxCantidad = loItem.Cantidad
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LIQTADIC("IdItem","NROITEM","Codigo","ArtLiq","ArtDesc","Cantidad","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCantidad>>, <<lxCosto>>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  LIQTALLER.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.LIQTALLER where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LIQTPROD where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LIQTDESC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LIQTINS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LIQTADIC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'LIQTALLER' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.LIQTALLER where  LIQTALLER.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.LIQTALLER where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  LIQTALLER.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxLIQTALLERNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDETALLER'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.LIQTALLER Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.LIQTALLER set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Taller = ] + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'"+ [, Proveedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'"+ [, OrdenDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..OrdenDesde ) + "'"+ [, OrdenHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..OrdenHasta ) + "'"+ [, ProcDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProcDesde ) + "'"+ [, ProcHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProcHasta ) + "'"+ [, GestDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..GestDesde ) + "'"+ [, GestHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..GestHasta ) + "'"+ [, fecdesde = ] + "'" + this.ConvertirDateSql( &lcCursor..fecdesde ) + "'"+ [, fechasta = ] + "'" + this.ConvertirDateSql( &lcCursor..fechasta ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Descartes = ] + transform( &lcCursor..Descartes )+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Insumos = ] + transform( &lcCursor..Insumos )+ [, ListaCosto = ] + "'" + this.FormatearTextoSql( &lcCursor..ListaCosto ) + "'"+ [, CObs = ] + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, Comprob = ] + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'"+ [, LetraComp = ] + "'" + this.FormatearTextoSql( &lcCursor..LetraComp ) + "'"+ [, PuntoComp = ] + transform( &lcCursor..PuntoComp )+ [, NumeroComp = ] + transform( &lcCursor..NumeroComp ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.LIQTALLER Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECEXPO, FMODIFW, FALTAFW, FECTRANS, BDMODIFW, ESTTRANS, VALTAFW, BDALTAFW, HALTAFW, VMODIFW, HORAEXPO, SMODIFW, UALTAFW, HMODIFW, SALTAFW, UMODIFW, HORAIMPO, ZADSFW, Codigo, Taller, Proveedor, OrdenDesde, OrdenHasta, ProcDesde, ProcHasta, GestDesde, GestHasta, fecdesde, fechasta, Numero, Descartes, Moneda, Insumos, ListaCosto, CObs, FTotal, Comprob, LetraComp, PuntoComp, NumeroComp
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OrdenDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OrdenHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProcDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProcHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GestDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..GestHasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..fecdesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechasta ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + transform( &lcCursor..Descartes ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + transform( &lcCursor..Insumos ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ListaCosto ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LetraComp ) + "'" + ',' + transform( &lcCursor..PuntoComp ) + ',' + transform( &lcCursor..NumeroComp )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.LIQTALLER ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDETALLER'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.LIQTPROD Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.LIQTDESC Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.LIQTINS Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.LIQTADIC Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMPROBANTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMLIQTALLERPRODUCCION'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.LIQTPROD ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.Comp       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ProcDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiElab   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDeta  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtLiq     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtDesc    ) + "'" + ',' + transform( cDetallesExistentes.Costo      ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMLIQTALLERDESCARTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.LIQTDESC ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.Comp       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ProcDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiElab   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDeta  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtLiq     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtDesc    ) + "'" + ',' + transform( cDetallesExistentes.Costo      ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMLIQTALLERINSUMOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","Comp","NROITEM","Codigo","Proceso","ProcDeta","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.LIQTINS ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.Comp       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ProcDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Insumo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InsDeta    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDeta  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtLiq     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtDesc    ) + "'" + ',' + transform( cDetallesExistentes.Costo      ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMLIQTALLERADICIONAL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","NROITEM","Codigo","ArtLiq","ArtDesc","Cantidad","Costo","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.LIQTADIC ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtLiq     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtDesc    ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + transform( cDetallesExistentes.Costo      ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Numero     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONDETALLER'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONDETALLER_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONDETALLER_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMLIQTALLERPRODUCCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMLIQTALLERDESCARTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMLIQTALLERINSUMOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMLIQTALLERADICIONAL'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_LIQTALLER')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'LIQUIDACIONDETALLER'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad LIQUIDACIONDETALLER. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDETALLER'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( Numero, 12, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( Numero, 12, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDETALLER'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  fecdesde  
		* Validar ANTERIORES A 1/1/1753  fechasta  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LIQTALLER') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LIQTALLER
Create Table ZooLogic.TablaTrabajo_LIQTALLER ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"valtafw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"codigo" char( 38 )  null, 
"taller" char( 15 )  null, 
"proveedor" char( 10 )  null, 
"ordendesde" char( 12 )  null, 
"ordenhasta" char( 12 )  null, 
"procdesde" char( 15 )  null, 
"prochasta" char( 15 )  null, 
"gestdesde" char( 12 )  null, 
"gesthasta" char( 12 )  null, 
"fecdesde" datetime  null, 
"fechasta" datetime  null, 
"numero" numeric( 12, 0 )  null, 
"descartes" numeric( 2, 0 )  null, 
"moneda" char( 10 )  null, 
"insumos" numeric( 2, 0 )  null, 
"listacosto" char( 6 )  null, 
"cobs" varchar(max)  null, 
"ftotal" numeric( 15, 2 )  null, 
"comprob" char( 20 )  null, 
"letracomp" char( 1 )  null, 
"puntocomp" numeric( 5, 0 )  null, 
"numerocomp" numeric( 8, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_LIQTALLER' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_LIQTALLER' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONDETALLER'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('taller','taller')
			.AgregarMapeo('proveedor','proveedor')
			.AgregarMapeo('ordendesde','ordendesde')
			.AgregarMapeo('ordenhasta','ordenhasta')
			.AgregarMapeo('procdesde','procdesde')
			.AgregarMapeo('prochasta','prochasta')
			.AgregarMapeo('gestdesde','gestdesde')
			.AgregarMapeo('gesthasta','gesthasta')
			.AgregarMapeo('fecdesde','fecdesde')
			.AgregarMapeo('fechasta','fechasta')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descartes','descartes')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('insumos','insumos')
			.AgregarMapeo('listacosto','listacosto')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('comprob','comprob')
			.AgregarMapeo('letracomp','letracomp')
			.AgregarMapeo('puntocomp','puntocomp')
			.AgregarMapeo('numerocomp','numerocomp')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_LIQTALLER'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.TALLER = isnull( d.TALLER, t.TALLER ),t.PROVEEDOR = isnull( d.PROVEEDOR, t.PROVEEDOR ),t.ORDENDESDE = isnull( d.ORDENDESDE, t.ORDENDESDE ),t.ORDENHASTA = isnull( d.ORDENHASTA, t.ORDENHASTA ),t.PROCDESDE = isnull( d.PROCDESDE, t.PROCDESDE ),t.PROCHASTA = isnull( d.PROCHASTA, t.PROCHASTA ),t.GESTDESDE = isnull( d.GESTDESDE, t.GESTDESDE ),t.GESTHASTA = isnull( d.GESTHASTA, t.GESTHASTA ),t.FECDESDE = isnull( d.FECDESDE, t.FECDESDE ),t.FECHASTA = isnull( d.FECHASTA, t.FECHASTA ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCARTES = isnull( d.DESCARTES, t.DESCARTES ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.INSUMOS = isnull( d.INSUMOS, t.INSUMOS ),t.LISTACOSTO = isnull( d.LISTACOSTO, t.LISTACOSTO ),t.COBS = isnull( d.COBS, t.COBS ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.COMPROB = isnull( d.COMPROB, t.COMPROB ),t.LETRACOMP = isnull( d.LETRACOMP, t.LETRACOMP ),t.PUNTOCOMP = isnull( d.PUNTOCOMP, t.PUNTOCOMP ),t.NUMEROCOMP = isnull( d.NUMEROCOMP, t.NUMEROCOMP )
					from ZooLogic.LIQTALLER t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.LIQTALLER(Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Bdmodifw,Esttrans,Valtafw,Bdaltafw,Haltafw,Vmodifw,Horaexpo,Smodifw,Ualtafw,Hmodifw,Saltafw,Umodifw,Horaimpo,Zadsfw,Codigo,Taller,Proveedor,Ordendesde,Ordenhasta,Procdesde,Prochasta,Gestdesde,Gesthasta,Fecdesde,Fechasta,Numero,Descartes,Moneda,Insumos,Listacosto,Cobs,Ftotal,Comprob,Letracomp,Puntocomp,Numerocomp)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.VALTAFW,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.ZADSFW,''),isnull( d.CODIGO,''),isnull( d.TALLER,''),isnull( d.PROVEEDOR,''),isnull( d.ORDENDESDE,''),isnull( d.ORDENHASTA,''),isnull( d.PROCDESDE,''),isnull( d.PROCHASTA,''),isnull( d.GESTDESDE,''),isnull( d.GESTHASTA,''),isnull( d.FECDESDE,''),isnull( d.FECHASTA,''),isnull( d.NUMERO,0),isnull( d.DESCARTES,0),isnull( d.MONEDA,''),isnull( d.INSUMOS,0),isnull( d.LISTACOSTO,''),isnull( d.COBS,''),isnull( d.FTOTAL,0),isnull( d.COMPROB,''),isnull( d.LETRACOMP,''),isnull( d.PUNTOCOMP,0),isnull( d.NUMEROCOMP,0)
						From deleted d left join ZooLogic.LIQTALLER pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.LIQTALLER cc 
							 on  d.Numero = cc.Numero
						Where pk.Codigo Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal no es la esperada'
					from ZooLogic.LIQTALLER t inner join deleted d 
							on   t.Numero = d.Numero
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal a importar ya existe'
					from ZooLogic.LIQTALLER t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQTALLER_CompAfe
ON ZooLogic.TablaTrabajo_LIQTALLER_CompAfe
AFTER DELETE
As
Begin
Update t Set 
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AFECOMPROB = isnull( d.AFECOMPROB, t.AFECOMPROB ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEFECHA = isnull( d.AFEFECHA, t.AFEFECHA ),
t.AFETOTAL = isnull( d.AFETOTAL, t.AFETOTAL ),
t.AFEVEND = isnull( d.AFEVEND, t.AFEVEND ),
t.AFETIPO = isnull( d.AFETIPO, t.AFETIPO ),
t.AFECTA = isnull( d.AFECTA, t.AFECTA ),
t.DESCINTER = isnull( d.DESCINTER, t.DESCINTER ),
t.NOMINTER = isnull( d.NOMINTER, t.NOMINTER ),
t.CODINTER = isnull( d.CODINTER, t.CODINTER ),
t.ORIGEN = isnull( d.ORIGEN, t.ORIGEN )
from ZooLogic.CompAfe t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CompAfe
( 
"AFETIPOCOM",
"NROITEM",
"CODIGO",
"AFECOMPROB",
"AFELETRA",
"AFEPTOVEN",
"AFENUMCOM",
"AFEFECHA",
"AFETOTAL",
"AFEVEND",
"AFETIPO",
"AFECTA",
"DESCINTER",
"NOMINTER",
"CODINTER",
"ORIGEN"
 )
Select 
d.AFETIPOCOM,
d.NROITEM,
d.CODIGO,
d.AFECOMPROB,
d.AFELETRA,
d.AFEPTOVEN,
d.AFENUMCOM,
d.AFEFECHA,
d.AFETOTAL,
d.AFEVEND,
d.AFETIPO,
d.AFECTA,
d.DESCINTER,
d.NOMINTER,
d.CODINTER,
d.ORIGEN
From deleted d left join ZooLogic.CompAfe pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_LIQTPROD( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQTALLER_LIQTPROD
ON ZooLogic.TablaTrabajo_LIQTALLER_LIQTPROD
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.PROCDETA = isnull( d.PROCDETA, t.PROCDETA ),
t.SEMIELAB = isnull( d.SEMIELAB, t.SEMIELAB ),
t.SEMIDETA = isnull( d.SEMIDETA, t.SEMIDETA ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.COLORDETA = isnull( d.COLORDETA, t.COLORDETA ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.TALLEDETA = isnull( d.TALLEDETA, t.TALLEDETA ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.ARTLIQ = isnull( d.ARTLIQ, t.ARTLIQ ),
t.ARTDESC = isnull( d.ARTDESC, t.ARTDESC ),
t.COSTO = isnull( d.COSTO, t.COSTO ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.LIQTPROD t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.LIQTPROD
( 
"IDITEM",
"COMP",
"NROITEM",
"CODIGO",
"PROCESO",
"PROCDETA",
"SEMIELAB",
"SEMIDETA",
"CODCOLOR",
"COLORDETA",
"CODTALLE",
"TALLEDETA",
"CANTIDAD",
"ARTLIQ",
"ARTDESC",
"COSTO",
"MONTO"
 )
Select 
d.IDITEM,
d.COMP,
d.NROITEM,
d.CODIGO,
d.PROCESO,
d.PROCDETA,
d.SEMIELAB,
d.SEMIDETA,
d.CODCOLOR,
d.COLORDETA,
d.CODTALLE,
d.TALLEDETA,
d.CANTIDAD,
d.ARTLIQ,
d.ARTDESC,
d.COSTO,
d.MONTO
From deleted d left join ZooLogic.LIQTPROD pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_LIQTDESC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQTALLER_LIQTDESC
ON ZooLogic.TablaTrabajo_LIQTALLER_LIQTDESC
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.PROCDETA = isnull( d.PROCDETA, t.PROCDETA ),
t.SEMIELAB = isnull( d.SEMIELAB, t.SEMIELAB ),
t.SEMIDETA = isnull( d.SEMIDETA, t.SEMIDETA ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.COLORDETA = isnull( d.COLORDETA, t.COLORDETA ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.TALLEDETA = isnull( d.TALLEDETA, t.TALLEDETA ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.ARTLIQ = isnull( d.ARTLIQ, t.ARTLIQ ),
t.ARTDESC = isnull( d.ARTDESC, t.ARTDESC ),
t.COSTO = isnull( d.COSTO, t.COSTO ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.LIQTDESC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.LIQTDESC
( 
"IDITEM",
"COMP",
"NROITEM",
"CODIGO",
"PROCESO",
"PROCDETA",
"SEMIELAB",
"SEMIDETA",
"CODCOLOR",
"COLORDETA",
"CODTALLE",
"TALLEDETA",
"CANTIDAD",
"ARTLIQ",
"ARTDESC",
"COSTO",
"MONTO"
 )
Select 
d.IDITEM,
d.COMP,
d.NROITEM,
d.CODIGO,
d.PROCESO,
d.PROCDETA,
d.SEMIELAB,
d.SEMIDETA,
d.CODCOLOR,
d.COLORDETA,
d.CODTALLE,
d.TALLEDETA,
d.CANTIDAD,
d.ARTLIQ,
d.ARTDESC,
d.COSTO,
d.MONTO
From deleted d left join ZooLogic.LIQTDESC pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_LIQTINS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQTALLER_LIQTINS
ON ZooLogic.TablaTrabajo_LIQTALLER_LIQTINS
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.PROCDETA = isnull( d.PROCDETA, t.PROCDETA ),
t.INSUMO = isnull( d.INSUMO, t.INSUMO ),
t.INSDETA = isnull( d.INSDETA, t.INSDETA ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.COLORDETA = isnull( d.COLORDETA, t.COLORDETA ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.TALLEDETA = isnull( d.TALLEDETA, t.TALLEDETA ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.ARTLIQ = isnull( d.ARTLIQ, t.ARTLIQ ),
t.ARTDESC = isnull( d.ARTDESC, t.ARTDESC ),
t.COSTO = isnull( d.COSTO, t.COSTO ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.LIQTINS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.LIQTINS
( 
"IDITEM",
"COMP",
"NROITEM",
"CODIGO",
"PROCESO",
"PROCDETA",
"INSUMO",
"INSDETA",
"CODCOLOR",
"COLORDETA",
"CODTALLE",
"TALLEDETA",
"CANTIDAD",
"ARTLIQ",
"ARTDESC",
"COSTO",
"MONTO"
 )
Select 
d.IDITEM,
d.COMP,
d.NROITEM,
d.CODIGO,
d.PROCESO,
d.PROCDETA,
d.INSUMO,
d.INSDETA,
d.CODCOLOR,
d.COLORDETA,
d.CODTALLE,
d.TALLEDETA,
d.CANTIDAD,
d.ARTLIQ,
d.ARTDESC,
d.COSTO,
d.MONTO
From deleted d left join ZooLogic.LIQTINS pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_LIQTADIC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQTALLER_LIQTADIC
ON ZooLogic.TablaTrabajo_LIQTALLER_LIQTADIC
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.ARTLIQ = isnull( d.ARTLIQ, t.ARTLIQ ),
t.ARTDESC = isnull( d.ARTDESC, t.ARTDESC ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.COSTO = isnull( d.COSTO, t.COSTO ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.LIQTADIC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.LIQTADIC
( 
"IDITEM",
"NROITEM",
"CODIGO",
"ARTLIQ",
"ARTDESC",
"CANTIDAD",
"COSTO",
"MONTO"
 )
Select 
d.IDITEM,
d.NROITEM,
d.CODIGO,
d.ARTLIQ,
d.ARTDESC,
d.CANTIDAD,
d.COSTO,
d.MONTO
From deleted d left join ZooLogic.LIQTADIC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LIQTALLER') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LIQTALLER
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_LIQUIDACIONDETALLER' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDETALLER.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDETALLER.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDETALLER.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDETALLER.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDETALLER.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Gestiondeproduccion.Limpiar()
					.Gestiondeproduccion.SetearEsNavegacion( .lProcesando )
					.Gestiondeproduccion.Cargar()
					.Basededatosmodificacionfw = nvl( c_LIQUIDACIONDETALLER.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_LIQUIDACIONDETALLER.Estadotransferencia, [] )
					.Versionaltafw = nvl( c_LIQUIDACIONDETALLER.Versionaltafw, [] )
					.Basededatosaltafw = nvl( c_LIQUIDACIONDETALLER.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_LIQUIDACIONDETALLER.Horaaltafw, [] )
					.Versionmodificacionfw = nvl( c_LIQUIDACIONDETALLER.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_LIQUIDACIONDETALLER.Horaexpo, [] )
					.Seriemodificacionfw = nvl( c_LIQUIDACIONDETALLER.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_LIQUIDACIONDETALLER.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_LIQUIDACIONDETALLER.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_LIQUIDACIONDETALLER.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_LIQUIDACIONDETALLER.Usuariomodificacionfw, [] )
					.Horaimpo = nvl( c_LIQUIDACIONDETALLER.Horaimpo, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Codigo = nvl( c_LIQUIDACIONDETALLER.Codigo, [] )
					.Taller_PK =  nvl( c_LIQUIDACIONDETALLER.Taller, [] )
					.Liquidaciontallerproduccion.Limpiar()
					.Liquidaciontallerproduccion.SetearEsNavegacion( .lProcesando )
					.Liquidaciontallerproduccion.Cargar()
					.Liquidaciontallerdescarte.Limpiar()
					.Liquidaciontallerdescarte.SetearEsNavegacion( .lProcesando )
					.Liquidaciontallerdescarte.Cargar()
					.Liquidaciontallerinsumos.Limpiar()
					.Liquidaciontallerinsumos.SetearEsNavegacion( .lProcesando )
					.Liquidaciontallerinsumos.Cargar()
					.Liquidaciontalleradicionales.Limpiar()
					.Liquidaciontalleradicionales.SetearEsNavegacion( .lProcesando )
					.Liquidaciontalleradicionales.Cargar()
					.Proveedor_PK =  nvl( c_LIQUIDACIONDETALLER.Proveedor, [] )
					.Ordendesde = nvl( c_LIQUIDACIONDETALLER.Ordendesde, [] )
					.Ordenhasta = nvl( c_LIQUIDACIONDETALLER.Ordenhasta, [] )
					.Procesodesde_PK =  nvl( c_LIQUIDACIONDETALLER.Procesodesde, [] )
					.Procesohasta_PK =  nvl( c_LIQUIDACIONDETALLER.Procesohasta, [] )
					.Gestiondesde = nvl( c_LIQUIDACIONDETALLER.Gestiondesde, [] )
					.Gestionhasta = nvl( c_LIQUIDACIONDETALLER.Gestionhasta, [] )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDETALLER.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONDETALLER.Fechahasta, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_LIQUIDACIONDETALLER.Numero, 0 )
					.Descartes = nvl( c_LIQUIDACIONDETALLER.Descartes, 0 )
					.Moneda_PK =  nvl( c_LIQUIDACIONDETALLER.Moneda, [] )
					.Insumos = nvl( c_LIQUIDACIONDETALLER.Insumos, 0 )
					.Listadecosto_PK =  nvl( c_LIQUIDACIONDETALLER.Listadecosto, [] )
					lcValor = This.ObtenerMemo( 'c_Observ')
					.Observ = lcValor 
					.Total = nvl( c_LIQUIDACIONDETALLER.Total, 0 )
					.Comprobante = nvl( c_LIQUIDACIONDETALLER.Comprobante, [] )
					.Letracomprobante = nvl( c_LIQUIDACIONDETALLER.Letracomprobante, [] )
					.Puntodeventacomprobante = nvl( c_LIQUIDACIONDETALLER.Puntodeventacomprobante, 0 )
					.Numerocomprobante = nvl( c_LIQUIDACIONDETALLER.Numerocomprobante, 0 )
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
			lxRetorno = c_LIQUIDACIONDETALLER.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.GestionDeProduccion
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

		loDetalle = this.oEntidad.LiquidacionTallerProduccion
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

		loDetalle = this.oEntidad.LiquidacionTallerDescarte
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

		loDetalle = this.oEntidad.LiquidacionTallerInsumos
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

		loDetalle = this.oEntidad.LiquidacionTallerAdicionales
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
		return c_LIQUIDACIONDETALLER.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.LIQTALLER' )
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
								from ZooLogic.LIQTALLER 
								Where   LIQTALLER.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "LIQTALLER", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Codigo" as "Codigo", "Taller" as "Taller", "Proveedor" as "Proveedor", "Ordendesde" as "Ordendesde", "Ordenhasta" as "Ordenhasta", "Procdesde" as "Procesodesde", "Prochasta" as "Procesohasta", "Gestdesde" as "Gestiondesde", "Gesthasta" as "Gestionhasta", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Numero" as "Numero", "Descartes" as "Descartes", "Moneda" as "Moneda", "Insumos" as "Insumos", "Listacosto" as "Listadecosto", "Cobs" as "Observ", "Ftotal" as "Total", "Comprob" as "Comprobante", "Letracomp" as "Letracomprobante", "Puntocomp" as "Puntodeventacomprobante", "Numerocomp" as "Numerocomprobante"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.LIQTALLER 
								Where   LIQTALLER.CODIGO != ''
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
	Tabla = 'LIQTALLER'
	Filtro = " LIQTALLER.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " LIQTALLER.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "LIQTALLER.Numero"
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
	<row entidad="LIQUIDACIONDETALLER                     " atributo="FECHAIMPO                               " tabla="LIQTALLER      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="FECHAEXPO                               " tabla="LIQTALLER      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="FECHAMODIFICACIONFW                     " tabla="LIQTALLER      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="FECHAALTAFW                             " tabla="LIQTALLER      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="FECHATRANSFERENCIA                      " tabla="LIQTALLER      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="GESTIONDEPRODUCCION                     " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobantes                                                                                                                                                    " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="6" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="LIQTALLER      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="ESTADOTRANSFERENCIA                     " tabla="LIQTALLER      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="VERSIONALTAFW                           " tabla="LIQTALLER      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="BASEDEDATOSALTAFW                       " tabla="LIQTALLER      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="HORAALTAFW                              " tabla="LIQTALLER      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="VERSIONMODIFICACIONFW                   " tabla="LIQTALLER      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="HORAEXPO                                " tabla="LIQTALLER      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="SERIEMODIFICACIONFW                     " tabla="LIQTALLER      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="USUARIOALTAFW                           " tabla="LIQTALLER      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="HORAMODIFICACIONFW                      " tabla="LIQTALLER      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="SERIEALTAFW                             " tabla="LIQTALLER      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="USUARIOMODIFICACIONFW                   " tabla="LIQTALLER      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="HORAIMPO                                " tabla="LIQTALLER      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="ZADSFW                                  " tabla="LIQTALLER      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="CODIGO                                  " tabla="LIQTALLER      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="198" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="TALLER                                  " tabla="LIQTALLER      " campo="TALLER    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLER                                  " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Taller                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="LIQUIDACIONTALLERPRODUCCION             " tabla="LIQTPROD       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Producción                                                                                                                                                      " dominio="DETALLEITEMLIQTALLERPRODUCCION" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="LIQUIDACIONTALLERDESCARTE               " tabla="LIQTDESC       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Descarte                                                                                                                                                        " dominio="DETALLEITEMLIQTALLERDESCARTE  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="LIQUIDACIONTALLERINSUMOS                " tabla="LIQTINS        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Insumos                                                                                                                                                         " dominio="DETALLEITEMLIQTALLERINSUMOS   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="LIQUIDACIONTALLERADICIONALES            " tabla="LIQTADIC       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Costos adicionales                                                                                                                                              " dominio="DETALLEITEMLIQTALLERADICIONAL " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="PROVEEDOR                               " tabla="LIQTALLER      " campo="PROVEEDOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="ORDENDESDE                              " tabla="LIQTALLER      " campo="ORDENDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="4" etiqueta="Orden desde                                                                                                                                                     " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="ORDENHASTA                              " tabla="LIQTALLER      " campo="ORDENHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="999999999999                                                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="6" etiqueta="Orden hasta                                                                                                                                                     " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="PROCESODESDE                            " tabla="LIQTALLER      " campo="PROCDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROCESOPRODUCCION                       " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Proceso desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="PROCESOHASTA                            " tabla="LIQTALLER      " campo="PROCHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROCESOPRODUCCION                       " tipodato="C         " longitud="15" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,15)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="6" etiqueta="Proceso hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="GESTIONDESDE                            " tabla="LIQTALLER      " campo="GESTDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="4" etiqueta="Gestión desde                                                                                                                                                   " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="GESTIONHASTA                            " tabla="LIQTALLER      " campo="GESTHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="999999999999                                                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="4" etiqueta="Gestión hasta                                                                                                                                                   " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="FECHADESDE                              " tabla="LIQTALLER      " campo="FECDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=Iif( goServicios.librerias.ObtenerFecha() &lt; goParametros.Felino.GestionDeVentas.MovMer.FechaUltimaTomaDeInventario, goServicios.librerias.ObtenerFecha(), goParametros.Felino.GestionDeVentas.MovMer.FechaUltimaTomaDeInventario)                            " obligatorio="false" admitebusqueda="408" etiqueta="Fecha de gestión                                                                                                                                                " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="FECHAHASTA                              " tabla="LIQTALLER      " campo="FECHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="410" etiqueta="Fecha hasta                                                                                                                                                     " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="NUMERO                                  " tabla="LIQTALLER      " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="16" etiqueta="Nro. gestión de producción                                                                                                                                      " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="DESCARTES                               " tabla="LIQTALLER      " campo="DESCARTES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="10" etiqueta="Acción en descartes                                                                                                                                             " dominio="COMBOLIQUIDACIONTALLER        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="MONEDA                                  " tabla="LIQTALLER      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGOSINALTA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="INSUMOS                                 " tabla="LIQTALLER      " campo="INSUMOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="8" etiqueta="Acción en insumos                                                                                                                                               " dominio="COMBOLIQUIDACIONTALLER        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="LISTADECOSTO                            " tabla="LIQTALLER      " campo="LISTACOSTO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADECOSTOSDEPRODUCCION               " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Lista de costo                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="OBSERV                                  " tabla="LIQTALLER      " campo="COBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="TOTAL                                   " tabla="LIQTALLER      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="COMPROBANTE                             " tabla="LIQTALLER      " campo="COMPROB   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="&quot;&quot;                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="12" etiqueta="Comprobante                                                                                                                                                     " dominio="COMPRELALIQU                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="LETRACOMPROBANTE                        " tabla="LIQTALLER      " campo="LETRACOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Letra comprobante                                                                                                                                               " dominio="COMPRELALIQU                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="PUNTODEVENTACOMPROBANTE                 " tabla="LIQTALLER      " campo="PUNTOCOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Punto de venta                                                                                                                                                  " dominio="COMPRELALIQU                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONDETALLER                     " atributo="NUMEROCOMPROBANTE                       " tabla="LIQTALLER      " campo="NUMEROCOMP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="COMPRELALIQU                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="DESCRIPCION                             " tabla="TALLER         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLER On LIQTALLER.TALLER = TALLER.Codigo And  TALLER.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On LIQTALLER.PROVEEDOR = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="DESCRIPCION                             " tabla="PROCPRODUC     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROCPRODUC On LIQTALLER.PROCDESDE = PROCPRODUC.Codigo And  PROCPRODUC.CODIGO != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="DESCRIPCION                             " tabla="PROCPRODUC     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROCPRODUC On LIQTALLER.PROCHASTA = PROCPRODUC.Codigo And  PROCPRODUC.CODIGO != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On LIQTALLER.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADECOSTOSDEPRODUCCION               " atributo="DESCRIPCION                             " tabla="LCOSTOP        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LCOSTOP On LIQTALLER.LISTACOSTO = LCOSTOP.Codigo And  LCOSTOP.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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