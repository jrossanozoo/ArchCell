
define class Din_EntidadINTERACCIONDEORDENAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_INTERACCIONDEORDEN'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_INOPK'
	cTablaPrincipal = 'INTORDEN'
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
			local  lxIntordenFecimpo, lxIntordenFaltafw, lxIntordenFecexpo, lxIntordenFmodifw, lxIntordenFectrans, lxIntordenHmodifw, lxIntordenSaltafw, lxIntordenSmodifw, lxIntordenUmodifw, lxIntordenUaltafw, lxIntordenZadsfw, lxIntordenValtafw, lxIntordenVmodifw, lxIntordenHoraimpo, lxIntordenHaltafw, lxIntordenHoraexpo, lxIntordenBdmodifw, lxIntordenEsttrans, lxIntordenTipagrupub, lxIntordenAnulado, lxIntordenFecha, lxIntordenCcolor, lxIntordenTalle, lxIntordenArt, lxIntordenTipodesc, lxIntordenEst, lxIntordenOrden, lxIntordenObs, lxIntordenDescol, lxIntordenDesctalle, lxIntordenDescart, lxIntordenCliente, lxIntordenValor, lxIntordenHora, lxIntordenCodigo, lxIntordenClidesc, lxIntordenVendedor, lxIntordenBdaltafw, lxIntordenDescvend
				lxIntordenFecimpo =  .Fechaimpo			lxIntordenFaltafw =  .Fechaaltafw			lxIntordenFecexpo =  .Fechaexpo			lxIntordenFmodifw =  .Fechamodificacionfw			lxIntordenFectrans =  .Fechatransferencia			lxIntordenHmodifw =  .Horamodificacionfw			lxIntordenSaltafw =  .Seriealtafw			lxIntordenSmodifw =  .Seriemodificacionfw			lxIntordenUmodifw =  .Usuariomodificacionfw			lxIntordenUaltafw =  .Usuarioaltafw			lxIntordenZadsfw =  .Zadsfw			lxIntordenValtafw =  .Versionaltafw			lxIntordenVmodifw =  .Versionmodificacionfw			lxIntordenHoraimpo =  .Horaimpo			lxIntordenHaltafw =  .Horaaltafw			lxIntordenHoraexpo =  .Horaexpo			lxIntordenBdmodifw =  .Basededatosmodificacionfw			lxIntordenEsttrans =  .Estadotransferencia			lxIntordenTipagrupub =  .Tipoagrupamientopublicaciones			lxIntordenAnulado =  .Anulado			lxIntordenFecha =  .Fecha			lxIntordenCcolor =  upper( .Color_PK ) 			lxIntordenTalle =  upper( .Talle_PK ) 			lxIntordenArt =  upper( .Articulo_PK ) 			lxIntordenTipodesc =  .Tipodescuento			lxIntordenEst =  upper( .Estado_PK ) 			lxIntordenOrden =  upper( .Orden_PK ) 			lxIntordenObs =  .Obs			lxIntordenDescol =  .Colordescripcion			lxIntordenDesctalle =  .Talledescripcion			lxIntordenDescart =  .Articulodescripcion			lxIntordenCliente =  upper( .Cliente_PK ) 			lxIntordenValor =  .Valor			lxIntordenHora =  .Hora			lxIntordenCodigo =  .Codigo			lxIntordenClidesc =  .Clientedescripcion			lxIntordenVendedor =  upper( .Vendedor_PK ) 			lxIntordenBdaltafw =  .Basededatosaltafw			lxIntordenDescvend =  .Vendedordescripcion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxIntordenCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.INTORDEN ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Fectrans","Hmodifw","Saltafw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Esttrans","Tipagrupub","Anulado","Fecha","Ccolor","Talle","Art","Tipodesc","Est","Orden","Obs","Descol","Desctalle","Descart","Cliente","Valor","Hora","Codigo","Clidesc","Vendedor","Bdaltafw","Descvend" ) values ( <<"'" + this.ConvertirDateSql( lxIntordenFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIntordenFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIntordenFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIntordenFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIntordenFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenEsttrans ) + "'" >>, <<lxIntordenTipagrupub >>, <<iif( lxIntordenAnulado, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxIntordenFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenCcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenArt ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenTipodesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenEst ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenOrden ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenDescol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenDesctalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenDescart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenCliente ) + "'" >>, <<lxIntordenValor >>, <<"'" + this.FormatearTextoSql( lxIntordenHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenClidesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenDescvend ) + "'" >> )
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
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubINO("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxIntordenFecimpo, lxIntordenFaltafw, lxIntordenFecexpo, lxIntordenFmodifw, lxIntordenFectrans, lxIntordenHmodifw, lxIntordenSaltafw, lxIntordenSmodifw, lxIntordenUmodifw, lxIntordenUaltafw, lxIntordenZadsfw, lxIntordenValtafw, lxIntordenVmodifw, lxIntordenHoraimpo, lxIntordenHaltafw, lxIntordenHoraexpo, lxIntordenBdmodifw, lxIntordenEsttrans, lxIntordenTipagrupub, lxIntordenAnulado, lxIntordenFecha, lxIntordenCcolor, lxIntordenTalle, lxIntordenArt, lxIntordenTipodesc, lxIntordenEst, lxIntordenOrden, lxIntordenObs, lxIntordenDescol, lxIntordenDesctalle, lxIntordenDescart, lxIntordenCliente, lxIntordenValor, lxIntordenHora, lxIntordenCodigo, lxIntordenClidesc, lxIntordenVendedor, lxIntordenBdaltafw, lxIntordenDescvend
				lxIntordenFecimpo =  .Fechaimpo			lxIntordenFaltafw =  .Fechaaltafw			lxIntordenFecexpo =  .Fechaexpo			lxIntordenFmodifw =  .Fechamodificacionfw			lxIntordenFectrans =  .Fechatransferencia			lxIntordenHmodifw =  .Horamodificacionfw			lxIntordenSaltafw =  .Seriealtafw			lxIntordenSmodifw =  .Seriemodificacionfw			lxIntordenUmodifw =  .Usuariomodificacionfw			lxIntordenUaltafw =  .Usuarioaltafw			lxIntordenZadsfw =  .Zadsfw			lxIntordenValtafw =  .Versionaltafw			lxIntordenVmodifw =  .Versionmodificacionfw			lxIntordenHoraimpo =  .Horaimpo			lxIntordenHaltafw =  .Horaaltafw			lxIntordenHoraexpo =  .Horaexpo			lxIntordenBdmodifw =  .Basededatosmodificacionfw			lxIntordenEsttrans =  .Estadotransferencia			lxIntordenTipagrupub =  .Tipoagrupamientopublicaciones			lxIntordenAnulado =  .Anulado			lxIntordenFecha =  .Fecha			lxIntordenCcolor =  upper( .Color_PK ) 			lxIntordenTalle =  upper( .Talle_PK ) 			lxIntordenArt =  upper( .Articulo_PK ) 			lxIntordenTipodesc =  .Tipodescuento			lxIntordenEst =  upper( .Estado_PK ) 			lxIntordenOrden =  upper( .Orden_PK ) 			lxIntordenObs =  .Obs			lxIntordenDescol =  .Colordescripcion			lxIntordenDesctalle =  .Talledescripcion			lxIntordenDescart =  .Articulodescripcion			lxIntordenCliente =  upper( .Cliente_PK ) 			lxIntordenValor =  .Valor			lxIntordenHora =  .Hora			lxIntordenCodigo =  .Codigo			lxIntordenClidesc =  .Clientedescripcion			lxIntordenVendedor =  upper( .Vendedor_PK ) 			lxIntordenBdaltafw =  .Basededatosaltafw			lxIntordenDescvend =  .Vendedordescripcion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.INTORDEN set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxIntordenFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxIntordenFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxIntordenFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxIntordenFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxIntordenFectrans ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxIntordenHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxIntordenSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxIntordenSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxIntordenUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxIntordenUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxIntordenZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxIntordenValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxIntordenVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxIntordenHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxIntordenHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxIntordenHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxIntordenBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxIntordenEsttrans ) + "'">>,"Tipagrupub" = <<lxIntordenTipagrupub>>,"Anulado" = <<iif( lxIntordenAnulado, 1, 0 )>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxIntordenFecha ) + "'">>,"Ccolor" = <<"'" + this.FormatearTextoSql( lxIntordenCcolor ) + "'">>,"Talle" = <<"'" + this.FormatearTextoSql( lxIntordenTalle ) + "'">>,"Art" = <<"'" + this.FormatearTextoSql( lxIntordenArt ) + "'">>,"Tipodesc" = <<"'" + this.FormatearTextoSql( lxIntordenTipodesc ) + "'">>,"Est" = <<"'" + this.FormatearTextoSql( lxIntordenEst ) + "'">>,"Orden" = <<"'" + this.FormatearTextoSql( lxIntordenOrden ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxIntordenObs ) + "'">>,"Descol" = <<"'" + this.FormatearTextoSql( lxIntordenDescol ) + "'">>,"Desctalle" = <<"'" + this.FormatearTextoSql( lxIntordenDesctalle ) + "'">>,"Descart" = <<"'" + this.FormatearTextoSql( lxIntordenDescart ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxIntordenCliente ) + "'">>,"Valor" = <<lxIntordenValor>>,"Hora" = <<"'" + this.FormatearTextoSql( lxIntordenHora ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxIntordenCodigo ) + "'">>,"Clidesc" = <<"'" + this.FormatearTextoSql( lxIntordenClidesc ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxIntordenVendedor ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxIntordenBdaltafw ) + "'">>,"Descvend" = <<"'" + this.FormatearTextoSql( lxIntordenDescvend ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxIntordenCodigo ) + "'">> and  INTORDEN.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubINO where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubINO("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.INTORDEN where " + this.ConvertirFuncionesSql( " INTORDEN.CODIGO != ''" ) )
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
			Local lxIntordenCodigo
			lxIntordenCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecha" as "Fecha", "Ccolor" as "Color", "Talle" as "Talle", "Art" as "Articulo", "Tipodesc" as "Tipodescuento", "Est" as "Estado", "Orden" as "Orden", "Obs" as "Obs", "Descol" as "Colordescripcion", "Desctalle" as "Talledescripcion", "Descart" as "Articulodescripcion", "Cliente" as "Cliente", "Valor" as "Valor", "Hora" as "Hora", "Codigo" as "Codigo", "Clidesc" as "Clientedescripcion", "Vendedor" as "Vendedor", "Bdaltafw" as "Basededatosaltafw", "Descvend" as "Vendedordescripcion" from ZooLogic.INTORDEN where "Codigo" = <<"'" + this.FormatearTextoSql( lxIntordenCodigo ) + "'">> and  INTORDEN.CODIGO != ''
			endtext
			use in select('c_INTERACCIONDEORDEN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INTERACCIONDEORDEN', set( 'Datasession' ) )

			if reccount( 'c_INTERACCIONDEORDEN' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubINO where Codigo = <<"'" + this.FormatearTextoSql( c_INTERACCIONDEORDEN.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxIntordenCodigo as Variant
		llRetorno = .t.
		lxIntordenCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.INTORDEN where "Codigo" = <<"'" + this.FormatearTextoSql( lxIntordenCodigo ) + "'">> and  INTORDEN.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecha" as "Fecha", "Ccolor" as "Color", "Talle" as "Talle", "Art" as "Articulo", "Tipodesc" as "Tipodescuento", "Est" as "Estado", "Orden" as "Orden", "Obs" as "Obs", "Descol" as "Colordescripcion", "Desctalle" as "Talledescripcion", "Descart" as "Articulodescripcion", "Cliente" as "Cliente", "Valor" as "Valor", "Hora" as "Hora", "Codigo" as "Codigo", "Clidesc" as "Clientedescripcion", "Vendedor" as "Vendedor", "Bdaltafw" as "Basededatosaltafw", "Descvend" as "Vendedordescripcion" from ZooLogic.INTORDEN where  INTORDEN.CODIGO != '' order by Codigo
			endtext
			use in select('c_INTERACCIONDEORDEN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INTERACCIONDEORDEN', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubINO where Codigo = <<"'" + this.FormatearTextoSql( c_INTERACCIONDEORDEN.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecha" as "Fecha", "Ccolor" as "Color", "Talle" as "Talle", "Art" as "Articulo", "Tipodesc" as "Tipodescuento", "Est" as "Estado", "Orden" as "Orden", "Obs" as "Obs", "Descol" as "Colordescripcion", "Desctalle" as "Talledescripcion", "Descart" as "Articulodescripcion", "Cliente" as "Cliente", "Valor" as "Valor", "Hora" as "Hora", "Codigo" as "Codigo", "Clidesc" as "Clientedescripcion", "Vendedor" as "Vendedor", "Bdaltafw" as "Basededatosaltafw", "Descvend" as "Vendedordescripcion" from ZooLogic.INTORDEN where  funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INTORDEN.CODIGO != '' order by Codigo
			endtext
			use in select('c_INTERACCIONDEORDEN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INTERACCIONDEORDEN', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubINO where Codigo = <<"'" + this.FormatearTextoSql( c_INTERACCIONDEORDEN.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecha" as "Fecha", "Ccolor" as "Color", "Talle" as "Talle", "Art" as "Articulo", "Tipodesc" as "Tipodescuento", "Est" as "Estado", "Orden" as "Orden", "Obs" as "Obs", "Descol" as "Colordescripcion", "Desctalle" as "Talledescripcion", "Descart" as "Articulodescripcion", "Cliente" as "Cliente", "Valor" as "Valor", "Hora" as "Hora", "Codigo" as "Codigo", "Clidesc" as "Clientedescripcion", "Vendedor" as "Vendedor", "Bdaltafw" as "Basededatosaltafw", "Descvend" as "Vendedordescripcion" from ZooLogic.INTORDEN where  funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INTORDEN.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_INTERACCIONDEORDEN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INTERACCIONDEORDEN', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubINO where Codigo = <<"'" + this.FormatearTextoSql( c_INTERACCIONDEORDEN.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecha" as "Fecha", "Ccolor" as "Color", "Talle" as "Talle", "Art" as "Articulo", "Tipodesc" as "Tipodescuento", "Est" as "Estado", "Orden" as "Orden", "Obs" as "Obs", "Descol" as "Colordescripcion", "Desctalle" as "Talledescripcion", "Descart" as "Articulodescripcion", "Cliente" as "Cliente", "Valor" as "Valor", "Hora" as "Hora", "Codigo" as "Codigo", "Clidesc" as "Clientedescripcion", "Vendedor" as "Vendedor", "Bdaltafw" as "Basededatosaltafw", "Descvend" as "Vendedordescripcion" from ZooLogic.INTORDEN where  INTORDEN.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_INTERACCIONDEORDEN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INTERACCIONDEORDEN', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubINO where Codigo = <<"'" + this.FormatearTextoSql( c_INTERACCIONDEORDEN.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Faltafw,Fecexpo,Fmodifw,Fectrans,Hmodifw,Saltafw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valt" + ;
"afw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Esttrans,Tipagrupub,Anulado,Fecha,Ccolor,Talle,Art,Ti" + ;
"podesc,Est,Orden,Obs,Descol,Desctalle,Descart,Cliente,Valor,Hora,Codigo,Clidesc,Vendedor,Bdaltafw,De" + ;
"scvend" + ;
" from ZooLogic.INTORDEN where  INTORDEN.CODIGO != '' and " + lcFiltro )
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
			local  lxIntordenFecimpo, lxIntordenFaltafw, lxIntordenFecexpo, lxIntordenFmodifw, lxIntordenFectrans, lxIntordenHmodifw, lxIntordenSaltafw, lxIntordenSmodifw, lxIntordenUmodifw, lxIntordenUaltafw, lxIntordenZadsfw, lxIntordenValtafw, lxIntordenVmodifw, lxIntordenHoraimpo, lxIntordenHaltafw, lxIntordenHoraexpo, lxIntordenBdmodifw, lxIntordenEsttrans, lxIntordenTipagrupub, lxIntordenAnulado, lxIntordenFecha, lxIntordenCcolor, lxIntordenTalle, lxIntordenArt, lxIntordenTipodesc, lxIntordenEst, lxIntordenOrden, lxIntordenObs, lxIntordenDescol, lxIntordenDesctalle, lxIntordenDescart, lxIntordenCliente, lxIntordenValor, lxIntordenHora, lxIntordenCodigo, lxIntordenClidesc, lxIntordenVendedor, lxIntordenBdaltafw, lxIntordenDescvend
				lxIntordenFecimpo = ctod( '  /  /    ' )			lxIntordenFaltafw = ctod( '  /  /    ' )			lxIntordenFecexpo = ctod( '  /  /    ' )			lxIntordenFmodifw = ctod( '  /  /    ' )			lxIntordenFectrans = ctod( '  /  /    ' )			lxIntordenHmodifw = []			lxIntordenSaltafw = []			lxIntordenSmodifw = []			lxIntordenUmodifw = []			lxIntordenUaltafw = []			lxIntordenZadsfw = []			lxIntordenValtafw = []			lxIntordenVmodifw = []			lxIntordenHoraimpo = []			lxIntordenHaltafw = []			lxIntordenHoraexpo = []			lxIntordenBdmodifw = []			lxIntordenEsttrans = []			lxIntordenTipagrupub = 0			lxIntordenAnulado = .F.			lxIntordenFecha = ctod( '  /  /    ' )			lxIntordenCcolor = []			lxIntordenTalle = []			lxIntordenArt = []			lxIntordenTipodesc = []			lxIntordenEst = []			lxIntordenOrden = []			lxIntordenObs = []			lxIntordenDescol = []			lxIntordenDesctalle = []			lxIntordenDescart = []			lxIntordenCliente = []			lxIntordenValor = 0			lxIntordenHora = []			lxIntordenCodigo = []			lxIntordenClidesc = []			lxIntordenVendedor = []			lxIntordenBdaltafw = []			lxIntordenDescvend = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubINO where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.INTORDEN where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'INTORDEN' + '_' + tcCampo
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
		lcWhere = " Where  INTORDEN.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecha" as "Fecha", "Ccolor" as "Color", "Talle" as "Talle", "Art" as "Articulo", "Tipodesc" as "Tipodescuento", "Est" as "Estado", "Orden" as "Orden", "Obs" as "Obs", "Descol" as "Colordescripcion", "Desctalle" as "Talledescripcion", "Descart" as "Articulodescripcion", "Cliente" as "Cliente", "Valor" as "Valor", "Hora" as "Hora", "Codigo" as "Codigo", "Clidesc" as "Clientedescripcion", "Vendedor" as "Vendedor", "Bdaltafw" as "Basededatosaltafw", "Descvend" as "Vendedordescripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'INTORDEN', '', tnTope )
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
		lcWhere = " Where  AGRUPUBINO.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubINO', 'AgruPubliDetalle', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
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
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ART AS ARTICULO'
				Case lcAtributo == 'TIPODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODESC AS TIPODESCUENTO'
				Case lcAtributo == 'ESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EST AS ESTADO'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDEN'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'COLORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCOL AS COLORDESCRIPCION'
				Case lcAtributo == 'TALLEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCTALLE AS TALLEDESCRIPCION'
				Case lcAtributo == 'ARTICULODESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCART AS ARTICULODESCRIPCION'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIDESC AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VENDEDORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCVEND AS VENDEDORDESCRIPCION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ART'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODESCUENTO'
				lcCampo = 'TIPODESC'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADO'
				lcCampo = 'EST'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'ORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDESCRIPCION'
				lcCampo = 'DESCOL'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDESCRIPCION'
				lcCampo = 'DESCTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODESCRIPCION'
				lcCampo = 'DESCART'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'CLIDESC'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDORDESCRIPCION'
				lcCampo = 'DESCVEND'
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
			lcRetorno = 'AGRUPUBINO'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxIntordenFecimpo, lxIntordenFaltafw, lxIntordenFecexpo, lxIntordenFmodifw, lxIntordenFectrans, lxIntordenHmodifw, lxIntordenSaltafw, lxIntordenSmodifw, lxIntordenUmodifw, lxIntordenUaltafw, lxIntordenZadsfw, lxIntordenValtafw, lxIntordenVmodifw, lxIntordenHoraimpo, lxIntordenHaltafw, lxIntordenHoraexpo, lxIntordenBdmodifw, lxIntordenEsttrans, lxIntordenTipagrupub, lxIntordenAnulado, lxIntordenFecha, lxIntordenCcolor, lxIntordenTalle, lxIntordenArt, lxIntordenTipodesc, lxIntordenEst, lxIntordenOrden, lxIntordenObs, lxIntordenDescol, lxIntordenDesctalle, lxIntordenDescart, lxIntordenCliente, lxIntordenValor, lxIntordenHora, lxIntordenCodigo, lxIntordenClidesc, lxIntordenVendedor, lxIntordenBdaltafw, lxIntordenDescvend
				lxIntordenFecimpo =  .Fechaimpo			lxIntordenFaltafw =  .Fechaaltafw			lxIntordenFecexpo =  .Fechaexpo			lxIntordenFmodifw =  .Fechamodificacionfw			lxIntordenFectrans =  .Fechatransferencia			lxIntordenHmodifw =  .Horamodificacionfw			lxIntordenSaltafw =  .Seriealtafw			lxIntordenSmodifw =  .Seriemodificacionfw			lxIntordenUmodifw =  .Usuariomodificacionfw			lxIntordenUaltafw =  .Usuarioaltafw			lxIntordenZadsfw =  .Zadsfw			lxIntordenValtafw =  .Versionaltafw			lxIntordenVmodifw =  .Versionmodificacionfw			lxIntordenHoraimpo =  .Horaimpo			lxIntordenHaltafw =  .Horaaltafw			lxIntordenHoraexpo =  .Horaexpo			lxIntordenBdmodifw =  .Basededatosmodificacionfw			lxIntordenEsttrans =  .Estadotransferencia			lxIntordenTipagrupub =  .Tipoagrupamientopublicaciones			lxIntordenAnulado =  .Anulado			lxIntordenFecha =  .Fecha			lxIntordenCcolor =  upper( .Color_PK ) 			lxIntordenTalle =  upper( .Talle_PK ) 			lxIntordenArt =  upper( .Articulo_PK ) 			lxIntordenTipodesc =  .Tipodescuento			lxIntordenEst =  upper( .Estado_PK ) 			lxIntordenOrden =  upper( .Orden_PK ) 			lxIntordenObs =  .Obs			lxIntordenDescol =  .Colordescripcion			lxIntordenDesctalle =  .Talledescripcion			lxIntordenDescart =  .Articulodescripcion			lxIntordenCliente =  upper( .Cliente_PK ) 			lxIntordenValor =  .Valor			lxIntordenHora =  .Hora			lxIntordenCodigo =  .Codigo			lxIntordenClidesc =  .Clientedescripcion			lxIntordenVendedor =  upper( .Vendedor_PK ) 			lxIntordenBdaltafw =  .Basededatosaltafw			lxIntordenDescvend =  .Vendedordescripcion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.INTORDEN ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Fectrans","Hmodifw","Saltafw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Esttrans","Tipagrupub","Anulado","Fecha","Ccolor","Talle","Art","Tipodesc","Est","Orden","Obs","Descol","Desctalle","Descart","Cliente","Valor","Hora","Codigo","Clidesc","Vendedor","Bdaltafw","Descvend" ) values ( <<"'" + this.ConvertirDateSql( lxIntordenFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIntordenFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIntordenFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIntordenFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxIntordenFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenEsttrans ) + "'" >>, <<lxIntordenTipagrupub >>, <<iif( lxIntordenAnulado, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxIntordenFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenCcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenArt ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenTipodesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenEst ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenOrden ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenDescol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenDesctalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenDescart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenCliente ) + "'" >>, <<lxIntordenValor >>, <<"'" + this.FormatearTextoSql( lxIntordenHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenClidesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxIntordenDescvend ) + "'" >> )
		endtext
		loColeccion.cTabla = 'INTORDEN' 
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
						Insert into ZooLogic.AgruPubINO("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxIntordenFecimpo, lxIntordenFaltafw, lxIntordenFecexpo, lxIntordenFmodifw, lxIntordenFectrans, lxIntordenHmodifw, lxIntordenSaltafw, lxIntordenSmodifw, lxIntordenUmodifw, lxIntordenUaltafw, lxIntordenZadsfw, lxIntordenValtafw, lxIntordenVmodifw, lxIntordenHoraimpo, lxIntordenHaltafw, lxIntordenHoraexpo, lxIntordenBdmodifw, lxIntordenEsttrans, lxIntordenTipagrupub, lxIntordenAnulado, lxIntordenFecha, lxIntordenCcolor, lxIntordenTalle, lxIntordenArt, lxIntordenTipodesc, lxIntordenEst, lxIntordenOrden, lxIntordenObs, lxIntordenDescol, lxIntordenDesctalle, lxIntordenDescart, lxIntordenCliente, lxIntordenValor, lxIntordenHora, lxIntordenCodigo, lxIntordenClidesc, lxIntordenVendedor, lxIntordenBdaltafw, lxIntordenDescvend
				lxIntordenFecimpo =  .Fechaimpo			lxIntordenFaltafw =  .Fechaaltafw			lxIntordenFecexpo =  .Fechaexpo			lxIntordenFmodifw =  .Fechamodificacionfw			lxIntordenFectrans =  .Fechatransferencia			lxIntordenHmodifw =  .Horamodificacionfw			lxIntordenSaltafw =  .Seriealtafw			lxIntordenSmodifw =  .Seriemodificacionfw			lxIntordenUmodifw =  .Usuariomodificacionfw			lxIntordenUaltafw =  .Usuarioaltafw			lxIntordenZadsfw =  .Zadsfw			lxIntordenValtafw =  .Versionaltafw			lxIntordenVmodifw =  .Versionmodificacionfw			lxIntordenHoraimpo =  .Horaimpo			lxIntordenHaltafw =  .Horaaltafw			lxIntordenHoraexpo =  .Horaexpo			lxIntordenBdmodifw =  .Basededatosmodificacionfw			lxIntordenEsttrans =  .Estadotransferencia			lxIntordenTipagrupub =  .Tipoagrupamientopublicaciones			lxIntordenAnulado =  .Anulado			lxIntordenFecha =  .Fecha			lxIntordenCcolor =  upper( .Color_PK ) 			lxIntordenTalle =  upper( .Talle_PK ) 			lxIntordenArt =  upper( .Articulo_PK ) 			lxIntordenTipodesc =  .Tipodescuento			lxIntordenEst =  upper( .Estado_PK ) 			lxIntordenOrden =  upper( .Orden_PK ) 			lxIntordenObs =  .Obs			lxIntordenDescol =  .Colordescripcion			lxIntordenDesctalle =  .Talledescripcion			lxIntordenDescart =  .Articulodescripcion			lxIntordenCliente =  upper( .Cliente_PK ) 			lxIntordenValor =  .Valor			lxIntordenHora =  .Hora			lxIntordenCodigo =  .Codigo			lxIntordenClidesc =  .Clientedescripcion			lxIntordenVendedor =  upper( .Vendedor_PK ) 			lxIntordenBdaltafw =  .Basededatosaltafw			lxIntordenDescvend =  .Vendedordescripcion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  INTORDEN.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.INTORDEN set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxIntordenFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxIntordenFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxIntordenFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxIntordenFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxIntordenFectrans ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxIntordenHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxIntordenSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxIntordenSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxIntordenUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxIntordenUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxIntordenZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxIntordenValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxIntordenVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxIntordenHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxIntordenHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxIntordenHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxIntordenBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxIntordenEsttrans ) + "'">>, "Tipagrupub" = <<lxIntordenTipagrupub>>, "Anulado" = <<iif( lxIntordenAnulado, 1, 0 )>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxIntordenFecha ) + "'">>, "Ccolor" = <<"'" + this.FormatearTextoSql( lxIntordenCcolor ) + "'">>, "Talle" = <<"'" + this.FormatearTextoSql( lxIntordenTalle ) + "'">>, "Art" = <<"'" + this.FormatearTextoSql( lxIntordenArt ) + "'">>, "Tipodesc" = <<"'" + this.FormatearTextoSql( lxIntordenTipodesc ) + "'">>, "Est" = <<"'" + this.FormatearTextoSql( lxIntordenEst ) + "'">>, "Orden" = <<"'" + this.FormatearTextoSql( lxIntordenOrden ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxIntordenObs ) + "'">>, "Descol" = <<"'" + this.FormatearTextoSql( lxIntordenDescol ) + "'">>, "Desctalle" = <<"'" + this.FormatearTextoSql( lxIntordenDesctalle ) + "'">>, "Descart" = <<"'" + this.FormatearTextoSql( lxIntordenDescart ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxIntordenCliente ) + "'">>, "Valor" = <<lxIntordenValor>>, "Hora" = <<"'" + this.FormatearTextoSql( lxIntordenHora ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxIntordenCodigo ) + "'">>, "Clidesc" = <<"'" + this.FormatearTextoSql( lxIntordenClidesc ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxIntordenVendedor ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxIntordenBdaltafw ) + "'">>, "Descvend" = <<"'" + this.FormatearTextoSql( lxIntordenDescvend ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'INTORDEN' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.AgruPubINO where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubINO("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  INTORDEN.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.INTORDEN where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPubINO where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'INTORDEN' 
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
			lcRetorno = [update ZooLogic.INTORDEN set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  INTORDEN.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.INTORDEN where  INTORDEN.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.INTORDEN where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  INTORDEN.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INTERACCIONDEORDEN'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.INTORDEN Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					if this.oEntidad.cContexto == 'C'
						if curSeek.ANULADO
							Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
							this.oConexion.EjecutarSql( [UPDATE ZooLogic.INTORDEN set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, cColor = ] + "'" + this.FormatearTextoSql( &lcCursor..cColor ) + "'"+ [, Talle = ] + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'"+ [, Art = ] + "'" + this.FormatearTextoSql( &lcCursor..Art ) + "'"+ [, TipoDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoDesc ) + "'"+ [, Est = ] + "'" + this.FormatearTextoSql( &lcCursor..Est ) + "'"+ [, Orden = ] + "'" + this.FormatearTextoSql( &lcCursor..Orden ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, DesCol = ] + "'" + this.FormatearTextoSql( &lcCursor..DesCol ) + "'"+ [, DescTalle = ] + "'" + this.FormatearTextoSql( &lcCursor..DescTalle ) + "'"+ [, DescArt = ] + "'" + this.FormatearTextoSql( &lcCursor..DescArt ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, Valor = ] + transform( &lcCursor..Valor )+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, CliDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..CliDesc ) + "'"+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"+ [, DescVend = ] + "'" + this.FormatearTextoSql( &lcCursor..DescVend ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
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
					 FECIMPO, FALTAFW, FECEXPO, FMODIFW, FECTRANS, HMODIFW, SALTAFW, SMODIFW, UMODIFW, UALTAFW, ZADSFW, VALTAFW, VMODIFW, HORAIMPO, HALTAFW, HORAEXPO, BDMODIFW, ESTTRANS, tipagrupub, Anulado, Fecha, cColor, Talle, Art, TipoDesc, Est, Orden, Obs, DesCol, DescTalle, DescArt, Cliente, Valor, Hora, Codigo, CliDesc, Vendedor, BDAltaFW, DescVend
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cColor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Art ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoDesc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Est ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Orden ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DesCol ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescTalle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescArt ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + transform( &lcCursor..Valor ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CliDesc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescVend ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.INTORDEN ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INTERACCIONDEORDEN'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubINO Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICINO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubINO ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'INTERACCIONDEORDEN'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'INTERACCIONDEORDEN_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'INTERACCIONDEORDEN_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICINO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IntOrden')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'INTERACCIONDEORDEN'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad INTERACCIONDEORDEN. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INTERACCIONDEORDEN'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INTERACCIONDEORDEN'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IntOrden') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IntOrden
Create Table ZooLogic.TablaTrabajo_IntOrden ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
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
"esttrans" char( 20 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"anulado" bit  null, 
"fecha" datetime  null, 
"ccolor" char( 6 )  null, 
"talle" char( 5 )  null, 
"art" char( 15 )  null, 
"tipodesc" char( 10 )  null, 
"est" char( 30 )  null, 
"orden" char( 20 )  null, 
"obs" varchar(max)  null, 
"descol" char( 50 )  null, 
"desctalle" char( 50 )  null, 
"descart" char( 100 )  null, 
"cliente" char( 10 )  null, 
"valor" numeric( 10, 2 )  null, 
"hora" char( 8 )  null, 
"codigo" char( 20 )  null, 
"clidesc" char( 185 )  null, 
"vendedor" char( 10 )  null, 
"bdaltafw" char( 8 )  null, 
"descvend" char( 60 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IntOrden' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IntOrden' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INTERACCIONDEORDEN'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
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
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('ccolor','ccolor')
			.AgregarMapeo('talle','talle')
			.AgregarMapeo('art','art')
			.AgregarMapeo('tipodesc','tipodesc')
			.AgregarMapeo('est','est')
			.AgregarMapeo('orden','orden')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('descol','descol')
			.AgregarMapeo('desctalle','desctalle')
			.AgregarMapeo('descart','descart')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('clidesc','clidesc')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('descvend','descvend')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IntOrden'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.ART = isnull( d.ART, t.ART ),t.TIPODESC = isnull( d.TIPODESC, t.TIPODESC ),t.EST = isnull( d.EST, t.EST ),t.ORDEN = isnull( d.ORDEN, t.ORDEN ),t.OBS = isnull( d.OBS, t.OBS ),t.DESCOL = isnull( d.DESCOL, t.DESCOL ),t.DESCTALLE = isnull( d.DESCTALLE, t.DESCTALLE ),t.DESCART = isnull( d.DESCART, t.DESCART ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.HORA = isnull( d.HORA, t.HORA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CLIDESC = isnull( d.CLIDESC, t.CLIDESC ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.DESCVEND = isnull( d.DESCVEND, t.DESCVEND )
					from ZooLogic.INTORDEN t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.INTORDEN(Fecimpo,Faltafw,Fecexpo,Fmodifw,Fectrans,Hmodifw,Saltafw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Esttrans,Tipagrupub,Anulado,Fecha,Ccolor,Talle,Art,Tipodesc,Est,Orden,Obs,Descol,Desctalle,Descart,Cliente,Valor,Hora,Codigo,Clidesc,Vendedor,Bdaltafw,Descvend)
					Select isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.TIPAGRUPUB,0),isnull( d.ANULADO,0),isnull( d.FECHA,''),isnull( d.CCOLOR,''),isnull( d.TALLE,''),isnull( d.ART,''),isnull( d.TIPODESC,''),isnull( d.EST,''),isnull( d.ORDEN,''),isnull( d.OBS,''),isnull( d.DESCOL,''),isnull( d.DESCTALLE,''),isnull( d.DESCART,''),isnull( d.CLIENTE,''),isnull( d.VALOR,0),isnull( d.HORA,''),isnull( d.CODIGO,''),isnull( d.CLIDESC,''),isnull( d.VENDEDOR,''),isnull( d.BDALTAFW,''),isnull( d.DESCVEND,'')
						From deleted d left join ZooLogic.INTORDEN pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubINO( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_INTORDEN_AgruPubINO
ON ZooLogic.TablaTrabajo_INTORDEN_AgruPubINO
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubINO t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubINO
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
From deleted d left join ZooLogic.AgruPubINO pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IntOrden') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IntOrden
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_INTERACCIONDEORDEN' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_INTERACCIONDEORDEN.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_INTERACCIONDEORDEN.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_INTERACCIONDEORDEN.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_INTERACCIONDEORDEN.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_INTERACCIONDEORDEN.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Horamodificacionfw = nvl( c_INTERACCIONDEORDEN.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_INTERACCIONDEORDEN.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_INTERACCIONDEORDEN.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_INTERACCIONDEORDEN.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_INTERACCIONDEORDEN.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_INTERACCIONDEORDEN.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_INTERACCIONDEORDEN.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_INTERACCIONDEORDEN.Horaimpo, [] )
					.Horaaltafw = nvl( c_INTERACCIONDEORDEN.Horaaltafw, [] )
					.Horaexpo = nvl( c_INTERACCIONDEORDEN.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_INTERACCIONDEORDEN.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_INTERACCIONDEORDEN.Estadotransferencia, [] )
					.Tipoagrupamientopublicaciones = nvl( c_INTERACCIONDEORDEN.Tipoagrupamientopublicaciones, 0 )
					.Anulado = nvl( c_INTERACCIONDEORDEN.Anulado, .F. )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_INTERACCIONDEORDEN.Fecha, ctod( '  /  /    ' ) ) )
					.Color_PK =  nvl( c_INTERACCIONDEORDEN.Color, [] )
					.Talle_PK =  nvl( c_INTERACCIONDEORDEN.Talle, [] )
					.Articulo_PK =  nvl( c_INTERACCIONDEORDEN.Articulo, [] )
					.Tipodescuento = nvl( c_INTERACCIONDEORDEN.Tipodescuento, [] )
					.Estado_PK =  nvl( c_INTERACCIONDEORDEN.Estado, [] )
					.Orden_PK =  nvl( c_INTERACCIONDEORDEN.Orden, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Colordescripcion = nvl( c_INTERACCIONDEORDEN.Colordescripcion, [] )
					.Talledescripcion = nvl( c_INTERACCIONDEORDEN.Talledescripcion, [] )
					.Articulodescripcion = nvl( c_INTERACCIONDEORDEN.Articulodescripcion, [] )
					.Cliente_PK =  nvl( c_INTERACCIONDEORDEN.Cliente, [] )
					.Valor = nvl( c_INTERACCIONDEORDEN.Valor, 0 )
					.Hora = nvl( c_INTERACCIONDEORDEN.Hora, [] )
					.Codigo = nvl( c_INTERACCIONDEORDEN.Codigo, [] )
					.Clientedescripcion = nvl( c_INTERACCIONDEORDEN.Clientedescripcion, [] )
					.Vendedor_PK =  nvl( c_INTERACCIONDEORDEN.Vendedor, [] )
					.Basededatosaltafw = nvl( c_INTERACCIONDEORDEN.Basededatosaltafw, [] )
					.Vendedordescripcion = nvl( c_INTERACCIONDEORDEN.Vendedordescripcion, [] )
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
		return c_INTERACCIONDEORDEN.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.INTORDEN' )
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
								from ZooLogic.INTORDEN 
								Where   INTORDEN.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "INTORDEN", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Anulado" as "Anulado", "Fecha" as "Fecha", "Ccolor" as "Color", "Talle" as "Talle", "Art" as "Articulo", "Tipodesc" as "Tipodescuento", "Est" as "Estado", "Orden" as "Orden", "Obs" as "Obs", "Descol" as "Colordescripcion", "Desctalle" as "Talledescripcion", "Descart" as "Articulodescripcion", "Cliente" as "Cliente", "Valor" as "Valor", "Hora" as "Hora", "Codigo" as "Codigo", "Clidesc" as "Clientedescripcion", "Vendedor" as "Vendedor", "Bdaltafw" as "Basededatosaltafw", "Descvend" as "Vendedordescripcion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.INTORDEN 
								Where   INTORDEN.CODIGO != ''
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
	Tabla = 'INTORDEN'
	Filtro = " INTORDEN.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " INTORDEN.CODIGO != ''"
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
	<row entidad="INTERACCIONDEORDEN                      " atributo="FECHAIMPO                               " tabla="INTORDEN       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="FECHAALTAFW                             " tabla="INTORDEN       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="FECHAEXPO                               " tabla="INTORDEN       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="FECHAMODIFICACIONFW                     " tabla="INTORDEN       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="FECHATRANSFERENCIA                      " tabla="INTORDEN       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="HORAMODIFICACIONFW                      " tabla="INTORDEN       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="SERIEALTAFW                             " tabla="INTORDEN       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="SERIEMODIFICACIONFW                     " tabla="INTORDEN       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="USUARIOMODIFICACIONFW                   " tabla="INTORDEN       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="USUARIOALTAFW                           " tabla="INTORDEN       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="ZADSFW                                  " tabla="INTORDEN       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="VERSIONALTAFW                           " tabla="INTORDEN       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="VERSIONMODIFICACIONFW                   " tabla="INTORDEN       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="HORAIMPO                                " tabla="INTORDEN       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="HORAALTAFW                              " tabla="INTORDEN       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="HORAEXPO                                " tabla="INTORDEN       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="INTORDEN       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="ESTADOTRANSFERENCIA                     " tabla="INTORDEN       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="INTORDEN       " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="ANULADO                                 " tabla="INTORDEN       " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="FECHA                                   " tabla="INTORDEN       " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="8" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="COLOR                                   " tabla="INTORDEN       " campo="CCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Color                                                                                                                                                           " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Orden.Color                                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="TALLE                                   " tabla="INTORDEN       " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Talle                                                                                                                                                           " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Orden.Talle                                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="ARTICULO                                " tabla="INTORDEN       " campo="ART       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Orden.Articulo                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="TIPODESCUENTO                           " tabla="INTORDEN       " campo="TIPODESC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="ESTADO                                  " tabla="INTORDEN       " campo="EST       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ESTADOSDEINTERACCION                    " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="32" etiqueta="Estado                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot;ESTINTERAC.CODIGO NOT IN ('REMITOAUTOMATICO','FACTURAAUTOMATICO','CERRADAAUTOMATICO','MODIFICACION') &quot;                                                                                                 " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="ORDEN                                   " tabla="INTORDEN       " campo="ORDEN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORDENDESERVICIO                         " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="14" etiqueta="Orden de servicio                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="OBS                                     " tabla="INTORDEN       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBINO     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICINO    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="COLORDESCRIPCION                        " tabla="INTORDEN       " campo="DESCOL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Color descripción                                                                                                                                               " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="TALLEDESCRIPCION                        " tabla="INTORDEN       " campo="DESCTALLE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Talle descripción                                                                                                                                               " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Talle.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="ARTICULODESCRIPCION                     " tabla="INTORDEN       " campo="DESCART   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Artículo descripción                                                                                                                                            " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="CLIENTE                                 " tabla="INTORDEN       " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Orden.Cliente                                                                                                                                                                                                                                                 " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="VALOR                                   " tabla="INTORDEN       " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="36" etiqueta="Valor                                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="HORA                                    " tabla="INTORDEN       " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="10" etiqueta="Hora                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="CODIGO                                  " tabla="INTORDEN       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="CLIENTEDESCRIPCION                      " tabla="INTORDEN       " campo="CLIDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Cliente descripción                                                                                                                                             " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="VENDEDOR                                " tabla="INTORDEN       " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="BASEDEDATOSALTAFW                       " tabla="INTORDEN       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.Zoo.App.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INTERACCIONDEORDEN                      " atributo="VENDEDORDESCRIPCION                     " tabla="INTORDEN       " campo="DESCVEND  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Vendedor descripción                                                                                                                                            " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Vendedor.Nombre                                                                                                                                                                                                                                               " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="25" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On INTORDEN.CCOLOR = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="29" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On INTORDEN.TALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On INTORDEN.ART = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOSDEINTERACCION                    " atributo="DESCRIPCION                             " tabla="ESTINTERAC     " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="33" etiqueta="Detalle Est.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ESTINTERAC On INTORDEN.EST = ESTINTERAC.Codigo And  ESTINTERAC.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDESERVICIO                         " atributo="FECHA                                   " tabla="ORDENSERV      " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="15" etiqueta="Detalle Ord.                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDENSERV On INTORDEN.ORDEN = ORDENSERV.Codigo And  ORDENSERV.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="17" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On INTORDEN.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On INTORDEN.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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