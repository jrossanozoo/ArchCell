
define class Din_EntidadCOTIZACIONPRODUCCIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COTIZACIONPRODUCCION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 12, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 12, 0)]
	cTagClaveCandidata = '_CGOCC'
	cTagClavePk = '_CGOPK'
	cTablaPrincipal = 'COTIZAGOP'
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
			local  lxCotizagopFmodifw, lxCotizagopFaltafw, lxCotizagopFecexpo, lxCotizagopFecimpo, lxCotizagopFectrans, lxCotizagopEsttrans, lxCotizagopValtafw, lxCotizagopVmodifw, lxCotizagopBdmodifw, lxCotizagopUmodifw, lxCotizagopHaltafw, lxCotizagopSmodifw, lxCotizagopUaltafw, lxCotizagopSaltafw, lxCotizagopHoraimpo, lxCotizagopHmodifw, lxCotizagopZadsfw, lxCotizagopHoraexpo, lxCotizagopBdaltafw, lxCotizagopCodigo, lxCotizagopCobs, lxCotizagopNumero, lxCotizagopGestionpro, lxCotizagopFecha, lxCotizagopOrdendepro, lxCotizagopProceso, lxCotizagopGenera, lxCotizagopTaller, lxCotizagopLetracomp, lxCotizagopProveedor, lxCotizagopPuntocomp, lxCotizagopListac, lxCotizagopNumerocomp, lxCotizagopMoneda, lxCotizagopInsumos, lxCotizagopDescartes
				lxCotizagopFmodifw =  .Fechamodificacionfw			lxCotizagopFaltafw =  .Fechaaltafw			lxCotizagopFecexpo =  .Fechaexpo			lxCotizagopFecimpo =  .Fechaimpo			lxCotizagopFectrans =  .Fechatransferencia			lxCotizagopEsttrans =  .Estadotransferencia			lxCotizagopValtafw =  .Versionaltafw			lxCotizagopVmodifw =  .Versionmodificacionfw			lxCotizagopBdmodifw =  .Basededatosmodificacionfw			lxCotizagopUmodifw =  .Usuariomodificacionfw			lxCotizagopHaltafw =  .Horaaltafw			lxCotizagopSmodifw =  .Seriemodificacionfw			lxCotizagopUaltafw =  .Usuarioaltafw			lxCotizagopSaltafw =  .Seriealtafw			lxCotizagopHoraimpo =  .Horaimpo			lxCotizagopHmodifw =  .Horamodificacionfw			lxCotizagopZadsfw =  .Zadsfw			lxCotizagopHoraexpo =  .Horaexpo			lxCotizagopBdaltafw =  .Basededatosaltafw			lxCotizagopCodigo =  .Codigo			lxCotizagopCobs =  .Observ			lxCotizagopNumero =  .Numero			lxCotizagopGestionpro =  upper( .GestionDeProduccion_PK ) 			lxCotizagopFecha =  .Fecha			lxCotizagopOrdendepro =  upper( .OrdenDeProduccion_PK ) 			lxCotizagopProceso =  upper( .Proceso_PK ) 			lxCotizagopGenera =  .Generar			lxCotizagopTaller =  upper( .Taller_PK ) 			lxCotizagopLetracomp =  .Letracomprobante			lxCotizagopProveedor =  upper( .Proveedor_PK ) 			lxCotizagopPuntocomp =  .Puntodeventacomprobante			lxCotizagopListac =  upper( .ListaDeCosto_PK ) 			lxCotizagopNumerocomp =  .Numerocomprobante			lxCotizagopMoneda =  upper( .Moneda_PK ) 			lxCotizagopInsumos =  .Insumos			lxCotizagopDescartes =  .Descartes
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCotizagopCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COTIZAGOP ( "Fmodifw","Faltafw","Fecexpo","Fecimpo","Fectrans","Esttrans","Valtafw","Vmodifw","Bdmodifw","Umodifw","Haltafw","Smodifw","Ualtafw","Saltafw","Horaimpo","Hmodifw","Zadsfw","Horaexpo","Bdaltafw","Codigo","Cobs","Numero","Gestionpro","Fecha","Ordendepro","Proceso","Genera","Taller","Letracomp","Proveedor","Puntocomp","Listac","Numerocomp","Moneda","Insumos","Descartes" ) values ( <<"'" + this.ConvertirDateSql( lxCotizagopFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopCobs ) + "'" >>, <<lxCotizagopNumero >>, <<"'" + this.FormatearTextoSql( lxCotizagopGestionpro ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopOrdendepro ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopProceso ) + "'" >>, <<lxCotizagopGenera >>, <<"'" + this.FormatearTextoSql( lxCotizagopTaller ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopLetracomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopProveedor ) + "'" >>, <<lxCotizagopPuntocomp >>, <<"'" + this.FormatearTextoSql( lxCotizagopListac ) + "'" >>, <<lxCotizagopNumerocomp >>, <<"'" + this.FormatearTextoSql( lxCotizagopMoneda ) + "'" >>, <<lxCotizagopInsumos >>, <<lxCotizagopDescartes >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenProduccion
				if this.oEntidad.CotizacionOrdenProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDPROD("IdItem","Comp","NROITEM","Cotizalqpr","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenDescarte
				if this.oEntidad.CotizacionOrdenDescarte.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDDESC("IdItem","Comp","NROITEM","Cotizalqde","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenInsumos
				if this.oEntidad.CotizacionOrdenInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDINS("IdItem","Comp","NROITEM","Cotizalqin","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenAdicionales
				if this.oEntidad.CotizacionOrdenAdicionales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulo = loItem.Iditemarticulo
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COTORDADIC("IdItem","NROITEM","Comp","Cotizalqad","ArtLiq","ArtDesc","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxCosto>>, <<lxMonto>> ) 
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
			local  lxCotizagopFmodifw, lxCotizagopFaltafw, lxCotizagopFecexpo, lxCotizagopFecimpo, lxCotizagopFectrans, lxCotizagopEsttrans, lxCotizagopValtafw, lxCotizagopVmodifw, lxCotizagopBdmodifw, lxCotizagopUmodifw, lxCotizagopHaltafw, lxCotizagopSmodifw, lxCotizagopUaltafw, lxCotizagopSaltafw, lxCotizagopHoraimpo, lxCotizagopHmodifw, lxCotizagopZadsfw, lxCotizagopHoraexpo, lxCotizagopBdaltafw, lxCotizagopCodigo, lxCotizagopCobs, lxCotizagopNumero, lxCotizagopGestionpro, lxCotizagopFecha, lxCotizagopOrdendepro, lxCotizagopProceso, lxCotizagopGenera, lxCotizagopTaller, lxCotizagopLetracomp, lxCotizagopProveedor, lxCotizagopPuntocomp, lxCotizagopListac, lxCotizagopNumerocomp, lxCotizagopMoneda, lxCotizagopInsumos, lxCotizagopDescartes
				lxCotizagopFmodifw =  .Fechamodificacionfw			lxCotizagopFaltafw =  .Fechaaltafw			lxCotizagopFecexpo =  .Fechaexpo			lxCotizagopFecimpo =  .Fechaimpo			lxCotizagopFectrans =  .Fechatransferencia			lxCotizagopEsttrans =  .Estadotransferencia			lxCotizagopValtafw =  .Versionaltafw			lxCotizagopVmodifw =  .Versionmodificacionfw			lxCotizagopBdmodifw =  .Basededatosmodificacionfw			lxCotizagopUmodifw =  .Usuariomodificacionfw			lxCotizagopHaltafw =  .Horaaltafw			lxCotizagopSmodifw =  .Seriemodificacionfw			lxCotizagopUaltafw =  .Usuarioaltafw			lxCotizagopSaltafw =  .Seriealtafw			lxCotizagopHoraimpo =  .Horaimpo			lxCotizagopHmodifw =  .Horamodificacionfw			lxCotizagopZadsfw =  .Zadsfw			lxCotizagopHoraexpo =  .Horaexpo			lxCotizagopBdaltafw =  .Basededatosaltafw			lxCotizagopCodigo =  .Codigo			lxCotizagopCobs =  .Observ			lxCotizagopNumero =  .Numero			lxCotizagopGestionpro =  upper( .GestionDeProduccion_PK ) 			lxCotizagopFecha =  .Fecha			lxCotizagopOrdendepro =  upper( .OrdenDeProduccion_PK ) 			lxCotizagopProceso =  upper( .Proceso_PK ) 			lxCotizagopGenera =  .Generar			lxCotizagopTaller =  upper( .Taller_PK ) 			lxCotizagopLetracomp =  .Letracomprobante			lxCotizagopProveedor =  upper( .Proveedor_PK ) 			lxCotizagopPuntocomp =  .Puntodeventacomprobante			lxCotizagopListac =  upper( .ListaDeCosto_PK ) 			lxCotizagopNumerocomp =  .Numerocomprobante			lxCotizagopMoneda =  upper( .Moneda_PK ) 			lxCotizagopInsumos =  .Insumos			lxCotizagopDescartes =  .Descartes
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.COTIZAGOP set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCotizagopFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCotizagopFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCotizagopFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCotizagopFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCotizagopFectrans ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCotizagopEsttrans ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCotizagopValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopVmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopBdmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCotizagopHaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCotizagopUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCotizagopSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCotizagopHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopHmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCotizagopZadsfw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCotizagopHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCotizagopBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCotizagopCodigo ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxCotizagopCobs ) + "'">>,"Numero" = <<lxCotizagopNumero>>,"Gestionpro" = <<"'" + this.FormatearTextoSql( lxCotizagopGestionpro ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCotizagopFecha ) + "'">>,"Ordendepro" = <<"'" + this.FormatearTextoSql( lxCotizagopOrdendepro ) + "'">>,"Proceso" = <<"'" + this.FormatearTextoSql( lxCotizagopProceso ) + "'">>,"Genera" = <<lxCotizagopGenera>>,"Taller" = <<"'" + this.FormatearTextoSql( lxCotizagopTaller ) + "'">>,"Letracomp" = <<"'" + this.FormatearTextoSql( lxCotizagopLetracomp ) + "'">>,"Proveedor" = <<"'" + this.FormatearTextoSql( lxCotizagopProveedor ) + "'">>,"Puntocomp" = <<lxCotizagopPuntocomp>>,"Listac" = <<"'" + this.FormatearTextoSql( lxCotizagopListac ) + "'">>,"Numerocomp" = <<lxCotizagopNumerocomp>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCotizagopMoneda ) + "'">>,"Insumos" = <<lxCotizagopInsumos>>,"Descartes" = <<lxCotizagopDescartes>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCotizagopCodigo ) + "'">> and  COTIZAGOP.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTORDPROD where "Cotizalqpr" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTORDDESC where "Cotizalqde" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTORDINS where "Cotizalqin" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTORDADIC where "Cotizalqad" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenProduccion
				if this.oEntidad.CotizacionOrdenProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDPROD("IdItem","Comp","NROITEM","Cotizalqpr","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenDescarte
				if this.oEntidad.CotizacionOrdenDescarte.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDDESC("IdItem","Comp","NROITEM","Cotizalqde","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenInsumos
				if this.oEntidad.CotizacionOrdenInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDINS("IdItem","Comp","NROITEM","Cotizalqin","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenAdicionales
				if this.oEntidad.CotizacionOrdenAdicionales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulo = loItem.Iditemarticulo
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COTORDADIC("IdItem","NROITEM","Comp","Cotizalqad","ArtLiq","ArtDesc","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxCosto>>, <<lxMonto>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.COTIZAGOP where " + this.ConvertirFuncionesSql( " COTIZAGOP.CODIGO != ''" ) )
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
			Local lxCotizagopCodigo
			lxCotizagopCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Cobs" as "Observ", "Numero" as "Numero", "Gestionpro" as "Gestiondeproduccion", "Fecha" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Genera" as "Generar", "Taller" as "Taller", "Letracomp" as "Letracomprobante", "Proveedor" as "Proveedor", "Puntocomp" as "Puntodeventacomprobante", "Listac" as "Listadecosto", "Numerocomp" as "Numerocomprobante", "Moneda" as "Moneda", "Insumos" as "Insumos", "Descartes" as "Descartes" from ZooLogic.COTIZAGOP where "Codigo" = <<"'" + this.FormatearTextoSql( lxCotizagopCodigo ) + "'">> and  COTIZAGOP.CODIGO != ''
			endtext
			use in select('c_COTIZACIONPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COTIZACIONPRODUCCION', set( 'Datasession' ) )

			if reccount( 'c_COTIZACIONPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqpr" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDPROD where Cotizalqpr = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqde" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDDESC where Cotizalqde = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqin" as "Codigo", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDINS where Cotizalqin = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Cotizalqad" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDADIC where Cotizalqad = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenAdicionales
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCOTIZAGOPNumero As Variant
			lxCOTIZAGOPNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Cobs" as "Observ", "Numero" as "Numero", "Gestionpro" as "Gestiondeproduccion", "Fecha" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Genera" as "Generar", "Taller" as "Taller", "Letracomp" as "Letracomprobante", "Proveedor" as "Proveedor", "Puntocomp" as "Puntodeventacomprobante", "Listac" as "Listadecosto", "Numerocomp" as "Numerocomprobante", "Moneda" as "Moneda", "Insumos" as "Insumos", "Descartes" as "Descartes" from ZooLogic.COTIZAGOP where  COTIZAGOP.CODIGO != '' And Numero = <<lxCOTIZAGOPNumero>>
			endtext
			use in select('c_COTIZACIONPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COTIZACIONPRODUCCION', set( 'Datasession' ) )
			if reccount( 'c_COTIZACIONPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqpr" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDPROD where Cotizalqpr = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqde" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDDESC where Cotizalqde = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqin" as "Codigo", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDINS where Cotizalqin = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Cotizalqad" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDADIC where Cotizalqad = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenAdicionales
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCotizagopCodigo as Variant
		llRetorno = .t.
		lxCotizagopCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COTIZAGOP where "Codigo" = <<"'" + this.FormatearTextoSql( lxCotizagopCodigo ) + "'">> and  COTIZAGOP.CODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Cobs" as "Observ", "Numero" as "Numero", "Gestionpro" as "Gestiondeproduccion", "Fecha" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Genera" as "Generar", "Taller" as "Taller", "Letracomp" as "Letracomprobante", "Proveedor" as "Proveedor", "Puntocomp" as "Puntodeventacomprobante", "Listac" as "Listadecosto", "Numerocomp" as "Numerocomprobante", "Moneda" as "Moneda", "Insumos" as "Insumos", "Descartes" as "Descartes" from ZooLogic.COTIZAGOP where  COTIZAGOP.CODIGO != '' order by Numero
			endtext
			use in select('c_COTIZACIONPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COTIZACIONPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqpr" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDPROD where Cotizalqpr = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqde" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDDESC where Cotizalqde = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqin" as "Codigo", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDINS where Cotizalqin = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Cotizalqad" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDADIC where Cotizalqad = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenAdicionales
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Cobs" as "Observ", "Numero" as "Numero", "Gestionpro" as "Gestiondeproduccion", "Fecha" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Genera" as "Generar", "Taller" as "Taller", "Letracomp" as "Letracomprobante", "Proveedor" as "Proveedor", "Puntocomp" as "Puntodeventacomprobante", "Listac" as "Listadecosto", "Numerocomp" as "Numerocomprobante", "Moneda" as "Moneda", "Insumos" as "Insumos", "Descartes" as "Descartes" from ZooLogic.COTIZAGOP where  str( Numero, 12, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COTIZAGOP.CODIGO != '' order by Numero
			endtext
			use in select('c_COTIZACIONPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COTIZACIONPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqpr" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDPROD where Cotizalqpr = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqde" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDDESC where Cotizalqde = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqin" as "Codigo", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDINS where Cotizalqin = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Cotizalqad" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDADIC where Cotizalqad = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenAdicionales
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Cobs" as "Observ", "Numero" as "Numero", "Gestionpro" as "Gestiondeproduccion", "Fecha" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Genera" as "Generar", "Taller" as "Taller", "Letracomp" as "Letracomprobante", "Proveedor" as "Proveedor", "Puntocomp" as "Puntodeventacomprobante", "Listac" as "Listadecosto", "Numerocomp" as "Numerocomprobante", "Moneda" as "Moneda", "Insumos" as "Insumos", "Descartes" as "Descartes" from ZooLogic.COTIZAGOP where  str( Numero, 12, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COTIZAGOP.CODIGO != '' order by Numero desc
			endtext
			use in select('c_COTIZACIONPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COTIZACIONPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqpr" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDPROD where Cotizalqpr = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqde" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDDESC where Cotizalqde = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqin" as "Codigo", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDINS where Cotizalqin = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Cotizalqad" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDADIC where Cotizalqad = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenAdicionales
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Cobs" as "Observ", "Numero" as "Numero", "Gestionpro" as "Gestiondeproduccion", "Fecha" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Genera" as "Generar", "Taller" as "Taller", "Letracomp" as "Letracomprobante", "Proveedor" as "Proveedor", "Puntocomp" as "Puntodeventacomprobante", "Listac" as "Listadecosto", "Numerocomp" as "Numerocomprobante", "Moneda" as "Moneda", "Insumos" as "Insumos", "Descartes" as "Descartes" from ZooLogic.COTIZAGOP where  COTIZAGOP.CODIGO != '' order by Numero desc
			endtext
			use in select('c_COTIZACIONPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COTIZACIONPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqpr" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDPROD where Cotizalqpr = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenProduccion')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenProduccion', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenProduccion
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqde" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDDESC where Cotizalqde = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenDescarte')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenDescarte', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenDescarte
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqin" as "Codigo", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDINS where Cotizalqin = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Cotizalqad" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto" from ZooLogic.COTORDADIC where Cotizalqad = <<"'" + this.FormatearTextoSql( c_COTIZACIONPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CotizacionOrdenAdicionales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CotizacionOrdenAdicionales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CotizacionOrdenAdicionales
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Faltafw,Fecexpo,Fecimpo,Fectrans,Esttrans,Valtafw,Vmodifw,Bdmodifw,Umodifw,Haltafw,S" + ;
"modifw,Ualtafw,Saltafw,Horaimpo,Hmodifw,Zadsfw,Horaexpo,Bdaltafw,Codigo,Cobs,Numero,Gestionpro,Fecha" + ;
",Ordendepro,Proceso,Genera,Taller,Letracomp,Proveedor,Puntocomp,Listac,Numerocomp,Moneda,Insumos,Des" + ;
"cartes" + ;
" from ZooLogic.COTIZAGOP where  COTIZAGOP.CODIGO != '' and " + lcFiltro )
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
			local  lxCotizagopFmodifw, lxCotizagopFaltafw, lxCotizagopFecexpo, lxCotizagopFecimpo, lxCotizagopFectrans, lxCotizagopEsttrans, lxCotizagopValtafw, lxCotizagopVmodifw, lxCotizagopBdmodifw, lxCotizagopUmodifw, lxCotizagopHaltafw, lxCotizagopSmodifw, lxCotizagopUaltafw, lxCotizagopSaltafw, lxCotizagopHoraimpo, lxCotizagopHmodifw, lxCotizagopZadsfw, lxCotizagopHoraexpo, lxCotizagopBdaltafw, lxCotizagopCodigo, lxCotizagopCobs, lxCotizagopNumero, lxCotizagopGestionpro, lxCotizagopFecha, lxCotizagopOrdendepro, lxCotizagopProceso, lxCotizagopGenera, lxCotizagopTaller, lxCotizagopLetracomp, lxCotizagopProveedor, lxCotizagopPuntocomp, lxCotizagopListac, lxCotizagopNumerocomp, lxCotizagopMoneda, lxCotizagopInsumos, lxCotizagopDescartes
				lxCotizagopFmodifw = ctod( '  /  /    ' )			lxCotizagopFaltafw = ctod( '  /  /    ' )			lxCotizagopFecexpo = ctod( '  /  /    ' )			lxCotizagopFecimpo = ctod( '  /  /    ' )			lxCotizagopFectrans = ctod( '  /  /    ' )			lxCotizagopEsttrans = []			lxCotizagopValtafw = []			lxCotizagopVmodifw = []			lxCotizagopBdmodifw = []			lxCotizagopUmodifw = []			lxCotizagopHaltafw = []			lxCotizagopSmodifw = []			lxCotizagopUaltafw = []			lxCotizagopSaltafw = []			lxCotizagopHoraimpo = []			lxCotizagopHmodifw = []			lxCotizagopZadsfw = []			lxCotizagopHoraexpo = []			lxCotizagopBdaltafw = []			lxCotizagopCodigo = []			lxCotizagopCobs = []			lxCotizagopNumero = 0			lxCotizagopGestionpro = []			lxCotizagopFecha = ctod( '  /  /    ' )			lxCotizagopOrdendepro = []			lxCotizagopProceso = []			lxCotizagopGenera = 0			lxCotizagopTaller = []			lxCotizagopLetracomp = []			lxCotizagopProveedor = []			lxCotizagopPuntocomp = 0			lxCotizagopListac = []			lxCotizagopNumerocomp = 0			lxCotizagopMoneda = []			lxCotizagopInsumos = 0			lxCotizagopDescartes = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTORDPROD where "Cotizalqpr" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTORDDESC where "Cotizalqde" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTORDINS where "Cotizalqin" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COTORDADIC where "Cotizalqad" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COTIZAGOP where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COTIZAGOP' + '_' + tcCampo
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
		lcWhere = " Where  COTIZAGOP.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Cobs" as "Observ", "Numero" as "Numero", "Gestionpro" as "Gestiondeproduccion", "Fecha" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Genera" as "Generar", "Taller" as "Taller", "Letracomp" as "Letracomprobante", "Proveedor" as "Proveedor", "Puntocomp" as "Puntodeventacomprobante", "Listac" as "Listadecosto", "Numerocomp" as "Numerocomprobante", "Moneda" as "Moneda", "Insumos" as "Insumos", "Descartes" as "Descartes"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COTIZAGOP', '', tnTope )
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
	Function ObtenerDatosDetalleCotizacionOrdenProduccion( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COTORDPROD.COTIZALQPR != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqpr" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCotizacionOrdenProduccion( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COTORDPROD', 'CotizacionOrdenProduccion', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCotizacionOrdenProduccion( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCotizacionOrdenProduccion( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleCotizacionOrdenDescarte( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COTORDDESC.COTIZALQDE != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqde" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCotizacionOrdenDescarte( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COTORDDESC', 'CotizacionOrdenDescarte', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCotizacionOrdenDescarte( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCotizacionOrdenDescarte( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleCotizacionOrdenInsumos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COTORDINS.COTIZALQIN != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Cotizalqin" as "Codigo", "Insumo" as "Insumo", "Insdeta" as "Insumodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Costo" as "Costo", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCotizacionOrdenInsumos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COTORDINS', 'CotizacionOrdenInsumos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCotizacionOrdenInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCotizacionOrdenInsumos( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleCotizacionOrdenAdicionales( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COTORDADIC.COTIZALQAD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditemarticulo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Cotizalqad" as "Codigo", "Artliq" as "Articulo", "Artdesc" as "Articulodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Cantidad", "Costo" as "Costo", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCotizacionOrdenAdicionales( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COTORDADIC', 'CotizacionOrdenAdicionales', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCotizacionOrdenAdicionales( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCotizacionOrdenAdicionales( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERV'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'GESTIONDEPRODUCCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GESTIONPRO AS GESTIONDEPRODUCCION'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'ORDENDEPRODUCCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDENDEPRO AS ORDENDEPRODUCCION'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'GENERAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GENERA AS GENERAR'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'LETRACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRACOMP AS LETRACOMPROBANTE'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDOR AS PROVEEDOR'
				Case lcAtributo == 'PUNTODEVENTACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUNTOCOMP AS PUNTODEVENTACOMPROBANTE'
				Case lcAtributo == 'LISTADECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTAC AS LISTADECOSTO'
				Case lcAtributo == 'NUMEROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROCOMP AS NUMEROCOMPROBANTE'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDA'
				Case lcAtributo == 'INSUMOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMOS AS INSUMOS'
				Case lcAtributo == 'DESCARTES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCARTES AS DESCARTES'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCotizacionOrdenProduccion( tcCampos As String ) As String
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZALQPR AS CODIGO'
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
	Function ObtenerCamposSelectDetalleCotizacionOrdenDescarte( tcCampos As String ) As String
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZALQDE AS CODIGO'
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
	Function ObtenerCamposSelectDetalleCotizacionOrdenInsumos( tcCampos As String ) As String
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZALQIN AS CODIGO'
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
	Function ObtenerCamposSelectDetalleCotizacionOrdenAdicionales( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZALQAD AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTLIQ AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESC AS ARTICULODETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERV'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'GESTIONDEPRODUCCION'
				lcCampo = 'GESTIONPRO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPRODUCCION'
				lcCampo = 'ORDENDEPRO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'GENERAR'
				lcCampo = 'GENERA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'LETRACOMPROBANTE'
				lcCampo = 'LETRACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVEEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTACOMPROBANTE'
				lcCampo = 'PUNTOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADECOSTO'
				lcCampo = 'LISTAC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMPROBANTE'
				lcCampo = 'NUMEROCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMOS'
				lcCampo = 'INSUMOS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCARTES'
				lcCampo = 'DESCARTES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCotizacionOrdenProduccion( tcAtributo As String ) As String
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
				lcCampo = 'COTIZALQPR'
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
	Function ObtenerCampoDetalleCotizacionOrdenDescarte( tcAtributo As String ) As String
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
				lcCampo = 'COTIZALQDE'
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
	Function ObtenerCampoDetalleCotizacionOrdenInsumos( tcAtributo As String ) As String
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
				lcCampo = 'COTIZALQIN'
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
	Function ObtenerCampoDetalleCotizacionOrdenAdicionales( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COTIZALQAD'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'ARTDESC'
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
		if upper( alltrim( tcDetalle ) ) == 'COTIZACIONORDENPRODUCCION'
			lcRetorno = 'COTORDPROD'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'COTIZACIONORDENDESCARTE'
			lcRetorno = 'COTORDDESC'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'COTIZACIONORDENINSUMOS'
			lcRetorno = 'COTORDINS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'COTIZACIONORDENADICIONALES'
			lcRetorno = 'COTORDADIC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCotizagopFmodifw, lxCotizagopFaltafw, lxCotizagopFecexpo, lxCotizagopFecimpo, lxCotizagopFectrans, lxCotizagopEsttrans, lxCotizagopValtafw, lxCotizagopVmodifw, lxCotizagopBdmodifw, lxCotizagopUmodifw, lxCotizagopHaltafw, lxCotizagopSmodifw, lxCotizagopUaltafw, lxCotizagopSaltafw, lxCotizagopHoraimpo, lxCotizagopHmodifw, lxCotizagopZadsfw, lxCotizagopHoraexpo, lxCotizagopBdaltafw, lxCotizagopCodigo, lxCotizagopCobs, lxCotizagopNumero, lxCotizagopGestionpro, lxCotizagopFecha, lxCotizagopOrdendepro, lxCotizagopProceso, lxCotizagopGenera, lxCotizagopTaller, lxCotizagopLetracomp, lxCotizagopProveedor, lxCotizagopPuntocomp, lxCotizagopListac, lxCotizagopNumerocomp, lxCotizagopMoneda, lxCotizagopInsumos, lxCotizagopDescartes
				lxCotizagopFmodifw =  .Fechamodificacionfw			lxCotizagopFaltafw =  .Fechaaltafw			lxCotizagopFecexpo =  .Fechaexpo			lxCotizagopFecimpo =  .Fechaimpo			lxCotizagopFectrans =  .Fechatransferencia			lxCotizagopEsttrans =  .Estadotransferencia			lxCotizagopValtafw =  .Versionaltafw			lxCotizagopVmodifw =  .Versionmodificacionfw			lxCotizagopBdmodifw =  .Basededatosmodificacionfw			lxCotizagopUmodifw =  .Usuariomodificacionfw			lxCotizagopHaltafw =  .Horaaltafw			lxCotizagopSmodifw =  .Seriemodificacionfw			lxCotizagopUaltafw =  .Usuarioaltafw			lxCotizagopSaltafw =  .Seriealtafw			lxCotizagopHoraimpo =  .Horaimpo			lxCotizagopHmodifw =  .Horamodificacionfw			lxCotizagopZadsfw =  .Zadsfw			lxCotizagopHoraexpo =  .Horaexpo			lxCotizagopBdaltafw =  .Basededatosaltafw			lxCotizagopCodigo =  .Codigo			lxCotizagopCobs =  .Observ			lxCotizagopNumero =  .Numero			lxCotizagopGestionpro =  upper( .GestionDeProduccion_PK ) 			lxCotizagopFecha =  .Fecha			lxCotizagopOrdendepro =  upper( .OrdenDeProduccion_PK ) 			lxCotizagopProceso =  upper( .Proceso_PK ) 			lxCotizagopGenera =  .Generar			lxCotizagopTaller =  upper( .Taller_PK ) 			lxCotizagopLetracomp =  .Letracomprobante			lxCotizagopProveedor =  upper( .Proveedor_PK ) 			lxCotizagopPuntocomp =  .Puntodeventacomprobante			lxCotizagopListac =  upper( .ListaDeCosto_PK ) 			lxCotizagopNumerocomp =  .Numerocomprobante			lxCotizagopMoneda =  upper( .Moneda_PK ) 			lxCotizagopInsumos =  .Insumos			lxCotizagopDescartes =  .Descartes
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COTIZAGOP ( "Fmodifw","Faltafw","Fecexpo","Fecimpo","Fectrans","Esttrans","Valtafw","Vmodifw","Bdmodifw","Umodifw","Haltafw","Smodifw","Ualtafw","Saltafw","Horaimpo","Hmodifw","Zadsfw","Horaexpo","Bdaltafw","Codigo","Cobs","Numero","Gestionpro","Fecha","Ordendepro","Proceso","Genera","Taller","Letracomp","Proveedor","Puntocomp","Listac","Numerocomp","Moneda","Insumos","Descartes" ) values ( <<"'" + this.ConvertirDateSql( lxCotizagopFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopCobs ) + "'" >>, <<lxCotizagopNumero >>, <<"'" + this.FormatearTextoSql( lxCotizagopGestionpro ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCotizagopFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopOrdendepro ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopProceso ) + "'" >>, <<lxCotizagopGenera >>, <<"'" + this.FormatearTextoSql( lxCotizagopTaller ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopLetracomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCotizagopProveedor ) + "'" >>, <<lxCotizagopPuntocomp >>, <<"'" + this.FormatearTextoSql( lxCotizagopListac ) + "'" >>, <<lxCotizagopNumerocomp >>, <<"'" + this.FormatearTextoSql( lxCotizagopMoneda ) + "'" >>, <<lxCotizagopInsumos >>, <<lxCotizagopDescartes >> )
		endtext
		loColeccion.cTabla = 'COTIZAGOP' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenProduccion
				if this.oEntidad.CotizacionOrdenProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDPROD("IdItem","Comp","NROITEM","Cotizalqpr","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenDescarte
				if this.oEntidad.CotizacionOrdenDescarte.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDDESC("IdItem","Comp","NROITEM","Cotizalqde","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenInsumos
				if this.oEntidad.CotizacionOrdenInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDINS("IdItem","Comp","NROITEM","Cotizalqin","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenAdicionales
				if this.oEntidad.CotizacionOrdenAdicionales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulo = loItem.Iditemarticulo
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COTORDADIC("IdItem","NROITEM","Comp","Cotizalqad","ArtLiq","ArtDesc","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxCosto>>, <<lxMonto>> ) 
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
			local  lxCotizagopFmodifw, lxCotizagopFaltafw, lxCotizagopFecexpo, lxCotizagopFecimpo, lxCotizagopFectrans, lxCotizagopEsttrans, lxCotizagopValtafw, lxCotizagopVmodifw, lxCotizagopBdmodifw, lxCotizagopUmodifw, lxCotizagopHaltafw, lxCotizagopSmodifw, lxCotizagopUaltafw, lxCotizagopSaltafw, lxCotizagopHoraimpo, lxCotizagopHmodifw, lxCotizagopZadsfw, lxCotizagopHoraexpo, lxCotizagopBdaltafw, lxCotizagopCodigo, lxCotizagopCobs, lxCotizagopNumero, lxCotizagopGestionpro, lxCotizagopFecha, lxCotizagopOrdendepro, lxCotizagopProceso, lxCotizagopGenera, lxCotizagopTaller, lxCotizagopLetracomp, lxCotizagopProveedor, lxCotizagopPuntocomp, lxCotizagopListac, lxCotizagopNumerocomp, lxCotizagopMoneda, lxCotizagopInsumos, lxCotizagopDescartes
				lxCotizagopFmodifw =  .Fechamodificacionfw			lxCotizagopFaltafw =  .Fechaaltafw			lxCotizagopFecexpo =  .Fechaexpo			lxCotizagopFecimpo =  .Fechaimpo			lxCotizagopFectrans =  .Fechatransferencia			lxCotizagopEsttrans =  .Estadotransferencia			lxCotizagopValtafw =  .Versionaltafw			lxCotizagopVmodifw =  .Versionmodificacionfw			lxCotizagopBdmodifw =  .Basededatosmodificacionfw			lxCotizagopUmodifw =  .Usuariomodificacionfw			lxCotizagopHaltafw =  .Horaaltafw			lxCotizagopSmodifw =  .Seriemodificacionfw			lxCotizagopUaltafw =  .Usuarioaltafw			lxCotizagopSaltafw =  .Seriealtafw			lxCotizagopHoraimpo =  .Horaimpo			lxCotizagopHmodifw =  .Horamodificacionfw			lxCotizagopZadsfw =  .Zadsfw			lxCotizagopHoraexpo =  .Horaexpo			lxCotizagopBdaltafw =  .Basededatosaltafw			lxCotizagopCodigo =  .Codigo			lxCotizagopCobs =  .Observ			lxCotizagopNumero =  .Numero			lxCotizagopGestionpro =  upper( .GestionDeProduccion_PK ) 			lxCotizagopFecha =  .Fecha			lxCotizagopOrdendepro =  upper( .OrdenDeProduccion_PK ) 			lxCotizagopProceso =  upper( .Proceso_PK ) 			lxCotizagopGenera =  .Generar			lxCotizagopTaller =  upper( .Taller_PK ) 			lxCotizagopLetracomp =  .Letracomprobante			lxCotizagopProveedor =  upper( .Proveedor_PK ) 			lxCotizagopPuntocomp =  .Puntodeventacomprobante			lxCotizagopListac =  upper( .ListaDeCosto_PK ) 			lxCotizagopNumerocomp =  .Numerocomprobante			lxCotizagopMoneda =  upper( .Moneda_PK ) 			lxCotizagopInsumos =  .Insumos			lxCotizagopDescartes =  .Descartes
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COTIZAGOP.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COTIZAGOP set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCotizagopFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCotizagopFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCotizagopFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCotizagopFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCotizagopFectrans ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCotizagopEsttrans ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCotizagopValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopVmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopBdmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCotizagopHaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCotizagopUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCotizagopSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCotizagopHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCotizagopHmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCotizagopZadsfw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCotizagopHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCotizagopBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCotizagopCodigo ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxCotizagopCobs ) + "'">>, "Numero" = <<lxCotizagopNumero>>, "Gestionpro" = <<"'" + this.FormatearTextoSql( lxCotizagopGestionpro ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCotizagopFecha ) + "'">>, "Ordendepro" = <<"'" + this.FormatearTextoSql( lxCotizagopOrdendepro ) + "'">>, "Proceso" = <<"'" + this.FormatearTextoSql( lxCotizagopProceso ) + "'">>, "Genera" = <<lxCotizagopGenera>>, "Taller" = <<"'" + this.FormatearTextoSql( lxCotizagopTaller ) + "'">>, "Letracomp" = <<"'" + this.FormatearTextoSql( lxCotizagopLetracomp ) + "'">>, "Proveedor" = <<"'" + this.FormatearTextoSql( lxCotizagopProveedor ) + "'">>, "Puntocomp" = <<lxCotizagopPuntocomp>>, "Listac" = <<"'" + this.FormatearTextoSql( lxCotizagopListac ) + "'">>, "Numerocomp" = <<lxCotizagopNumerocomp>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCotizagopMoneda ) + "'">>, "Insumos" = <<lxCotizagopInsumos>>, "Descartes" = <<lxCotizagopDescartes>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COTIZAGOP' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.COTORDPROD where "Cotizalqpr" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.COTORDDESC where "Cotizalqde" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.COTORDINS where "Cotizalqin" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.COTORDADIC where "Cotizalqad" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenProduccion
				if this.oEntidad.CotizacionOrdenProduccion.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDPROD("IdItem","Comp","NROITEM","Cotizalqpr","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenDescarte
				if this.oEntidad.CotizacionOrdenDescarte.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDDESC("IdItem","Comp","NROITEM","Cotizalqde","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenInsumos
				if this.oEntidad.CotizacionOrdenInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.COTORDINS("IdItem","Comp","NROITEM","Cotizalqin","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<lxCosto>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CotizacionOrdenAdicionales
				if this.oEntidad.CotizacionOrdenAdicionales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulo = loItem.Iditemarticulo
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxCosto = loItem.Costo
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COTORDADIC("IdItem","NROITEM","Comp","Cotizalqad","ArtLiq","ArtDesc","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","Costo","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxCosto>>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COTIZAGOP.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COTIZAGOP where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.COTORDPROD where "Cotizalqpr" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.COTORDDESC where "Cotizalqde" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.COTORDINS where "Cotizalqin" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.COTORDADIC where "Cotizalqad" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'COTIZAGOP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COTIZAGOP where  COTIZAGOP.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COTIZAGOP where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COTIZAGOP.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCOTIZAGOPNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COTIZACIONPRODUCCION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COTIZAGOP Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.COTIZAGOP set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, CObs = ] + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, GestionPro = ] + "'" + this.FormatearTextoSql( &lcCursor..GestionPro ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, OrdenDePro = ] + "'" + this.FormatearTextoSql( &lcCursor..OrdenDePro ) + "'"+ [, Proceso = ] + "'" + this.FormatearTextoSql( &lcCursor..Proceso ) + "'"+ [, Genera = ] + transform( &lcCursor..Genera )+ [, Taller = ] + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'"+ [, LetraComp = ] + "'" + this.FormatearTextoSql( &lcCursor..LetraComp ) + "'"+ [, Proveedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'"+ [, PuntoComp = ] + transform( &lcCursor..PuntoComp )+ [, ListaC = ] + "'" + this.FormatearTextoSql( &lcCursor..ListaC ) + "'"+ [, NumeroComp = ] + transform( &lcCursor..NumeroComp )+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Insumos = ] + transform( &lcCursor..Insumos )+ [, Descartes = ] + transform( &lcCursor..Descartes ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.COTIZAGOP Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FALTAFW, FECEXPO, FECIMPO, FECTRANS, ESTTRANS, VALTAFW, VMODIFW, BDMODIFW, UMODIFW, HALTAFW, SMODIFW, UALTAFW, SALTAFW, HORAIMPO, HMODIFW, ZADSFW, HORAEXPO, BDALTAFW, Codigo, CObs, Numero, GestionPro, Fecha, OrdenDePro, Proceso, Genera, Taller, LetraComp, Proveedor, PuntoComp, ListaC, NumeroComp, Moneda, Insumos, Descartes
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..GestionPro ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OrdenDePro ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proceso ) + "'" + ',' + transform( &lcCursor..Genera ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..LetraComp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'" + ',' + transform( &lcCursor..PuntoComp ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ListaC ) + "'" + ',' + transform( &lcCursor..NumeroComp ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + transform( &lcCursor..Insumos ) + ',' + transform( &lcCursor..Descartes )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.COTIZAGOP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COTIZACIONPRODUCCION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.COTORDPROD Where Cotizalqpr] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.COTORDDESC Where Cotizalqde] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.COTORDINS Where Cotizalqin] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.COTORDADIC Where Cotizalqad] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOTIZAORDENPRODUCC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Cotizalqpr in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","Comp","NROITEM","Cotizalqpr","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.COTORDPROD ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.Comp       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cotizalqpr ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiElab   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDeta  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtLiq     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtDesc    ) + "'" + ',' + transform( cDetallesExistentes.Costo      ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOTIZAORDENDESCARTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Cotizalqde in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","Comp","NROITEM","Cotizalqde","SemiElab","SemiDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.COTORDDESC ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.Comp       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cotizalqde ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiElab   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDeta  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtLiq     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtDesc    ) + "'" + ',' + transform( cDetallesExistentes.Costo      ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOTIZAORDENINSUMOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Cotizalqin in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","Comp","NROITEM","Cotizalqin","Insumo","InsDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","ArtLiq","ArtDesc","Costo","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.COTORDINS ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.Comp       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cotizalqin ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Insumo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InsDeta    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDeta  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtLiq     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtDesc    ) + "'" + ',' + transform( cDetallesExistentes.Costo      ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOTIZAORDENADICION'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Cotizalqad in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","NROITEM","Comp","Cotizalqad","ArtLiq","ArtDesc","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","Costo","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.COTORDADIC ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.Comp       ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cotizalqad ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtLiq     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ArtDesc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDeta  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + transform( cDetallesExistentes.Costo      ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'COTIZACIONPRODUCCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COTIZACIONPRODUCCION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COTIZACIONPRODUCCION_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOTIZAORDENPRODUCC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOTIZAORDENDESCARTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOTIZAORDENINSUMOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOTIZAORDENADICION'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COTIZAGOP')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COTIZACIONPRODUCCION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COTIZACIONPRODUCCION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COTIZACIONPRODUCCION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COTIZACIONPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COTIZAGOP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COTIZAGOP
Create Table ZooLogic.TablaTrabajo_COTIZAGOP ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"esttrans" char( 20 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"bdmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"cobs" varchar(max)  null, 
"numero" numeric( 12, 0 )  null, 
"gestionpro" char( 38 )  null, 
"fecha" datetime  null, 
"ordendepro" char( 38 )  null, 
"proceso" char( 15 )  null, 
"genera" numeric( 2, 0 )  null, 
"taller" char( 15 )  null, 
"letracomp" char( 1 )  null, 
"proveedor" char( 10 )  null, 
"puntocomp" numeric( 5, 0 )  null, 
"listac" char( 6 )  null, 
"numerocomp" numeric( 8, 0 )  null, 
"moneda" char( 10 )  null, 
"insumos" numeric( 2, 0 )  null, 
"descartes" numeric( 2, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COTIZAGOP' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COTIZAGOP' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COTIZACIONPRODUCCION'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('gestionpro','gestionpro')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('ordendepro','ordendepro')
			.AgregarMapeo('proceso','proceso')
			.AgregarMapeo('genera','genera')
			.AgregarMapeo('taller','taller')
			.AgregarMapeo('letracomp','letracomp')
			.AgregarMapeo('proveedor','proveedor')
			.AgregarMapeo('puntocomp','puntocomp')
			.AgregarMapeo('listac','listac')
			.AgregarMapeo('numerocomp','numerocomp')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('insumos','insumos')
			.AgregarMapeo('descartes','descartes')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COTIZAGOP'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.COBS = isnull( d.COBS, t.COBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.GESTIONPRO = isnull( d.GESTIONPRO, t.GESTIONPRO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.ORDENDEPRO = isnull( d.ORDENDEPRO, t.ORDENDEPRO ),t.PROCESO = isnull( d.PROCESO, t.PROCESO ),t.GENERA = isnull( d.GENERA, t.GENERA ),t.TALLER = isnull( d.TALLER, t.TALLER ),t.LETRACOMP = isnull( d.LETRACOMP, t.LETRACOMP ),t.PROVEEDOR = isnull( d.PROVEEDOR, t.PROVEEDOR ),t.PUNTOCOMP = isnull( d.PUNTOCOMP, t.PUNTOCOMP ),t.LISTAC = isnull( d.LISTAC, t.LISTAC ),t.NUMEROCOMP = isnull( d.NUMEROCOMP, t.NUMEROCOMP ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.INSUMOS = isnull( d.INSUMOS, t.INSUMOS ),t.DESCARTES = isnull( d.DESCARTES, t.DESCARTES )
					from ZooLogic.COTIZAGOP t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.COTIZAGOP(Fmodifw,Faltafw,Fecexpo,Fecimpo,Fectrans,Esttrans,Valtafw,Vmodifw,Bdmodifw,Umodifw,Haltafw,Smodifw,Ualtafw,Saltafw,Horaimpo,Hmodifw,Zadsfw,Horaexpo,Bdaltafw,Codigo,Cobs,Numero,Gestionpro,Fecha,Ordendepro,Proceso,Genera,Taller,Letracomp,Proveedor,Puntocomp,Listac,Numerocomp,Moneda,Insumos,Descartes)
					Select isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.ESTTRANS,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.ZADSFW,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.COBS,''),isnull( d.NUMERO,0),isnull( d.GESTIONPRO,''),isnull( d.FECHA,''),isnull( d.ORDENDEPRO,''),isnull( d.PROCESO,''),isnull( d.GENERA,0),isnull( d.TALLER,''),isnull( d.LETRACOMP,''),isnull( d.PROVEEDOR,''),isnull( d.PUNTOCOMP,0),isnull( d.LISTAC,''),isnull( d.NUMEROCOMP,0),isnull( d.MONEDA,''),isnull( d.INSUMOS,0),isnull( d.DESCARTES,0)
						From deleted d left join ZooLogic.COTIZAGOP pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.COTIZAGOP cc 
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
					from ZooLogic.COTIZAGOP t inner join deleted d 
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
					from ZooLogic.COTIZAGOP t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_COTORDPROD( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COTIZAGOP_COTORDPROD
ON ZooLogic.TablaTrabajo_COTIZAGOP_COTORDPROD
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COTIZALQPR = isnull( d.COTIZALQPR, t.COTIZALQPR ),
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
from ZooLogic.COTORDPROD t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.COTORDPROD
( 
"IDITEM",
"COMP",
"NROITEM",
"COTIZALQPR",
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
d.COTIZALQPR,
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
From deleted d left join ZooLogic.COTORDPROD pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_COTORDDESC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COTIZAGOP_COTORDDESC
ON ZooLogic.TablaTrabajo_COTIZAGOP_COTORDDESC
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COTIZALQDE = isnull( d.COTIZALQDE, t.COTIZALQDE ),
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
from ZooLogic.COTORDDESC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.COTORDDESC
( 
"IDITEM",
"COMP",
"NROITEM",
"COTIZALQDE",
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
d.COTIZALQDE,
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
From deleted d left join ZooLogic.COTORDDESC pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_COTORDINS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COTIZAGOP_COTORDINS
ON ZooLogic.TablaTrabajo_COTIZAGOP_COTORDINS
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COTIZALQIN = isnull( d.COTIZALQIN, t.COTIZALQIN ),
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
from ZooLogic.COTORDINS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.COTORDINS
( 
"IDITEM",
"COMP",
"NROITEM",
"COTIZALQIN",
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
d.COTIZALQIN,
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
From deleted d left join ZooLogic.COTORDINS pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_COTORDADIC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COTIZAGOP_COTORDADIC
ON ZooLogic.TablaTrabajo_COTIZAGOP_COTORDADIC
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.COTIZALQAD = isnull( d.COTIZALQAD, t.COTIZALQAD ),
t.ARTLIQ = isnull( d.ARTLIQ, t.ARTLIQ ),
t.ARTDESC = isnull( d.ARTDESC, t.ARTDESC ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.COLORDETA = isnull( d.COLORDETA, t.COLORDETA ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.TALLEDETA = isnull( d.TALLEDETA, t.TALLEDETA ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.COSTO = isnull( d.COSTO, t.COSTO ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.COTORDADIC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.COTORDADIC
( 
"IDITEM",
"NROITEM",
"COMP",
"COTIZALQAD",
"ARTLIQ",
"ARTDESC",
"CODCOLOR",
"COLORDETA",
"CODTALLE",
"TALLEDETA",
"CANTIDAD",
"COSTO",
"MONTO"
 )
Select 
d.IDITEM,
d.NROITEM,
d.COMP,
d.COTIZALQAD,
d.ARTLIQ,
d.ARTDESC,
d.CODCOLOR,
d.COLORDETA,
d.CODTALLE,
d.TALLEDETA,
d.CANTIDAD,
d.COSTO,
d.MONTO
From deleted d left join ZooLogic.COTORDADIC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COTIZAGOP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COTIZAGOP
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COTIZACIONPRODUCCION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COTIZACIONPRODUCCION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COTIZACIONPRODUCCION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COTIZACIONPRODUCCION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COTIZACIONPRODUCCION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COTIZACIONPRODUCCION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Estadotransferencia = nvl( c_COTIZACIONPRODUCCION.Estadotransferencia, [] )
					.Versionaltafw = nvl( c_COTIZACIONPRODUCCION.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_COTIZACIONPRODUCCION.Versionmodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_COTIZACIONPRODUCCION.Basededatosmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_COTIZACIONPRODUCCION.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_COTIZACIONPRODUCCION.Horaaltafw, [] )
					.Seriemodificacionfw = nvl( c_COTIZACIONPRODUCCION.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_COTIZACIONPRODUCCION.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_COTIZACIONPRODUCCION.Seriealtafw, [] )
					.Horaimpo = nvl( c_COTIZACIONPRODUCCION.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_COTIZACIONPRODUCCION.Horamodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaexpo = nvl( c_COTIZACIONPRODUCCION.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_COTIZACIONPRODUCCION.Basededatosaltafw, [] )
					.Codigo = nvl( c_COTIZACIONPRODUCCION.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observ')
					.Observ = lcValor 
					.Numero = nvl( c_COTIZACIONPRODUCCION.Numero, 0 )
					.Gestiondeproduccion_PK =  nvl( c_COTIZACIONPRODUCCION.Gestiondeproduccion, [] )
					.Cotizacionordenproduccion.Limpiar()
					.Cotizacionordenproduccion.SetearEsNavegacion( .lProcesando )
					.Cotizacionordenproduccion.Cargar()
					.Cotizacionordendescarte.Limpiar()
					.Cotizacionordendescarte.SetearEsNavegacion( .lProcesando )
					.Cotizacionordendescarte.Cargar()
					.Cotizacionordeninsumos.Limpiar()
					.Cotizacionordeninsumos.SetearEsNavegacion( .lProcesando )
					.Cotizacionordeninsumos.Cargar()
					.Cotizacionordenadicionales.Limpiar()
					.Cotizacionordenadicionales.SetearEsNavegacion( .lProcesando )
					.Cotizacionordenadicionales.Cargar()
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_COTIZACIONPRODUCCION.Fecha, ctod( '  /  /    ' ) ) )
					.Ordendeproduccion_PK =  nvl( c_COTIZACIONPRODUCCION.Ordendeproduccion, [] )
					.Proceso_PK =  nvl( c_COTIZACIONPRODUCCION.Proceso, [] )
					.Generar = nvl( c_COTIZACIONPRODUCCION.Generar, 0 )
					.Taller_PK =  nvl( c_COTIZACIONPRODUCCION.Taller, [] )
					.Letracomprobante = nvl( c_COTIZACIONPRODUCCION.Letracomprobante, [] )
					.Proveedor_PK =  nvl( c_COTIZACIONPRODUCCION.Proveedor, [] )
					.Puntodeventacomprobante = nvl( c_COTIZACIONPRODUCCION.Puntodeventacomprobante, 0 )
					.Listadecosto_PK =  nvl( c_COTIZACIONPRODUCCION.Listadecosto, [] )
					.Numerocomprobante = nvl( c_COTIZACIONPRODUCCION.Numerocomprobante, 0 )
					.Moneda_PK =  nvl( c_COTIZACIONPRODUCCION.Moneda, [] )
					.Insumos = nvl( c_COTIZACIONPRODUCCION.Insumos, 0 )
					.Descartes = nvl( c_COTIZACIONPRODUCCION.Descartes, 0 )
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
			lxRetorno = c_COTIZACIONPRODUCCION.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.CotizacionOrdenProduccion
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

		loDetalle = this.oEntidad.CotizacionOrdenDescarte
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

		loDetalle = this.oEntidad.CotizacionOrdenInsumos
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

		loDetalle = this.oEntidad.CotizacionOrdenAdicionales
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
		return c_COTIZACIONPRODUCCION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COTIZAGOP' )
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
								from ZooLogic.COTIZAGOP 
								Where   COTIZAGOP.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COTIZAGOP", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Cobs" as "Observ", "Numero" as "Numero", "Gestionpro" as "Gestiondeproduccion", "Fecha" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Genera" as "Generar", "Taller" as "Taller", "Letracomp" as "Letracomprobante", "Proveedor" as "Proveedor", "Puntocomp" as "Puntodeventacomprobante", "Listac" as "Listadecosto", "Numerocomp" as "Numerocomprobante", "Moneda" as "Moneda", "Insumos" as "Insumos", "Descartes" as "Descartes"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COTIZAGOP 
								Where   COTIZAGOP.CODIGO != ''
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
	Tabla = 'COTIZAGOP'
	Filtro = " COTIZAGOP.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COTIZAGOP.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "COTIZAGOP.Numero"
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
	<row entidad="COTIZACIONPRODUCCION                    " atributo="FECHAMODIFICACIONFW                     " tabla="COTIZAGOP      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="FECHAALTAFW                             " tabla="COTIZAGOP      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="FECHAEXPO                               " tabla="COTIZAGOP      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="FECHAIMPO                               " tabla="COTIZAGOP      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="FECHATRANSFERENCIA                      " tabla="COTIZAGOP      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="ESTADOTRANSFERENCIA                     " tabla="COTIZAGOP      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="VERSIONALTAFW                           " tabla="COTIZAGOP      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="VERSIONMODIFICACIONFW                   " tabla="COTIZAGOP      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COTIZAGOP      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="USUARIOMODIFICACIONFW                   " tabla="COTIZAGOP      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="HORAALTAFW                              " tabla="COTIZAGOP      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="SERIEMODIFICACIONFW                     " tabla="COTIZAGOP      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="USUARIOALTAFW                           " tabla="COTIZAGOP      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="SERIEALTAFW                             " tabla="COTIZAGOP      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="HORAIMPO                                " tabla="COTIZAGOP      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="HORAMODIFICACIONFW                      " tabla="COTIZAGOP      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="ZADSFW                                  " tabla="COTIZAGOP      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="HORAEXPO                                " tabla="COTIZAGOP      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="BASEDEDATOSALTAFW                       " tabla="COTIZAGOP      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="CODIGO                                  " tabla="COTIZAGOP      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="OBSERV                                  " tabla="COTIZAGOP      " campo="COBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="NUMERO                                  " tabla="COTIZAGOP      " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Nro. gestión de producción                                                                                                                                      " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="GESTIONDEPRODUCCION                     " tabla="COTIZAGOP      " campo="GESTIONPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GESTIONDEPRODUCCION                     " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="402" etiqueta="Gestión de producción                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="COTIZACIONORDENPRODUCCION               " tabla="COTORDPROD     " campo="COTIZALQPR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Producción                                                                                                                                                      " dominio="DETALLEITEMCOTIZAORDENPRODUCC " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="COTIZACIONORDENDESCARTE                 " tabla="COTORDDESC     " campo="COTIZALQDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Descarte                                                                                                                                                        " dominio="DETALLEITEMCOTIZAORDENDESCARTE" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="COTIZACIONORDENINSUMOS                  " tabla="COTORDINS      " campo="COTIZALQIN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Insumos                                                                                                                                                         " dominio="DETALLEITEMCOTIZAORDENINSUMOS " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="COTIZACIONORDENADICIONALES              " tabla="COTORDADIC     " campo="COTIZALQAD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Costos adicionales                                                                                                                                              " dominio="DETALLEITEMCOTIZAORDENADICION " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="FECHA                                   " tabla="COTIZAGOP      " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="4" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="ORDENDEPRODUCCION                       " tabla="COTIZAGOP      " campo="ORDENDEPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORDENDEPRODUCCION                       " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Orden de producción                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="PROCESO                                 " tabla="COTIZAGOP      " campo="PROCESO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROCESOPRODUCCION                       " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Proceso                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="GENERAR                                 " tabla="COTIZAGOP      " campo="GENERA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="18" etiqueta="Generar liquidación                                                                                                                                             " dominio="COMPRELALIQU                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="TALLER                                  " tabla="COTIZAGOP      " campo="TALLER    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLER                                  " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Taller                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="LETRACOMPROBANTE                        " tabla="COTIZAGOP      " campo="LETRACOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Letra comprobante                                                                                                                                               " dominio="COMPRELALIQU                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="PROVEEDOR                               " tabla="COTIZAGOP      " campo="PROVEEDOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="PUNTODEVENTACOMPROBANTE                 " tabla="COTIZAGOP      " campo="PUNTOCOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Punto de venta                                                                                                                                                  " dominio="COMPRELALIQU                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="LISTADECOSTO                            " tabla="COTIZAGOP      " campo="LISTAC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADECOSTOSDEPRODUCCION               " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="14" etiqueta="Lista de costo de producción                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="NUMEROCOMPROBANTE                       " tabla="COTIZAGOP      " campo="NUMEROCOMP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="COMPRELALIQU                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="MONEDA                                  " tabla="COTIZAGOP      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="16" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="INSUMOS                                 " tabla="COTIZAGOP      " campo="INSUMOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="20" etiqueta="Acción en insumos                                                                                                                                               " dominio="COMBOLIQUIDACIONTALLER        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COTIZACIONPRODUCCION                    " atributo="DESCARTES                               " tabla="COTIZAGOP      " campo="DESCARTES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="22" etiqueta="Acción en descartes                                                                                                                                             " dominio="COMBOLIQUIDACIONTALLER        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="FECHA                                   " tabla="GESTIONPROD    " campo="FFCH      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Ges.                                                                                                                                                    " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GESTIONPROD On COTIZAGOP.GESTIONPRO = GESTIONPROD.CODIGO And  GESTIONPROD.CODIGO != ''                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="DESCRIPCION                             " tabla="ORDENPROD      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Ord.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDENPROD On COTIZAGOP.ORDENDEPRO = ORDENPROD.Codigo And  ORDENPROD.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="DESCRIPCION                             " tabla="PROCPRODUC     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROCPRODUC On COTIZAGOP.PROCESO = PROCPRODUC.Codigo And  PROCPRODUC.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="DESCRIPCION                             " tabla="TALLER         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLER On COTIZAGOP.TALLER = TALLER.Codigo And  TALLER.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On COTIZAGOP.PROVEEDOR = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADECOSTOSDEPRODUCCION               " atributo="DESCRIPCION                             " tabla="LCOSTOP        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LCOSTOP On COTIZAGOP.LISTAC = LCOSTOP.Codigo And  LCOSTOP.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On COTIZAGOP.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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