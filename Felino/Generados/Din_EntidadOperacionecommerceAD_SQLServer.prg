
define class Din_EntidadOPERACIONECOMMERCEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_OPERACIONECOMMERCE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Numero + Ecommerce]
	cExpresionCCPorCampos = [#tabla#.NUMERO + #tabla#.ECOMMERCE]
	cTagClaveCandidata = '_OECCC'
	cTagClavePk = '_OECPK'
	cTablaPrincipal = 'OPECOM'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
			.ColSentencias = _screen.zoo.crearobjeto('zooColeccion')
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
			local  lxOpecomFectrans, lxOpecomFmodifw, lxOpecomFecexpo, lxOpecomFecimpo, lxOpecomFaltafw, lxOpecomCant, lxOpecomVmodifw, lxOpecomUmodifw, lxOpecomValtafw, lxOpecomHoraimpo, lxOpecomUaltafw, lxOpecomEsttrans, lxOpecomSaltafw, lxOpecomHoraexpo, lxOpecomHmodifw, lxOpecomSmodifw, lxOpecomHaltafw, lxOpecomIdenvio, lxOpecomBdmodifw, lxOpecomIdcomp, lxOpecomLogistic, lxOpecomBdaltafw, lxOpecomEcommerce, lxOpecomCodigo, lxOpecomFecha, lxOpecomHora, lxOpecomPenproc, lxOpecomMlfulle, lxOpecomPackid, lxOpecomStoreorder, lxOpecomPodesc, lxOpecomNumero, lxOpecomFpago, lxOpecomUrlecomm, lxOpecomMondesc, lxOpecomCliecom, lxOpecomMondes2, lxOpecomCliedragon, lxOpecomPorrec, lxOpecomEnvio, lxOpecomMonrec, lxOpecomTelenvio, lxOpecomMonrec2, lxOpecomPago, lxOpecomZadsfw, lxOpecomPagado, lxOpecomOptotal, lxOpecomObs
				lxOpecomFectrans =  .Fechatransferencia			lxOpecomFmodifw =  .Fechamodificacionfw			lxOpecomFecexpo =  .Fechaexpo			lxOpecomFecimpo =  .Fechaimpo			lxOpecomFaltafw =  .Fechaaltafw			lxOpecomCant =  .Cantidadtotal			lxOpecomVmodifw =  .Versionmodificacionfw			lxOpecomUmodifw =  .Usuariomodificacionfw			lxOpecomValtafw =  .Versionaltafw			lxOpecomHoraimpo =  .Horaimpo			lxOpecomUaltafw =  .Usuarioaltafw			lxOpecomEsttrans =  .Estadotransferencia			lxOpecomSaltafw =  .Seriealtafw			lxOpecomHoraexpo =  .Horaexpo			lxOpecomHmodifw =  .Horamodificacionfw			lxOpecomSmodifw =  .Seriemodificacionfw			lxOpecomHaltafw =  .Horaaltafw			lxOpecomIdenvio =  .Envioid			lxOpecomBdmodifw =  .Basededatosmodificacionfw			lxOpecomIdcomp =  .Comprobanteid			lxOpecomLogistic =  .Logistictype			lxOpecomBdaltafw =  .Basededatosaltafw			lxOpecomEcommerce =  upper( .Ecommerce_PK ) 			lxOpecomCodigo =  .Codigo			lxOpecomFecha =  .Fecha			lxOpecomHora =  .Hora			lxOpecomPenproc =  .Pendientedeprocesar			lxOpecomMlfulle =  .Mlfullenvios			lxOpecomPackid =  .Packid			lxOpecomStoreorder =  .Storeorderid			lxOpecomPodesc =  .Descuentoporcentaje			lxOpecomNumero =  .Numero			lxOpecomFpago =  .Fechadepago			lxOpecomUrlecomm =  .Linkoperacionecommerce			lxOpecomMondesc =  .Descuentomonto			lxOpecomCliecom =  upper( .ClienteEcom_PK ) 			lxOpecomMondes2 =  .Descuentomonto2			lxOpecomCliedragon =  upper( .ClienteDragon_PK ) 			lxOpecomPorrec =  .Recargoporcentaje			lxOpecomEnvio =  .Datosenvio			lxOpecomMonrec =  .Recargomonto			lxOpecomTelenvio =  .Telefonoenvio			lxOpecomMonrec2 =  .Recargomonto2			lxOpecomPago =  .Datospago			lxOpecomZadsfw =  .Zadsfw			lxOpecomPagado =  .Pagado			lxOpecomOptotal =  .Total			lxOpecomObs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxOpecomCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.OPECOM ( "Fectrans","Fmodifw","Fecexpo","Fecimpo","Faltafw","Cant","Vmodifw","Umodifw","Valtafw","Horaimpo","Ualtafw","Esttrans","Saltafw","Horaexpo","Hmodifw","Smodifw","Haltafw","Idenvio","Bdmodifw","Idcomp","Logistic","Bdaltafw","Ecommerce","Codigo","Fecha","Hora","Penproc","Mlfulle","Packid","Storeorder","Podesc","Numero","Fpago","Urlecomm","Mondesc","Cliecom","Mondes2","Cliedragon","Porrec","Envio","Monrec","Telenvio","Monrec2","Pago","Zadsfw","Pagado","Optotal","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxOpecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFaltafw ) + "'" >>, <<lxOpecomCant >>, <<"'" + this.FormatearTextoSql( lxOpecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomIdenvio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomIdcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomLogistic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomEcommerce ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHora ) + "'" >>, <<iif( lxOpecomPenproc, 1, 0 ) >>, <<iif( lxOpecomMlfulle, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOpecomPackid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomStoreorder ) + "'" >>, <<lxOpecomPodesc >>, <<"'" + this.FormatearTextoSql( lxOpecomNumero ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomUrlecomm ) + "'" >>, <<lxOpecomMondesc >>, <<"'" + this.FormatearTextoSql( lxOpecomCliecom ) + "'" >>, <<lxOpecomMondes2 >>, <<"'" + this.FormatearTextoSql( lxOpecomCliedragon ) + "'" >>, <<lxOpecomPorrec >>, <<"'" + this.FormatearTextoSql( lxOpecomEnvio ) + "'" >>, <<lxOpecomMonrec >>, <<"'" + this.FormatearTextoSql( lxOpecomTelenvio ) + "'" >>, <<lxOpecomMonrec2 >>, <<"'" + this.FormatearTextoSql( lxOpecomPago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomZadsfw ) + "'" >>, <<iif( lxOpecomPagado, 1, 0 ) >>, <<lxOpecomOptotal >>, <<"'" + this.FormatearTextoSql( lxOpecomObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
			for each loItem in this.oEntidad.PublicacionDetalle
				if this.oEntidad.PublicacionDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxCodigoherrcancelacion = loItem.Codigoherrcancelacion
					lxNroitem = lnContadorNroItem
					lxNrooperacioncancelacion = loItem.Nrooperacioncancelacion
					lxNumerooperacion = loItem.Numerooperacion
					lxStoreorderid = loItem.Storeorderid
					lxIdpublicacion = loItem.Idpublicacion
					lxDescripcion = loItem.Descripcion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMonto = loItem.Monto
					lxMontodescuento = loItem.Montodescuento
					lxFechacancelacion = loItem.Fechacancelacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OPECOMDET("COMP","CodHerrCan","NROITEM","NumOpeCan","NumOpe","STOREORDER","IDPUB","CODIGO","DESCRI","OPART","ARTDET","OPCOLOR","COLDET","OPTALLE","CANT","PRECIO","PORDESC","MONTO","MONDESC","FecCan" ) values ( <<lxComportamiento>>, <<lxCodigoherrcancelacion>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxNrooperacioncancelacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerooperacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxStoreorderid ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdpublicacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMonto>>, <<lxMontodescuento>>, <<"'" + this.ConvertirDateSql( lxFechacancelacion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxRecibido = loItem.Recibido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OPECOMVAL("NroItem","JJNUM","JJCO","JJDE","JJRecib" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<lxRecibido>> ) 
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
			this.GenerarSentenciasComponentes()
			local  lxOpecomFectrans, lxOpecomFmodifw, lxOpecomFecexpo, lxOpecomFecimpo, lxOpecomFaltafw, lxOpecomCant, lxOpecomVmodifw, lxOpecomUmodifw, lxOpecomValtafw, lxOpecomHoraimpo, lxOpecomUaltafw, lxOpecomEsttrans, lxOpecomSaltafw, lxOpecomHoraexpo, lxOpecomHmodifw, lxOpecomSmodifw, lxOpecomHaltafw, lxOpecomIdenvio, lxOpecomBdmodifw, lxOpecomIdcomp, lxOpecomLogistic, lxOpecomBdaltafw, lxOpecomEcommerce, lxOpecomCodigo, lxOpecomFecha, lxOpecomHora, lxOpecomPenproc, lxOpecomMlfulle, lxOpecomPackid, lxOpecomStoreorder, lxOpecomPodesc, lxOpecomNumero, lxOpecomFpago, lxOpecomUrlecomm, lxOpecomMondesc, lxOpecomCliecom, lxOpecomMondes2, lxOpecomCliedragon, lxOpecomPorrec, lxOpecomEnvio, lxOpecomMonrec, lxOpecomTelenvio, lxOpecomMonrec2, lxOpecomPago, lxOpecomZadsfw, lxOpecomPagado, lxOpecomOptotal, lxOpecomObs
				lxOpecomFectrans =  .Fechatransferencia			lxOpecomFmodifw =  .Fechamodificacionfw			lxOpecomFecexpo =  .Fechaexpo			lxOpecomFecimpo =  .Fechaimpo			lxOpecomFaltafw =  .Fechaaltafw			lxOpecomCant =  .Cantidadtotal			lxOpecomVmodifw =  .Versionmodificacionfw			lxOpecomUmodifw =  .Usuariomodificacionfw			lxOpecomValtafw =  .Versionaltafw			lxOpecomHoraimpo =  .Horaimpo			lxOpecomUaltafw =  .Usuarioaltafw			lxOpecomEsttrans =  .Estadotransferencia			lxOpecomSaltafw =  .Seriealtafw			lxOpecomHoraexpo =  .Horaexpo			lxOpecomHmodifw =  .Horamodificacionfw			lxOpecomSmodifw =  .Seriemodificacionfw			lxOpecomHaltafw =  .Horaaltafw			lxOpecomIdenvio =  .Envioid			lxOpecomBdmodifw =  .Basededatosmodificacionfw			lxOpecomIdcomp =  .Comprobanteid			lxOpecomLogistic =  .Logistictype			lxOpecomBdaltafw =  .Basededatosaltafw			lxOpecomEcommerce =  upper( .Ecommerce_PK ) 			lxOpecomCodigo =  .Codigo			lxOpecomFecha =  .Fecha			lxOpecomHora =  .Hora			lxOpecomPenproc =  .Pendientedeprocesar			lxOpecomMlfulle =  .Mlfullenvios			lxOpecomPackid =  .Packid			lxOpecomStoreorder =  .Storeorderid			lxOpecomPodesc =  .Descuentoporcentaje			lxOpecomNumero =  .Numero			lxOpecomFpago =  .Fechadepago			lxOpecomUrlecomm =  .Linkoperacionecommerce			lxOpecomMondesc =  .Descuentomonto			lxOpecomCliecom =  upper( .ClienteEcom_PK ) 			lxOpecomMondes2 =  .Descuentomonto2			lxOpecomCliedragon =  upper( .ClienteDragon_PK ) 			lxOpecomPorrec =  .Recargoporcentaje			lxOpecomEnvio =  .Datosenvio			lxOpecomMonrec =  .Recargomonto			lxOpecomTelenvio =  .Telefonoenvio			lxOpecomMonrec2 =  .Recargomonto2			lxOpecomPago =  .Datospago			lxOpecomZadsfw =  .Zadsfw			lxOpecomPagado =  .Pagado			lxOpecomOptotal =  .Total			lxOpecomObs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.OPECOM set "Fectrans" = <<"'" + this.ConvertirDateSql( lxOpecomFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxOpecomFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxOpecomFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxOpecomFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxOpecomFaltafw ) + "'">>,"Cant" = <<lxOpecomCant>>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxOpecomVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxOpecomUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxOpecomValtafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxOpecomHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxOpecomUaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxOpecomEsttrans ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxOpecomSaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxOpecomHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxOpecomHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxOpecomSmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxOpecomHaltafw ) + "'">>,"Idenvio" = <<"'" + this.FormatearTextoSql( lxOpecomIdenvio ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOpecomBdmodifw ) + "'">>,"Idcomp" = <<"'" + this.FormatearTextoSql( lxOpecomIdcomp ) + "'">>,"Logistic" = <<"'" + this.FormatearTextoSql( lxOpecomLogistic ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOpecomBdaltafw ) + "'">>,"Ecommerce" = <<"'" + this.FormatearTextoSql( lxOpecomEcommerce ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxOpecomCodigo ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxOpecomFecha ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxOpecomHora ) + "'">>,"Penproc" = <<iif( lxOpecomPenproc, 1, 0 )>>,"Mlfulle" = <<iif( lxOpecomMlfulle, 1, 0 )>>,"Packid" = <<"'" + this.FormatearTextoSql( lxOpecomPackid ) + "'">>,"Storeorder" = <<"'" + this.FormatearTextoSql( lxOpecomStoreorder ) + "'">>,"Podesc" = <<lxOpecomPodesc>>,"Numero" = <<"'" + this.FormatearTextoSql( lxOpecomNumero ) + "'">>,"Fpago" = <<"'" + this.ConvertirDateSql( lxOpecomFpago ) + "'">>,"Urlecomm" = <<"'" + this.FormatearTextoSql( lxOpecomUrlecomm ) + "'">>,"Mondesc" = <<lxOpecomMondesc>>,"Cliecom" = <<"'" + this.FormatearTextoSql( lxOpecomCliecom ) + "'">>,"Mondes2" = <<lxOpecomMondes2>>,"Cliedragon" = <<"'" + this.FormatearTextoSql( lxOpecomCliedragon ) + "'">>,"Porrec" = <<lxOpecomPorrec>>,"Envio" = <<"'" + this.FormatearTextoSql( lxOpecomEnvio ) + "'">>,"Monrec" = <<lxOpecomMonrec>>,"Telenvio" = <<"'" + this.FormatearTextoSql( lxOpecomTelenvio ) + "'">>,"Monrec2" = <<lxOpecomMonrec2>>,"Pago" = <<"'" + this.FormatearTextoSql( lxOpecomPago ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxOpecomZadsfw ) + "'">>,"Pagado" = <<iif( lxOpecomPagado, 1, 0 )>>,"Optotal" = <<lxOpecomOptotal>>,"Obs" = <<"'" + this.FormatearTextoSql( lxOpecomObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxOpecomCodigo ) + "'">> and  OPECOM.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.OPECOMDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.OPECOMVAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
			for each loItem in this.oEntidad.PublicacionDetalle
				if this.oEntidad.PublicacionDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxCodigoherrcancelacion = loItem.Codigoherrcancelacion
					lxNroitem = lnContadorNroItem
					lxNrooperacioncancelacion = loItem.Nrooperacioncancelacion
					lxNumerooperacion = loItem.Numerooperacion
					lxStoreorderid = loItem.Storeorderid
					lxIdpublicacion = loItem.Idpublicacion
					lxDescripcion = loItem.Descripcion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMonto = loItem.Monto
					lxMontodescuento = loItem.Montodescuento
					lxFechacancelacion = loItem.Fechacancelacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OPECOMDET("COMP","CodHerrCan","NROITEM","NumOpeCan","NumOpe","STOREORDER","IDPUB","CODIGO","DESCRI","OPART","ARTDET","OPCOLOR","COLDET","OPTALLE","CANT","PRECIO","PORDESC","MONTO","MONDESC","FecCan" ) values ( <<lxComportamiento>>, <<lxCodigoherrcancelacion>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxNrooperacioncancelacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerooperacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxStoreorderid ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdpublicacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMonto>>, <<lxMontodescuento>>, <<"'" + this.ConvertirDateSql( lxFechacancelacion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxRecibido = loItem.Recibido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OPECOMVAL("NroItem","JJNUM","JJCO","JJDE","JJRecib" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<lxRecibido>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.OPECOM where " + this.ConvertirFuncionesSql( " OPECOM.CODIGO != ''" ) )
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
			Local lxOpecomCodigo
			lxOpecomCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Cant" as "Cantidadtotal", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Idenvio" as "Envioid", "Bdmodifw" as "Basededatosmodificacionfw", "Idcomp" as "Comprobanteid", "Logistic" as "Logistictype", "Bdaltafw" as "Basededatosaltafw", "Ecommerce" as "Ecommerce", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Penproc" as "Pendientedeprocesar", "Mlfulle" as "Mlfullenvios", "Packid" as "Packid", "Storeorder" as "Storeorderid", "Podesc" as "Descuentoporcentaje", "Numero" as "Numero", "Fpago" as "Fechadepago", "Urlecomm" as "Linkoperacionecommerce", "Mondesc" as "Descuentomonto", "Cliecom" as "Clienteecom", "Mondes2" as "Descuentomonto2", "Cliedragon" as "Clientedragon", "Porrec" as "Recargoporcentaje", "Envio" as "Datosenvio", "Monrec" as "Recargomonto", "Telenvio" as "Telefonoenvio", "Monrec2" as "Recargomonto2", "Pago" as "Datospago", "Zadsfw" as "Zadsfw", "Pagado" as "Pagado", "Optotal" as "Total", "Obs" as "Obs" from ZooLogic.OPECOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxOpecomCodigo ) + "'">> and  OPECOM.CODIGO != ''
			endtext
			use in select('c_OPERACIONECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OPERACIONECOMMERCE', set( 'Datasession' ) )

			if reccount( 'c_OPERACIONECOMMERCE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Codherrcan" as "Codigoherrcancelacion", "Nroitem" as "Nroitem", "Numopecan" as "Nrooperacioncancelacion", "Numope" as "Numerooperacion", "Storeorder" as "Storeorderid", "Idpub" as "Idpublicacion", "Codigo" as "Codigo", "Descri" as "Descripcion", "Opart" as "Articulo", "Artdet" as "Articulodetalle", "Opcolor" as "Color", "Coldet" as "Colordetalle", "Optalle" as "Talle", "Cant" as "Cantidad", "Precio" as "Precio", "Pordesc" as "Descuento", "Monto" as "Monto", "Mondesc" as "Montodescuento", "Feccan" as "Fechacancelacion" from ZooLogic.OPECOMDET where CODIGO = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PublicacionDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PublicacionDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PublicacionDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjrecib" as "Recibido" from ZooLogic.OPECOMVAL where JJNUM = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxOPECOMNUMERO As Variant, lxOPECOMECOMMERCE As Variant
			lxOPECOMNUMERO = .Numero
			lxOPECOMECOMMERCE = .Ecommerce_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Cant" as "Cantidadtotal", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Idenvio" as "Envioid", "Bdmodifw" as "Basededatosmodificacionfw", "Idcomp" as "Comprobanteid", "Logistic" as "Logistictype", "Bdaltafw" as "Basededatosaltafw", "Ecommerce" as "Ecommerce", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Penproc" as "Pendientedeprocesar", "Mlfulle" as "Mlfullenvios", "Packid" as "Packid", "Storeorder" as "Storeorderid", "Podesc" as "Descuentoporcentaje", "Numero" as "Numero", "Fpago" as "Fechadepago", "Urlecomm" as "Linkoperacionecommerce", "Mondesc" as "Descuentomonto", "Cliecom" as "Clienteecom", "Mondes2" as "Descuentomonto2", "Cliedragon" as "Clientedragon", "Porrec" as "Recargoporcentaje", "Envio" as "Datosenvio", "Monrec" as "Recargomonto", "Telenvio" as "Telefonoenvio", "Monrec2" as "Recargomonto2", "Pago" as "Datospago", "Zadsfw" as "Zadsfw", "Pagado" as "Pagado", "Optotal" as "Total", "Obs" as "Obs" from ZooLogic.OPECOM where  OPECOM.CODIGO != '' And NUMERO = <<"'" + this.FormatearTextoSql( lxOPECOMNUMERO ) + "'">> and ECOMMERCE = <<"'" + this.FormatearTextoSql( lxOPECOMECOMMERCE ) + "'">>
			endtext
			use in select('c_OPERACIONECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OPERACIONECOMMERCE', set( 'Datasession' ) )
			if reccount( 'c_OPERACIONECOMMERCE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Codherrcan" as "Codigoherrcancelacion", "Nroitem" as "Nroitem", "Numopecan" as "Nrooperacioncancelacion", "Numope" as "Numerooperacion", "Storeorder" as "Storeorderid", "Idpub" as "Idpublicacion", "Codigo" as "Codigo", "Descri" as "Descripcion", "Opart" as "Articulo", "Artdet" as "Articulodetalle", "Opcolor" as "Color", "Coldet" as "Colordetalle", "Optalle" as "Talle", "Cant" as "Cantidad", "Precio" as "Precio", "Pordesc" as "Descuento", "Monto" as "Monto", "Mondesc" as "Montodescuento", "Feccan" as "Fechacancelacion" from ZooLogic.OPECOMDET where CODIGO = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PublicacionDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PublicacionDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PublicacionDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjrecib" as "Recibido" from ZooLogic.OPECOMVAL where JJNUM = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxOpecomCodigo as Variant
		llRetorno = .t.
		lxOpecomCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.OPECOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxOpecomCodigo ) + "'">> and  OPECOM.CODIGO != ''
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
				lcOrden =  .Numero + .Ecommerce_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Cant" as "Cantidadtotal", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Idenvio" as "Envioid", "Bdmodifw" as "Basededatosmodificacionfw", "Idcomp" as "Comprobanteid", "Logistic" as "Logistictype", "Bdaltafw" as "Basededatosaltafw", "Ecommerce" as "Ecommerce", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Penproc" as "Pendientedeprocesar", "Mlfulle" as "Mlfullenvios", "Packid" as "Packid", "Storeorder" as "Storeorderid", "Podesc" as "Descuentoporcentaje", "Numero" as "Numero", "Fpago" as "Fechadepago", "Urlecomm" as "Linkoperacionecommerce", "Mondesc" as "Descuentomonto", "Cliecom" as "Clienteecom", "Mondes2" as "Descuentomonto2", "Cliedragon" as "Clientedragon", "Porrec" as "Recargoporcentaje", "Envio" as "Datosenvio", "Monrec" as "Recargomonto", "Telenvio" as "Telefonoenvio", "Monrec2" as "Recargomonto2", "Pago" as "Datospago", "Zadsfw" as "Zadsfw", "Pagado" as "Pagado", "Optotal" as "Total", "Obs" as "Obs" from ZooLogic.OPECOM where  OPECOM.CODIGO != '' order by NUMERO,ECOMMERCE
			endtext
			use in select('c_OPERACIONECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OPERACIONECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Codherrcan" as "Codigoherrcancelacion", "Nroitem" as "Nroitem", "Numopecan" as "Nrooperacioncancelacion", "Numope" as "Numerooperacion", "Storeorder" as "Storeorderid", "Idpub" as "Idpublicacion", "Codigo" as "Codigo", "Descri" as "Descripcion", "Opart" as "Articulo", "Artdet" as "Articulodetalle", "Opcolor" as "Color", "Coldet" as "Colordetalle", "Optalle" as "Talle", "Cant" as "Cantidad", "Precio" as "Precio", "Pordesc" as "Descuento", "Monto" as "Monto", "Mondesc" as "Montodescuento", "Feccan" as "Fechacancelacion" from ZooLogic.OPECOMDET where CODIGO = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PublicacionDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PublicacionDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PublicacionDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjrecib" as "Recibido" from ZooLogic.OPECOMVAL where JJNUM = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
				lcOrden =  .Numero + .Ecommerce_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Cant" as "Cantidadtotal", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Idenvio" as "Envioid", "Bdmodifw" as "Basededatosmodificacionfw", "Idcomp" as "Comprobanteid", "Logistic" as "Logistictype", "Bdaltafw" as "Basededatosaltafw", "Ecommerce" as "Ecommerce", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Penproc" as "Pendientedeprocesar", "Mlfulle" as "Mlfullenvios", "Packid" as "Packid", "Storeorder" as "Storeorderid", "Podesc" as "Descuentoporcentaje", "Numero" as "Numero", "Fpago" as "Fechadepago", "Urlecomm" as "Linkoperacionecommerce", "Mondesc" as "Descuentomonto", "Cliecom" as "Clienteecom", "Mondes2" as "Descuentomonto2", "Cliedragon" as "Clientedragon", "Porrec" as "Recargoporcentaje", "Envio" as "Datosenvio", "Monrec" as "Recargomonto", "Telenvio" as "Telefonoenvio", "Monrec2" as "Recargomonto2", "Pago" as "Datospago", "Zadsfw" as "Zadsfw", "Pagado" as "Pagado", "Optotal" as "Total", "Obs" as "Obs" from ZooLogic.OPECOM where  funciones.padr( NUMERO, 38, ' ' ) + funciones.padr( ECOMMERCE, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  OPECOM.CODIGO != '' order by NUMERO,ECOMMERCE
			endtext
			use in select('c_OPERACIONECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OPERACIONECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Codherrcan" as "Codigoherrcancelacion", "Nroitem" as "Nroitem", "Numopecan" as "Nrooperacioncancelacion", "Numope" as "Numerooperacion", "Storeorder" as "Storeorderid", "Idpub" as "Idpublicacion", "Codigo" as "Codigo", "Descri" as "Descripcion", "Opart" as "Articulo", "Artdet" as "Articulodetalle", "Opcolor" as "Color", "Coldet" as "Colordetalle", "Optalle" as "Talle", "Cant" as "Cantidad", "Precio" as "Precio", "Pordesc" as "Descuento", "Monto" as "Monto", "Mondesc" as "Montodescuento", "Feccan" as "Fechacancelacion" from ZooLogic.OPECOMDET where CODIGO = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PublicacionDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PublicacionDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PublicacionDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjrecib" as "Recibido" from ZooLogic.OPECOMVAL where JJNUM = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
				lcOrden =  .Numero + .Ecommerce_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Cant" as "Cantidadtotal", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Idenvio" as "Envioid", "Bdmodifw" as "Basededatosmodificacionfw", "Idcomp" as "Comprobanteid", "Logistic" as "Logistictype", "Bdaltafw" as "Basededatosaltafw", "Ecommerce" as "Ecommerce", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Penproc" as "Pendientedeprocesar", "Mlfulle" as "Mlfullenvios", "Packid" as "Packid", "Storeorder" as "Storeorderid", "Podesc" as "Descuentoporcentaje", "Numero" as "Numero", "Fpago" as "Fechadepago", "Urlecomm" as "Linkoperacionecommerce", "Mondesc" as "Descuentomonto", "Cliecom" as "Clienteecom", "Mondes2" as "Descuentomonto2", "Cliedragon" as "Clientedragon", "Porrec" as "Recargoporcentaje", "Envio" as "Datosenvio", "Monrec" as "Recargomonto", "Telenvio" as "Telefonoenvio", "Monrec2" as "Recargomonto2", "Pago" as "Datospago", "Zadsfw" as "Zadsfw", "Pagado" as "Pagado", "Optotal" as "Total", "Obs" as "Obs" from ZooLogic.OPECOM where  funciones.padr( NUMERO, 38, ' ' ) + funciones.padr( ECOMMERCE, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  OPECOM.CODIGO != '' order by NUMERO desc,ECOMMERCE desc
			endtext
			use in select('c_OPERACIONECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OPERACIONECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Codherrcan" as "Codigoherrcancelacion", "Nroitem" as "Nroitem", "Numopecan" as "Nrooperacioncancelacion", "Numope" as "Numerooperacion", "Storeorder" as "Storeorderid", "Idpub" as "Idpublicacion", "Codigo" as "Codigo", "Descri" as "Descripcion", "Opart" as "Articulo", "Artdet" as "Articulodetalle", "Opcolor" as "Color", "Coldet" as "Colordetalle", "Optalle" as "Talle", "Cant" as "Cantidad", "Precio" as "Precio", "Pordesc" as "Descuento", "Monto" as "Monto", "Mondesc" as "Montodescuento", "Feccan" as "Fechacancelacion" from ZooLogic.OPECOMDET where CODIGO = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PublicacionDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PublicacionDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PublicacionDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjrecib" as "Recibido" from ZooLogic.OPECOMVAL where JJNUM = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
				lcOrden =  .Numero + .Ecommerce_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Cant" as "Cantidadtotal", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Idenvio" as "Envioid", "Bdmodifw" as "Basededatosmodificacionfw", "Idcomp" as "Comprobanteid", "Logistic" as "Logistictype", "Bdaltafw" as "Basededatosaltafw", "Ecommerce" as "Ecommerce", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Penproc" as "Pendientedeprocesar", "Mlfulle" as "Mlfullenvios", "Packid" as "Packid", "Storeorder" as "Storeorderid", "Podesc" as "Descuentoporcentaje", "Numero" as "Numero", "Fpago" as "Fechadepago", "Urlecomm" as "Linkoperacionecommerce", "Mondesc" as "Descuentomonto", "Cliecom" as "Clienteecom", "Mondes2" as "Descuentomonto2", "Cliedragon" as "Clientedragon", "Porrec" as "Recargoporcentaje", "Envio" as "Datosenvio", "Monrec" as "Recargomonto", "Telenvio" as "Telefonoenvio", "Monrec2" as "Recargomonto2", "Pago" as "Datospago", "Zadsfw" as "Zadsfw", "Pagado" as "Pagado", "Optotal" as "Total", "Obs" as "Obs" from ZooLogic.OPECOM where  OPECOM.CODIGO != '' order by NUMERO desc,ECOMMERCE desc
			endtext
			use in select('c_OPERACIONECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OPERACIONECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Codherrcan" as "Codigoherrcancelacion", "Nroitem" as "Nroitem", "Numopecan" as "Nrooperacioncancelacion", "Numope" as "Numerooperacion", "Storeorder" as "Storeorderid", "Idpub" as "Idpublicacion", "Codigo" as "Codigo", "Descri" as "Descripcion", "Opart" as "Articulo", "Artdet" as "Articulodetalle", "Opcolor" as "Color", "Coldet" as "Colordetalle", "Optalle" as "Talle", "Cant" as "Cantidad", "Precio" as "Precio", "Pordesc" as "Descuento", "Monto" as "Monto", "Mondesc" as "Montodescuento", "Feccan" as "Fechacancelacion" from ZooLogic.OPECOMDET where CODIGO = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PublicacionDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PublicacionDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PublicacionDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjrecib" as "Recibido" from ZooLogic.OPECOMVAL where JJNUM = <<"'" + this.FormatearTextoSql( c_OPERACIONECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fmodifw,Fecexpo,Fecimpo,Faltafw,Cant,Vmodifw,Umodifw,Valtafw,Horaimpo,Ualtafw,Esttr" + ;
"ans,Saltafw,Horaexpo,Hmodifw,Smodifw,Haltafw,Idenvio,Bdmodifw,Idcomp,Logistic,Bdaltafw,Ecommerce,Cod" + ;
"igo,Fecha,Hora,Penproc,Mlfulle,Packid,Storeorder,Podesc,Numero,Fpago,Urlecomm,Mondesc,Cliecom,Mondes" + ;
"2,Cliedragon,Porrec,Envio,Monrec,Telenvio,Monrec2,Pago,Zadsfw,Pagado,Optotal,Obs" + ;
" from ZooLogic.OPECOM where  OPECOM.CODIGO != '' and " + lcFiltro )
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
			local  lxOpecomFectrans, lxOpecomFmodifw, lxOpecomFecexpo, lxOpecomFecimpo, lxOpecomFaltafw, lxOpecomCant, lxOpecomVmodifw, lxOpecomUmodifw, lxOpecomValtafw, lxOpecomHoraimpo, lxOpecomUaltafw, lxOpecomEsttrans, lxOpecomSaltafw, lxOpecomHoraexpo, lxOpecomHmodifw, lxOpecomSmodifw, lxOpecomHaltafw, lxOpecomIdenvio, lxOpecomBdmodifw, lxOpecomIdcomp, lxOpecomLogistic, lxOpecomBdaltafw, lxOpecomEcommerce, lxOpecomCodigo, lxOpecomFecha, lxOpecomHora, lxOpecomPenproc, lxOpecomMlfulle, lxOpecomPackid, lxOpecomStoreorder, lxOpecomPodesc, lxOpecomNumero, lxOpecomFpago, lxOpecomUrlecomm, lxOpecomMondesc, lxOpecomCliecom, lxOpecomMondes2, lxOpecomCliedragon, lxOpecomPorrec, lxOpecomEnvio, lxOpecomMonrec, lxOpecomTelenvio, lxOpecomMonrec2, lxOpecomPago, lxOpecomZadsfw, lxOpecomPagado, lxOpecomOptotal, lxOpecomObs
				lxOpecomFectrans = ctod( '  /  /    ' )			lxOpecomFmodifw = ctod( '  /  /    ' )			lxOpecomFecexpo = ctod( '  /  /    ' )			lxOpecomFecimpo = ctod( '  /  /    ' )			lxOpecomFaltafw = ctod( '  /  /    ' )			lxOpecomCant = 0			lxOpecomVmodifw = []			lxOpecomUmodifw = []			lxOpecomValtafw = []			lxOpecomHoraimpo = []			lxOpecomUaltafw = []			lxOpecomEsttrans = []			lxOpecomSaltafw = []			lxOpecomHoraexpo = []			lxOpecomHmodifw = []			lxOpecomSmodifw = []			lxOpecomHaltafw = []			lxOpecomIdenvio = []			lxOpecomBdmodifw = []			lxOpecomIdcomp = []			lxOpecomLogistic = []			lxOpecomBdaltafw = []			lxOpecomEcommerce = []			lxOpecomCodigo = []			lxOpecomFecha = ctod( '  /  /    ' )			lxOpecomHora = []			lxOpecomPenproc = .F.			lxOpecomMlfulle = .F.			lxOpecomPackid = []			lxOpecomStoreorder = []			lxOpecomPodesc = 0			lxOpecomNumero = []			lxOpecomFpago = ctod( '  /  /    ' )			lxOpecomUrlecomm = []			lxOpecomMondesc = 0			lxOpecomCliecom = []			lxOpecomMondes2 = 0			lxOpecomCliedragon = []			lxOpecomPorrec = 0			lxOpecomEnvio = []			lxOpecomMonrec = 0			lxOpecomTelenvio = []			lxOpecomMonrec2 = 0			lxOpecomPago = []			lxOpecomZadsfw = []			lxOpecomPagado = .F.			lxOpecomOptotal = 0			lxOpecomObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.OPECOMDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.OPECOMVAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.OPECOM where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'OPECOM' + '_' + tcCampo
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
		lcWhere = " Where  OPECOM.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Cant" as "Cantidadtotal", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Idenvio" as "Envioid", "Bdmodifw" as "Basededatosmodificacionfw", "Idcomp" as "Comprobanteid", "Logistic" as "Logistictype", "Bdaltafw" as "Basededatosaltafw", "Ecommerce" as "Ecommerce", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Penproc" as "Pendientedeprocesar", "Mlfulle" as "Mlfullenvios", "Packid" as "Packid", "Storeorder" as "Storeorderid", "Podesc" as "Descuentoporcentaje", "Numero" as "Numero", "Fpago" as "Fechadepago", "Urlecomm" as "Linkoperacionecommerce", "Mondesc" as "Descuentomonto", "Cliecom" as "Clienteecom", "Mondes2" as "Descuentomonto2", "Cliedragon" as "Clientedragon", "Porrec" as "Recargoporcentaje", "Envio" as "Datosenvio", "Monrec" as "Recargomonto", "Telenvio" as "Telefonoenvio", "Monrec2" as "Recargomonto2", "Pago" as "Datospago", "Zadsfw" as "Zadsfw", "Pagado" as "Pagado", "Optotal" as "Total", "Obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'OPECOM', '', tnTope )
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
	Function ObtenerDatosDetalleCOMPAFEC( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPAFE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCOMPAFEC( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompAfe', 'COMPAFEC', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCOMPAFEC( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCOMPAFEC( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetallePublicacionDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  OPECOMDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Comp" as "Comportamiento", "Codherrcan" as "Codigoherrcancelacion", "Nroitem" as "Nroitem", "Numopecan" as "Nrooperacioncancelacion", "Numope" as "Numerooperacion", "Storeorder" as "Storeorderid", "Idpub" as "Idpublicacion", "Codigo" as "Codigo", "Descri" as "Descripcion", "Opart" as "Articulo", "Artdet" as "Articulodetalle", "Opcolor" as "Color", "Coldet" as "Colordetalle", "Optalle" as "Talle", "Cant" as "Cantidad", "Precio" as "Precio", "Pordesc" as "Descuento", "Monto" as "Monto", "Mondesc" as "Montodescuento", "Feccan" as "Fechacancelacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallePublicacionDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'OPECOMDET', 'PublicacionDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallePublicacionDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallePublicacionDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleValoresDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  OPECOMVAL.JJNUM != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjrecib" as "Recibido"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValoresDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'OPECOMVAL', 'ValoresDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleValoresDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'CANTIDADTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANT AS CANTIDADTOTAL'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ENVIOID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENVIO AS ENVIOID'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'COMPROBANTEID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCOMP AS COMPROBANTEID'
				Case lcAtributo == 'LOGISTICTYPE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LOGISTIC AS LOGISTICTYPE'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ECOMMERCE AS ECOMMERCE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'PENDIENTEDEPROCESAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PENPROC AS PENDIENTEDEPROCESAR'
				Case lcAtributo == 'MLFULLENVIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MLFULLE AS MLFULLENVIOS'
				Case lcAtributo == 'PACKID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PACKID AS PACKID'
				Case lcAtributo == 'STOREORDERID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'STOREORDER AS STOREORDERID'
				Case lcAtributo == 'DESCUENTOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PODESC AS DESCUENTOPORCENTAJE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'FECHADEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPAGO AS FECHADEPAGO'
				Case lcAtributo == 'LINKOPERACIONECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'URLECOMM AS LINKOPERACIONECOMMERCE'
				Case lcAtributo == 'DESCUENTOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESC AS DESCUENTOMONTO'
				Case lcAtributo == 'CLIENTEECOM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIECOM AS CLIENTEECOM'
				Case lcAtributo == 'DESCUENTOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDES2 AS DESCUENTOMONTO2'
				Case lcAtributo == 'CLIENTEDRAGON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDRAGON AS CLIENTEDRAGON'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORREC AS RECARGOPORCENTAJE'
				Case lcAtributo == 'DATOSENVIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENVIO AS DATOSENVIO'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONREC AS RECARGOMONTO'
				Case lcAtributo == 'TELEFONOENVIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TELENVIO AS TELEFONOENVIO'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONREC2 AS RECARGOMONTO2'
				Case lcAtributo == 'DATOSPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGO AS DATOSPAGO'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'PAGADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGADO AS PAGADO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPTOTAL AS TOTAL'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCOMPAFEC( tcCampos As String ) As String
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
	Function ObtenerCamposSelectDetallePublicacionDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'CODIGOHERRCANCELACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODHERRCAN AS CODIGOHERRCANCELACION'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NROOPERACIONCANCELACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMOPECAN AS NROOPERACIONCANCELACION'
				Case lcAtributo == 'NUMEROOPERACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMOPE AS NUMEROOPERACION'
				Case lcAtributo == 'STOREORDERID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'STOREORDER AS STOREORDERID'
				Case lcAtributo == 'IDPUBLICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDPUB AS IDPUBLICACION'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRIPCION'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDET AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDET AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPTALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANT AS CANTIDAD'
				Case lcAtributo == 'PRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIO AS PRECIO'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORDESC AS DESCUENTO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'MONTODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESC AS MONTODESCUENTO'
				Case lcAtributo == 'FECHACANCELACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECCAN AS FECHACANCELACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJNUM AS CODIGO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCO AS VALOR'
				Case lcAtributo == 'VALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJDE AS VALORDETALLE'
				Case lcAtributo == 'RECIBIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJRECIB AS RECIBIDO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADTOTAL'
				lcCampo = 'CANT'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ENVIOID'
				lcCampo = 'IDENVIO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEID'
				lcCampo = 'IDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'LOGISTICTYPE'
				lcCampo = 'LOGISTIC'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ECOMMERCE'
				lcCampo = 'ECOMMERCE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'PENDIENTEDEPROCESAR'
				lcCampo = 'PENPROC'
			Case upper( alltrim( tcAtributo ) ) == 'MLFULLENVIOS'
				lcCampo = 'MLFULLE'
			Case upper( alltrim( tcAtributo ) ) == 'PACKID'
				lcCampo = 'PACKID'
			Case upper( alltrim( tcAtributo ) ) == 'STOREORDERID'
				lcCampo = 'STOREORDER'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPORCENTAJE'
				lcCampo = 'PODESC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADEPAGO'
				lcCampo = 'FPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'LINKOPERACIONECOMMERCE'
				lcCampo = 'URLECOMM'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTO'
				lcCampo = 'MONDESC'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEECOM'
				lcCampo = 'CLIECOM'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTO2'
				lcCampo = 'MONDES2'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDRAGON'
				lcCampo = 'CLIEDRAGON'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'PORREC'
			Case upper( alltrim( tcAtributo ) ) == 'DATOSENVIO'
				lcCampo = 'ENVIO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MONREC'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONOENVIO'
				lcCampo = 'TELENVIO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'MONREC2'
			Case upper( alltrim( tcAtributo ) ) == 'DATOSPAGO'
				lcCampo = 'PAGO'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'PAGADO'
				lcCampo = 'PAGADO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'OPTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCOMPAFEC( tcAtributo As String ) As String
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
	Function ObtenerCampoDetallePublicacionDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOHERRCANCELACION'
				lcCampo = 'CODHERRCAN'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NROOPERACIONCANCELACION'
				lcCampo = 'NUMOPECAN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROOPERACION'
				lcCampo = 'NUMOPE'
			Case upper( alltrim( tcAtributo ) ) == 'STOREORDERID'
				lcCampo = 'STOREORDER'
			Case upper( alltrim( tcAtributo ) ) == 'IDPUBLICACION'
				lcCampo = 'IDPUB'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'OPART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'ARTDET'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'OPCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'OPTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANT'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIO'
				lcCampo = 'PRECIO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'PORDESC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO'
				lcCampo = 'MONDESC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACANCELACION'
				lcCampo = 'FECCAN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleValoresDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'JJNUM'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'JJCO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDETALLE'
				lcCampo = 'JJDE'
			Case upper( alltrim( tcAtributo ) ) == 'RECIBIDO'
				lcCampo = 'JJRECIB'
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
		if upper( alltrim( tcDetalle ) ) == 'PUBLICACIONDETALLE'
			lcRetorno = 'OPECOMDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'VALORESDETALLE'
			lcRetorno = 'OPECOMVAL'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxOpecomFectrans, lxOpecomFmodifw, lxOpecomFecexpo, lxOpecomFecimpo, lxOpecomFaltafw, lxOpecomCant, lxOpecomVmodifw, lxOpecomUmodifw, lxOpecomValtafw, lxOpecomHoraimpo, lxOpecomUaltafw, lxOpecomEsttrans, lxOpecomSaltafw, lxOpecomHoraexpo, lxOpecomHmodifw, lxOpecomSmodifw, lxOpecomHaltafw, lxOpecomIdenvio, lxOpecomBdmodifw, lxOpecomIdcomp, lxOpecomLogistic, lxOpecomBdaltafw, lxOpecomEcommerce, lxOpecomCodigo, lxOpecomFecha, lxOpecomHora, lxOpecomPenproc, lxOpecomMlfulle, lxOpecomPackid, lxOpecomStoreorder, lxOpecomPodesc, lxOpecomNumero, lxOpecomFpago, lxOpecomUrlecomm, lxOpecomMondesc, lxOpecomCliecom, lxOpecomMondes2, lxOpecomCliedragon, lxOpecomPorrec, lxOpecomEnvio, lxOpecomMonrec, lxOpecomTelenvio, lxOpecomMonrec2, lxOpecomPago, lxOpecomZadsfw, lxOpecomPagado, lxOpecomOptotal, lxOpecomObs
				lxOpecomFectrans =  .Fechatransferencia			lxOpecomFmodifw =  .Fechamodificacionfw			lxOpecomFecexpo =  .Fechaexpo			lxOpecomFecimpo =  .Fechaimpo			lxOpecomFaltafw =  .Fechaaltafw			lxOpecomCant =  .Cantidadtotal			lxOpecomVmodifw =  .Versionmodificacionfw			lxOpecomUmodifw =  .Usuariomodificacionfw			lxOpecomValtafw =  .Versionaltafw			lxOpecomHoraimpo =  .Horaimpo			lxOpecomUaltafw =  .Usuarioaltafw			lxOpecomEsttrans =  .Estadotransferencia			lxOpecomSaltafw =  .Seriealtafw			lxOpecomHoraexpo =  .Horaexpo			lxOpecomHmodifw =  .Horamodificacionfw			lxOpecomSmodifw =  .Seriemodificacionfw			lxOpecomHaltafw =  .Horaaltafw			lxOpecomIdenvio =  .Envioid			lxOpecomBdmodifw =  .Basededatosmodificacionfw			lxOpecomIdcomp =  .Comprobanteid			lxOpecomLogistic =  .Logistictype			lxOpecomBdaltafw =  .Basededatosaltafw			lxOpecomEcommerce =  upper( .Ecommerce_PK ) 			lxOpecomCodigo =  .Codigo			lxOpecomFecha =  .Fecha			lxOpecomHora =  .Hora			lxOpecomPenproc =  .Pendientedeprocesar			lxOpecomMlfulle =  .Mlfullenvios			lxOpecomPackid =  .Packid			lxOpecomStoreorder =  .Storeorderid			lxOpecomPodesc =  .Descuentoporcentaje			lxOpecomNumero =  .Numero			lxOpecomFpago =  .Fechadepago			lxOpecomUrlecomm =  .Linkoperacionecommerce			lxOpecomMondesc =  .Descuentomonto			lxOpecomCliecom =  upper( .ClienteEcom_PK ) 			lxOpecomMondes2 =  .Descuentomonto2			lxOpecomCliedragon =  upper( .ClienteDragon_PK ) 			lxOpecomPorrec =  .Recargoporcentaje			lxOpecomEnvio =  .Datosenvio			lxOpecomMonrec =  .Recargomonto			lxOpecomTelenvio =  .Telefonoenvio			lxOpecomMonrec2 =  .Recargomonto2			lxOpecomPago =  .Datospago			lxOpecomZadsfw =  .Zadsfw			lxOpecomPagado =  .Pagado			lxOpecomOptotal =  .Total			lxOpecomObs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.OPECOM ( "Fectrans","Fmodifw","Fecexpo","Fecimpo","Faltafw","Cant","Vmodifw","Umodifw","Valtafw","Horaimpo","Ualtafw","Esttrans","Saltafw","Horaexpo","Hmodifw","Smodifw","Haltafw","Idenvio","Bdmodifw","Idcomp","Logistic","Bdaltafw","Ecommerce","Codigo","Fecha","Hora","Penproc","Mlfulle","Packid","Storeorder","Podesc","Numero","Fpago","Urlecomm","Mondesc","Cliecom","Mondes2","Cliedragon","Porrec","Envio","Monrec","Telenvio","Monrec2","Pago","Zadsfw","Pagado","Optotal","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxOpecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFaltafw ) + "'" >>, <<lxOpecomCant >>, <<"'" + this.FormatearTextoSql( lxOpecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomIdenvio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomIdcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomLogistic ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomEcommerce ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomHora ) + "'" >>, <<iif( lxOpecomPenproc, 1, 0 ) >>, <<iif( lxOpecomMlfulle, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOpecomPackid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomStoreorder ) + "'" >>, <<lxOpecomPodesc >>, <<"'" + this.FormatearTextoSql( lxOpecomNumero ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOpecomFpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomUrlecomm ) + "'" >>, <<lxOpecomMondesc >>, <<"'" + this.FormatearTextoSql( lxOpecomCliecom ) + "'" >>, <<lxOpecomMondes2 >>, <<"'" + this.FormatearTextoSql( lxOpecomCliedragon ) + "'" >>, <<lxOpecomPorrec >>, <<"'" + this.FormatearTextoSql( lxOpecomEnvio ) + "'" >>, <<lxOpecomMonrec >>, <<"'" + this.FormatearTextoSql( lxOpecomTelenvio ) + "'" >>, <<lxOpecomMonrec2 >>, <<"'" + this.FormatearTextoSql( lxOpecomPago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOpecomZadsfw ) + "'" >>, <<iif( lxOpecomPagado, 1, 0 ) >>, <<lxOpecomOptotal >>, <<"'" + this.FormatearTextoSql( lxOpecomObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'OPECOM' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
			for each loItem in this.oEntidad.PublicacionDetalle
				if this.oEntidad.PublicacionDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxCodigoherrcancelacion = loItem.Codigoherrcancelacion
					lxNroitem = lnContadorNroItem
					lxNrooperacioncancelacion = loItem.Nrooperacioncancelacion
					lxNumerooperacion = loItem.Numerooperacion
					lxStoreorderid = loItem.Storeorderid
					lxIdpublicacion = loItem.Idpublicacion
					lxDescripcion = loItem.Descripcion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMonto = loItem.Monto
					lxMontodescuento = loItem.Montodescuento
					lxFechacancelacion = loItem.Fechacancelacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OPECOMDET("COMP","CodHerrCan","NROITEM","NumOpeCan","NumOpe","STOREORDER","IDPUB","CODIGO","DESCRI","OPART","ARTDET","OPCOLOR","COLDET","OPTALLE","CANT","PRECIO","PORDESC","MONTO","MONDESC","FecCan" ) values ( <<lxComportamiento>>, <<lxCodigoherrcancelacion>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxNrooperacioncancelacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerooperacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxStoreorderid ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdpublicacion ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMonto>>, <<lxMontodescuento>>, <<"'" + this.ConvertirDateSql( lxFechacancelacion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxRecibido = loItem.Recibido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OPECOMVAL("NroItem","JJNUM","JJCO","JJDE","JJRecib" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<lxRecibido>> ) 
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
			local  lxOpecomFectrans, lxOpecomFmodifw, lxOpecomFecexpo, lxOpecomFecimpo, lxOpecomFaltafw, lxOpecomCant, lxOpecomVmodifw, lxOpecomUmodifw, lxOpecomValtafw, lxOpecomHoraimpo, lxOpecomUaltafw, lxOpecomEsttrans, lxOpecomSaltafw, lxOpecomHoraexpo, lxOpecomHmodifw, lxOpecomSmodifw, lxOpecomHaltafw, lxOpecomIdenvio, lxOpecomBdmodifw, lxOpecomIdcomp, lxOpecomLogistic, lxOpecomBdaltafw, lxOpecomEcommerce, lxOpecomCodigo, lxOpecomFecha, lxOpecomHora, lxOpecomPenproc, lxOpecomMlfulle, lxOpecomPackid, lxOpecomStoreorder, lxOpecomPodesc, lxOpecomNumero, lxOpecomFpago, lxOpecomUrlecomm, lxOpecomMondesc, lxOpecomCliecom, lxOpecomMondes2, lxOpecomCliedragon, lxOpecomPorrec, lxOpecomEnvio, lxOpecomMonrec, lxOpecomTelenvio, lxOpecomMonrec2, lxOpecomPago, lxOpecomZadsfw, lxOpecomPagado, lxOpecomOptotal, lxOpecomObs
				lxOpecomFectrans =  .Fechatransferencia			lxOpecomFmodifw =  .Fechamodificacionfw			lxOpecomFecexpo =  .Fechaexpo			lxOpecomFecimpo =  .Fechaimpo			lxOpecomFaltafw =  .Fechaaltafw			lxOpecomCant =  .Cantidadtotal			lxOpecomVmodifw =  .Versionmodificacionfw			lxOpecomUmodifw =  .Usuariomodificacionfw			lxOpecomValtafw =  .Versionaltafw			lxOpecomHoraimpo =  .Horaimpo			lxOpecomUaltafw =  .Usuarioaltafw			lxOpecomEsttrans =  .Estadotransferencia			lxOpecomSaltafw =  .Seriealtafw			lxOpecomHoraexpo =  .Horaexpo			lxOpecomHmodifw =  .Horamodificacionfw			lxOpecomSmodifw =  .Seriemodificacionfw			lxOpecomHaltafw =  .Horaaltafw			lxOpecomIdenvio =  .Envioid			lxOpecomBdmodifw =  .Basededatosmodificacionfw			lxOpecomIdcomp =  .Comprobanteid			lxOpecomLogistic =  .Logistictype			lxOpecomBdaltafw =  .Basededatosaltafw			lxOpecomEcommerce =  upper( .Ecommerce_PK ) 			lxOpecomCodigo =  .Codigo			lxOpecomFecha =  .Fecha			lxOpecomHora =  .Hora			lxOpecomPenproc =  .Pendientedeprocesar			lxOpecomMlfulle =  .Mlfullenvios			lxOpecomPackid =  .Packid			lxOpecomStoreorder =  .Storeorderid			lxOpecomPodesc =  .Descuentoporcentaje			lxOpecomNumero =  .Numero			lxOpecomFpago =  .Fechadepago			lxOpecomUrlecomm =  .Linkoperacionecommerce			lxOpecomMondesc =  .Descuentomonto			lxOpecomCliecom =  upper( .ClienteEcom_PK ) 			lxOpecomMondes2 =  .Descuentomonto2			lxOpecomCliedragon =  upper( .ClienteDragon_PK ) 			lxOpecomPorrec =  .Recargoporcentaje			lxOpecomEnvio =  .Datosenvio			lxOpecomMonrec =  .Recargomonto			lxOpecomTelenvio =  .Telefonoenvio			lxOpecomMonrec2 =  .Recargomonto2			lxOpecomPago =  .Datospago			lxOpecomZadsfw =  .Zadsfw			lxOpecomPagado =  .Pagado			lxOpecomOptotal =  .Total			lxOpecomObs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  OPECOM.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.OPECOM set "Fectrans" = <<"'" + this.ConvertirDateSql( lxOpecomFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxOpecomFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxOpecomFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxOpecomFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxOpecomFaltafw ) + "'">>, "Cant" = <<lxOpecomCant>>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxOpecomVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxOpecomUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxOpecomValtafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxOpecomHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxOpecomUaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxOpecomEsttrans ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxOpecomSaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxOpecomHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxOpecomHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxOpecomSmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxOpecomHaltafw ) + "'">>, "Idenvio" = <<"'" + this.FormatearTextoSql( lxOpecomIdenvio ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOpecomBdmodifw ) + "'">>, "Idcomp" = <<"'" + this.FormatearTextoSql( lxOpecomIdcomp ) + "'">>, "Logistic" = <<"'" + this.FormatearTextoSql( lxOpecomLogistic ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOpecomBdaltafw ) + "'">>, "Ecommerce" = <<"'" + this.FormatearTextoSql( lxOpecomEcommerce ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxOpecomCodigo ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxOpecomFecha ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxOpecomHora ) + "'">>, "Penproc" = <<iif( lxOpecomPenproc, 1, 0 )>>, "Mlfulle" = <<iif( lxOpecomMlfulle, 1, 0 )>>, "Packid" = <<"'" + this.FormatearTextoSql( lxOpecomPackid ) + "'">>, "Storeorder" = <<"'" + this.FormatearTextoSql( lxOpecomStoreorder ) + "'">>, "Podesc" = <<lxOpecomPodesc>>, "Numero" = <<"'" + this.FormatearTextoSql( lxOpecomNumero ) + "'">>, "Fpago" = <<"'" + this.ConvertirDateSql( lxOpecomFpago ) + "'">>, "Urlecomm" = <<"'" + this.FormatearTextoSql( lxOpecomUrlecomm ) + "'">>, "Mondesc" = <<lxOpecomMondesc>>, "Cliecom" = <<"'" + this.FormatearTextoSql( lxOpecomCliecom ) + "'">>, "Mondes2" = <<lxOpecomMondes2>>, "Cliedragon" = <<"'" + this.FormatearTextoSql( lxOpecomCliedragon ) + "'">>, "Porrec" = <<lxOpecomPorrec>>, "Envio" = <<"'" + this.FormatearTextoSql( lxOpecomEnvio ) + "'">>, "Monrec" = <<lxOpecomMonrec>>, "Telenvio" = <<"'" + this.FormatearTextoSql( lxOpecomTelenvio ) + "'">>, "Monrec2" = <<lxOpecomMonrec2>>, "Pago" = <<"'" + this.FormatearTextoSql( lxOpecomPago ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxOpecomZadsfw ) + "'">>, "Pagado" = <<iif( lxOpecomPagado, 1, 0 )>>, "Optotal" = <<lxOpecomOptotal>>, "Obs" = <<"'" + this.FormatearTextoSql( lxOpecomObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'OPECOM' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.OPECOMDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.OPECOMVAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
			for each loItem in this.oEntidad.PublicacionDetalle
				if this.oEntidad.PublicacionDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxCodigoherrcancelacion = loItem.Codigoherrcancelacion
					lxNroitem = lnContadorNroItem
					lxNrooperacioncancelacion = loItem.Nrooperacioncancelacion
					lxNumerooperacion = loItem.Numerooperacion
					lxStoreorderid = loItem.Storeorderid
					lxIdpublicacion = loItem.Idpublicacion
					lxDescripcion = loItem.Descripcion
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMonto = loItem.Monto
					lxMontodescuento = loItem.Montodescuento
					lxFechacancelacion = loItem.Fechacancelacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OPECOMDET("COMP","CodHerrCan","NROITEM","NumOpeCan","NumOpe","STOREORDER","IDPUB","CODIGO","DESCRI","OPART","ARTDET","OPCOLOR","COLDET","OPTALLE","CANT","PRECIO","PORDESC","MONTO","MONDESC","FecCan" ) values ( <<lxComportamiento>>, <<lxCodigoherrcancelacion>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxNrooperacioncancelacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerooperacion ) + "'">>, <<"'" + this.FormatearTextoSql( lxStoreorderid ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdpublicacion ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMonto>>, <<lxMontodescuento>>, <<"'" + this.ConvertirDateSql( lxFechacancelacion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxRecibido = loItem.Recibido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OPECOMVAL("NroItem","JJNUM","JJCO","JJDE","JJRecib" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<lxRecibido>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  OPECOM.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.OPECOM where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.OPECOMDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.OPECOMVAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'OPECOM' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

		with this.oEntidad
		
			.oCompEcommerce.lNuevo = .EsNuevo()
			.oCompEcommerce.lEdicion = .EsEdicion()
			.oCompEcommerce.lEliminar = .lEliminar
			.oCompEcommerce.lAnular = .lAnular
			loColSentencias = .oCompEcommerce.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.OPECOM set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  OPECOM.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.OPECOM where  OPECOM.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.OPECOM where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  OPECOM.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxOPECOMECOMMERCE as variant, lxOPECOMNUMERO as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'OPERACIONECOMMERCE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.OPECOM Where  NUMERO = ] + "'" + this.FormatearTextoSql( &lcCursor..NUMERO     ) + "'" + [ and ECOMMERCE = ] + "'" + this.FormatearTextoSql( &lcCursor..ECOMMERCE  ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.OPECOM set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, CANT = ] + transform( &lcCursor..CANT )+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, IdEnvio = ] + "'" + this.FormatearTextoSql( &lcCursor..IdEnvio ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, IDCOMP = ] + "'" + this.FormatearTextoSql( &lcCursor..IDCOMP ) + "'"+ [, Logistic = ] + "'" + this.FormatearTextoSql( &lcCursor..Logistic ) + "'"+ [, ECOMMERCE = ] + "'" + this.FormatearTextoSql( &lcCursor..ECOMMERCE ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, HORA = ] + "'" + this.FormatearTextoSql( &lcCursor..HORA ) + "'"+ [, PenProc = ] + Transform( iif( &lcCursor..PenProc, 1, 0 ))+ [, MLFULLE = ] + Transform( iif( &lcCursor..MLFULLE, 1, 0 ))+ [, PACKID = ] + "'" + this.FormatearTextoSql( &lcCursor..PACKID ) + "'"+ [, STOREORDER = ] + "'" + this.FormatearTextoSql( &lcCursor..STOREORDER ) + "'"+ [, PODESC = ] + transform( &lcCursor..PODESC )+ [, NUMERO = ] + "'" + this.FormatearTextoSql( &lcCursor..NUMERO ) + "'"+ [, FPAGO = ] + "'" + this.ConvertirDateSql( &lcCursor..FPAGO ) + "'"+ [, UrlEcomm = ] + "'" + this.FormatearTextoSql( &lcCursor..UrlEcomm ) + "'"+ [, MONDESC = ] + transform( &lcCursor..MONDESC )+ [, CLIECOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIECOM ) + "'"+ [, MONDES2 = ] + transform( &lcCursor..MONDES2 )+ [, CLIEDRAGON = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIEDRAGON ) + "'"+ [, PORREC = ] + transform( &lcCursor..PORREC )+ [, ENVIO = ] + "'" + this.FormatearTextoSql( &lcCursor..ENVIO ) + "'"+ [, MONREC = ] + transform( &lcCursor..MONREC )+ [, TELENVIO = ] + "'" + this.FormatearTextoSql( &lcCursor..TELENVIO ) + "'"+ [, MONREC2 = ] + transform( &lcCursor..MONREC2 )+ [, PAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..PAGO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, PAGADO = ] + Transform( iif( &lcCursor..PAGADO, 1, 0 ))+ [, OPTOTAL = ] + transform( &lcCursor..OPTOTAL )+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.OPECOM Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FMODIFW, FECEXPO, FECIMPO, FALTAFW, CANT, VMODIFW, UMODIFW, VALTAFW, HORAIMPO, UALTAFW, ESTTRANS, SALTAFW, HORAEXPO, HMODIFW, SMODIFW, HALTAFW, IdEnvio, BDMODIFW, IDCOMP, Logistic, BDALTAFW, ECOMMERCE, CODIGO, FECHA, HORA, PenProc, MLFULLE, PACKID, STOREORDER, PODESC, NUMERO, FPAGO, UrlEcomm, MONDESC, CLIECOM, MONDES2, CLIEDRAGON, PORREC, ENVIO, MONREC, TELENVIO, MONREC2, PAGO, ZADSFW, PAGADO, OPTOTAL, OBS
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + transform( &lcCursor..CANT ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdEnvio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IDCOMP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Logistic ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ECOMMERCE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORA ) + "'" + ',' + Transform( iif( &lcCursor..PenProc, 1, 0 )) + ',' + Transform( iif( &lcCursor..MLFULLE, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PACKID ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..STOREORDER ) + "'" + ',' + transform( &lcCursor..PODESC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..NUMERO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FPAGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UrlEcomm ) + "'" + ',' + transform( &lcCursor..MONDESC )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIECOM ) + "'" + ',' + transform( &lcCursor..MONDES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIEDRAGON ) + "'" + ',' + transform( &lcCursor..PORREC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ENVIO ) + "'" + ',' + transform( &lcCursor..MONREC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TELENVIO ) + "'" + ',' + transform( &lcCursor..MONREC2 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PAGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + Transform( iif( &lcCursor..PAGADO, 1, 0 )) + ',' + transform( &lcCursor..OPTOTAL ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.OPECOM ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'OPERACIONECOMMERCE'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.OPECOMDET Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.OPECOMVAL Where JJNUM] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMPROBANTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPUBLICACIONECOM'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"COMP","CodHerrCan","NROITEM","NumOpeCan","NumOpe","STOREORDER","IDPUB","CODIGO","DESCRI","OPART","ARTDET","OPCOLOR","COLDET","OPTALLE","CANT","PRECIO","PORDESC","MONTO","MONDESC","FecCan"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.OPECOMDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.CodHerrCan ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NumOpeCan  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NumOpe     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.STOREORDER ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDPUB      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DESCRI     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPART      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ARTDET     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPCOLOR    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.COLDET     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPTALLE    ) + "'" + ',' + transform( cDetallesExistentes.CANT       ) + ',' + transform( cDetallesExistentes.PRECIO     ) + ',' + transform( cDetallesExistentes.PORDESC    ) + ',' + transform( cDetallesExistentes.MONTO      ) + ',' + transform( cDetallesExistentes.MONDESC    ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FecCan     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALOROPEECOM'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NroItem","JJNUM","JJCO","JJDE","JJRecib"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.OPECOMVAL ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NroItem    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + transform( cDetallesExistentes.JJRecib    ) + ' )'  )
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
		lcRetorno = lcRetorno + ' - Plataforma: ' + transform( &tcCursor..ECOMMERCE  )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'OPERACIONECOMMERCE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'OPERACIONECOMMERCE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'OPERACIONECOMMERCE_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPUBLICACIONECOM'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALOROPEECOM'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_OPECOM')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'OPERACIONECOMMERCE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..NUMERO ) or isnull( &lcCursor..ECOMMERCE )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad OPERACIONECOMMERCE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'OPERACIONECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,NUMERO + ECOMMERCE as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NUMERO + ECOMMERCE, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'OPERACIONECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECHA     
		* Validar ANTERIORES A 1/1/1753  FPAGO     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_OPECOM') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_OPECOM
Create Table ZooLogic.TablaTrabajo_OPECOM ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"cant" numeric( 10, 0 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"saltafw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"idenvio" char( 30 )  null, 
"bdmodifw" char( 8 )  null, 
"idcomp" char( 60 )  null, 
"logistic" char( 38 )  null, 
"bdaltafw" char( 8 )  null, 
"ecommerce" char( 10 )  null, 
"codigo" char( 38 )  null, 
"fecha" datetime  null, 
"hora" char( 5 )  null, 
"penproc" bit  null, 
"mlfulle" bit  null, 
"packid" char( 20 )  null, 
"storeorder" char( 20 )  null, 
"podesc" numeric( 5, 2 )  null, 
"numero" char( 38 )  null, 
"fpago" datetime  null, 
"urlecomm" char( 200 )  null, 
"mondesc" numeric( 12, 2 )  null, 
"cliecom" char( 10 )  null, 
"mondes2" numeric( 12, 2 )  null, 
"cliedragon" char( 5 )  null, 
"porrec" numeric( 5, 2 )  null, 
"envio" char( 20 )  null, 
"monrec" numeric( 12, 2 )  null, 
"telenvio" char( 30 )  null, 
"monrec2" numeric( 12, 2 )  null, 
"pago" char( 20 )  null, 
"zadsfw" varchar(max)  null, 
"pagado" bit  null, 
"optotal" numeric( 15, 2 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_OPECOM' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_OPECOM' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'OPERACIONECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('cant','cant')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('idenvio','idenvio')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('idcomp','idcomp')
			.AgregarMapeo('logistic','logistic')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('ecommerce','ecommerce')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('penproc','penproc')
			.AgregarMapeo('mlfulle','mlfulle')
			.AgregarMapeo('packid','packid')
			.AgregarMapeo('storeorder','storeorder')
			.AgregarMapeo('podesc','podesc')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('fpago','fpago')
			.AgregarMapeo('urlecomm','urlecomm')
			.AgregarMapeo('mondesc','mondesc')
			.AgregarMapeo('cliecom','cliecom')
			.AgregarMapeo('mondes2','mondes2')
			.AgregarMapeo('cliedragon','cliedragon')
			.AgregarMapeo('porrec','porrec')
			.AgregarMapeo('envio','envio')
			.AgregarMapeo('monrec','monrec')
			.AgregarMapeo('telenvio','telenvio')
			.AgregarMapeo('monrec2','monrec2')
			.AgregarMapeo('pago','pago')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('pagado','pagado')
			.AgregarMapeo('optotal','optotal')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_OPECOM'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.CANT = isnull( d.CANT, t.CANT ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.IDENVIO = isnull( d.IDENVIO, t.IDENVIO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.IDCOMP = isnull( d.IDCOMP, t.IDCOMP ),t.LOGISTIC = isnull( d.LOGISTIC, t.LOGISTIC ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ECOMMERCE = isnull( d.ECOMMERCE, t.ECOMMERCE ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.HORA = isnull( d.HORA, t.HORA ),t.PENPROC = isnull( d.PENPROC, t.PENPROC ),t.MLFULLE = isnull( d.MLFULLE, t.MLFULLE ),t.PACKID = isnull( d.PACKID, t.PACKID ),t.STOREORDER = isnull( d.STOREORDER, t.STOREORDER ),t.PODESC = isnull( d.PODESC, t.PODESC ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FPAGO = isnull( d.FPAGO, t.FPAGO ),t.URLECOMM = isnull( d.URLECOMM, t.URLECOMM ),t.MONDESC = isnull( d.MONDESC, t.MONDESC ),t.CLIECOM = isnull( d.CLIECOM, t.CLIECOM ),t.MONDES2 = isnull( d.MONDES2, t.MONDES2 ),t.CLIEDRAGON = isnull( d.CLIEDRAGON, t.CLIEDRAGON ),t.PORREC = isnull( d.PORREC, t.PORREC ),t.ENVIO = isnull( d.ENVIO, t.ENVIO ),t.MONREC = isnull( d.MONREC, t.MONREC ),t.TELENVIO = isnull( d.TELENVIO, t.TELENVIO ),t.MONREC2 = isnull( d.MONREC2, t.MONREC2 ),t.PAGO = isnull( d.PAGO, t.PAGO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.PAGADO = isnull( d.PAGADO, t.PAGADO ),t.OPTOTAL = isnull( d.OPTOTAL, t.OPTOTAL ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.OPECOM t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.NUMERO = d.NUMERO
							 and  t.ECOMMERCE = d.ECOMMERCE
				-- Fin Updates
				insert into ZooLogic.OPECOM(Fectrans,Fmodifw,Fecexpo,Fecimpo,Faltafw,Cant,Vmodifw,Umodifw,Valtafw,Horaimpo,Ualtafw,Esttrans,Saltafw,Horaexpo,Hmodifw,Smodifw,Haltafw,Idenvio,Bdmodifw,Idcomp,Logistic,Bdaltafw,Ecommerce,Codigo,Fecha,Hora,Penproc,Mlfulle,Packid,Storeorder,Podesc,Numero,Fpago,Urlecomm,Mondesc,Cliecom,Mondes2,Cliedragon,Porrec,Envio,Monrec,Telenvio,Monrec2,Pago,Zadsfw,Pagado,Optotal,Obs)
					Select isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.CANT,0),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.SALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.IDENVIO,''),isnull( d.BDMODIFW,''),isnull( d.IDCOMP,''),isnull( d.LOGISTIC,''),isnull( d.BDALTAFW,''),isnull( d.ECOMMERCE,''),isnull( d.CODIGO,''),isnull( d.FECHA,''),isnull( d.HORA,''),isnull( d.PENPROC,0),isnull( d.MLFULLE,0),isnull( d.PACKID,''),isnull( d.STOREORDER,''),isnull( d.PODESC,0),isnull( d.NUMERO,''),isnull( d.FPAGO,''),isnull( d.URLECOMM,''),isnull( d.MONDESC,0),isnull( d.CLIECOM,''),isnull( d.MONDES2,0),isnull( d.CLIEDRAGON,''),isnull( d.PORREC,0),isnull( d.ENVIO,''),isnull( d.MONREC,0),isnull( d.TELENVIO,''),isnull( d.MONREC2,0),isnull( d.PAGO,''),isnull( d.ZADSFW,''),isnull( d.PAGADO,0),isnull( d.OPTOTAL,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.OPECOM pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.OPECOM cc 
							 on  d.NUMERO = cc.NUMERO
							 and  d.ECOMMERCE = cc.ECOMMERCE
						Where pk.CODIGO Is Null 
							 and cc.NUMERO Is Null 
							 and cc.ECOMMERCE Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(38) ) + ', PLATAFORMA ' + cast( d.ECOMMERCE as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.OPECOM t inner join deleted d 
							on   t.NUMERO = d.NUMERO
							 and  t.ECOMMERCE = d.ECOMMERCE
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(38) ) + ', PLATAFORMA ' + cast( d.ECOMMERCE as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.OPECOM t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.NUMERO = h.NUMERO
							 and   t.ECOMMERCE = h.ECOMMERCE
							where   h.NUMERO is null 
							 and   h.ECOMMERCE is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_OPECOM_CompAfe
ON ZooLogic.TablaTrabajo_OPECOM_CompAfe
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
	function ObtenerTriggerDeleteImportacion_OPECOMDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_OPECOM_OPECOMDET
ON ZooLogic.TablaTrabajo_OPECOM_OPECOMDET
AFTER DELETE
As
Begin
Update t Set 
t.COMP = isnull( d.COMP, t.COMP ),
t.CODHERRCAN = isnull( d.CODHERRCAN, t.CODHERRCAN ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.NUMOPECAN = isnull( d.NUMOPECAN, t.NUMOPECAN ),
t.NUMOPE = isnull( d.NUMOPE, t.NUMOPE ),
t.STOREORDER = isnull( d.STOREORDER, t.STOREORDER ),
t.IDPUB = isnull( d.IDPUB, t.IDPUB ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.OPART = isnull( d.OPART, t.OPART ),
t.ARTDET = isnull( d.ARTDET, t.ARTDET ),
t.OPCOLOR = isnull( d.OPCOLOR, t.OPCOLOR ),
t.COLDET = isnull( d.COLDET, t.COLDET ),
t.OPTALLE = isnull( d.OPTALLE, t.OPTALLE ),
t.CANT = isnull( d.CANT, t.CANT ),
t.PRECIO = isnull( d.PRECIO, t.PRECIO ),
t.PORDESC = isnull( d.PORDESC, t.PORDESC ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.MONDESC = isnull( d.MONDESC, t.MONDESC ),
t.FECCAN = isnull( d.FECCAN, t.FECCAN )
from ZooLogic.OPECOMDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.OPECOMDET
( 
"COMP",
"CODHERRCAN",
"NROITEM",
"NUMOPECAN",
"NUMOPE",
"STOREORDER",
"IDPUB",
"CODIGO",
"DESCRI",
"OPART",
"ARTDET",
"OPCOLOR",
"COLDET",
"OPTALLE",
"CANT",
"PRECIO",
"PORDESC",
"MONTO",
"MONDESC",
"FECCAN"
 )
Select 
d.COMP,
d.CODHERRCAN,
d.NROITEM,
d.NUMOPECAN,
d.NUMOPE,
d.STOREORDER,
d.IDPUB,
d.CODIGO,
d.DESCRI,
d.OPART,
d.ARTDET,
d.OPCOLOR,
d.COLDET,
d.OPTALLE,
d.CANT,
d.PRECIO,
d.PORDESC,
d.MONTO,
d.MONDESC,
d.FECCAN
From deleted d left join ZooLogic.OPECOMDET pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_OPECOMVAL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_OPECOM_OPECOMVAL
ON ZooLogic.TablaTrabajo_OPECOM_OPECOMVAL
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJRECIB = isnull( d.JJRECIB, t.JJRECIB )
from ZooLogic.OPECOMVAL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.OPECOMVAL
( 
"NROITEM",
"JJNUM",
"JJCO",
"JJDE",
"JJRECIB"
 )
Select 
d.NROITEM,
d.JJNUM,
d.JJCO,
d.JJDE,
d.JJRECIB
From deleted d left join ZooLogic.OPECOMVAL pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_OPECOM') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_OPECOM
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_OPERACIONECOMMERCE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_OPERACIONECOMMERCE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_OPERACIONECOMMERCE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_OPERACIONECOMMERCE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_OPERACIONECOMMERCE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_OPERACIONECOMMERCE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Cantidadtotal = nvl( c_OPERACIONECOMMERCE.Cantidadtotal, 0 )
					.Versionmodificacionfw = nvl( c_OPERACIONECOMMERCE.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_OPERACIONECOMMERCE.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_OPERACIONECOMMERCE.Versionaltafw, [] )
					.Horaimpo = nvl( c_OPERACIONECOMMERCE.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_OPERACIONECOMMERCE.Usuarioaltafw, [] )
					.Estadotransferencia = nvl( c_OPERACIONECOMMERCE.Estadotransferencia, [] )
					.Seriealtafw = nvl( c_OPERACIONECOMMERCE.Seriealtafw, [] )
					.Horaexpo = nvl( c_OPERACIONECOMMERCE.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_OPERACIONECOMMERCE.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_OPERACIONECOMMERCE.Seriemodificacionfw, [] )
					.Horaaltafw = nvl( c_OPERACIONECOMMERCE.Horaaltafw, [] )
					.Envioid = nvl( c_OPERACIONECOMMERCE.Envioid, [] )
					.Basededatosmodificacionfw = nvl( c_OPERACIONECOMMERCE.Basededatosmodificacionfw, [] )
					.Comprobanteid = nvl( c_OPERACIONECOMMERCE.Comprobanteid, [] )
					.Logistictype = nvl( c_OPERACIONECOMMERCE.Logistictype, [] )
					.Basededatosaltafw = nvl( c_OPERACIONECOMMERCE.Basededatosaltafw, [] )
					.Ecommerce_PK =  nvl( c_OPERACIONECOMMERCE.Ecommerce, [] )
					.Codigo = nvl( c_OPERACIONECOMMERCE.Codigo, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_OPERACIONECOMMERCE.Fecha, ctod( '  /  /    ' ) ) )
					.Publicaciondetalle.Limpiar()
					.Publicaciondetalle.SetearEsNavegacion( .lProcesando )
					.Publicaciondetalle.Cargar()
					.Hora = nvl( c_OPERACIONECOMMERCE.Hora, [] )
					.Pendientedeprocesar = nvl( c_OPERACIONECOMMERCE.Pendientedeprocesar, .F. )
					.Mlfullenvios = nvl( c_OPERACIONECOMMERCE.Mlfullenvios, .F. )
					.Packid = nvl( c_OPERACIONECOMMERCE.Packid, [] )
					.Storeorderid = nvl( c_OPERACIONECOMMERCE.Storeorderid, [] )
					.Descuentoporcentaje = nvl( c_OPERACIONECOMMERCE.Descuentoporcentaje, 0 )
					.Numero = nvl( c_OPERACIONECOMMERCE.Numero, [] )
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Fechadepago = GoLibrerias.ObtenerFechaFormateada( nvl( c_OPERACIONECOMMERCE.Fechadepago, ctod( '  /  /    ' ) ) )
					.Linkoperacionecommerce = nvl( c_OPERACIONECOMMERCE.Linkoperacionecommerce, [] )
					.Descuentomonto = nvl( c_OPERACIONECOMMERCE.Descuentomonto, 0 )
					.Clienteecom_PK =  nvl( c_OPERACIONECOMMERCE.Clienteecom, [] )
					.Descuentomonto2 = nvl( c_OPERACIONECOMMERCE.Descuentomonto2, 0 )
					.Clientedragon_PK =  nvl( c_OPERACIONECOMMERCE.Clientedragon, [] )
					.Recargoporcentaje = nvl( c_OPERACIONECOMMERCE.Recargoporcentaje, 0 )
					.Datosenvio = nvl( c_OPERACIONECOMMERCE.Datosenvio, [] )
					.Recargomonto = nvl( c_OPERACIONECOMMERCE.Recargomonto, 0 )
					.Telefonoenvio = nvl( c_OPERACIONECOMMERCE.Telefonoenvio, [] )
					.Recargomonto2 = nvl( c_OPERACIONECOMMERCE.Recargomonto2, 0 )
					.Datospago = nvl( c_OPERACIONECOMMERCE.Datospago, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Pagado = nvl( c_OPERACIONECOMMERCE.Pagado, .F. )
					.Total = nvl( c_OPERACIONECOMMERCE.Total, 0 )
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
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_OPERACIONECOMMERCE.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.COMPAFEC
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

		loDetalle = this.oEntidad.PublicacionDetalle
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

		loDetalle = this.oEntidad.ValoresDetalle
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
		return c_OPERACIONECOMMERCE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.OPECOM' )
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
								from ZooLogic.OPECOM 
								Where   OPECOM.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "OPECOM", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Cant" as "Cantidadtotal", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Idenvio" as "Envioid", "Bdmodifw" as "Basededatosmodificacionfw", "Idcomp" as "Comprobanteid", "Logistic" as "Logistictype", "Bdaltafw" as "Basededatosaltafw", "Ecommerce" as "Ecommerce", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Penproc" as "Pendientedeprocesar", "Mlfulle" as "Mlfullenvios", "Packid" as "Packid", "Storeorder" as "Storeorderid", "Podesc" as "Descuentoporcentaje", "Numero" as "Numero", "Fpago" as "Fechadepago", "Urlecomm" as "Linkoperacionecommerce", "Mondesc" as "Descuentomonto", "Cliecom" as "Clienteecom", "Mondes2" as "Descuentomonto2", "Cliedragon" as "Clientedragon", "Porrec" as "Recargoporcentaje", "Envio" as "Datosenvio", "Monrec" as "Recargomonto", "Telenvio" as "Telefonoenvio", "Monrec2" as "Recargomonto2", "Pago" as "Datospago", "Zadsfw" as "Zadsfw", "Pagado" as "Pagado", "Optotal" as "Total", "Obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.OPECOM 
								Where   OPECOM.CODIGO != ''
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
	Tabla = 'OPECOM'
	Filtro = " OPECOM.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " OPECOM.CODIGO != ''"
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
	<row entidad="OPERACIONECOMMERCE                      " atributo="FECHATRANSFERENCIA                      " tabla="OPECOM         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="FECHAMODIFICACIONFW                     " tabla="OPECOM         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="FECHAEXPO                               " tabla="OPECOM         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="FECHAIMPO                               " tabla="OPECOM         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="FECHAALTAFW                             " tabla="OPECOM         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="CANTIDADTOTAL                           " tabla="OPECOM         " campo="CANT      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cantidad                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="VERSIONMODIFICACIONFW                   " tabla="OPECOM         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="USUARIOMODIFICACIONFW                   " tabla="OPECOM         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="VERSIONALTAFW                           " tabla="OPECOM         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="HORAIMPO                                " tabla="OPECOM         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="USUARIOALTAFW                           " tabla="OPECOM         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="ESTADOTRANSFERENCIA                     " tabla="OPECOM         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="SERIEALTAFW                             " tabla="OPECOM         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="HORAEXPO                                " tabla="OPECOM         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="HORAMODIFICACIONFW                      " tabla="OPECOM         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="SERIEMODIFICACIONFW                     " tabla="OPECOM         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="HORAALTAFW                              " tabla="OPECOM         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="ENVIOID                                 " tabla="OPECOM         " campo="IDENVIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="OPECOM         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="COMPROBANTEID                           " tabla="OPECOM         " campo="IDCOMP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="LOGISTICTYPE                            " tabla="OPECOM         " campo="LOGISTIC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="BASEDEDATOSALTAFW                       " tabla="OPECOM         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="ECOMMERCE                               " tabla="OPECOM         " campo="ECOMMERCE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ECOMMERCE                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Plataforma                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="CODIGO                                  " tabla="OPECOM         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="18" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="FECHA                                   " tabla="OPECOM         " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="12" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="PUBLICACIONDETALLE                      " tabla="OPECOMDET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Operación detalle                                                                                                                                               " dominio="DETALLEITEMPUBLICACIONECOM    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="HORA                                    " tabla="OPECOM         " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="=left( goservicios.libreRIAS.obtenerhora() , 5)                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="16" etiqueta="Hora                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="PENDIENTEDEPROCESAR                     " tabla="OPECOM         " campo="PENPROC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Pendiente de procesar                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="MLFULLENVIOS                            " tabla="OPECOM         " campo="MLFULLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Logística tercerizada                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="PACKID                                  " tabla="OPECOM         " campo="PACKID    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Nro. de carrito                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="STOREORDERID                            " tabla="OPECOM         " campo="STOREORDER" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Nro. de venta                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="DESCUENTOPORCENTAJE                     " tabla="OPECOM         " campo="PODESC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Porcentaje de descuento                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="NUMERO                                  " tabla="OPECOM         " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="VALORESDETALLE                          " tabla="OPECOMVAL      " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Valores                                                                                                                                                         " dominio="DETALLEITEMVALOROPEECOM       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="10" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="FECHADEPAGO                             " tabla="OPECOM         " campo="FPAGO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Fecha de pago                                                                                                                                                   " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="LINKOPERACIONECOMMERCE                  " tabla="OPECOM         " campo="URLECOMM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Enlace a la operación                                                                                                                                           " dominio="WEB                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="DESCUENTOMONTO                          " tabla="OPECOM         " campo="MONDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Monto % descuento                                                                                                                                               " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="CLIENTEECOM                             " tabla="OPECOM         " campo="CLIECOM   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTEECOMMERCE                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Cliente ecommerce                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="DESCUENTOMONTO2                         " tabla="OPECOM         " campo="MONDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="CLIENTEDRAGON                           " tabla="OPECOM         " campo="CLIEDRAGON" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Cliente Dragonfish                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="RECARGOPORCENTAJE                       " tabla="OPECOM         " campo="PORREC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Recargo porcentaje                                                                                                                                              " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="DATOSENVIO                              " tabla="OPECOM         " campo="ENVIO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Datos de envío                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="RECARGOMONTO                            " tabla="OPECOM         " campo="MONREC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Recargo % monto                                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="TELEFONOENVIO                           " tabla="OPECOM         " campo="TELENVIO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Teléfono de envío                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="RECARGOMONTO2                           " tabla="OPECOM         " campo="MONREC2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Recargo monto                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="DATOSPAGO                               " tabla="OPECOM         " campo="PAGO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Datos de pago                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="ZADSFW                                  " tabla="OPECOM         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Acciones del sistema                                                                                                                                            " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="8" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="PAGADO                                  " tabla="OPECOM         " campo="PAGADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Pagado                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="70" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="TOTAL                                   " tabla="OPECOM         " campo="OPTOTAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="7" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERACIONECOMMERCE                      " atributo="OBS                                     " tabla="OPECOM         " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="9" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DESCRIPCION                             " tabla="ECOM           " campo="CUENTA    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="7" etiqueta="Detalle Pla.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ECOM On OPECOM.ECOMMERCE = ECOM.CODIGO And  ECOM.CODIGO != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="CLIENTEECOMMERCE                        " tabla="CLIECOM        " campo="CLIENECOM " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLIECOM On OPECOM.CLIECOM = CLIECOM.numero And  CLIECOM.NUMERO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On OPECOM.CLIEDRAGON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext

			text to .cEstructuraDetalle noshow 
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
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="IDPUBLICACION                           " tabla="OPECOMDET      " campo="IDPUB     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleOperaciónDetalle, Publicación                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="DESCRIPCION                             " tabla="OPECOMDET      " campo="DESCRI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleOperaciónDetalle, Descripción                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="ARTICULO                                " tabla="OPECOMDET      " campo="OPART     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleOperaciónDetalle, Artículo                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="ARTICULODETALLE                         " tabla="OPECOMDET      " campo="ARTDET    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleOperaciónDetalle, Descripción                                                                                                                            " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="COLOR                                   " tabla="OPECOMDET      " campo="OPCOLOR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleOperaciónDetalle, Color                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="COLORDETALLE                            " tabla="OPECOMDET      " campo="COLDET    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleOperaciónDetalle, Detalle                                                                                                                                " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="TALLE                                   " tabla="OPECOMDET      " campo="OPTALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleOperaciónDetalle, Talle                                                                                                                                  " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="CANTIDAD                                " tabla="OPECOMDET      " campo="CANT      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetalleOperaciónDetalle, Cantidad                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="PRECIO                                  " tabla="OPECOMDET      " campo="PRECIO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleOperaciónDetalle, Precio                                                                                                                                 " dominio="PRECIONONEGATIVOPARAMETROFOCO " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="DESCUENTO                               " tabla="OPECOMDET      " campo="PORDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleOperaciónDetalle, % Descuento                                                                                                                            " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="MONTO                                   " tabla="OPECOMDET      " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="211" etiqueta="DetalleOperaciónDetalle, Monto                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="MONTODESCUENTO                          " tabla="OPECOMDET      " campo="MONDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="212" etiqueta="DetalleOperaciónDetalle, Monto de descuento                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMPUBLICACIONECOM                     " atributo="FECHACANCELACION                        " tabla="OPECOMDET      " campo="FECCAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="213" etiqueta="DetalleOperaciónDetalle, Fecha de cancelación                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPECOMDET On OPECOM.CODIGO = OPECOMDET.CODIGO And  OPECOM.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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