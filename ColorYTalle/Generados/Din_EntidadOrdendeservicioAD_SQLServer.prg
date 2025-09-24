
define class Din_EntidadORDENDESERVICIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ORDENDESERVICIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_ODSPK'
	cTablaPrincipal = 'ORDENSERV'
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
			local  lxOrdenservFectrans, lxOrdenservFecimpo, lxOrdenservFmodifw, lxOrdenservFaltafw, lxOrdenservFecexpo, lxOrdenservZadsfw, lxOrdenservEsttrans, lxOrdenservBdmodifw, lxOrdenservHoraimpo, lxOrdenservHaltafw, lxOrdenservUmodifw, lxOrdenservUaltafw, lxOrdenservSmodifw, lxOrdenservHoraexpo, lxOrdenservHmodifw, lxOrdenservSaltafw, lxOrdenservValtafw, lxOrdenservVmodifw, lxOrdenservTipagrupub, lxOrdenservAnulado, lxOrdenservFecadic1, lxOrdenservFecha, lxOrdenservCliente, lxOrdenservVendedor, lxOrdenservOsart, lxOrdenservObs, lxOrdenservFecadic2, lxOrdenservFechaent, lxOrdenservDescclient, lxOrdenservDescvend, lxOrdenservOscolor, lxOrdenservCodigo, lxOrdenservFecadic3, lxOrdenservGuidpresup, lxOrdenservLetrapresu, lxOrdenservNumpresup, lxOrdenservPvpresup, lxOrdenservIdcent, lxOrdenservTipoorden, lxOrdenservOstalle, lxOrdenservNrofac, lxOrdenservSucursal, lxOrdenservEstado, lxOrdenservEntadic1, lxOrdenservFechafac, lxOrdenservValor, lxOrdenservBdaltafw, lxOrdenservEntadic2, lxOrdenservEntadic3
				lxOrdenservFectrans =  .Fechatransferencia			lxOrdenservFecimpo =  .Fechaimpo			lxOrdenservFmodifw =  .Fechamodificacionfw			lxOrdenservFaltafw =  .Fechaaltafw			lxOrdenservFecexpo =  .Fechaexpo			lxOrdenservZadsfw =  .Zadsfw			lxOrdenservEsttrans =  .Estadotransferencia			lxOrdenservBdmodifw =  .Basededatosmodificacionfw			lxOrdenservHoraimpo =  .Horaimpo			lxOrdenservHaltafw =  .Horaaltafw			lxOrdenservUmodifw =  .Usuariomodificacionfw			lxOrdenservUaltafw =  .Usuarioaltafw			lxOrdenservSmodifw =  .Seriemodificacionfw			lxOrdenservHoraexpo =  .Horaexpo			lxOrdenservHmodifw =  .Horamodificacionfw			lxOrdenservSaltafw =  .Seriealtafw			lxOrdenservValtafw =  .Versionaltafw			lxOrdenservVmodifw =  .Versionmodificacionfw			lxOrdenservTipagrupub =  .Tipoagrupamientopublicaciones			lxOrdenservAnulado =  .Anulado			lxOrdenservFecadic1 =  .Fechaadicional1			lxOrdenservFecha =  .Fecha			lxOrdenservCliente =  upper( .Cliente_PK ) 			lxOrdenservVendedor =  upper( .Vendedor_PK ) 			lxOrdenservOsart =  upper( .Articulo_PK ) 			lxOrdenservObs =  .Obs			lxOrdenservFecadic2 =  .Fechaadicional2			lxOrdenservFechaent =  .Fechaentrega			lxOrdenservDescclient =  .Clientedescripcion			lxOrdenservDescvend =  .Vendedordescripcion			lxOrdenservOscolor =  upper( .Color_PK ) 			lxOrdenservCodigo =  .Codigo			lxOrdenservFecadic3 =  .Fechaadicional3			lxOrdenservGuidpresup =  .Guidpresupuesto			lxOrdenservLetrapresu =  .Letrapresupuesto			lxOrdenservNumpresup =  .Numeropresupuesto			lxOrdenservPvpresup =  .Ptovtapresupuesto			lxOrdenservIdcent =  .Idglobalcliente			lxOrdenservTipoorden =  upper( .TipoDeOrden_PK ) 			lxOrdenservOstalle =  upper( .Talle_PK ) 			lxOrdenservNrofac =  .Nrofactura			lxOrdenservSucursal =  upper( .Sucursal_PK ) 			lxOrdenservEstado =  upper( .Estado_PK ) 			lxOrdenservEntadic1 =  upper( .EntidadAdicional1_PK ) 			lxOrdenservFechafac =  .Fechafactura			lxOrdenservValor =  .Valor			lxOrdenservBdaltafw =  .Basededatosaltafw			lxOrdenservEntadic2 =  upper( .EntidadAdicional2_PK ) 			lxOrdenservEntadic3 =  upper( .EntidadAdicional3_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxOrdenservCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ORDENSERV ( "Fectrans","Fecimpo","Fmodifw","Faltafw","Fecexpo","Zadsfw","Esttrans","Bdmodifw","Horaimpo","Haltafw","Umodifw","Ualtafw","Smodifw","Horaexpo","Hmodifw","Saltafw","Valtafw","Vmodifw","Tipagrupub","Anulado","Fecadic1","Fecha","Cliente","Vendedor","Osart","Obs","Fecadic2","Fechaent","Descclient","Descvend","Oscolor","Codigo","Fecadic3","Guidpresup","Letrapresu","Numpresup","Pvpresup","Idcent","Tipoorden","Ostalle","Nrofac","Sucursal","Estado","Entadic1","Fechafac","Valor","Bdaltafw","Entadic2","Entadic3" ) values ( <<"'" + this.ConvertirDateSql( lxOrdenservFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservVmodifw ) + "'" >>, <<lxOrdenservTipagrupub >>, <<iif( lxOrdenservAnulado, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecadic1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservOsart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservObs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecadic2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFechaent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservDescclient ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservDescvend ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservOscolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecadic3 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservGuidpresup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservLetrapresu ) + "'" >>, <<lxOrdenservNumpresup >>, <<lxOrdenservPvpresup >>, <<"'" + this.FormatearTextoSql( lxOrdenservIdcent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservTipoorden ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservOstalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservNrofac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservSucursal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEntadic1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFechafac ) + "'" >>, <<lxOrdenservValor >>, <<"'" + this.FormatearTextoSql( lxOrdenservBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEntadic2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEntadic3 ) + "'" >> )
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
			for each loItem in this.oEntidad.DetalleCodigoDeServicio
				if this.oEntidad.DetalleCodigoDeServicio.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoserv_PK = loItem.Codigoserv_PK
					lxDescripcion = loItem.Descripcion
					lxNota = loItem.Nota
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CodServDet("NROITEM","CodServ","Descri","Nota","Cod" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodigoserv_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxNota ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubODS("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			this.GenerarSentenciasComponentes()
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxOrdenservFectrans, lxOrdenservFecimpo, lxOrdenservFmodifw, lxOrdenservFaltafw, lxOrdenservFecexpo, lxOrdenservZadsfw, lxOrdenservEsttrans, lxOrdenservBdmodifw, lxOrdenservHoraimpo, lxOrdenservHaltafw, lxOrdenservUmodifw, lxOrdenservUaltafw, lxOrdenservSmodifw, lxOrdenservHoraexpo, lxOrdenservHmodifw, lxOrdenservSaltafw, lxOrdenservValtafw, lxOrdenservVmodifw, lxOrdenservTipagrupub, lxOrdenservAnulado, lxOrdenservFecadic1, lxOrdenservFecha, lxOrdenservCliente, lxOrdenservVendedor, lxOrdenservOsart, lxOrdenservObs, lxOrdenservFecadic2, lxOrdenservFechaent, lxOrdenservDescclient, lxOrdenservDescvend, lxOrdenservOscolor, lxOrdenservCodigo, lxOrdenservFecadic3, lxOrdenservGuidpresup, lxOrdenservLetrapresu, lxOrdenservNumpresup, lxOrdenservPvpresup, lxOrdenservIdcent, lxOrdenservTipoorden, lxOrdenservOstalle, lxOrdenservNrofac, lxOrdenservSucursal, lxOrdenservEstado, lxOrdenservEntadic1, lxOrdenservFechafac, lxOrdenservValor, lxOrdenservBdaltafw, lxOrdenservEntadic2, lxOrdenservEntadic3
				lxOrdenservFectrans =  .Fechatransferencia			lxOrdenservFecimpo =  .Fechaimpo			lxOrdenservFmodifw =  .Fechamodificacionfw			lxOrdenservFaltafw =  .Fechaaltafw			lxOrdenservFecexpo =  .Fechaexpo			lxOrdenservZadsfw =  .Zadsfw			lxOrdenservEsttrans =  .Estadotransferencia			lxOrdenservBdmodifw =  .Basededatosmodificacionfw			lxOrdenservHoraimpo =  .Horaimpo			lxOrdenservHaltafw =  .Horaaltafw			lxOrdenservUmodifw =  .Usuariomodificacionfw			lxOrdenservUaltafw =  .Usuarioaltafw			lxOrdenservSmodifw =  .Seriemodificacionfw			lxOrdenservHoraexpo =  .Horaexpo			lxOrdenservHmodifw =  .Horamodificacionfw			lxOrdenservSaltafw =  .Seriealtafw			lxOrdenservValtafw =  .Versionaltafw			lxOrdenservVmodifw =  .Versionmodificacionfw			lxOrdenservTipagrupub =  .Tipoagrupamientopublicaciones			lxOrdenservAnulado =  .Anulado			lxOrdenservFecadic1 =  .Fechaadicional1			lxOrdenservFecha =  .Fecha			lxOrdenservCliente =  upper( .Cliente_PK ) 			lxOrdenservVendedor =  upper( .Vendedor_PK ) 			lxOrdenservOsart =  upper( .Articulo_PK ) 			lxOrdenservObs =  .Obs			lxOrdenservFecadic2 =  .Fechaadicional2			lxOrdenservFechaent =  .Fechaentrega			lxOrdenservDescclient =  .Clientedescripcion			lxOrdenservDescvend =  .Vendedordescripcion			lxOrdenservOscolor =  upper( .Color_PK ) 			lxOrdenservCodigo =  .Codigo			lxOrdenservFecadic3 =  .Fechaadicional3			lxOrdenservGuidpresup =  .Guidpresupuesto			lxOrdenservLetrapresu =  .Letrapresupuesto			lxOrdenservNumpresup =  .Numeropresupuesto			lxOrdenservPvpresup =  .Ptovtapresupuesto			lxOrdenservIdcent =  .Idglobalcliente			lxOrdenservTipoorden =  upper( .TipoDeOrden_PK ) 			lxOrdenservOstalle =  upper( .Talle_PK ) 			lxOrdenservNrofac =  .Nrofactura			lxOrdenservSucursal =  upper( .Sucursal_PK ) 			lxOrdenservEstado =  upper( .Estado_PK ) 			lxOrdenservEntadic1 =  upper( .EntidadAdicional1_PK ) 			lxOrdenservFechafac =  .Fechafactura			lxOrdenservValor =  .Valor			lxOrdenservBdaltafw =  .Basededatosaltafw			lxOrdenservEntadic2 =  upper( .EntidadAdicional2_PK ) 			lxOrdenservEntadic3 =  upper( .EntidadAdicional3_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ORDENSERV set "Fectrans" = <<"'" + this.ConvertirDateSql( lxOrdenservFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxOrdenservFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxOrdenservFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxOrdenservFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxOrdenservFecexpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxOrdenservZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxOrdenservEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxOrdenservHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxOrdenservHaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxOrdenservUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservSmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxOrdenservHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxOrdenservSaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxOrdenservValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservVmodifw ) + "'">>,"Tipagrupub" = <<lxOrdenservTipagrupub>>,"Anulado" = <<iif( lxOrdenservAnulado, 1, 0 )>>,"Fecadic1" = <<"'" + this.ConvertirDateSql( lxOrdenservFecadic1 ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxOrdenservFecha ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxOrdenservCliente ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxOrdenservVendedor ) + "'">>,"Osart" = <<"'" + this.FormatearTextoSql( lxOrdenservOsart ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxOrdenservObs ) + "'">>,"Fecadic2" = <<"'" + this.ConvertirDateSql( lxOrdenservFecadic2 ) + "'">>,"Fechaent" = <<"'" + this.ConvertirDateSql( lxOrdenservFechaent ) + "'">>,"Descclient" = <<"'" + this.FormatearTextoSql( lxOrdenservDescclient ) + "'">>,"Descvend" = <<"'" + this.FormatearTextoSql( lxOrdenservDescvend ) + "'">>,"Oscolor" = <<"'" + this.FormatearTextoSql( lxOrdenservOscolor ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenservCodigo ) + "'">>,"Fecadic3" = <<"'" + this.ConvertirDateSql( lxOrdenservFecadic3 ) + "'">>,"Guidpresup" = <<"'" + this.FormatearTextoSql( lxOrdenservGuidpresup ) + "'">>,"Letrapresu" = <<"'" + this.FormatearTextoSql( lxOrdenservLetrapresu ) + "'">>,"Numpresup" = <<lxOrdenservNumpresup>>,"Pvpresup" = <<lxOrdenservPvpresup>>,"Idcent" = <<"'" + this.FormatearTextoSql( lxOrdenservIdcent ) + "'">>,"Tipoorden" = <<"'" + this.FormatearTextoSql( lxOrdenservTipoorden ) + "'">>,"Ostalle" = <<"'" + this.FormatearTextoSql( lxOrdenservOstalle ) + "'">>,"Nrofac" = <<"'" + this.FormatearTextoSql( lxOrdenservNrofac ) + "'">>,"Sucursal" = <<"'" + this.FormatearTextoSql( lxOrdenservSucursal ) + "'">>,"Estado" = <<"'" + this.FormatearTextoSql( lxOrdenservEstado ) + "'">>,"Entadic1" = <<"'" + this.FormatearTextoSql( lxOrdenservEntadic1 ) + "'">>,"Fechafac" = <<"'" + this.ConvertirDateSql( lxOrdenservFechafac ) + "'">>,"Valor" = <<lxOrdenservValor>>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOrdenservBdaltafw ) + "'">>,"Entadic2" = <<"'" + this.FormatearTextoSql( lxOrdenservEntadic2 ) + "'">>,"Entadic3" = <<"'" + this.FormatearTextoSql( lxOrdenservEntadic3 ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenservCodigo ) + "'">> and  ORDENSERV.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CodServDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubODS where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleCodigoDeServicio
				if this.oEntidad.DetalleCodigoDeServicio.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoserv_PK = loItem.Codigoserv_PK
					lxDescripcion = loItem.Descripcion
					lxNota = loItem.Nota
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CodServDet("NROITEM","CodServ","Descri","Nota","Cod" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodigoserv_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxNota ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubODS("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.ORDENSERV where " + this.ConvertirFuncionesSql( " ORDENSERV.CODIGO != ''" ) )
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
			Local lxOrdenservCodigo
			lxOrdenservCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecadic1" as "Fechaadicional1", "Fecha" as "Fecha", "Cliente" as "Cliente", "Vendedor" as "Vendedor", "Osart" as "Articulo", "Obs" as "Obs", "Fecadic2" as "Fechaadicional2", "Fechaent" as "Fechaentrega", "Descclient" as "Clientedescripcion", "Descvend" as "Vendedordescripcion", "Oscolor" as "Color", "Codigo" as "Codigo", "Fecadic3" as "Fechaadicional3", "Guidpresup" as "Guidpresupuesto", "Letrapresu" as "Letrapresupuesto", "Numpresup" as "Numeropresupuesto", "Pvpresup" as "Ptovtapresupuesto", "Idcent" as "Idglobalcliente", "Tipoorden" as "Tipodeorden", "Ostalle" as "Talle", "Nrofac" as "Nrofactura", "Sucursal" as "Sucursal", "Estado" as "Estado", "Entadic1" as "Entidadadicional1", "Fechafac" as "Fechafactura", "Valor" as "Valor", "Bdaltafw" as "Basededatosaltafw", "Entadic2" as "Entidadadicional2", "Entadic3" as "Entidadadicional3" from ZooLogic.ORDENSERV where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenservCodigo ) + "'">> and  ORDENSERV.CODIGO != ''
			endtext
			use in select('c_ORDENDESERVICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDESERVICIO', set( 'Datasession' ) )

			if reccount( 'c_ORDENDESERVICIO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codserv" as "Codigoserv", "Descri" as "Descripcion", "Nota" as "Nota", "Cod" as "Codigo" from ZooLogic.CodServDet where Cod = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCodigoDeServicio')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCodigoDeServicio', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCodigoDeServicio
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubODS where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxOrdenservCodigo as Variant
		llRetorno = .t.
		lxOrdenservCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ORDENSERV where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenservCodigo ) + "'">> and  ORDENSERV.CODIGO != ''
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecadic1" as "Fechaadicional1", "Fecha" as "Fecha", "Cliente" as "Cliente", "Vendedor" as "Vendedor", "Osart" as "Articulo", "Obs" as "Obs", "Fecadic2" as "Fechaadicional2", "Fechaent" as "Fechaentrega", "Descclient" as "Clientedescripcion", "Descvend" as "Vendedordescripcion", "Oscolor" as "Color", "Codigo" as "Codigo", "Fecadic3" as "Fechaadicional3", "Guidpresup" as "Guidpresupuesto", "Letrapresu" as "Letrapresupuesto", "Numpresup" as "Numeropresupuesto", "Pvpresup" as "Ptovtapresupuesto", "Idcent" as "Idglobalcliente", "Tipoorden" as "Tipodeorden", "Ostalle" as "Talle", "Nrofac" as "Nrofactura", "Sucursal" as "Sucursal", "Estado" as "Estado", "Entadic1" as "Entidadadicional1", "Fechafac" as "Fechafactura", "Valor" as "Valor", "Bdaltafw" as "Basededatosaltafw", "Entadic2" as "Entidadadicional2", "Entadic3" as "Entidadadicional3" from ZooLogic.ORDENSERV where  ORDENSERV.CODIGO != '' order by Codigo
			endtext
			use in select('c_ORDENDESERVICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDESERVICIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codserv" as "Codigoserv", "Descri" as "Descripcion", "Nota" as "Nota", "Cod" as "Codigo" from ZooLogic.CodServDet where Cod = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCodigoDeServicio')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCodigoDeServicio', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCodigoDeServicio
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubODS where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecadic1" as "Fechaadicional1", "Fecha" as "Fecha", "Cliente" as "Cliente", "Vendedor" as "Vendedor", "Osart" as "Articulo", "Obs" as "Obs", "Fecadic2" as "Fechaadicional2", "Fechaent" as "Fechaentrega", "Descclient" as "Clientedescripcion", "Descvend" as "Vendedordescripcion", "Oscolor" as "Color", "Codigo" as "Codigo", "Fecadic3" as "Fechaadicional3", "Guidpresup" as "Guidpresupuesto", "Letrapresu" as "Letrapresupuesto", "Numpresup" as "Numeropresupuesto", "Pvpresup" as "Ptovtapresupuesto", "Idcent" as "Idglobalcliente", "Tipoorden" as "Tipodeorden", "Ostalle" as "Talle", "Nrofac" as "Nrofactura", "Sucursal" as "Sucursal", "Estado" as "Estado", "Entadic1" as "Entidadadicional1", "Fechafac" as "Fechafactura", "Valor" as "Valor", "Bdaltafw" as "Basededatosaltafw", "Entadic2" as "Entidadadicional2", "Entadic3" as "Entidadadicional3" from ZooLogic.ORDENSERV where  funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ORDENSERV.CODIGO != '' order by Codigo
			endtext
			use in select('c_ORDENDESERVICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDESERVICIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codserv" as "Codigoserv", "Descri" as "Descripcion", "Nota" as "Nota", "Cod" as "Codigo" from ZooLogic.CodServDet where Cod = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCodigoDeServicio')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCodigoDeServicio', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCodigoDeServicio
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubODS where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecadic1" as "Fechaadicional1", "Fecha" as "Fecha", "Cliente" as "Cliente", "Vendedor" as "Vendedor", "Osart" as "Articulo", "Obs" as "Obs", "Fecadic2" as "Fechaadicional2", "Fechaent" as "Fechaentrega", "Descclient" as "Clientedescripcion", "Descvend" as "Vendedordescripcion", "Oscolor" as "Color", "Codigo" as "Codigo", "Fecadic3" as "Fechaadicional3", "Guidpresup" as "Guidpresupuesto", "Letrapresu" as "Letrapresupuesto", "Numpresup" as "Numeropresupuesto", "Pvpresup" as "Ptovtapresupuesto", "Idcent" as "Idglobalcliente", "Tipoorden" as "Tipodeorden", "Ostalle" as "Talle", "Nrofac" as "Nrofactura", "Sucursal" as "Sucursal", "Estado" as "Estado", "Entadic1" as "Entidadadicional1", "Fechafac" as "Fechafactura", "Valor" as "Valor", "Bdaltafw" as "Basededatosaltafw", "Entadic2" as "Entidadadicional2", "Entadic3" as "Entidadadicional3" from ZooLogic.ORDENSERV where  funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ORDENSERV.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_ORDENDESERVICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDESERVICIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codserv" as "Codigoserv", "Descri" as "Descripcion", "Nota" as "Nota", "Cod" as "Codigo" from ZooLogic.CodServDet where Cod = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCodigoDeServicio')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCodigoDeServicio', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCodigoDeServicio
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubODS where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecadic1" as "Fechaadicional1", "Fecha" as "Fecha", "Cliente" as "Cliente", "Vendedor" as "Vendedor", "Osart" as "Articulo", "Obs" as "Obs", "Fecadic2" as "Fechaadicional2", "Fechaent" as "Fechaentrega", "Descclient" as "Clientedescripcion", "Descvend" as "Vendedordescripcion", "Oscolor" as "Color", "Codigo" as "Codigo", "Fecadic3" as "Fechaadicional3", "Guidpresup" as "Guidpresupuesto", "Letrapresu" as "Letrapresupuesto", "Numpresup" as "Numeropresupuesto", "Pvpresup" as "Ptovtapresupuesto", "Idcent" as "Idglobalcliente", "Tipoorden" as "Tipodeorden", "Ostalle" as "Talle", "Nrofac" as "Nrofactura", "Sucursal" as "Sucursal", "Estado" as "Estado", "Entadic1" as "Entidadadicional1", "Fechafac" as "Fechafactura", "Valor" as "Valor", "Bdaltafw" as "Basededatosaltafw", "Entadic2" as "Entidadadicional2", "Entadic3" as "Entidadadicional3" from ZooLogic.ORDENSERV where  ORDENSERV.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_ORDENDESERVICIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDESERVICIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codserv" as "Codigoserv", "Descri" as "Descripcion", "Nota" as "Nota", "Cod" as "Codigo" from ZooLogic.CodServDet where Cod = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleCodigoDeServicio')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleCodigoDeServicio', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleCodigoDeServicio
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubODS where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDESERVICIO.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecimpo,Fmodifw,Faltafw,Fecexpo,Zadsfw,Esttrans,Bdmodifw,Horaimpo,Haltafw,Umodifw,U" + ;
"altafw,Smodifw,Horaexpo,Hmodifw,Saltafw,Valtafw,Vmodifw,Tipagrupub,Anulado,Fecadic1,Fecha,Cliente,Ve" + ;
"ndedor,Osart,Obs,Fecadic2,Fechaent,Descclient,Descvend,Oscolor,Codigo,Fecadic3,Guidpresup,Letrapresu" + ;
",Numpresup,Pvpresup,Idcent,Tipoorden,Ostalle,Nrofac,Sucursal,Estado,Entadic1,Fechafac,Valor,Bdaltafw" + ;
",Entadic2,Entadic3" + ;
" from ZooLogic.ORDENSERV where  ORDENSERV.CODIGO != '' and " + lcFiltro )
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
			local  lxOrdenservFectrans, lxOrdenservFecimpo, lxOrdenservFmodifw, lxOrdenservFaltafw, lxOrdenservFecexpo, lxOrdenservZadsfw, lxOrdenservEsttrans, lxOrdenservBdmodifw, lxOrdenservHoraimpo, lxOrdenservHaltafw, lxOrdenservUmodifw, lxOrdenservUaltafw, lxOrdenservSmodifw, lxOrdenservHoraexpo, lxOrdenservHmodifw, lxOrdenservSaltafw, lxOrdenservValtafw, lxOrdenservVmodifw, lxOrdenservTipagrupub, lxOrdenservAnulado, lxOrdenservFecadic1, lxOrdenservFecha, lxOrdenservCliente, lxOrdenservVendedor, lxOrdenservOsart, lxOrdenservObs, lxOrdenservFecadic2, lxOrdenservFechaent, lxOrdenservDescclient, lxOrdenservDescvend, lxOrdenservOscolor, lxOrdenservCodigo, lxOrdenservFecadic3, lxOrdenservGuidpresup, lxOrdenservLetrapresu, lxOrdenservNumpresup, lxOrdenservPvpresup, lxOrdenservIdcent, lxOrdenservTipoorden, lxOrdenservOstalle, lxOrdenservNrofac, lxOrdenservSucursal, lxOrdenservEstado, lxOrdenservEntadic1, lxOrdenservFechafac, lxOrdenservValor, lxOrdenservBdaltafw, lxOrdenservEntadic2, lxOrdenservEntadic3
				lxOrdenservFectrans = ctod( '  /  /    ' )			lxOrdenservFecimpo = ctod( '  /  /    ' )			lxOrdenservFmodifw = ctod( '  /  /    ' )			lxOrdenservFaltafw = ctod( '  /  /    ' )			lxOrdenservFecexpo = ctod( '  /  /    ' )			lxOrdenservZadsfw = []			lxOrdenservEsttrans = []			lxOrdenservBdmodifw = []			lxOrdenservHoraimpo = []			lxOrdenservHaltafw = []			lxOrdenservUmodifw = []			lxOrdenservUaltafw = []			lxOrdenservSmodifw = []			lxOrdenservHoraexpo = []			lxOrdenservHmodifw = []			lxOrdenservSaltafw = []			lxOrdenservValtafw = []			lxOrdenservVmodifw = []			lxOrdenservTipagrupub = 0			lxOrdenservAnulado = .F.			lxOrdenservFecadic1 = ctod( '  /  /    ' )			lxOrdenservFecha = ctod( '  /  /    ' )			lxOrdenservCliente = []			lxOrdenservVendedor = []			lxOrdenservOsart = []			lxOrdenservObs = []			lxOrdenservFecadic2 = ctod( '  /  /    ' )			lxOrdenservFechaent = ctod( '  /  /    ' )			lxOrdenservDescclient = []			lxOrdenservDescvend = []			lxOrdenservOscolor = []			lxOrdenservCodigo = []			lxOrdenservFecadic3 = ctod( '  /  /    ' )			lxOrdenservGuidpresup = []			lxOrdenservLetrapresu = []			lxOrdenservNumpresup = 0			lxOrdenservPvpresup = 0			lxOrdenservIdcent = []			lxOrdenservTipoorden = []			lxOrdenservOstalle = []			lxOrdenservNrofac = []			lxOrdenservSucursal = []			lxOrdenservEstado = []			lxOrdenservEntadic1 = []			lxOrdenservFechafac = ctod( '  /  /    ' )			lxOrdenservValor = 0			lxOrdenservBdaltafw = []			lxOrdenservEntadic2 = []			lxOrdenservEntadic3 = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CodServDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubODS where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ORDENSERV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ORDENSERV' + '_' + tcCampo
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
		lcWhere = " Where  ORDENSERV.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecadic1" as "Fechaadicional1", "Fecha" as "Fecha", "Cliente" as "Cliente", "Vendedor" as "Vendedor", "Osart" as "Articulo", "Obs" as "Obs", "Fecadic2" as "Fechaadicional2", "Fechaent" as "Fechaentrega", "Descclient" as "Clientedescripcion", "Descvend" as "Vendedordescripcion", "Oscolor" as "Color", "Codigo" as "Codigo", "Fecadic3" as "Fechaadicional3", "Guidpresup" as "Guidpresupuesto", "Letrapresu" as "Letrapresupuesto", "Numpresup" as "Numeropresupuesto", "Pvpresup" as "Ptovtapresupuesto", "Idcent" as "Idglobalcliente", "Tipoorden" as "Tipodeorden", "Ostalle" as "Talle", "Nrofac" as "Nrofactura", "Sucursal" as "Sucursal", "Estado" as "Estado", "Entadic1" as "Entidadadicional1", "Fechafac" as "Fechafactura", "Valor" as "Valor", "Bdaltafw" as "Basededatosaltafw", "Entadic2" as "Entidadadicional2", "Entadic3" as "Entidadadicional3"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ORDENSERV', '', tnTope )
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
	Function ObtenerDatosDetalleDetalleInteracciones( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  . != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleInteracciones( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, '', 'DetalleInteracciones', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleInteracciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleInteracciones( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleCodigoDeServicio( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CODSERVDET.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codserv" as "Codigoserv", "Descri" as "Descripcion", "Nota" as "Nota", "Cod" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleCodigoDeServicio( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CodServDet', 'DetalleCodigoDeServicio', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleCodigoDeServicio( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleCodigoDeServicio( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBODS.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubODS', 'AgruPubliDetalle', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'FECHAADICIONAL1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECADIC1 AS FECHAADICIONAL1'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OSART AS ARTICULO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'FECHAADICIONAL2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECADIC2 AS FECHAADICIONAL2'
				Case lcAtributo == 'FECHAENTREGA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAENT AS FECHAENTREGA'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCCLIENT AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'VENDEDORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCVEND AS VENDEDORDESCRIPCION'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OSCOLOR AS COLOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHAADICIONAL3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECADIC3 AS FECHAADICIONAL3'
				Case lcAtributo == 'GUIDPRESUPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDPRESUP AS GUIDPRESUPUESTO'
				Case lcAtributo == 'LETRAPRESUPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRAPRESU AS LETRAPRESUPUESTO'
				Case lcAtributo == 'NUMEROPRESUPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMPRESUP AS NUMEROPRESUPUESTO'
				Case lcAtributo == 'PTOVTAPRESUPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PVPRESUP AS PTOVTAPRESUPUESTO'
				Case lcAtributo == 'IDGLOBALCLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCENT AS IDGLOBALCLIENTE'
				Case lcAtributo == 'TIPODEORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOORDEN AS TIPODEORDEN'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OSTALLE AS TALLE'
				Case lcAtributo == 'NROFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROFAC AS NROFACTURA'
				Case lcAtributo == 'SUCURSAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCURSAL AS SUCURSAL'
				Case lcAtributo == 'ESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADO'
				Case lcAtributo == 'ENTIDADADICIONAL1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTADIC1 AS ENTIDADADICIONAL1'
				Case lcAtributo == 'FECHAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAFAC AS FECHAFACTURA'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ENTIDADADICIONAL2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTADIC2 AS ENTIDADADICIONAL2'
				Case lcAtributo == 'ENTIDADADICIONAL3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTADIC3 AS ENTIDADADICIONAL3'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleInteracciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleCodigoDeServicio( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGOSERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODSERV AS CODIGOSERV'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRIPCION'
				Case lcAtributo == 'NOTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOTA AS NOTA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAADICIONAL1'
				lcCampo = 'FECADIC1'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'OSART'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAADICIONAL2'
				lcCampo = 'FECADIC2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAENTREGA'
				lcCampo = 'FECHAENT'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'DESCCLIENT'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDORDESCRIPCION'
				lcCampo = 'DESCVEND'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'OSCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAADICIONAL3'
				lcCampo = 'FECADIC3'
			Case upper( alltrim( tcAtributo ) ) == 'GUIDPRESUPUESTO'
				lcCampo = 'GUIDPRESUP'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAPRESUPUESTO'
				lcCampo = 'LETRAPRESU'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROPRESUPUESTO'
				lcCampo = 'NUMPRESUP'
			Case upper( alltrim( tcAtributo ) ) == 'PTOVTAPRESUPUESTO'
				lcCampo = 'PVPRESUP'
			Case upper( alltrim( tcAtributo ) ) == 'IDGLOBALCLIENTE'
				lcCampo = 'IDCENT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEORDEN'
				lcCampo = 'TIPOORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'OSTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'NROFACTURA'
				lcCampo = 'NROFAC'
			Case upper( alltrim( tcAtributo ) ) == 'SUCURSAL'
				lcCampo = 'SUCURSAL'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADO'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADADICIONAL1'
				lcCampo = 'ENTADIC1'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFACTURA'
				lcCampo = 'FECHAFAC'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADADICIONAL2'
				lcCampo = 'ENTADIC2'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADADICIONAL3'
				lcCampo = 'ENTADIC3'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleInteracciones( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleCodigoDeServicio( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOSERV'
				lcCampo = 'CODSERV'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'NOTA'
				lcCampo = 'NOTA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COD'
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
		if upper( alltrim( tcDetalle ) ) == 'DETALLEINTERACCIONES'
			lcRetorno = ''
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLECODIGODESERVICIO'
			lcRetorno = 'CODSERVDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBODS'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxOrdenservFectrans, lxOrdenservFecimpo, lxOrdenservFmodifw, lxOrdenservFaltafw, lxOrdenservFecexpo, lxOrdenservZadsfw, lxOrdenservEsttrans, lxOrdenservBdmodifw, lxOrdenservHoraimpo, lxOrdenservHaltafw, lxOrdenservUmodifw, lxOrdenservUaltafw, lxOrdenservSmodifw, lxOrdenservHoraexpo, lxOrdenservHmodifw, lxOrdenservSaltafw, lxOrdenservValtafw, lxOrdenservVmodifw, lxOrdenservTipagrupub, lxOrdenservAnulado, lxOrdenservFecadic1, lxOrdenservFecha, lxOrdenservCliente, lxOrdenservVendedor, lxOrdenservOsart, lxOrdenservObs, lxOrdenservFecadic2, lxOrdenservFechaent, lxOrdenservDescclient, lxOrdenservDescvend, lxOrdenservOscolor, lxOrdenservCodigo, lxOrdenservFecadic3, lxOrdenservGuidpresup, lxOrdenservLetrapresu, lxOrdenservNumpresup, lxOrdenservPvpresup, lxOrdenservIdcent, lxOrdenservTipoorden, lxOrdenservOstalle, lxOrdenservNrofac, lxOrdenservSucursal, lxOrdenservEstado, lxOrdenservEntadic1, lxOrdenservFechafac, lxOrdenservValor, lxOrdenservBdaltafw, lxOrdenservEntadic2, lxOrdenservEntadic3
				lxOrdenservFectrans =  .Fechatransferencia			lxOrdenservFecimpo =  .Fechaimpo			lxOrdenservFmodifw =  .Fechamodificacionfw			lxOrdenservFaltafw =  .Fechaaltafw			lxOrdenservFecexpo =  .Fechaexpo			lxOrdenservZadsfw =  .Zadsfw			lxOrdenservEsttrans =  .Estadotransferencia			lxOrdenservBdmodifw =  .Basededatosmodificacionfw			lxOrdenservHoraimpo =  .Horaimpo			lxOrdenservHaltafw =  .Horaaltafw			lxOrdenservUmodifw =  .Usuariomodificacionfw			lxOrdenservUaltafw =  .Usuarioaltafw			lxOrdenservSmodifw =  .Seriemodificacionfw			lxOrdenservHoraexpo =  .Horaexpo			lxOrdenservHmodifw =  .Horamodificacionfw			lxOrdenservSaltafw =  .Seriealtafw			lxOrdenservValtafw =  .Versionaltafw			lxOrdenservVmodifw =  .Versionmodificacionfw			lxOrdenservTipagrupub =  .Tipoagrupamientopublicaciones			lxOrdenservAnulado =  .Anulado			lxOrdenservFecadic1 =  .Fechaadicional1			lxOrdenservFecha =  .Fecha			lxOrdenservCliente =  upper( .Cliente_PK ) 			lxOrdenservVendedor =  upper( .Vendedor_PK ) 			lxOrdenservOsart =  upper( .Articulo_PK ) 			lxOrdenservObs =  .Obs			lxOrdenservFecadic2 =  .Fechaadicional2			lxOrdenservFechaent =  .Fechaentrega			lxOrdenservDescclient =  .Clientedescripcion			lxOrdenservDescvend =  .Vendedordescripcion			lxOrdenservOscolor =  upper( .Color_PK ) 			lxOrdenservCodigo =  .Codigo			lxOrdenservFecadic3 =  .Fechaadicional3			lxOrdenservGuidpresup =  .Guidpresupuesto			lxOrdenservLetrapresu =  .Letrapresupuesto			lxOrdenservNumpresup =  .Numeropresupuesto			lxOrdenservPvpresup =  .Ptovtapresupuesto			lxOrdenservIdcent =  .Idglobalcliente			lxOrdenservTipoorden =  upper( .TipoDeOrden_PK ) 			lxOrdenservOstalle =  upper( .Talle_PK ) 			lxOrdenservNrofac =  .Nrofactura			lxOrdenservSucursal =  upper( .Sucursal_PK ) 			lxOrdenservEstado =  upper( .Estado_PK ) 			lxOrdenservEntadic1 =  upper( .EntidadAdicional1_PK ) 			lxOrdenservFechafac =  .Fechafactura			lxOrdenservValor =  .Valor			lxOrdenservBdaltafw =  .Basededatosaltafw			lxOrdenservEntadic2 =  upper( .EntidadAdicional2_PK ) 			lxOrdenservEntadic3 =  upper( .EntidadAdicional3_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ORDENSERV ( "Fectrans","Fecimpo","Fmodifw","Faltafw","Fecexpo","Zadsfw","Esttrans","Bdmodifw","Horaimpo","Haltafw","Umodifw","Ualtafw","Smodifw","Horaexpo","Hmodifw","Saltafw","Valtafw","Vmodifw","Tipagrupub","Anulado","Fecadic1","Fecha","Cliente","Vendedor","Osart","Obs","Fecadic2","Fechaent","Descclient","Descvend","Oscolor","Codigo","Fecadic3","Guidpresup","Letrapresu","Numpresup","Pvpresup","Idcent","Tipoorden","Ostalle","Nrofac","Sucursal","Estado","Entadic1","Fechafac","Valor","Bdaltafw","Entadic2","Entadic3" ) values ( <<"'" + this.ConvertirDateSql( lxOrdenservFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservVmodifw ) + "'" >>, <<lxOrdenservTipagrupub >>, <<iif( lxOrdenservAnulado, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecadic1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservOsart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservObs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecadic2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFechaent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservDescclient ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservDescvend ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservOscolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFecadic3 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservGuidpresup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservLetrapresu ) + "'" >>, <<lxOrdenservNumpresup >>, <<lxOrdenservPvpresup >>, <<"'" + this.FormatearTextoSql( lxOrdenservIdcent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservTipoorden ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservOstalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservNrofac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservSucursal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEntadic1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenservFechafac ) + "'" >>, <<lxOrdenservValor >>, <<"'" + this.FormatearTextoSql( lxOrdenservBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEntadic2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenservEntadic3 ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ORDENSERV' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleCodigoDeServicio
				if this.oEntidad.DetalleCodigoDeServicio.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoserv_PK = loItem.Codigoserv_PK
					lxDescripcion = loItem.Descripcion
					lxNota = loItem.Nota
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CodServDet("NROITEM","CodServ","Descri","Nota","Cod" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodigoserv_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxNota ) + "'">>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubODS("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxOrdenservFectrans, lxOrdenservFecimpo, lxOrdenservFmodifw, lxOrdenservFaltafw, lxOrdenservFecexpo, lxOrdenservZadsfw, lxOrdenservEsttrans, lxOrdenservBdmodifw, lxOrdenservHoraimpo, lxOrdenservHaltafw, lxOrdenservUmodifw, lxOrdenservUaltafw, lxOrdenservSmodifw, lxOrdenservHoraexpo, lxOrdenservHmodifw, lxOrdenservSaltafw, lxOrdenservValtafw, lxOrdenservVmodifw, lxOrdenservTipagrupub, lxOrdenservAnulado, lxOrdenservFecadic1, lxOrdenservFecha, lxOrdenservCliente, lxOrdenservVendedor, lxOrdenservOsart, lxOrdenservObs, lxOrdenservFecadic2, lxOrdenservFechaent, lxOrdenservDescclient, lxOrdenservDescvend, lxOrdenservOscolor, lxOrdenservCodigo, lxOrdenservFecadic3, lxOrdenservGuidpresup, lxOrdenservLetrapresu, lxOrdenservNumpresup, lxOrdenservPvpresup, lxOrdenservIdcent, lxOrdenservTipoorden, lxOrdenservOstalle, lxOrdenservNrofac, lxOrdenservSucursal, lxOrdenservEstado, lxOrdenservEntadic1, lxOrdenservFechafac, lxOrdenservValor, lxOrdenservBdaltafw, lxOrdenservEntadic2, lxOrdenservEntadic3
				lxOrdenservFectrans =  .Fechatransferencia			lxOrdenservFecimpo =  .Fechaimpo			lxOrdenservFmodifw =  .Fechamodificacionfw			lxOrdenservFaltafw =  .Fechaaltafw			lxOrdenservFecexpo =  .Fechaexpo			lxOrdenservZadsfw =  .Zadsfw			lxOrdenservEsttrans =  .Estadotransferencia			lxOrdenservBdmodifw =  .Basededatosmodificacionfw			lxOrdenservHoraimpo =  .Horaimpo			lxOrdenservHaltafw =  .Horaaltafw			lxOrdenservUmodifw =  .Usuariomodificacionfw			lxOrdenservUaltafw =  .Usuarioaltafw			lxOrdenservSmodifw =  .Seriemodificacionfw			lxOrdenservHoraexpo =  .Horaexpo			lxOrdenservHmodifw =  .Horamodificacionfw			lxOrdenservSaltafw =  .Seriealtafw			lxOrdenservValtafw =  .Versionaltafw			lxOrdenservVmodifw =  .Versionmodificacionfw			lxOrdenservTipagrupub =  .Tipoagrupamientopublicaciones			lxOrdenservAnulado =  .Anulado			lxOrdenservFecadic1 =  .Fechaadicional1			lxOrdenservFecha =  .Fecha			lxOrdenservCliente =  upper( .Cliente_PK ) 			lxOrdenservVendedor =  upper( .Vendedor_PK ) 			lxOrdenservOsart =  upper( .Articulo_PK ) 			lxOrdenservObs =  .Obs			lxOrdenservFecadic2 =  .Fechaadicional2			lxOrdenservFechaent =  .Fechaentrega			lxOrdenservDescclient =  .Clientedescripcion			lxOrdenservDescvend =  .Vendedordescripcion			lxOrdenservOscolor =  upper( .Color_PK ) 			lxOrdenservCodigo =  .Codigo			lxOrdenservFecadic3 =  .Fechaadicional3			lxOrdenservGuidpresup =  .Guidpresupuesto			lxOrdenservLetrapresu =  .Letrapresupuesto			lxOrdenservNumpresup =  .Numeropresupuesto			lxOrdenservPvpresup =  .Ptovtapresupuesto			lxOrdenservIdcent =  .Idglobalcliente			lxOrdenservTipoorden =  upper( .TipoDeOrden_PK ) 			lxOrdenservOstalle =  upper( .Talle_PK ) 			lxOrdenservNrofac =  .Nrofactura			lxOrdenservSucursal =  upper( .Sucursal_PK ) 			lxOrdenservEstado =  upper( .Estado_PK ) 			lxOrdenservEntadic1 =  upper( .EntidadAdicional1_PK ) 			lxOrdenservFechafac =  .Fechafactura			lxOrdenservValor =  .Valor			lxOrdenservBdaltafw =  .Basededatosaltafw			lxOrdenservEntadic2 =  upper( .EntidadAdicional2_PK ) 			lxOrdenservEntadic3 =  upper( .EntidadAdicional3_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ORDENSERV.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ORDENSERV set "Fectrans" = <<"'" + this.ConvertirDateSql( lxOrdenservFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxOrdenservFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxOrdenservFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxOrdenservFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxOrdenservFecexpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxOrdenservZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxOrdenservEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxOrdenservHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxOrdenservHaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxOrdenservUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservSmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxOrdenservHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxOrdenservSaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxOrdenservValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenservVmodifw ) + "'">>, "Tipagrupub" = <<lxOrdenservTipagrupub>>, "Anulado" = <<iif( lxOrdenservAnulado, 1, 0 )>>, "Fecadic1" = <<"'" + this.ConvertirDateSql( lxOrdenservFecadic1 ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxOrdenservFecha ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxOrdenservCliente ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxOrdenservVendedor ) + "'">>, "Osart" = <<"'" + this.FormatearTextoSql( lxOrdenservOsart ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxOrdenservObs ) + "'">>, "Fecadic2" = <<"'" + this.ConvertirDateSql( lxOrdenservFecadic2 ) + "'">>, "Fechaent" = <<"'" + this.ConvertirDateSql( lxOrdenservFechaent ) + "'">>, "Descclient" = <<"'" + this.FormatearTextoSql( lxOrdenservDescclient ) + "'">>, "Descvend" = <<"'" + this.FormatearTextoSql( lxOrdenservDescvend ) + "'">>, "Oscolor" = <<"'" + this.FormatearTextoSql( lxOrdenservOscolor ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenservCodigo ) + "'">>, "Fecadic3" = <<"'" + this.ConvertirDateSql( lxOrdenservFecadic3 ) + "'">>, "Guidpresup" = <<"'" + this.FormatearTextoSql( lxOrdenservGuidpresup ) + "'">>, "Letrapresu" = <<"'" + this.FormatearTextoSql( lxOrdenservLetrapresu ) + "'">>, "Numpresup" = <<lxOrdenservNumpresup>>, "Pvpresup" = <<lxOrdenservPvpresup>>, "Idcent" = <<"'" + this.FormatearTextoSql( lxOrdenservIdcent ) + "'">>, "Tipoorden" = <<"'" + this.FormatearTextoSql( lxOrdenservTipoorden ) + "'">>, "Ostalle" = <<"'" + this.FormatearTextoSql( lxOrdenservOstalle ) + "'">>, "Nrofac" = <<"'" + this.FormatearTextoSql( lxOrdenservNrofac ) + "'">>, "Sucursal" = <<"'" + this.FormatearTextoSql( lxOrdenservSucursal ) + "'">>, "Estado" = <<"'" + this.FormatearTextoSql( lxOrdenservEstado ) + "'">>, "Entadic1" = <<"'" + this.FormatearTextoSql( lxOrdenservEntadic1 ) + "'">>, "Fechafac" = <<"'" + this.ConvertirDateSql( lxOrdenservFechafac ) + "'">>, "Valor" = <<lxOrdenservValor>>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOrdenservBdaltafw ) + "'">>, "Entadic2" = <<"'" + this.FormatearTextoSql( lxOrdenservEntadic2 ) + "'">>, "Entadic3" = <<"'" + this.FormatearTextoSql( lxOrdenservEntadic3 ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ORDENSERV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CodServDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubODS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleCodigoDeServicio
				if this.oEntidad.DetalleCodigoDeServicio.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoserv_PK = loItem.Codigoserv_PK
					lxDescripcion = loItem.Descripcion
					lxNota = loItem.Nota
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CodServDet("NROITEM","CodServ","Descri","Nota","Cod" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodigoserv_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxNota ) + "'">>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubODS("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ORDENSERV.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.ORDENSERV where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CodServDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubODS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ORDENSERV' 
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
		
			.oCompServiciosalcliente.lNuevo = .EsNuevo()
			.oCompServiciosalcliente.lEdicion = .EsEdicion()
			.oCompServiciosalcliente.lEliminar = .lEliminar
			.oCompServiciosalcliente.lAnular = .lAnular
			loColSentencias = .oCompServiciosalcliente.grabar()
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
			lcRetorno = [update ZooLogic.ORDENSERV set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  ORDENSERV.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ORDENSERV where  ORDENSERV.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ORDENSERV where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ORDENSERV.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDESERVICIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ORDENSERV Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					if this.oEntidad.cContexto == 'C'
						if curSeek.ANULADO
							Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
							this.oConexion.EjecutarSql( [UPDATE ZooLogic.ORDENSERV set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FecAdic1 = ] + "'" + this.ConvertirDateSql( &lcCursor..FecAdic1 ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"+ [, OSArt = ] + "'" + this.FormatearTextoSql( &lcCursor..OSArt ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, FecAdic2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FecAdic2 ) + "'"+ [, FechaEnt = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaEnt ) + "'"+ [, DescClient = ] + "'" + this.FormatearTextoSql( &lcCursor..DescClient ) + "'"+ [, DescVend = ] + "'" + this.FormatearTextoSql( &lcCursor..DescVend ) + "'"+ [, OSColor = ] + "'" + this.FormatearTextoSql( &lcCursor..OSColor ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, FecAdic3 = ] + "'" + this.ConvertirDateSql( &lcCursor..FecAdic3 ) + "'"+ [, GuidPresup = ] + "'" + this.FormatearTextoSql( &lcCursor..GuidPresup ) + "'"+ [, LetraPresu = ] + "'" + this.FormatearTextoSql( &lcCursor..LetraPresu ) + "'"+ [, NumPresup = ] + transform( &lcCursor..NumPresup )+ [, PVPresup = ] + transform( &lcCursor..PVPresup )+ [, IdCent = ] + "'" + this.FormatearTextoSql( &lcCursor..IdCent ) + "'"+ [, TipoOrden = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoOrden ) + "'"+ [, OSTalle = ] + "'" + this.FormatearTextoSql( &lcCursor..OSTalle ) + "'"+ [, NroFac = ] + "'" + this.FormatearTextoSql( &lcCursor..NroFac ) + "'"+ [, Sucursal = ] + "'" + this.FormatearTextoSql( &lcCursor..Sucursal ) + "'"+ [, Estado = ] + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"+ [, EntAdic1 = ] + "'" + this.FormatearTextoSql( &lcCursor..EntAdic1 ) + "'"+ [, FechaFac = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaFac ) + "'"+ [, Valor = ] + transform( &lcCursor..Valor )+ [, EntAdic2 = ] + "'" + this.FormatearTextoSql( &lcCursor..EntAdic2 ) + "'"+ [, EntAdic3 = ] + "'" + this.FormatearTextoSql( &lcCursor..EntAdic3 ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
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
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FECIMPO, FMODIFW, FALTAFW, FECEXPO, ZADSFW, ESTTRANS, BDMODIFW, HORAIMPO, HALTAFW, UMODIFW, UALTAFW, SMODIFW, HORAEXPO, HMODIFW, SALTAFW, VALTAFW, VMODIFW, tipagrupub, Anulado, FecAdic1, Fecha, Cliente, Vendedor, OSArt, Obs, FecAdic2, FechaEnt, DescClient, DescVend, OSColor, Codigo, FecAdic3, GuidPresup, LetraPresu, NumPresup, PVPresup, IdCent, TipoOrden, OSTalle, NroFac, Sucursal, Estado, EntAdic1, FechaFac, Valor, BDAltaFW, EntAdic2, EntAdic3
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecAdic1 ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OSArt ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecAdic2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaEnt ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescClient ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescVend ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OSColor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecAdic3 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GuidPresup ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LetraPresu ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NumPresup ) + ',' + transform( &lcCursor..PVPresup ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdCent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoOrden ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OSTalle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NroFac ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Sucursal ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EntAdic1 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaFac ) + "'" + ',' + transform( &lcCursor..Valor ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EntAdic2 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EntAdic3 ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ORDENSERV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDESERVICIO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CodServDet Where Cod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubODS Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCODSERV'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Cod in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodServ","Descri","Nota","Cod"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CodServDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodServ    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Nota       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cod        ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICODS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubODS ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Identificador: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ORDENDESERVICIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ORDENDESERVICIO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ORDENDESERVICIO_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCODSERV'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICODS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_OrdenServ')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ORDENDESERVICIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ORDENDESERVICIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDESERVICIO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDESERVICIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FecAdic1  
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  FecAdic2  
		* Validar ANTERIORES A 1/1/1753  FechaEnt  
		* Validar ANTERIORES A 1/1/1753  FecAdic3  
		* Validar ANTERIORES A 1/1/1753  FechaFac  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_OrdenServ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_OrdenServ
Create Table ZooLogic.TablaTrabajo_OrdenServ ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"anulado" bit  null, 
"fecadic1" datetime  null, 
"fecha" datetime  null, 
"cliente" char( 10 )  null, 
"vendedor" char( 10 )  null, 
"osart" char( 15 )  null, 
"obs" varchar(max)  null, 
"fecadic2" datetime  null, 
"fechaent" datetime  null, 
"descclient" char( 185 )  null, 
"descvend" char( 60 )  null, 
"oscolor" char( 6 )  null, 
"codigo" char( 20 )  null, 
"fecadic3" datetime  null, 
"guidpresup" char( 38 )  null, 
"letrapresu" char( 1 )  null, 
"numpresup" numeric( 8, 0 )  null, 
"pvpresup" numeric( 4, 0 )  null, 
"idcent" char( 38 )  null, 
"tipoorden" char( 20 )  null, 
"ostalle" char( 5 )  null, 
"nrofac" char( 30 )  null, 
"sucursal" char( 10 )  null, 
"estado" char( 30 )  null, 
"entadic1" char( 10 )  null, 
"fechafac" datetime  null, 
"valor" numeric( 15, 2 )  null, 
"bdaltafw" char( 8 )  null, 
"entadic2" char( 10 )  null, 
"entadic3" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_OrdenServ' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_OrdenServ' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDESERVICIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fecadic1','fecadic1')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('osart','osart')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('fecadic2','fecadic2')
			.AgregarMapeo('fechaent','fechaent')
			.AgregarMapeo('descclient','descclient')
			.AgregarMapeo('descvend','descvend')
			.AgregarMapeo('oscolor','oscolor')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fecadic3','fecadic3')
			.AgregarMapeo('guidpresup','guidpresup')
			.AgregarMapeo('letrapresu','letrapresu')
			.AgregarMapeo('numpresup','numpresup')
			.AgregarMapeo('pvpresup','pvpresup')
			.AgregarMapeo('idcent','idcent')
			.AgregarMapeo('tipoorden','tipoorden')
			.AgregarMapeo('ostalle','ostalle')
			.AgregarMapeo('nrofac','nrofac')
			.AgregarMapeo('sucursal','sucursal')
			.AgregarMapeo('estado','estado')
			.AgregarMapeo('entadic1','entadic1')
			.AgregarMapeo('fechafac','fechafac')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('entadic2','entadic2')
			.AgregarMapeo('entadic3','entadic3')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_OrdenServ'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FECADIC1 = isnull( d.FECADIC1, t.FECADIC1 ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.OSART = isnull( d.OSART, t.OSART ),t.OBS = isnull( d.OBS, t.OBS ),t.FECADIC2 = isnull( d.FECADIC2, t.FECADIC2 ),t.FECHAENT = isnull( d.FECHAENT, t.FECHAENT ),t.DESCCLIENT = isnull( d.DESCCLIENT, t.DESCCLIENT ),t.DESCVEND = isnull( d.DESCVEND, t.DESCVEND ),t.OSCOLOR = isnull( d.OSCOLOR, t.OSCOLOR ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FECADIC3 = isnull( d.FECADIC3, t.FECADIC3 ),t.GUIDPRESUP = isnull( d.GUIDPRESUP, t.GUIDPRESUP ),t.LETRAPRESU = isnull( d.LETRAPRESU, t.LETRAPRESU ),t.NUMPRESUP = isnull( d.NUMPRESUP, t.NUMPRESUP ),t.PVPRESUP = isnull( d.PVPRESUP, t.PVPRESUP ),t.IDCENT = isnull( d.IDCENT, t.IDCENT ),t.TIPOORDEN = isnull( d.TIPOORDEN, t.TIPOORDEN ),t.OSTALLE = isnull( d.OSTALLE, t.OSTALLE ),t.NROFAC = isnull( d.NROFAC, t.NROFAC ),t.SUCURSAL = isnull( d.SUCURSAL, t.SUCURSAL ),t.ESTADO = isnull( d.ESTADO, t.ESTADO ),t.ENTADIC1 = isnull( d.ENTADIC1, t.ENTADIC1 ),t.FECHAFAC = isnull( d.FECHAFAC, t.FECHAFAC ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ENTADIC2 = isnull( d.ENTADIC2, t.ENTADIC2 ),t.ENTADIC3 = isnull( d.ENTADIC3, t.ENTADIC3 )
					from ZooLogic.ORDENSERV t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.ORDENSERV(Fectrans,Fecimpo,Fmodifw,Faltafw,Fecexpo,Zadsfw,Esttrans,Bdmodifw,Horaimpo,Haltafw,Umodifw,Ualtafw,Smodifw,Horaexpo,Hmodifw,Saltafw,Valtafw,Vmodifw,Tipagrupub,Anulado,Fecadic1,Fecha,Cliente,Vendedor,Osart,Obs,Fecadic2,Fechaent,Descclient,Descvend,Oscolor,Codigo,Fecadic3,Guidpresup,Letrapresu,Numpresup,Pvpresup,Idcent,Tipoorden,Ostalle,Nrofac,Sucursal,Estado,Entadic1,Fechafac,Valor,Bdaltafw,Entadic2,Entadic3)
					Select isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.TIPAGRUPUB,0),isnull( d.ANULADO,0),isnull( d.FECADIC1,''),isnull( d.FECHA,''),isnull( d.CLIENTE,''),isnull( d.VENDEDOR,''),isnull( d.OSART,''),isnull( d.OBS,''),isnull( d.FECADIC2,''),isnull( d.FECHAENT,''),isnull( d.DESCCLIENT,''),isnull( d.DESCVEND,''),isnull( d.OSCOLOR,''),isnull( d.CODIGO,''),isnull( d.FECADIC3,''),isnull( d.GUIDPRESUP,''),isnull( d.LETRAPRESU,''),isnull( d.NUMPRESUP,0),isnull( d.PVPRESUP,0),isnull( d.IDCENT,''),isnull( d.TIPOORDEN,''),isnull( d.OSTALLE,''),isnull( d.NROFAC,''),isnull( d.SUCURSAL,''),isnull( d.ESTADO,''),isnull( d.ENTADIC1,''),isnull( d.FECHAFAC,''),isnull( d.VALOR,0),isnull( d.BDALTAFW,''),isnull( d.ENTADIC2,''),isnull( d.ENTADIC3,'')
						From deleted d left join ZooLogic.ORDENSERV pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CodServDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDENSERV_CodServDet
ON ZooLogic.TablaTrabajo_ORDENSERV_CodServDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODSERV = isnull( d.CODSERV, t.CODSERV ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.NOTA = isnull( d.NOTA, t.NOTA ),
t.COD = isnull( d.COD, t.COD )
from ZooLogic.CodServDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CodServDet
( 
"NROITEM",
"CODSERV",
"DESCRI",
"NOTA",
"COD"
 )
Select 
d.NROITEM,
d.CODSERV,
d.DESCRI,
d.NOTA,
d.COD
From deleted d left join ZooLogic.CodServDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubODS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDENSERV_AgruPubODS
ON ZooLogic.TablaTrabajo_ORDENSERV_AgruPubODS
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubODS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubODS
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
From deleted d left join ZooLogic.AgruPubODS pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_OrdenServ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_OrdenServ
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ORDENDESERVICIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_ORDENDESERVICIO.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_ORDENDESERVICIO.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_ORDENDESERVICIO.Horaimpo, [] )
					.Horaaltafw = nvl( c_ORDENDESERVICIO.Horaaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ORDENDESERVICIO.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ORDENDESERVICIO.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_ORDENDESERVICIO.Seriemodificacionfw, [] )
					.Horaexpo = nvl( c_ORDENDESERVICIO.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_ORDENDESERVICIO.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_ORDENDESERVICIO.Seriealtafw, [] )
					.Versionaltafw = nvl( c_ORDENDESERVICIO.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_ORDENDESERVICIO.Versionmodificacionfw, [] )
					.Tipoagrupamientopublicaciones = nvl( c_ORDENDESERVICIO.Tipoagrupamientopublicaciones, 0 )
					.Anulado = nvl( c_ORDENDESERVICIO.Anulado, .F. )
					.Fechaadicional1 = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechaadicional1, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fecha, ctod( '  /  /    ' ) ) )
					.Cliente_PK =  nvl( c_ORDENDESERVICIO.Cliente, [] )
					.Vendedor_PK =  nvl( c_ORDENDESERVICIO.Vendedor, [] )
					.Articulo_PK =  nvl( c_ORDENDESERVICIO.Articulo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Detalleinteracciones.Limpiar()
					.Detalleinteracciones.SetearEsNavegacion( .lProcesando )
					.Detalleinteracciones.Cargar()
					.Detallecodigodeservicio.Limpiar()
					.Detallecodigodeservicio.SetearEsNavegacion( .lProcesando )
					.Detallecodigodeservicio.Cargar()
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Fechaadicional2 = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechaadicional2, ctod( '  /  /    ' ) ) )
					.Fechaentrega = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechaentrega, ctod( '  /  /    ' ) ) )
					.Clientedescripcion = nvl( c_ORDENDESERVICIO.Clientedescripcion, [] )
					.Vendedordescripcion = nvl( c_ORDENDESERVICIO.Vendedordescripcion, [] )
					.Color_PK =  nvl( c_ORDENDESERVICIO.Color, [] )
					.Codigo = nvl( c_ORDENDESERVICIO.Codigo, [] )
					.Fechaadicional3 = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechaadicional3, ctod( '  /  /    ' ) ) )
					.Guidpresupuesto = nvl( c_ORDENDESERVICIO.Guidpresupuesto, [] )
					.Letrapresupuesto = nvl( c_ORDENDESERVICIO.Letrapresupuesto, [] )
					.Numeropresupuesto = nvl( c_ORDENDESERVICIO.Numeropresupuesto, 0 )
					.Ptovtapresupuesto = nvl( c_ORDENDESERVICIO.Ptovtapresupuesto, 0 )
					.Idglobalcliente = nvl( c_ORDENDESERVICIO.Idglobalcliente, [] )
					.Tipodeorden_PK =  nvl( c_ORDENDESERVICIO.Tipodeorden, [] )
					.Talle_PK =  nvl( c_ORDENDESERVICIO.Talle, [] )
					.Nrofactura = nvl( c_ORDENDESERVICIO.Nrofactura, [] )
					.Sucursal_PK =  nvl( c_ORDENDESERVICIO.Sucursal, [] )
					.Estado_PK =  nvl( c_ORDENDESERVICIO.Estado, [] )
					.Entidadadicional1_PK =  nvl( c_ORDENDESERVICIO.Entidadadicional1, [] )
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDESERVICIO.Fechafactura, ctod( '  /  /    ' ) ) )
					.Valor = nvl( c_ORDENDESERVICIO.Valor, 0 )
					.Basededatosaltafw = nvl( c_ORDENDESERVICIO.Basededatosaltafw, [] )
					.Entidadadicional2_PK =  nvl( c_ORDENDESERVICIO.Entidadadicional2, [] )
					.Entidadadicional3_PK =  nvl( c_ORDENDESERVICIO.Entidadadicional3, [] )
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
		
		loDetalle = this.oEntidad.DetalleCodigoDeServicio
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
		return c_ORDENDESERVICIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ORDENSERV' )
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
								from ZooLogic.ORDENSERV 
								Where   ORDENSERV.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ORDENSERV", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecadic1" as "Fechaadicional1", "Fecha" as "Fecha", "Cliente" as "Cliente", "Vendedor" as "Vendedor", "Osart" as "Articulo", "Obs" as "Obs", "Fecadic2" as "Fechaadicional2", "Fechaent" as "Fechaentrega", "Descclient" as "Clientedescripcion", "Descvend" as "Vendedordescripcion", "Oscolor" as "Color", "Codigo" as "Codigo", "Fecadic3" as "Fechaadicional3", "Guidpresup" as "Guidpresupuesto", "Letrapresu" as "Letrapresupuesto", "Numpresup" as "Numeropresupuesto", "Pvpresup" as "Ptovtapresupuesto", "Idcent" as "Idglobalcliente", "Tipoorden" as "Tipodeorden", "Ostalle" as "Talle", "Nrofac" as "Nrofactura", "Sucursal" as "Sucursal", "Estado" as "Estado", "Entadic1" as "Entidadadicional1", "Fechafac" as "Fechafactura", "Valor" as "Valor", "Bdaltafw" as "Basededatosaltafw", "Entadic2" as "Entidadadicional2", "Entadic3" as "Entidadadicional3"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ORDENSERV 
								Where   ORDENSERV.CODIGO != ''
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
	Tabla = 'ORDENSERV'
	Filtro = " ORDENSERV.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ORDENSERV.CODIGO != ''"
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
	<row entidad="ORDENDESERVICIO                         " atributo="FECHATRANSFERENCIA                      " tabla="ORDENSERV      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAIMPO                               " tabla="ORDENSERV      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAMODIFICACIONFW                     " tabla="ORDENSERV      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAALTAFW                             " tabla="ORDENSERV      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAEXPO                               " tabla="ORDENSERV      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="ZADSFW                                  " tabla="ORDENSERV      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="ESTADOTRANSFERENCIA                     " tabla="ORDENSERV      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ORDENSERV      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="HORAIMPO                                " tabla="ORDENSERV      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="HORAALTAFW                              " tabla="ORDENSERV      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="USUARIOMODIFICACIONFW                   " tabla="ORDENSERV      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="USUARIOALTAFW                           " tabla="ORDENSERV      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="SERIEMODIFICACIONFW                     " tabla="ORDENSERV      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="HORAEXPO                                " tabla="ORDENSERV      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="HORAMODIFICACIONFW                      " tabla="ORDENSERV      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="SERIEALTAFW                             " tabla="ORDENSERV      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="VERSIONALTAFW                           " tabla="ORDENSERV      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="VERSIONMODIFICACIONFW                   " tabla="ORDENSERV      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="ORDENSERV      " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="ANULADO                                 " tabla="ORDENSERV      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAADICIONAL1                         " tabla="ORDENSERV      " campo="FECADIC1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha adicional 1                                                                                                                                               " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHA                                   " tabla="ORDENSERV      " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="4" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="CLIENTE                                 " tabla="ORDENSERV      " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="VENDEDOR                                " tabla="ORDENSERV      " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="402" etiqueta="Recibido por                                                                                                                                                    " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="ARTICULO                                " tabla="ORDENSERV      " campo="OSART     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="OBS                                     " tabla="ORDENSERV      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="DETALLEINTERACCIONES                    " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Historial de interacciones                                                                                                                                      " dominio="DETALLEITEMINTERACCION        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="DETALLECODIGODESERVICIO                 " tabla="CODSERVDET     " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Detalle de códigos de servicio                                                                                                                                  " dominio="DETALLEITEMCODSERV            " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBODS     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICODS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAADICIONAL2                         " tabla="ORDENSERV      " campo="FECADIC2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Fecha adicional 2                                                                                                                                               " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAENTREGA                            " tabla="ORDENSERV      " campo="FECHAENT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="414" etiqueta="Fecha de entrega                                                                                                                                                " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="CLIENTEDESCRIPCION                      " tabla="ORDENSERV      " campo="DESCCLIENT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Cliente descripción                                                                                                                                             " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="VENDEDORDESCRIPCION                     " tabla="ORDENSERV      " campo="DESCVEND  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Recibido descripción                                                                                                                                            " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Vendedor.Nombre                                                                                                                                                                                                                                               " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="COLOR                                   " tabla="ORDENSERV      " campo="OSCOLOR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="CODIGO                                  " tabla="ORDENSERV      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Identificador                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAADICIONAL3                         " tabla="ORDENSERV      " campo="FECADIC3  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Fecha adicional 3                                                                                                                                               " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="GUIDPRESUPUESTO                         " tabla="ORDENSERV      " campo="GUIDPRESUP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Guid presupuesto                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="LETRAPRESUPUESTO                        " tabla="ORDENSERV      " campo="LETRAPRESU" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra presupuesto                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="NUMEROPRESUPUESTO                       " tabla="ORDENSERV      " campo="NUMPRESUP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número presupuesto                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="PTOVTAPRESUPUESTO                       " tabla="ORDENSERV      " campo="PVPRESUP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto de venta presupuesto                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="IDGLOBALCLIENTE                         " tabla="ORDENSERV      " campo="IDCENT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="ID de centralización                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="Cliente.Idglobal                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="PRESUPUESTO                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PRESUPUESTO                             " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Presupuesto número                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="TIPODEORDEN                             " tabla="ORDENSERV      " campo="TIPOORDEN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEORDEN                             " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="424" etiqueta="Tipo de orden                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="TALLE                                   " tabla="ORDENSERV      " campo="OSTALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Talle                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="NROFACTURA                              " tabla="ORDENSERV      " campo="NROFAC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Nro. de ticket/Fac.                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="SUCURSAL                                " tabla="ORDENSERV      " campo="SUCURSAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Sucursal                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="BaseDeDatosAltaFW.Sucursal                                                                                                                                                                                                                                    " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="ESTADO                                  " tabla="ORDENSERV      " campo="ESTADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ESTADOSDEINTERACCION                    " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Estado                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="ENTIDADADICIONAL1                       " tabla="ORDENSERV      " campo="ENTADIC1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADADICIONAL1                       " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Entidad adicional 1                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHAFACTURA                            " tabla="ORDENSERV      " campo="FECHAFAC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Fecha de ticket/Fac.                                                                                                                                            " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="VALOR                                   " tabla="ORDENSERV      " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Valor                                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="BASEDEDATOSALTAFW                       " tabla="ORDENSERV      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.Zoo.App.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="ENTIDADADICIONAL2                       " tabla="ORDENSERV      " campo="ENTADIC2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADADICIONAL2                       " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Entidad adicional 2                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="ENTIDADADICIONAL3                       " tabla="ORDENSERV      " campo="ENTADIC3  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADADICIONAL3                       " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Entidad adicional 3                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="7" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On ORDENSERV.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Rec.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On ORDENSERV.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On ORDENSERV.OSART = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On ORDENSERV.OSCOLOR = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEORDEN                             " atributo="DESCRIPCION                             " tabla="TIPOORDEN      " campo="DESCR     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOORDEN On ORDENSERV.TIPOORDEN = TIPOORDEN.Codigo And  TIPOORDEN.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On ORDENSERV.OSTALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Suc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On ORDENSERV.SUCURSAL = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="DESCRIPCION                             " tabla="ESTINTERAC     " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="433" etiqueta="Detalle Est.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ESTINTERAC On ORDENSERV.ESTADO = ESTINTERAC.Codigo And  ESTINTERAC.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADADICIONAL1                       " atributo="DESCRI                                  " tabla="ENTADIC1       " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTADIC1 On ORDENSERV.ENTADIC1 = ENTADIC1.Cod And  ENTADIC1.COD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADADICIONAL2                       " atributo="DESCRI                                  " tabla="ENTADIC2       " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTADIC2 On ORDENSERV.ENTADIC2 = ENTADIC2.Cod And  ENTADIC2.COD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADADICIONAL3                       " atributo="DESCRI                                  " tabla="ENTADIC3       " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTADIC3 On ORDENSERV.ENTADIC3 = ENTADIC3.Cod And  ENTADIC3.COD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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