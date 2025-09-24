
define class Din_EntidadPICKINGAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PICKING'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 8, 0)]
	cTagClaveCandidata = '_PIKCC'
	cTagClavePk = '_PIKPK'
	cTablaPrincipal = 'PICKING'
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
			local  lxPickingFaltafw, lxPickingFectrans, lxPickingFmodifw, lxPickingFecexpo, lxPickingFecimpo, lxPickingNumero, lxPickingPrepm, lxPickingValtafw, lxPickingUmodifw, lxPickingVmodifw, lxPickingZadsfw, lxPickingHaltafw, lxPickingHoraimpo, lxPickingSmodifw, lxPickingHmodifw, lxPickingUaltafw, lxPickingHoraexpo, lxPickingSaltafw, lxPickingBdmodifw, lxPickingBdaltafw, lxPickingEsttrans, lxPickingCodigo, lxPickingObs, lxPickingFecha, lxPickingComporigen, lxPickingVendedor, lxPickingFperson, lxPickingFcliente
				lxPickingFaltafw =  .Fechaaltafw			lxPickingFectrans =  .Fechatransferencia			lxPickingFmodifw =  .Fechamodificacionfw			lxPickingFecexpo =  .Fechaexpo			lxPickingFecimpo =  .Fechaimpo			lxPickingNumero =  .Numero			lxPickingPrepm =  .Espreparaciondemercaderia			lxPickingValtafw =  .Versionaltafw			lxPickingUmodifw =  .Usuariomodificacionfw			lxPickingVmodifw =  .Versionmodificacionfw			lxPickingZadsfw =  .Zadsfw			lxPickingHaltafw =  .Horaaltafw			lxPickingHoraimpo =  .Horaimpo			lxPickingSmodifw =  .Seriemodificacionfw			lxPickingHmodifw =  .Horamodificacionfw			lxPickingUaltafw =  .Usuarioaltafw			lxPickingHoraexpo =  .Horaexpo			lxPickingSaltafw =  .Seriealtafw			lxPickingBdmodifw =  .Basededatosmodificacionfw			lxPickingBdaltafw =  .Basededatosaltafw			lxPickingEsttrans =  .Estadotransferencia			lxPickingCodigo =  .Codigo			lxPickingObs =  .Obs			lxPickingFecha =  .Fecha			lxPickingComporigen =  .Tipocomprobanteorigen			lxPickingVendedor =  upper( .Vendedor_PK ) 			lxPickingFperson =  upper( .Cliente_PK ) 			lxPickingFcliente =  .Clientedescripcion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPickingCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PICKING ( "Faltafw","Fectrans","Fmodifw","Fecexpo","Fecimpo","Numero","Prepm","Valtafw","Umodifw","Vmodifw","Zadsfw","Haltafw","Horaimpo","Smodifw","Hmodifw","Ualtafw","Horaexpo","Saltafw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Obs","Fecha","Comporigen","Vendedor","Fperson","Fcliente" ) values ( <<"'" + this.ConvertirDateSql( lxPickingFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFecimpo ) + "'" >>, <<lxPickingNumero >>, <<iif( lxPickingPrepm, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPickingValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingObs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingComporigen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingFcliente ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CompAfec
				if this.oEntidad.CompAfec.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDiferencias
				if this.oEntidad.DetalleDiferencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetDifPicking("DPArticulo","COMP","NROITEM","ProcStock","Codigo","Equiv","DPDescArt","DPColor","DPDescColo","DPTalle","DPCantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleControlado
				if this.oEntidad.DetalleControlado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxAgregado = loItem.Agregado
					lxNoprocesarstock = loItem.Noprocesarstock
					lxArticulo_PK = loItem.Articulo_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					lxAfe_saldo = loItem.Afe_saldo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetOkPicking("COMP","NROITEM","Agregado","ProcStock","OPArticulo","Codigo","Equiv","OPDescArt","OPColor","OPDescColo","OPTalle","OPCantidad","AfeSaldo" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxAgregado, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>>, <<lxAfe_saldo>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleCoincidencias
				if this.oEntidad.DetalleCoincidencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetConPicking("CPArticulo","NROITEM","Codigo","CPEquiv","CPColor","CPTalle","CPCantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDiferenciasOriginal
				if this.oEntidad.DetalleDiferenciasOriginal.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetDifOPicking("Articulo","COMP","NROITEM","Codigo","Equivalenc","cColor","Talle","Cantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePreparacionMercaderia
				if this.oEntidad.DetallePreparacionMercaderia.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidadafectada = loItem.Cantidadafectada
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxCodigoori_PK = loItem.Codigoori_PK
					lxIditemarticulos = loItem.Iditemarticulos
					lxCantidadoriginal = loItem.Cantidadoriginal
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetPrepMPicking("NroItem","Codigo","Articulo","cColor","Talle","CantAfe","Equiv","CodigoOri","IdItem","CantOri" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidadafectada>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoori_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxCantidadoriginal>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleComprobantes
				if this.oEntidad.DetalleComprobantes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTimestampcomprobante = loItem.Timestampcomprobante
					lxEntregaposterior = loItem.Entregaposterior
					lxNroitem = lnContadorNroItem
					lxCliente = loItem.Cliente
					lxCodigocompafe = loItem.Codigocompafe
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxOrigendestino_PK = loItem.Origendestino_PK
					lxRemito = loItem.Remito
					lxOrigendestinodetalle = loItem.Origendestinodetalle
					lxCantidad = loItem.Cantidad
					lxIddecaja = loItem.Iddecaja
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetCompPicking("tscomp","EntregaPos","NROITEM","Cliente","Cod_Afe","Codigo","CPNumero","FechaComp","OriDes","REMITO","OriDesDesc","Cantidad","IdCaja" ) values ( <<lxTimestampcomprobante>>, <<lxEntregaposterior>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocompafe ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumero ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigendestino_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRemito ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigendestinodetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIddecaja ) + "'">> ) 
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
			local  lxPickingFaltafw, lxPickingFectrans, lxPickingFmodifw, lxPickingFecexpo, lxPickingFecimpo, lxPickingNumero, lxPickingPrepm, lxPickingValtafw, lxPickingUmodifw, lxPickingVmodifw, lxPickingZadsfw, lxPickingHaltafw, lxPickingHoraimpo, lxPickingSmodifw, lxPickingHmodifw, lxPickingUaltafw, lxPickingHoraexpo, lxPickingSaltafw, lxPickingBdmodifw, lxPickingBdaltafw, lxPickingEsttrans, lxPickingCodigo, lxPickingObs, lxPickingFecha, lxPickingComporigen, lxPickingVendedor, lxPickingFperson, lxPickingFcliente
				lxPickingFaltafw =  .Fechaaltafw			lxPickingFectrans =  .Fechatransferencia			lxPickingFmodifw =  .Fechamodificacionfw			lxPickingFecexpo =  .Fechaexpo			lxPickingFecimpo =  .Fechaimpo			lxPickingNumero =  .Numero			lxPickingPrepm =  .Espreparaciondemercaderia			lxPickingValtafw =  .Versionaltafw			lxPickingUmodifw =  .Usuariomodificacionfw			lxPickingVmodifw =  .Versionmodificacionfw			lxPickingZadsfw =  .Zadsfw			lxPickingHaltafw =  .Horaaltafw			lxPickingHoraimpo =  .Horaimpo			lxPickingSmodifw =  .Seriemodificacionfw			lxPickingHmodifw =  .Horamodificacionfw			lxPickingUaltafw =  .Usuarioaltafw			lxPickingHoraexpo =  .Horaexpo			lxPickingSaltafw =  .Seriealtafw			lxPickingBdmodifw =  .Basededatosmodificacionfw			lxPickingBdaltafw =  .Basededatosaltafw			lxPickingEsttrans =  .Estadotransferencia			lxPickingCodigo =  .Codigo			lxPickingObs =  .Obs			lxPickingFecha =  .Fecha			lxPickingComporigen =  .Tipocomprobanteorigen			lxPickingVendedor =  upper( .Vendedor_PK ) 			lxPickingFperson =  upper( .Cliente_PK ) 			lxPickingFcliente =  .Clientedescripcion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.PICKING set "Faltafw" = <<"'" + this.ConvertirDateSql( lxPickingFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxPickingFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxPickingFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxPickingFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxPickingFecimpo ) + "'">>,"Numero" = <<lxPickingNumero>>,"Prepm" = <<iif( lxPickingPrepm, 1, 0 )>>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxPickingValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxPickingUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxPickingVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxPickingZadsfw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxPickingHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxPickingHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxPickingSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPickingHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxPickingUaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxPickingHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxPickingSaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPickingBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPickingBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxPickingEsttrans ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxPickingCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxPickingObs ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxPickingFecha ) + "'">>,"Comporigen" = <<"'" + this.FormatearTextoSql( lxPickingComporigen ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxPickingVendedor ) + "'">>,"Fperson" = <<"'" + this.FormatearTextoSql( lxPickingFperson ) + "'">>,"Fcliente" = <<"'" + this.FormatearTextoSql( lxPickingFcliente ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxPickingCodigo ) + "'">> and  PICKING.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetDifPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetOkPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetConPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetDifOPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetPrepMPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetCompPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CompAfec
				if this.oEntidad.CompAfec.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDiferencias
				if this.oEntidad.DetalleDiferencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetDifPicking("DPArticulo","COMP","NROITEM","ProcStock","Codigo","Equiv","DPDescArt","DPColor","DPDescColo","DPTalle","DPCantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleControlado
				if this.oEntidad.DetalleControlado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxAgregado = loItem.Agregado
					lxNoprocesarstock = loItem.Noprocesarstock
					lxArticulo_PK = loItem.Articulo_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					lxAfe_saldo = loItem.Afe_saldo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetOkPicking("COMP","NROITEM","Agregado","ProcStock","OPArticulo","Codigo","Equiv","OPDescArt","OPColor","OPDescColo","OPTalle","OPCantidad","AfeSaldo" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxAgregado, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>>, <<lxAfe_saldo>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleCoincidencias
				if this.oEntidad.DetalleCoincidencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetConPicking("CPArticulo","NROITEM","Codigo","CPEquiv","CPColor","CPTalle","CPCantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDiferenciasOriginal
				if this.oEntidad.DetalleDiferenciasOriginal.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetDifOPicking("Articulo","COMP","NROITEM","Codigo","Equivalenc","cColor","Talle","Cantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePreparacionMercaderia
				if this.oEntidad.DetallePreparacionMercaderia.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidadafectada = loItem.Cantidadafectada
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxCodigoori_PK = loItem.Codigoori_PK
					lxIditemarticulos = loItem.Iditemarticulos
					lxCantidadoriginal = loItem.Cantidadoriginal
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetPrepMPicking("NroItem","Codigo","Articulo","cColor","Talle","CantAfe","Equiv","CodigoOri","IdItem","CantOri" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidadafectada>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoori_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxCantidadoriginal>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleComprobantes
				if this.oEntidad.DetalleComprobantes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTimestampcomprobante = loItem.Timestampcomprobante
					lxEntregaposterior = loItem.Entregaposterior
					lxNroitem = lnContadorNroItem
					lxCliente = loItem.Cliente
					lxCodigocompafe = loItem.Codigocompafe
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxOrigendestino_PK = loItem.Origendestino_PK
					lxRemito = loItem.Remito
					lxOrigendestinodetalle = loItem.Origendestinodetalle
					lxCantidad = loItem.Cantidad
					lxIddecaja = loItem.Iddecaja
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetCompPicking("tscomp","EntregaPos","NROITEM","Cliente","Cod_Afe","Codigo","CPNumero","FechaComp","OriDes","REMITO","OriDesDesc","Cantidad","IdCaja" ) values ( <<lxTimestampcomprobante>>, <<lxEntregaposterior>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocompafe ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumero ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigendestino_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRemito ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigendestinodetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIddecaja ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.PICKING where " + this.ConvertirFuncionesSql( " PICKING.CODIGO != ''" ) )
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
			Local lxPickingCodigo
			lxPickingCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Prepm" as "Espreparaciondemercaderia", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Fecha" as "Fecha", "Comporigen" as "Tipocomprobanteorigen", "Vendedor" as "Vendedor", "Fperson" as "Cliente", "Fcliente" as "Clientedescripcion" from ZooLogic.PICKING where "Codigo" = <<"'" + this.FormatearTextoSql( lxPickingCodigo ) + "'">> and  PICKING.CODIGO != ''
			endtext
			use in select('c_PICKING')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PICKING', set( 'Datasession' ) )

			if reccount( 'c_PICKING' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Dparticulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Dpdescart" as "Articulodetalle", "Dpcolor" as "Color", "Dpdesccolo" as "Colordetalle", "Dptalle" as "Talle", "Dpcantidad" as "Cantidad" from ZooLogic.DetDifPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Agregado" as "Agregado", "Procstock" as "Noprocesarstock", "Oparticulo" as "Articulo", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Opdescart" as "Articulodetalle", "Opcolor" as "Color", "Opdesccolo" as "Colordetalle", "Optalle" as "Talle", "Opcantidad" as "Cantidad", "Afesaldo" as "Afe_saldo" from ZooLogic.DetOkPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleControlado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleControlado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleControlado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cparticulo" as "Articulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Cpequiv" as "Equivalencia", "Cpcolor" as "Color", "Cptalle" as "Talle", "Cpcantidad" as "Cantidad" from ZooLogic.DetConPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCoincidencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCoincidencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCoincidencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Articulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalenc" as "Equivalencia", "Ccolor" as "Color", "Talle" as "Talle", "Cantidad" as "Cantidad" from ZooLogic.DetDifOPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferenciasOriginal')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferenciasOriginal', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferenciasOriginal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Cantafe" as "Cantidadafectada", "Equiv" as "Equivalencia", "Codigoori" as "Codigoori", "Iditem" as "Iditemarticulos", "Cantori" as "Cantidadoriginal" from ZooLogic.DetPrepMPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePreparacionMercaderia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePreparacionMercaderia', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePreparacionMercaderia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tscomp" as "Timestampcomprobante", "Entregapos" as "Entregaposterior", "Nroitem" as "Nroitem", "Cliente" as "Cliente", "Cod_afe" as "Codigocompafe", "Codigo" as "Codigo", "Cpnumero" as "Numero", "Fechacomp" as "Fecha", "Orides" as "Origendestino", "Remito" as "Remito", "Oridesdesc" as "Origendestinodetalle", "Cantidad" as "Cantidad", "Idcaja" as "Iddecaja" from ZooLogic.DetCompPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobantes
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxPickingNumero As Variant
			lxPickingNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Prepm" as "Espreparaciondemercaderia", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Fecha" as "Fecha", "Comporigen" as "Tipocomprobanteorigen", "Vendedor" as "Vendedor", "Fperson" as "Cliente", "Fcliente" as "Clientedescripcion" from ZooLogic.PICKING where  PICKING.CODIGO != '' And Numero = <<lxPickingNumero>>
			endtext
			use in select('c_PICKING')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PICKING', set( 'Datasession' ) )
			if reccount( 'c_PICKING' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Dparticulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Dpdescart" as "Articulodetalle", "Dpcolor" as "Color", "Dpdesccolo" as "Colordetalle", "Dptalle" as "Talle", "Dpcantidad" as "Cantidad" from ZooLogic.DetDifPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Agregado" as "Agregado", "Procstock" as "Noprocesarstock", "Oparticulo" as "Articulo", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Opdescart" as "Articulodetalle", "Opcolor" as "Color", "Opdesccolo" as "Colordetalle", "Optalle" as "Talle", "Opcantidad" as "Cantidad", "Afesaldo" as "Afe_saldo" from ZooLogic.DetOkPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleControlado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleControlado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleControlado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cparticulo" as "Articulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Cpequiv" as "Equivalencia", "Cpcolor" as "Color", "Cptalle" as "Talle", "Cpcantidad" as "Cantidad" from ZooLogic.DetConPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCoincidencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCoincidencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCoincidencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Articulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalenc" as "Equivalencia", "Ccolor" as "Color", "Talle" as "Talle", "Cantidad" as "Cantidad" from ZooLogic.DetDifOPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferenciasOriginal')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferenciasOriginal', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferenciasOriginal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Cantafe" as "Cantidadafectada", "Equiv" as "Equivalencia", "Codigoori" as "Codigoori", "Iditem" as "Iditemarticulos", "Cantori" as "Cantidadoriginal" from ZooLogic.DetPrepMPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePreparacionMercaderia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePreparacionMercaderia', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePreparacionMercaderia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tscomp" as "Timestampcomprobante", "Entregapos" as "Entregaposterior", "Nroitem" as "Nroitem", "Cliente" as "Cliente", "Cod_afe" as "Codigocompafe", "Codigo" as "Codigo", "Cpnumero" as "Numero", "Fechacomp" as "Fecha", "Orides" as "Origendestino", "Remito" as "Remito", "Oridesdesc" as "Origendestinodetalle", "Cantidad" as "Cantidad", "Idcaja" as "Iddecaja" from ZooLogic.DetCompPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobantes
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxPickingCodigo as Variant
		llRetorno = .t.
		lxPickingCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PICKING where "Codigo" = <<"'" + this.FormatearTextoSql( lxPickingCodigo ) + "'">> and  PICKING.CODIGO != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Prepm" as "Espreparaciondemercaderia", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Fecha" as "Fecha", "Comporigen" as "Tipocomprobanteorigen", "Vendedor" as "Vendedor", "Fperson" as "Cliente", "Fcliente" as "Clientedescripcion" from ZooLogic.PICKING where  PICKING.CODIGO != '' order by Numero
			endtext
			use in select('c_PICKING')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PICKING', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Dparticulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Dpdescart" as "Articulodetalle", "Dpcolor" as "Color", "Dpdesccolo" as "Colordetalle", "Dptalle" as "Talle", "Dpcantidad" as "Cantidad" from ZooLogic.DetDifPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Agregado" as "Agregado", "Procstock" as "Noprocesarstock", "Oparticulo" as "Articulo", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Opdescart" as "Articulodetalle", "Opcolor" as "Color", "Opdesccolo" as "Colordetalle", "Optalle" as "Talle", "Opcantidad" as "Cantidad", "Afesaldo" as "Afe_saldo" from ZooLogic.DetOkPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleControlado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleControlado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleControlado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cparticulo" as "Articulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Cpequiv" as "Equivalencia", "Cpcolor" as "Color", "Cptalle" as "Talle", "Cpcantidad" as "Cantidad" from ZooLogic.DetConPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCoincidencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCoincidencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCoincidencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Articulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalenc" as "Equivalencia", "Ccolor" as "Color", "Talle" as "Talle", "Cantidad" as "Cantidad" from ZooLogic.DetDifOPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferenciasOriginal')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferenciasOriginal', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferenciasOriginal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Cantafe" as "Cantidadafectada", "Equiv" as "Equivalencia", "Codigoori" as "Codigoori", "Iditem" as "Iditemarticulos", "Cantori" as "Cantidadoriginal" from ZooLogic.DetPrepMPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePreparacionMercaderia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePreparacionMercaderia', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePreparacionMercaderia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tscomp" as "Timestampcomprobante", "Entregapos" as "Entregaposterior", "Nroitem" as "Nroitem", "Cliente" as "Cliente", "Cod_afe" as "Codigocompafe", "Codigo" as "Codigo", "Cpnumero" as "Numero", "Fechacomp" as "Fecha", "Orides" as "Origendestino", "Remito" as "Remito", "Oridesdesc" as "Origendestinodetalle", "Cantidad" as "Cantidad", "Idcaja" as "Iddecaja" from ZooLogic.DetCompPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobantes
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Prepm" as "Espreparaciondemercaderia", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Fecha" as "Fecha", "Comporigen" as "Tipocomprobanteorigen", "Vendedor" as "Vendedor", "Fperson" as "Cliente", "Fcliente" as "Clientedescripcion" from ZooLogic.PICKING where  str( Numero, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PICKING.CODIGO != '' order by Numero
			endtext
			use in select('c_PICKING')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PICKING', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Dparticulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Dpdescart" as "Articulodetalle", "Dpcolor" as "Color", "Dpdesccolo" as "Colordetalle", "Dptalle" as "Talle", "Dpcantidad" as "Cantidad" from ZooLogic.DetDifPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Agregado" as "Agregado", "Procstock" as "Noprocesarstock", "Oparticulo" as "Articulo", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Opdescart" as "Articulodetalle", "Opcolor" as "Color", "Opdesccolo" as "Colordetalle", "Optalle" as "Talle", "Opcantidad" as "Cantidad", "Afesaldo" as "Afe_saldo" from ZooLogic.DetOkPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleControlado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleControlado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleControlado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cparticulo" as "Articulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Cpequiv" as "Equivalencia", "Cpcolor" as "Color", "Cptalle" as "Talle", "Cpcantidad" as "Cantidad" from ZooLogic.DetConPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCoincidencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCoincidencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCoincidencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Articulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalenc" as "Equivalencia", "Ccolor" as "Color", "Talle" as "Talle", "Cantidad" as "Cantidad" from ZooLogic.DetDifOPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferenciasOriginal')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferenciasOriginal', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferenciasOriginal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Cantafe" as "Cantidadafectada", "Equiv" as "Equivalencia", "Codigoori" as "Codigoori", "Iditem" as "Iditemarticulos", "Cantori" as "Cantidadoriginal" from ZooLogic.DetPrepMPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePreparacionMercaderia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePreparacionMercaderia', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePreparacionMercaderia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tscomp" as "Timestampcomprobante", "Entregapos" as "Entregaposterior", "Nroitem" as "Nroitem", "Cliente" as "Cliente", "Cod_afe" as "Codigocompafe", "Codigo" as "Codigo", "Cpnumero" as "Numero", "Fechacomp" as "Fecha", "Orides" as "Origendestino", "Remito" as "Remito", "Oridesdesc" as "Origendestinodetalle", "Cantidad" as "Cantidad", "Idcaja" as "Iddecaja" from ZooLogic.DetCompPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobantes
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Prepm" as "Espreparaciondemercaderia", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Fecha" as "Fecha", "Comporigen" as "Tipocomprobanteorigen", "Vendedor" as "Vendedor", "Fperson" as "Cliente", "Fcliente" as "Clientedescripcion" from ZooLogic.PICKING where  str( Numero, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PICKING.CODIGO != '' order by Numero desc
			endtext
			use in select('c_PICKING')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PICKING', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Dparticulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Dpdescart" as "Articulodetalle", "Dpcolor" as "Color", "Dpdesccolo" as "Colordetalle", "Dptalle" as "Talle", "Dpcantidad" as "Cantidad" from ZooLogic.DetDifPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Agregado" as "Agregado", "Procstock" as "Noprocesarstock", "Oparticulo" as "Articulo", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Opdescart" as "Articulodetalle", "Opcolor" as "Color", "Opdesccolo" as "Colordetalle", "Optalle" as "Talle", "Opcantidad" as "Cantidad", "Afesaldo" as "Afe_saldo" from ZooLogic.DetOkPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleControlado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleControlado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleControlado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cparticulo" as "Articulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Cpequiv" as "Equivalencia", "Cpcolor" as "Color", "Cptalle" as "Talle", "Cpcantidad" as "Cantidad" from ZooLogic.DetConPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCoincidencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCoincidencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCoincidencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Articulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalenc" as "Equivalencia", "Ccolor" as "Color", "Talle" as "Talle", "Cantidad" as "Cantidad" from ZooLogic.DetDifOPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferenciasOriginal')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferenciasOriginal', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferenciasOriginal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Cantafe" as "Cantidadafectada", "Equiv" as "Equivalencia", "Codigoori" as "Codigoori", "Iditem" as "Iditemarticulos", "Cantori" as "Cantidadoriginal" from ZooLogic.DetPrepMPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePreparacionMercaderia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePreparacionMercaderia', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePreparacionMercaderia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tscomp" as "Timestampcomprobante", "Entregapos" as "Entregaposterior", "Nroitem" as "Nroitem", "Cliente" as "Cliente", "Cod_afe" as "Codigocompafe", "Codigo" as "Codigo", "Cpnumero" as "Numero", "Fechacomp" as "Fecha", "Orides" as "Origendestino", "Remito" as "Remito", "Oridesdesc" as "Origendestinodetalle", "Cantidad" as "Cantidad", "Idcaja" as "Iddecaja" from ZooLogic.DetCompPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobantes
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Prepm" as "Espreparaciondemercaderia", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Fecha" as "Fecha", "Comporigen" as "Tipocomprobanteorigen", "Vendedor" as "Vendedor", "Fperson" as "Cliente", "Fcliente" as "Clientedescripcion" from ZooLogic.PICKING where  PICKING.CODIGO != '' order by Numero desc
			endtext
			use in select('c_PICKING')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PICKING', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Dparticulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Dpdescart" as "Articulodetalle", "Dpcolor" as "Color", "Dpdesccolo" as "Colordetalle", "Dptalle" as "Talle", "Dpcantidad" as "Cantidad" from ZooLogic.DetDifPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Agregado" as "Agregado", "Procstock" as "Noprocesarstock", "Oparticulo" as "Articulo", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Opdescart" as "Articulodetalle", "Opcolor" as "Color", "Opdesccolo" as "Colordetalle", "Optalle" as "Talle", "Opcantidad" as "Cantidad", "Afesaldo" as "Afe_saldo" from ZooLogic.DetOkPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleControlado')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleControlado', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleControlado
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cparticulo" as "Articulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Cpequiv" as "Equivalencia", "Cpcolor" as "Color", "Cptalle" as "Talle", "Cpcantidad" as "Cantidad" from ZooLogic.DetConPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCoincidencias')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCoincidencias', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCoincidencias
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Articulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalenc" as "Equivalencia", "Ccolor" as "Color", "Talle" as "Talle", "Cantidad" as "Cantidad" from ZooLogic.DetDifOPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleDiferenciasOriginal')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDiferenciasOriginal', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDiferenciasOriginal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Cantafe" as "Cantidadafectada", "Equiv" as "Equivalencia", "Codigoori" as "Codigoori", "Iditem" as "Iditemarticulos", "Cantori" as "Cantidadoriginal" from ZooLogic.DetPrepMPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePreparacionMercaderia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePreparacionMercaderia', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePreparacionMercaderia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tscomp" as "Timestampcomprobante", "Entregapos" as "Entregaposterior", "Nroitem" as "Nroitem", "Cliente" as "Cliente", "Cod_afe" as "Codigocompafe", "Codigo" as "Codigo", "Cpnumero" as "Numero", "Fechacomp" as "Fecha", "Orides" as "Origendestino", "Remito" as "Remito", "Oridesdesc" as "Origendestinodetalle", "Cantidad" as "Cantidad", "Idcaja" as "Iddecaja" from ZooLogic.DetCompPicking where Codigo = <<"'" + this.FormatearTextoSql( c_PICKING.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobantes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobantes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobantes
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fmodifw,Fecexpo,Fecimpo,Numero,Prepm,Valtafw,Umodifw,Vmodifw,Zadsfw,Haltafw" + ;
",Horaimpo,Smodifw,Hmodifw,Ualtafw,Horaexpo,Saltafw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Obs,Fecha,Compo" + ;
"rigen,Vendedor,Fperson,Fcliente" + ;
" from ZooLogic.PICKING where  PICKING.CODIGO != '' and " + lcFiltro )
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
			local  lxPickingFaltafw, lxPickingFectrans, lxPickingFmodifw, lxPickingFecexpo, lxPickingFecimpo, lxPickingNumero, lxPickingPrepm, lxPickingValtafw, lxPickingUmodifw, lxPickingVmodifw, lxPickingZadsfw, lxPickingHaltafw, lxPickingHoraimpo, lxPickingSmodifw, lxPickingHmodifw, lxPickingUaltafw, lxPickingHoraexpo, lxPickingSaltafw, lxPickingBdmodifw, lxPickingBdaltafw, lxPickingEsttrans, lxPickingCodigo, lxPickingObs, lxPickingFecha, lxPickingComporigen, lxPickingVendedor, lxPickingFperson, lxPickingFcliente
				lxPickingFaltafw = ctod( '  /  /    ' )			lxPickingFectrans = ctod( '  /  /    ' )			lxPickingFmodifw = ctod( '  /  /    ' )			lxPickingFecexpo = ctod( '  /  /    ' )			lxPickingFecimpo = ctod( '  /  /    ' )			lxPickingNumero = 0			lxPickingPrepm = .F.			lxPickingValtafw = []			lxPickingUmodifw = []			lxPickingVmodifw = []			lxPickingZadsfw = []			lxPickingHaltafw = []			lxPickingHoraimpo = []			lxPickingSmodifw = []			lxPickingHmodifw = []			lxPickingUaltafw = []			lxPickingHoraexpo = []			lxPickingSaltafw = []			lxPickingBdmodifw = []			lxPickingBdaltafw = []			lxPickingEsttrans = []			lxPickingCodigo = []			lxPickingObs = []			lxPickingFecha = ctod( '  /  /    ' )			lxPickingComporigen = []			lxPickingVendedor = []			lxPickingFperson = []			lxPickingFcliente = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetDifPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetOkPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetConPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetDifOPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetPrepMPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetCompPicking where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PICKING where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PICKING' + '_' + tcCampo
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
		lcWhere = " Where  PICKING.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Prepm" as "Espreparaciondemercaderia", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Fecha" as "Fecha", "Comporigen" as "Tipocomprobanteorigen", "Vendedor" as "Vendedor", "Fperson" as "Cliente", "Fcliente" as "Clientedescripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PICKING', '', tnTope )
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
	Function ObtenerDatosDetalleCompAfec( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPAFE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCompAfec( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompAfe', 'CompAfec', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCompAfec( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCompAfec( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleDiferencias( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETDIFPICKING.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Dparticulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Dpdescart" as "Articulodetalle", "Dpcolor" as "Color", "Dpdesccolo" as "Colordetalle", "Dptalle" as "Talle", "Dpcantidad" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleDiferencias( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DetDifPicking', 'DetalleDiferencias', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleDiferencias( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleDiferencias( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleControlado( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETOKPICKING.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Agregado" as "Agregado", "Procstock" as "Noprocesarstock", "Oparticulo" as "Articulo", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Opdescart" as "Articulodetalle", "Opcolor" as "Color", "Opdesccolo" as "Colordetalle", "Optalle" as "Talle", "Opcantidad" as "Cantidad", "Afesaldo" as "Afe_saldo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleControlado( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DetOkPicking', 'DetalleControlado', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleControlado( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleControlado( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleCoincidencias( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETCONPICKING.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Cparticulo" as "Articulo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Cpequiv" as "Equivalencia", "Cpcolor" as "Color", "Cptalle" as "Talle", "Cpcantidad" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleCoincidencias( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DetConPicking', 'DetalleCoincidencias', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleCoincidencias( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleCoincidencias( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleDiferenciasOriginal( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETDIFOPICKING.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Articulo" as "Articulo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalenc" as "Equivalencia", "Ccolor" as "Color", "Talle" as "Talle", "Cantidad" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleDiferenciasOriginal( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DetDifOPicking', 'DetalleDiferenciasOriginal', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleDiferenciasOriginal( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleDiferenciasOriginal( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetallePreparacionMercaderia( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETPREPMPICKING.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Cantafe" as "Cantidadafectada", "Equiv" as "Equivalencia", "Codigoori" as "Codigoori", "Iditem" as "Iditemarticulos", "Cantori" as "Cantidadoriginal"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetallePreparacionMercaderia( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DetPrepMPicking', 'DetallePreparacionMercaderia', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetallePreparacionMercaderia( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetallePreparacionMercaderia( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleComprobantes( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETCOMPPICKING.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Tscomp" as "Timestampcomprobante", "Entregapos" as "Entregaposterior", "Nroitem" as "Nroitem", "Cliente" as "Cliente", "Cod_afe" as "Codigocompafe", "Codigo" as "Codigo", "Cpnumero" as "Numero", "Fechacomp" as "Fecha", "Orides" as "Origendestino", "Remito" as "Remito", "Oridesdesc" as "Origendestinodetalle", "Cantidad" as "Cantidad", "Idcaja" as "Iddecaja"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleComprobantes( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DetCompPicking', 'DetalleComprobantes', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleComprobantes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleComprobantes( lcAtributo )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'ESPREPARACIONDEMERCADERIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PREPM AS ESPREPARACIONDEMERCADERIA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
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
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'TIPOCOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPORIGEN AS TIPOCOMPROBANTEORIGEN'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS CLIENTE'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDESCRIPCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCompAfec( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS TIPOCOMPROBANTE'
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
	Function ObtenerCamposSelectDetalleDetalleDiferencias( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DPARTICULO AS ARTICULO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DPDESCART AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DPCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DPDESCCOLO AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DPTALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DPCANTIDAD AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleControlado( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'AGREGADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGREGADO AS AGREGADO'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPARTICULO AS ARTICULO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPDESCART AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPDESCCOLO AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPTALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPCANTIDAD AS CANTIDAD'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleCoincidencias( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPARTICULO AS ARTICULO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPEQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPCOLOR AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPTALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPCANTIDAD AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleDiferenciasOriginal( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTICULO AS ARTICULO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIVALENC AS EQUIVALENCIA'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetallePreparacionMercaderia( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTICULO AS ARTICULO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'CANTIDADAFECTADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTAFE AS CANTIDADAFECTADA'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'CODIGOORI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOORI AS CODIGOORI'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'CANTIDADORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTORI AS CANTIDADORIGINAL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleComprobantes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'TIMESTAMPCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TSCOMP AS TIMESTAMPCOMPROBANTE'
				Case lcAtributo == 'ENTREGAPOSTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTREGAPOS AS ENTREGAPOSTERIOR'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CODIGOCOMPAFE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD_AFE AS CODIGOCOMPAFE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPNUMERO AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMP AS FECHA'
				Case lcAtributo == 'ORIGENDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIDES AS ORIGENDESTINO'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REMITO AS REMITO'
				Case lcAtributo == 'ORIGENDESTINODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIDESDESC AS ORIGENDESTINODETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'IDDECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS IDDECAJA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'ESPREPARACIONDEMERCADERIA'
				lcCampo = 'PREPM'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTEORIGEN'
				lcCampo = 'COMPORIGEN'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'FCLIENTE'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCompAfec( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
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
	Function ObtenerCampoDetalleDetalleDiferencias( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'DPARTICULO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DPDESCART'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'DPCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'DPDESCCOLO'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'DPTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'DPCANTIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleControlado( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AGREGADO'
				lcCampo = 'AGREGADO'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'OPARTICULO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'OPDESCART'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'OPCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'OPDESCCOLO'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'OPTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'OPCANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleCoincidencias( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'CPARTICULO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'CPEQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CPCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CPTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CPCANTIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleDiferenciasOriginal( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTICULO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIVALENC'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetallePreparacionMercaderia( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTICULO'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADAFECTADA'
				lcCampo = 'CANTAFE'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOORI'
				lcCampo = 'CODIGOORI'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADORIGINAL'
				lcCampo = 'CANTORI'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleComprobantes( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMPCOMPROBANTE'
				lcCampo = 'TSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPOSTERIOR'
				lcCampo = 'ENTREGAPOS'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPAFE'
				lcCampo = 'COD_AFE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CPNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINO'
				lcCampo = 'ORIDES'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'REMITO'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINODETALLE'
				lcCampo = 'ORIDESDESC'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'IDDECAJA'
				lcCampo = 'IDCAJA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLEDIFERENCIAS'
			lcRetorno = 'DETDIFPICKING'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLECONTROLADO'
			lcRetorno = 'DETOKPICKING'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLECOINCIDENCIAS'
			lcRetorno = 'DETCONPICKING'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLEDIFERENCIASORIGINAL'
			lcRetorno = 'DETDIFOPICKING'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLEPREPARACIONMERCADERIA'
			lcRetorno = 'DETPREPMPICKING'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLECOMPROBANTES'
			lcRetorno = 'DETCOMPPICKING'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxPickingFaltafw, lxPickingFectrans, lxPickingFmodifw, lxPickingFecexpo, lxPickingFecimpo, lxPickingNumero, lxPickingPrepm, lxPickingValtafw, lxPickingUmodifw, lxPickingVmodifw, lxPickingZadsfw, lxPickingHaltafw, lxPickingHoraimpo, lxPickingSmodifw, lxPickingHmodifw, lxPickingUaltafw, lxPickingHoraexpo, lxPickingSaltafw, lxPickingBdmodifw, lxPickingBdaltafw, lxPickingEsttrans, lxPickingCodigo, lxPickingObs, lxPickingFecha, lxPickingComporigen, lxPickingVendedor, lxPickingFperson, lxPickingFcliente
				lxPickingFaltafw =  .Fechaaltafw			lxPickingFectrans =  .Fechatransferencia			lxPickingFmodifw =  .Fechamodificacionfw			lxPickingFecexpo =  .Fechaexpo			lxPickingFecimpo =  .Fechaimpo			lxPickingNumero =  .Numero			lxPickingPrepm =  .Espreparaciondemercaderia			lxPickingValtafw =  .Versionaltafw			lxPickingUmodifw =  .Usuariomodificacionfw			lxPickingVmodifw =  .Versionmodificacionfw			lxPickingZadsfw =  .Zadsfw			lxPickingHaltafw =  .Horaaltafw			lxPickingHoraimpo =  .Horaimpo			lxPickingSmodifw =  .Seriemodificacionfw			lxPickingHmodifw =  .Horamodificacionfw			lxPickingUaltafw =  .Usuarioaltafw			lxPickingHoraexpo =  .Horaexpo			lxPickingSaltafw =  .Seriealtafw			lxPickingBdmodifw =  .Basededatosmodificacionfw			lxPickingBdaltafw =  .Basededatosaltafw			lxPickingEsttrans =  .Estadotransferencia			lxPickingCodigo =  .Codigo			lxPickingObs =  .Obs			lxPickingFecha =  .Fecha			lxPickingComporigen =  .Tipocomprobanteorigen			lxPickingVendedor =  upper( .Vendedor_PK ) 			lxPickingFperson =  upper( .Cliente_PK ) 			lxPickingFcliente =  .Clientedescripcion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PICKING ( "Faltafw","Fectrans","Fmodifw","Fecexpo","Fecimpo","Numero","Prepm","Valtafw","Umodifw","Vmodifw","Zadsfw","Haltafw","Horaimpo","Smodifw","Hmodifw","Ualtafw","Horaexpo","Saltafw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Obs","Fecha","Comporigen","Vendedor","Fperson","Fcliente" ) values ( <<"'" + this.ConvertirDateSql( lxPickingFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFecimpo ) + "'" >>, <<lxPickingNumero >>, <<iif( lxPickingPrepm, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPickingValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingObs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPickingFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingComporigen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPickingFcliente ) + "'" >> )
		endtext
		loColeccion.cTabla = 'PICKING' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CompAfec
				if this.oEntidad.CompAfec.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDiferencias
				if this.oEntidad.DetalleDiferencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetDifPicking("DPArticulo","COMP","NROITEM","ProcStock","Codigo","Equiv","DPDescArt","DPColor","DPDescColo","DPTalle","DPCantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleControlado
				if this.oEntidad.DetalleControlado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxAgregado = loItem.Agregado
					lxNoprocesarstock = loItem.Noprocesarstock
					lxArticulo_PK = loItem.Articulo_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					lxAfe_saldo = loItem.Afe_saldo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetOkPicking("COMP","NROITEM","Agregado","ProcStock","OPArticulo","Codigo","Equiv","OPDescArt","OPColor","OPDescColo","OPTalle","OPCantidad","AfeSaldo" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxAgregado, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>>, <<lxAfe_saldo>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleCoincidencias
				if this.oEntidad.DetalleCoincidencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetConPicking("CPArticulo","NROITEM","Codigo","CPEquiv","CPColor","CPTalle","CPCantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDiferenciasOriginal
				if this.oEntidad.DetalleDiferenciasOriginal.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetDifOPicking("Articulo","COMP","NROITEM","Codigo","Equivalenc","cColor","Talle","Cantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePreparacionMercaderia
				if this.oEntidad.DetallePreparacionMercaderia.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidadafectada = loItem.Cantidadafectada
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxCodigoori_PK = loItem.Codigoori_PK
					lxIditemarticulos = loItem.Iditemarticulos
					lxCantidadoriginal = loItem.Cantidadoriginal
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetPrepMPicking("NroItem","Codigo","Articulo","cColor","Talle","CantAfe","Equiv","CodigoOri","IdItem","CantOri" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidadafectada>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoori_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxCantidadoriginal>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleComprobantes
				if this.oEntidad.DetalleComprobantes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTimestampcomprobante = loItem.Timestampcomprobante
					lxEntregaposterior = loItem.Entregaposterior
					lxNroitem = lnContadorNroItem
					lxCliente = loItem.Cliente
					lxCodigocompafe = loItem.Codigocompafe
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxOrigendestino_PK = loItem.Origendestino_PK
					lxRemito = loItem.Remito
					lxOrigendestinodetalle = loItem.Origendestinodetalle
					lxCantidad = loItem.Cantidad
					lxIddecaja = loItem.Iddecaja
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetCompPicking("tscomp","EntregaPos","NROITEM","Cliente","Cod_Afe","Codigo","CPNumero","FechaComp","OriDes","REMITO","OriDesDesc","Cantidad","IdCaja" ) values ( <<lxTimestampcomprobante>>, <<lxEntregaposterior>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocompafe ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumero ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigendestino_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRemito ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigendestinodetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIddecaja ) + "'">> ) 
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
			local  lxPickingFaltafw, lxPickingFectrans, lxPickingFmodifw, lxPickingFecexpo, lxPickingFecimpo, lxPickingNumero, lxPickingPrepm, lxPickingValtafw, lxPickingUmodifw, lxPickingVmodifw, lxPickingZadsfw, lxPickingHaltafw, lxPickingHoraimpo, lxPickingSmodifw, lxPickingHmodifw, lxPickingUaltafw, lxPickingHoraexpo, lxPickingSaltafw, lxPickingBdmodifw, lxPickingBdaltafw, lxPickingEsttrans, lxPickingCodigo, lxPickingObs, lxPickingFecha, lxPickingComporigen, lxPickingVendedor, lxPickingFperson, lxPickingFcliente
				lxPickingFaltafw =  .Fechaaltafw			lxPickingFectrans =  .Fechatransferencia			lxPickingFmodifw =  .Fechamodificacionfw			lxPickingFecexpo =  .Fechaexpo			lxPickingFecimpo =  .Fechaimpo			lxPickingNumero =  .Numero			lxPickingPrepm =  .Espreparaciondemercaderia			lxPickingValtafw =  .Versionaltafw			lxPickingUmodifw =  .Usuariomodificacionfw			lxPickingVmodifw =  .Versionmodificacionfw			lxPickingZadsfw =  .Zadsfw			lxPickingHaltafw =  .Horaaltafw			lxPickingHoraimpo =  .Horaimpo			lxPickingSmodifw =  .Seriemodificacionfw			lxPickingHmodifw =  .Horamodificacionfw			lxPickingUaltafw =  .Usuarioaltafw			lxPickingHoraexpo =  .Horaexpo			lxPickingSaltafw =  .Seriealtafw			lxPickingBdmodifw =  .Basededatosmodificacionfw			lxPickingBdaltafw =  .Basededatosaltafw			lxPickingEsttrans =  .Estadotransferencia			lxPickingCodigo =  .Codigo			lxPickingObs =  .Obs			lxPickingFecha =  .Fecha			lxPickingComporigen =  .Tipocomprobanteorigen			lxPickingVendedor =  upper( .Vendedor_PK ) 			lxPickingFperson =  upper( .Cliente_PK ) 			lxPickingFcliente =  .Clientedescripcion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PICKING.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PICKING set "Faltafw" = <<"'" + this.ConvertirDateSql( lxPickingFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxPickingFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPickingFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPickingFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPickingFecimpo ) + "'">>, "Numero" = <<lxPickingNumero>>, "Prepm" = <<iif( lxPickingPrepm, 1, 0 )>>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxPickingValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxPickingUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxPickingVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxPickingZadsfw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxPickingHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxPickingHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxPickingSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPickingHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxPickingUaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxPickingHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxPickingSaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPickingBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPickingBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxPickingEsttrans ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxPickingCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxPickingObs ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxPickingFecha ) + "'">>, "Comporigen" = <<"'" + this.FormatearTextoSql( lxPickingComporigen ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxPickingVendedor ) + "'">>, "Fperson" = <<"'" + this.FormatearTextoSql( lxPickingFperson ) + "'">>, "Fcliente" = <<"'" + this.FormatearTextoSql( lxPickingFcliente ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PICKING' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetDifPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetOkPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetConPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetDifOPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetPrepMPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetCompPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CompAfec
				if this.oEntidad.CompAfec.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDiferencias
				if this.oEntidad.DetalleDiferencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetDifPicking("DPArticulo","COMP","NROITEM","ProcStock","Codigo","Equiv","DPDescArt","DPColor","DPDescColo","DPTalle","DPCantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleControlado
				if this.oEntidad.DetalleControlado.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxAgregado = loItem.Agregado
					lxNoprocesarstock = loItem.Noprocesarstock
					lxArticulo_PK = loItem.Articulo_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					lxAfe_saldo = loItem.Afe_saldo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetOkPicking("COMP","NROITEM","Agregado","ProcStock","OPArticulo","Codigo","Equiv","OPDescArt","OPColor","OPDescColo","OPTalle","OPCantidad","AfeSaldo" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxAgregado, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>>, <<lxAfe_saldo>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleCoincidencias
				if this.oEntidad.DetalleCoincidencias.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetConPicking("CPArticulo","NROITEM","Codigo","CPEquiv","CPColor","CPTalle","CPCantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDiferenciasOriginal
				if this.oEntidad.DetalleDiferenciasOriginal.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetDifOPicking("Articulo","COMP","NROITEM","Codigo","Equivalenc","cColor","Talle","Cantidad" ) values ( <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePreparacionMercaderia
				if this.oEntidad.DetallePreparacionMercaderia.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxColor_PK = loItem.Color_PK
					lxTalle = loItem.Talle
					lxCantidadafectada = loItem.Cantidadafectada
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxCodigoori_PK = loItem.Codigoori_PK
					lxIditemarticulos = loItem.Iditemarticulos
					lxCantidadoriginal = loItem.Cantidadoriginal
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetPrepMPicking("NroItem","Codigo","Articulo","cColor","Talle","CantAfe","Equiv","CodigoOri","IdItem","CantOri" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidadafectada>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoori_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxCantidadoriginal>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleComprobantes
				if this.oEntidad.DetalleComprobantes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTimestampcomprobante = loItem.Timestampcomprobante
					lxEntregaposterior = loItem.Entregaposterior
					lxNroitem = lnContadorNroItem
					lxCliente = loItem.Cliente
					lxCodigocompafe = loItem.Codigocompafe
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxOrigendestino_PK = loItem.Origendestino_PK
					lxRemito = loItem.Remito
					lxOrigendestinodetalle = loItem.Origendestinodetalle
					lxCantidad = loItem.Cantidad
					lxIddecaja = loItem.Iddecaja
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetCompPicking("tscomp","EntregaPos","NROITEM","Cliente","Cod_Afe","Codigo","CPNumero","FechaComp","OriDes","REMITO","OriDesDesc","Cantidad","IdCaja" ) values ( <<lxTimestampcomprobante>>, <<lxEntregaposterior>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocompafe ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumero ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigendestino_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRemito ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigendestinodetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIddecaja ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PICKING.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.PICKING where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetDifPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetOkPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetConPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetDifOPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetPrepMPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DetCompPicking where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'PICKING' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PICKING where  PICKING.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PICKING where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PICKING.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPickingNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PICKING'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PICKING Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.PICKING set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, PREPM = ] + Transform( iif( &lcCursor..PREPM, 1, 0 ))+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, CompOrigen = ] + "'" + this.FormatearTextoSql( &lcCursor..CompOrigen ) + "'"+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FCLIENTE = ] + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.PICKING Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FALTAFW, FECTRANS, FMODIFW, FECEXPO, FECIMPO, Numero, PREPM, VALTAFW, UMODIFW, VMODIFW, ZADSFW, HALTAFW, HORAIMPO, SMODIFW, HMODIFW, UALTAFW, HORAEXPO, SALTAFW, BDMODIFW, BDALTAFW, ESTTRANS, Codigo, Obs, Fecha, CompOrigen, Vendedor, FPerson, FCLIENTE
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + Transform( iif( &lcCursor..PREPM, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CompOrigen ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.PICKING ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PICKING'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DetDifPicking Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DetOkPicking Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DetConPicking Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DetDifOPicking Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DetPrepMPicking Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DetCompPicking Where Codigo] + lcIn  )
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
			"NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDIFERENCIASPICKING'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"DPArticulo","COMP","NROITEM","ProcStock","Codigo","Equiv","DPDescArt","DPColor","DPDescColo","DPTalle","DPCantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DetDifPicking ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.DPArticulo ) + "'" + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DPDescArt  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DPColor    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DPDescColo ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DPTalle    ) + "'" + ',' + transform( cDetallesExistentes.DPCantidad ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMOKPICKING'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"COMP","NROITEM","Agregado","ProcStock","OPArticulo","Codigo","Equiv","OPDescArt","OPColor","OPDescColo","OPTalle","OPCantidad","AfeSaldo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DetOkPicking ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.Agregado  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPArticulo ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPDescArt  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPColor    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPDescColo ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPTalle    ) + "'" + ',' + transform( cDetallesExistentes.OPCantidad ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOINCIDENCIAPICKING'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"CPArticulo","NROITEM","Codigo","CPEquiv","CPColor","CPTalle","CPCantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DetConPicking ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.CPArticulo ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CPEquiv    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CPColor    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CPTalle    ) + "'" + ',' + transform( cDetallesExistentes.CPCantidad ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDIFORIGINALPICKING'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Articulo","COMP","NROITEM","Codigo","Equivalenc","cColor","Talle","Cantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DetDifOPicking ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.Articulo   ) + "'" + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equivalenc ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPREPMPICKING'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NroItem","Codigo","Articulo","cColor","Talle","CantAfe","Equiv","CodigoOri","IdItem","CantOri"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DetPrepMPicking ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NroItem    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Articulo   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.CantAfe    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodigoOri  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.CantOri    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMPROBANTESPICKING'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"tscomp","EntregaPos","NROITEM","Cliente","Cod_Afe","Codigo","CPNumero","FechaComp","OriDes","REMITO","OriDesDesc","Cantidad","IdCaja"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DetCompPicking ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.tscomp     ) + ',' + transform( cDetallesExistentes.EntregaPos ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cliente    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cod_Afe    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CPNumero   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaComp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OriDes     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.REMITO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OriDesDesc ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdCaja     ) + "'" + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'PICKING'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PICKING_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PICKING_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDIFERENCIASPICKING'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMOKPICKING'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOINCIDENCIAPICKING'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDIFORIGINALPICKING'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPREPMPICKING'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTESPICKING'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_Picking')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PICKING'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PICKING. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PICKING'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( Numero, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( Numero, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PICKING'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Picking') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Picking
Create Table ZooLogic.TablaTrabajo_Picking ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"prepm" bit  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codigo" char( 38 )  null, 
"obs" varchar(max)  null, 
"fecha" datetime  null, 
"comporigen" char( 40 )  null, 
"vendedor" char( 5 )  null, 
"fperson" char( 5 )  null, 
"fcliente" char( 30 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_Picking' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_Picking' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PICKING'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('prepm','prepm')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('comporigen','comporigen')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fcliente','fcliente')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_Picking'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.PREPM = isnull( d.PREPM, t.PREPM ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.COMPORIGEN = isnull( d.COMPORIGEN, t.COMPORIGEN ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE )
					from ZooLogic.PICKING t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.PICKING(Faltafw,Fectrans,Fmodifw,Fecexpo,Fecimpo,Numero,Prepm,Valtafw,Umodifw,Vmodifw,Zadsfw,Haltafw,Horaimpo,Smodifw,Hmodifw,Ualtafw,Horaexpo,Saltafw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Obs,Fecha,Comporigen,Vendedor,Fperson,Fcliente)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.NUMERO,0),isnull( d.PREPM,0),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.FECHA,''),isnull( d.COMPORIGEN,''),isnull( d.VENDEDOR,''),isnull( d.FPERSON,''),isnull( d.FCLIENTE,'')
						From deleted d left join ZooLogic.PICKING pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.PICKING cc 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.PICKING t inner join deleted d 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.PICKING t inner join deleted d 
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
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PICKING_CompAfe
ON ZooLogic.TablaTrabajo_PICKING_CompAfe
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
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
"NROITEM",
"CODIGO",
"AFETIPOCOM",
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
d.NROITEM,
d.CODIGO,
d.AFETIPOCOM,
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
	function ObtenerTriggerDeleteImportacion_DetDifPicking( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PICKING_DetDifPicking
ON ZooLogic.TablaTrabajo_PICKING_DetDifPicking
AFTER DELETE
As
Begin
Update t Set 
t.DPARTICULO = isnull( d.DPARTICULO, t.DPARTICULO ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.DPDESCART = isnull( d.DPDESCART, t.DPDESCART ),
t.DPCOLOR = isnull( d.DPCOLOR, t.DPCOLOR ),
t.DPDESCCOLO = isnull( d.DPDESCCOLO, t.DPDESCCOLO ),
t.DPTALLE = isnull( d.DPTALLE, t.DPTALLE ),
t.DPCANTIDAD = isnull( d.DPCANTIDAD, t.DPCANTIDAD )
from ZooLogic.DetDifPicking t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DetDifPicking
( 
"DPARTICULO",
"COMP",
"NROITEM",
"PROCSTOCK",
"CODIGO",
"EQUIV",
"DPDESCART",
"DPCOLOR",
"DPDESCCOLO",
"DPTALLE",
"DPCANTIDAD"
 )
Select 
d.DPARTICULO,
d.COMP,
d.NROITEM,
d.PROCSTOCK,
d.CODIGO,
d.EQUIV,
d.DPDESCART,
d.DPCOLOR,
d.DPDESCCOLO,
d.DPTALLE,
d.DPCANTIDAD
From deleted d left join ZooLogic.DetDifPicking pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DetOkPicking( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PICKING_DetOkPicking
ON ZooLogic.TablaTrabajo_PICKING_DetOkPicking
AFTER DELETE
As
Begin
Update t Set 
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.AGREGADO = isnull( d.AGREGADO, t.AGREGADO ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.OPARTICULO = isnull( d.OPARTICULO, t.OPARTICULO ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.OPDESCART = isnull( d.OPDESCART, t.OPDESCART ),
t.OPCOLOR = isnull( d.OPCOLOR, t.OPCOLOR ),
t.OPDESCCOLO = isnull( d.OPDESCCOLO, t.OPDESCCOLO ),
t.OPTALLE = isnull( d.OPTALLE, t.OPTALLE ),
t.OPCANTIDAD = isnull( d.OPCANTIDAD, t.OPCANTIDAD ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO )
from ZooLogic.DetOkPicking t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DetOkPicking
( 
"COMP",
"NROITEM",
"AGREGADO",
"PROCSTOCK",
"OPARTICULO",
"CODIGO",
"EQUIV",
"OPDESCART",
"OPCOLOR",
"OPDESCCOLO",
"OPTALLE",
"OPCANTIDAD",
"AFESALDO"
 )
Select 
d.COMP,
d.NROITEM,
d.AGREGADO,
d.PROCSTOCK,
d.OPARTICULO,
d.CODIGO,
d.EQUIV,
d.OPDESCART,
d.OPCOLOR,
d.OPDESCCOLO,
d.OPTALLE,
d.OPCANTIDAD,
d.AFESALDO
From deleted d left join ZooLogic.DetOkPicking pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DetConPicking( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PICKING_DetConPicking
ON ZooLogic.TablaTrabajo_PICKING_DetConPicking
AFTER DELETE
As
Begin
Update t Set 
t.CPARTICULO = isnull( d.CPARTICULO, t.CPARTICULO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CPEQUIV = isnull( d.CPEQUIV, t.CPEQUIV ),
t.CPCOLOR = isnull( d.CPCOLOR, t.CPCOLOR ),
t.CPTALLE = isnull( d.CPTALLE, t.CPTALLE ),
t.CPCANTIDAD = isnull( d.CPCANTIDAD, t.CPCANTIDAD )
from ZooLogic.DetConPicking t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DetConPicking
( 
"CPARTICULO",
"NROITEM",
"CODIGO",
"CPEQUIV",
"CPCOLOR",
"CPTALLE",
"CPCANTIDAD"
 )
Select 
d.CPARTICULO,
d.NROITEM,
d.CODIGO,
d.CPEQUIV,
d.CPCOLOR,
d.CPTALLE,
d.CPCANTIDAD
From deleted d left join ZooLogic.DetConPicking pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DetDifOPicking( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PICKING_DetDifOPicking
ON ZooLogic.TablaTrabajo_PICKING_DetDifOPicking
AFTER DELETE
As
Begin
Update t Set 
t.ARTICULO = isnull( d.ARTICULO, t.ARTICULO ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIVALENC = isnull( d.EQUIVALENC, t.EQUIVALENC ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD )
from ZooLogic.DetDifOPicking t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DetDifOPicking
( 
"ARTICULO",
"COMP",
"NROITEM",
"CODIGO",
"EQUIVALENC",
"CCOLOR",
"TALLE",
"CANTIDAD"
 )
Select 
d.ARTICULO,
d.COMP,
d.NROITEM,
d.CODIGO,
d.EQUIVALENC,
d.CCOLOR,
d.TALLE,
d.CANTIDAD
From deleted d left join ZooLogic.DetDifOPicking pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DetPrepMPicking( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PICKING_DetPrepMPicking
ON ZooLogic.TablaTrabajo_PICKING_DetPrepMPicking
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.ARTICULO = isnull( d.ARTICULO, t.ARTICULO ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.CANTAFE = isnull( d.CANTAFE, t.CANTAFE ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.CODIGOORI = isnull( d.CODIGOORI, t.CODIGOORI ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.CANTORI = isnull( d.CANTORI, t.CANTORI )
from ZooLogic.DetPrepMPicking t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DetPrepMPicking
( 
"NROITEM",
"CODIGO",
"ARTICULO",
"CCOLOR",
"TALLE",
"CANTAFE",
"EQUIV",
"CODIGOORI",
"IDITEM",
"CANTORI"
 )
Select 
d.NROITEM,
d.CODIGO,
d.ARTICULO,
d.CCOLOR,
d.TALLE,
d.CANTAFE,
d.EQUIV,
d.CODIGOORI,
d.IDITEM,
d.CANTORI
From deleted d left join ZooLogic.DetPrepMPicking pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DetCompPicking( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PICKING_DetCompPicking
ON ZooLogic.TablaTrabajo_PICKING_DetCompPicking
AFTER DELETE
As
Begin
Update t Set 
t.TSCOMP = isnull( d.TSCOMP, t.TSCOMP ),
t.ENTREGAPOS = isnull( d.ENTREGAPOS, t.ENTREGAPOS ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),
t.COD_AFE = isnull( d.COD_AFE, t.COD_AFE ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CPNUMERO = isnull( d.CPNUMERO, t.CPNUMERO ),
t.FECHACOMP = isnull( d.FECHACOMP, t.FECHACOMP ),
t.ORIDES = isnull( d.ORIDES, t.ORIDES ),
t.REMITO = isnull( d.REMITO, t.REMITO ),
t.ORIDESDESC = isnull( d.ORIDESDESC, t.ORIDESDESC ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA )
from ZooLogic.DetCompPicking t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DetCompPicking
( 
"TSCOMP",
"ENTREGAPOS",
"NROITEM",
"CLIENTE",
"COD_AFE",
"CODIGO",
"CPNUMERO",
"FECHACOMP",
"ORIDES",
"REMITO",
"ORIDESDESC",
"CANTIDAD",
"IDCAJA"
 )
Select 
d.TSCOMP,
d.ENTREGAPOS,
d.NROITEM,
d.CLIENTE,
d.COD_AFE,
d.CODIGO,
d.CPNUMERO,
d.FECHACOMP,
d.ORIDES,
d.REMITO,
d.ORIDESDESC,
d.CANTIDAD,
d.IDCAJA
From deleted d left join ZooLogic.DetCompPicking pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Picking') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Picking
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PICKING' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PICKING.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PICKING.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PICKING.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PICKING.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PICKING.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_PICKING.Numero, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Espreparaciondemercaderia = nvl( c_PICKING.Espreparaciondemercaderia, .F. )
					.Versionaltafw = nvl( c_PICKING.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_PICKING.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_PICKING.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaaltafw = nvl( c_PICKING.Horaaltafw, [] )
					.Horaimpo = nvl( c_PICKING.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_PICKING.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_PICKING.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_PICKING.Usuarioaltafw, [] )
					.Horaexpo = nvl( c_PICKING.Horaexpo, [] )
					.Seriealtafw = nvl( c_PICKING.Seriealtafw, [] )
					.Basededatosmodificacionfw = nvl( c_PICKING.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_PICKING.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_PICKING.Estadotransferencia, [] )
					.Detallediferencias.Limpiar()
					.Detallediferencias.SetearEsNavegacion( .lProcesando )
					.Detallediferencias.Cargar()
					.Detallecontrolado.Limpiar()
					.Detallecontrolado.SetearEsNavegacion( .lProcesando )
					.Detallecontrolado.Cargar()
					.Detallecoincidencias.Limpiar()
					.Detallecoincidencias.SetearEsNavegacion( .lProcesando )
					.Detallecoincidencias.Cargar()
					.Detallediferenciasoriginal.Limpiar()
					.Detallediferenciasoriginal.SetearEsNavegacion( .lProcesando )
					.Detallediferenciasoriginal.Cargar()
					.Codigo = nvl( c_PICKING.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Detallepreparacionmercaderia.Limpiar()
					.Detallepreparacionmercaderia.SetearEsNavegacion( .lProcesando )
					.Detallepreparacionmercaderia.Cargar()
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_PICKING.Fecha, ctod( '  /  /    ' ) ) )
					.Tipocomprobanteorigen = nvl( c_PICKING.Tipocomprobanteorigen, [] )
					.Detallecomprobantes.Limpiar()
					.Detallecomprobantes.SetearEsNavegacion( .lProcesando )
					.Detallecomprobantes.Cargar()
					.Vendedor_PK =  nvl( c_PICKING.Vendedor, [] )
					.Cliente_PK =  nvl( c_PICKING.Cliente, [] )
					.Clientedescripcion = nvl( c_PICKING.Clientedescripcion, [] )
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
			lxRetorno = c_PICKING.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.CompAfec
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

		loDetalle = this.oEntidad.DetalleDiferencias
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

		loDetalle = this.oEntidad.DetalleControlado
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

		loDetalle = this.oEntidad.DetalleCoincidencias
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

		loDetalle = this.oEntidad.DetalleDiferenciasOriginal
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

		loDetalle = this.oEntidad.DetallePreparacionMercaderia
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

		loDetalle = this.oEntidad.DetalleComprobantes
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
		return c_PICKING.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PICKING' )
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
								from ZooLogic.PICKING 
								Where   PICKING.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PICKING", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Prepm" as "Espreparaciondemercaderia", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Obs" as "Obs", "Fecha" as "Fecha", "Comporigen" as "Tipocomprobanteorigen", "Vendedor" as "Vendedor", "Fperson" as "Cliente", "Fcliente" as "Clientedescripcion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PICKING 
								Where   PICKING.CODIGO != ''
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
	Tabla = 'PICKING'
	Filtro = " PICKING.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PICKING.CODIGO != ''"
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
	<row entidad="PICKING                                 " atributo="FECHAALTAFW                             " tabla="PICKING        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="FECHATRANSFERENCIA                      " tabla="PICKING        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="FECHAMODIFICACIONFW                     " tabla="PICKING        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="FECHAEXPO                               " tabla="PICKING        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="FECHAIMPO                               " tabla="PICKING        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="NUMERO                                  " tabla="PICKING        " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="ESPREPARACIONDEMERCADERIA               " tabla="PICKING        " campo="PREPM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Es preparación de mercadería                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="VERSIONALTAFW                           " tabla="PICKING        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="USUARIOMODIFICACIONFW                   " tabla="PICKING        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="VERSIONMODIFICACIONFW                   " tabla="PICKING        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="ZADSFW                                  " tabla="PICKING        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="HORAALTAFW                              " tabla="PICKING        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="HORAIMPO                                " tabla="PICKING        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="SERIEMODIFICACIONFW                     " tabla="PICKING        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="HORAMODIFICACIONFW                      " tabla="PICKING        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="USUARIOALTAFW                           " tabla="PICKING        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="HORAEXPO                                " tabla="PICKING        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="SERIEALTAFW                             " tabla="PICKING        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PICKING        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="BASEDEDATOSALTAFW                       " tabla="PICKING        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="ESTADOTRANSFERENCIA                     " tabla="PICKING        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="DETALLEDIFERENCIAS                      " tabla="DETDIFPICKING  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Diferencias encontradas                                                                                                                                         " dominio="DETALLEITEMDIFERENCIASPICKING " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="DETALLECONTROLADO                       " tabla="DETOKPICKING   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Artículos controlados                                                                                                                                           " dominio="DETALLEITEMOKPICKING          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="DETALLECOINCIDENCIAS                    " tabla="DETCONPICKING  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Coincidencias encontradas                                                                                                                                       " dominio="DETALLEITEMCOINCIDENCIAPICKING" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="DETALLEDIFERENCIASORIGINAL              " tabla="DETDIFOPICKING " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Diferencias originales encontradas                                                                                                                              " dominio="DETALLEITEMDIFORIGINALPICKING " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="CODIGO                                  " tabla="PICKING        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="12" etiqueta="Codigo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="OBS                                     " tabla="PICKING        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="DETALLEPREPARACIONMERCADERIA            " tabla="DETPREPMPICKING" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Unidades en preparación                                                                                                                                         " dominio="DETALLEITEMPREPMPICKING       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="FECHA                                   " tabla="PICKING        " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="6" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="TIPOCOMPROBANTEORIGEN                   " tabla="PICKING        " campo="COMPORIGEN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="=alltrim( goParametros.Felino.Picking.ComprobanteDefaultParaNuevoPicking )                                                                                                                                                                                    " obligatorio="false" admitebusqueda="8" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="COMBOENTIDADESPICKING         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="DETALLECOMPROBANTES                     " tabla="DETCOMPPICKING " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Comprobantes a controlar                                                                                                                                        " dominio="DETALLEITEMCOMPROBANTESPICKING" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="VENDEDOR                                " tabla="PICKING        " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="CLIENTE                                 " tabla="PICKING        " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PICKING                                 " atributo="CLIENTEDESCRIPCION                      " tabla="PICKING        " campo="FCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Cliente descripción                                                                                                                                             " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On PICKING.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="13" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On PICKING.FPERSON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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