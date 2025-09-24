
define class Din_EntidadASIENTOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ASIENTO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.NUMERO, 8, 0)]
	cTagClaveCandidata = '_ASICC'
	cTagClavePk = '_ASIPK'
	cTablaPrincipal = 'ASIENTO'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxAsientoFecexpo, lxAsientoFaltafw, lxAsientoFecimpo, lxAsientoFmodifw, lxAsientoFectrans, lxAsientoCotiz, lxAsientoNumaper, lxAsientoEsttrans, lxAsientoSmodifw, lxAsientoHaltafw, lxAsientoHmodifw, lxAsientoHoraexpo, lxAsientoHoraimpo, lxAsientoSaltafw, lxAsientoBdmodifw, lxAsientoUmodifw, lxAsientoReversaa, lxAsientoValtafw, lxAsientoBdaltafw, lxAsientoRevpor, lxAsientoUaltafw, lxAsientoZadsfw, lxAsientoVmodifw, lxAsientoAcod, lxAsientoObs, lxAsientoFuente, lxAsientoEjercicio, lxAsientoContabiliz, lxAsientoCierreej, lxAsientoRsocial, lxAsientoNumero, lxAsientoFecha, lxAsientoTipoasient, lxAsientoClase, lxAsientoReferen, lxAsientoCcosto, lxAsientoMoneda
				lxAsientoFecexpo =  .Fechaexpo			lxAsientoFaltafw =  .Fechaaltafw			lxAsientoFecimpo =  .Fechaimpo			lxAsientoFmodifw =  .Fechamodificacionfw			lxAsientoFectrans =  .Fechatransferencia			lxAsientoCotiz =  .Cotizacion			lxAsientoNumaper =  .Numeroapertura			lxAsientoEsttrans =  .Estadotransferencia			lxAsientoSmodifw =  .Seriemodificacionfw			lxAsientoHaltafw =  .Horaaltafw			lxAsientoHmodifw =  .Horamodificacionfw			lxAsientoHoraexpo =  .Horaexpo			lxAsientoHoraimpo =  .Horaimpo			lxAsientoSaltafw =  .Seriealtafw			lxAsientoBdmodifw =  .Basededatosmodificacionfw			lxAsientoUmodifw =  .Usuariomodificacionfw			lxAsientoReversaa =  .Reversaa			lxAsientoValtafw =  .Versionaltafw			lxAsientoBdaltafw =  .Basededatosaltafw			lxAsientoRevpor =  .Reversadopor			lxAsientoUaltafw =  .Usuarioaltafw			lxAsientoZadsfw =  .Zadsfw			lxAsientoVmodifw =  .Versionmodificacionfw			lxAsientoAcod =  .Codigo			lxAsientoObs =  .Observacion			lxAsientoFuente =  .Fuente			lxAsientoEjercicio =  .Ejercicio_PK 			lxAsientoContabiliz =  .Contabilizacion			lxAsientoCierreej =  .Cierreejercicio			lxAsientoRsocial =  upper( .RazonSocial_PK ) 			lxAsientoNumero =  .Numero			lxAsientoFecha =  .Fecha			lxAsientoTipoasient =  .Tipo			lxAsientoClase =  .Clase			lxAsientoReferen =  .Referencia			lxAsientoCcosto =  upper( .CentroDeCosto_PK ) 			lxAsientoMoneda =  upper( .MonedaComprobante_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAsientoAcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ASIENTO ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Cotiz","Numaper","Esttrans","Smodifw","Haltafw","Hmodifw","Horaexpo","Horaimpo","Saltafw","Bdmodifw","Umodifw","Reversaa","Valtafw","Bdaltafw","Revpor","Ualtafw","Zadsfw","Vmodifw","Acod","Obs","Fuente","Ejercicio","Contabiliz","Cierreej","Rsocial","Numero","Fecha","Tipoasient","Clase","Referen","Ccosto","Moneda" ) values ( <<"'" + this.ConvertirDateSql( lxAsientoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAsientoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAsientoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAsientoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAsientoFectrans ) + "'" >>, <<lxAsientoCotiz >>, <<lxAsientoNumaper >>, <<"'" + this.FormatearTextoSql( lxAsientoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoReversaa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoRevpor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoAcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoFuente ) + "'" >>, <<lxAsientoEjercicio >>, <<lxAsientoContabiliz >>, <<lxAsientoCierreej >>, <<"'" + this.FormatearTextoSql( lxAsientoRsocial ) + "'" >>, <<lxAsientoNumero >>, <<"'" + this.ConvertirDateSql( lxAsientoFecha ) + "'" >>, <<lxAsientoTipoasient >>, <<lxAsientoClase >>, <<"'" + this.FormatearTextoSql( lxAsientoReferen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoCcosto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoMoneda ) + "'" >> )
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
			for each loItem in this.oEntidad.AsientoDetalle
				if this.oEntidad.AsientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxPlandecuentas_PK = loItem.Plandecuentas_PK
					lxPlandecuentasdetalle = loItem.Plandecuentasdetalle
					lxLeyenda = loItem.Leyenda
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDebe = loItem.Debe
					lxHaber = loItem.Haber
					lxSaldo = loItem.Saldo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ASIENTODET("NROITEM","CODIGO","PCUENTA","PCUENTAD","Leyenda","CODCCOS","DEBE","HABER","SALDO" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlandecuentas_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlandecuentasdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxLeyenda ) + "'">>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<lxDebe>>, <<lxHaber>>, <<lxSaldo>> ) 
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
			this.GenerarSentenciasComponentes()
			local  lxAsientoFecexpo, lxAsientoFaltafw, lxAsientoFecimpo, lxAsientoFmodifw, lxAsientoFectrans, lxAsientoCotiz, lxAsientoNumaper, lxAsientoEsttrans, lxAsientoSmodifw, lxAsientoHaltafw, lxAsientoHmodifw, lxAsientoHoraexpo, lxAsientoHoraimpo, lxAsientoSaltafw, lxAsientoBdmodifw, lxAsientoUmodifw, lxAsientoReversaa, lxAsientoValtafw, lxAsientoBdaltafw, lxAsientoRevpor, lxAsientoUaltafw, lxAsientoZadsfw, lxAsientoVmodifw, lxAsientoAcod, lxAsientoObs, lxAsientoFuente, lxAsientoEjercicio, lxAsientoContabiliz, lxAsientoCierreej, lxAsientoRsocial, lxAsientoNumero, lxAsientoFecha, lxAsientoTipoasient, lxAsientoClase, lxAsientoReferen, lxAsientoCcosto, lxAsientoMoneda
				lxAsientoFecexpo =  .Fechaexpo			lxAsientoFaltafw =  .Fechaaltafw			lxAsientoFecimpo =  .Fechaimpo			lxAsientoFmodifw =  .Fechamodificacionfw			lxAsientoFectrans =  .Fechatransferencia			lxAsientoCotiz =  .Cotizacion			lxAsientoNumaper =  .Numeroapertura			lxAsientoEsttrans =  .Estadotransferencia			lxAsientoSmodifw =  .Seriemodificacionfw			lxAsientoHaltafw =  .Horaaltafw			lxAsientoHmodifw =  .Horamodificacionfw			lxAsientoHoraexpo =  .Horaexpo			lxAsientoHoraimpo =  .Horaimpo			lxAsientoSaltafw =  .Seriealtafw			lxAsientoBdmodifw =  .Basededatosmodificacionfw			lxAsientoUmodifw =  .Usuariomodificacionfw			lxAsientoReversaa =  .Reversaa			lxAsientoValtafw =  .Versionaltafw			lxAsientoBdaltafw =  .Basededatosaltafw			lxAsientoRevpor =  .Reversadopor			lxAsientoUaltafw =  .Usuarioaltafw			lxAsientoZadsfw =  .Zadsfw			lxAsientoVmodifw =  .Versionmodificacionfw			lxAsientoAcod =  .Codigo			lxAsientoObs =  .Observacion			lxAsientoFuente =  .Fuente			lxAsientoEjercicio =  .Ejercicio_PK 			lxAsientoContabiliz =  .Contabilizacion			lxAsientoCierreej =  .Cierreejercicio			lxAsientoRsocial =  upper( .RazonSocial_PK ) 			lxAsientoNumero =  .Numero			lxAsientoFecha =  .Fecha			lxAsientoTipoasient =  .Tipo			lxAsientoClase =  .Clase			lxAsientoReferen =  .Referencia			lxAsientoCcosto =  upper( .CentroDeCosto_PK ) 			lxAsientoMoneda =  upper( .MonedaComprobante_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ASIENTO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAsientoFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAsientoFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAsientoFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAsientoFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAsientoFectrans ) + "'">>,"Cotiz" = <<lxAsientoCotiz>>,"Numaper" = <<lxAsientoNumaper>>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAsientoEsttrans ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAsientoSmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAsientoHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAsientoHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAsientoHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAsientoHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAsientoSaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAsientoBdmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAsientoUmodifw ) + "'">>,"Reversaa" = <<"'" + this.FormatearTextoSql( lxAsientoReversaa ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAsientoValtafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAsientoBdaltafw ) + "'">>,"Revpor" = <<"'" + this.FormatearTextoSql( lxAsientoRevpor ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAsientoUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAsientoZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAsientoVmodifw ) + "'">>,"Acod" = <<"'" + this.FormatearTextoSql( lxAsientoAcod ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxAsientoObs ) + "'">>,"Fuente" = <<"'" + this.FormatearTextoSql( lxAsientoFuente ) + "'">>,"Ejercicio" = <<lxAsientoEjercicio>>,"Contabiliz" = <<lxAsientoContabiliz>>,"Cierreej" = <<lxAsientoCierreej>>,"Rsocial" = <<"'" + this.FormatearTextoSql( lxAsientoRsocial ) + "'">>,"Numero" = <<lxAsientoNumero>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxAsientoFecha ) + "'">>,"Tipoasient" = <<lxAsientoTipoasient>>,"Clase" = <<lxAsientoClase>>,"Referen" = <<"'" + this.FormatearTextoSql( lxAsientoReferen ) + "'">>,"Ccosto" = <<"'" + this.FormatearTextoSql( lxAsientoCcosto ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxAsientoMoneda ) + "'">> where "Acod" = <<"'" + this.FormatearTextoSql( lxAsientoAcod ) + "'">> and  ASIENTO.ACOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ASIENTODET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AsientoDetalle
				if this.oEntidad.AsientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxPlandecuentas_PK = loItem.Plandecuentas_PK
					lxPlandecuentasdetalle = loItem.Plandecuentasdetalle
					lxLeyenda = loItem.Leyenda
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDebe = loItem.Debe
					lxHaber = loItem.Haber
					lxSaldo = loItem.Saldo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ASIENTODET("NROITEM","CODIGO","PCUENTA","PCUENTAD","Leyenda","CODCCOS","DEBE","HABER","SALDO" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlandecuentas_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlandecuentasdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxLeyenda ) + "'">>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<lxDebe>>, <<lxHaber>>, <<lxSaldo>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ACOD from ZooLogic.ASIENTO where " + this.ConvertirFuncionesSql( " ASIENTO.ACOD != ''" ) )
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
			Local lxAsientoAcod
			lxAsientoAcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Numaper" as "Numeroapertura", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Reversaa" as "Reversaa", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Revpor" as "Reversadopor", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Acod" as "Codigo", "Obs" as "Observacion", "Fuente" as "Fuente", "Ejercicio" as "Ejercicio", "Contabiliz" as "Contabilizacion", "Cierreej" as "Cierreejercicio", "Rsocial" as "Razonsocial", "Numero" as "Numero", "Fecha" as "Fecha", "Tipoasient" as "Tipo", "Clase" as "Clase", "Referen" as "Referencia", "Ccosto" as "Centrodecosto", "Moneda" as "Monedacomprobante" from ZooLogic.ASIENTO where "Acod" = <<"'" + this.FormatearTextoSql( lxAsientoAcod ) + "'">> and  ASIENTO.ACOD != ''
			endtext
			use in select('c_ASIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ASIENTO', set( 'Datasession' ) )

			if reccount( 'c_ASIENTO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Pcuenta" as "Plandecuentas", "Pcuentad" as "Plandecuentasdetalle", "Leyenda" as "Leyenda", "Codccos" as "Centrodecosto", "Debe" as "Debe", "Haber" as "Haber", "Saldo" as "Saldo" from ZooLogic.ASIENTODET where CODIGO = <<"'" + this.FormatearTextoSql( c_ASIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AsientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AsientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AsientoDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxASIENTONUMERO As Variant
			lxASIENTONUMERO = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Numaper" as "Numeroapertura", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Reversaa" as "Reversaa", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Revpor" as "Reversadopor", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Acod" as "Codigo", "Obs" as "Observacion", "Fuente" as "Fuente", "Ejercicio" as "Ejercicio", "Contabiliz" as "Contabilizacion", "Cierreej" as "Cierreejercicio", "Rsocial" as "Razonsocial", "Numero" as "Numero", "Fecha" as "Fecha", "Tipoasient" as "Tipo", "Clase" as "Clase", "Referen" as "Referencia", "Ccosto" as "Centrodecosto", "Moneda" as "Monedacomprobante" from ZooLogic.ASIENTO where  ASIENTO.ACOD != '' And NUMERO = <<lxASIENTONUMERO>>
			endtext
			use in select('c_ASIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ASIENTO', set( 'Datasession' ) )
			if reccount( 'c_ASIENTO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Pcuenta" as "Plandecuentas", "Pcuentad" as "Plandecuentasdetalle", "Leyenda" as "Leyenda", "Codccos" as "Centrodecosto", "Debe" as "Debe", "Haber" as "Haber", "Saldo" as "Saldo" from ZooLogic.ASIENTODET where CODIGO = <<"'" + this.FormatearTextoSql( c_ASIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AsientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AsientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AsientoDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAsientoAcod as Variant
		llRetorno = .t.
		lxAsientoAcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ASIENTO where "Acod" = <<"'" + this.FormatearTextoSql( lxAsientoAcod ) + "'">> and  ASIENTO.ACOD != ''
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
				lcOrden =  str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Numaper" as "Numeroapertura", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Reversaa" as "Reversaa", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Revpor" as "Reversadopor", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Acod" as "Codigo", "Obs" as "Observacion", "Fuente" as "Fuente", "Ejercicio" as "Ejercicio", "Contabiliz" as "Contabilizacion", "Cierreej" as "Cierreejercicio", "Rsocial" as "Razonsocial", "Numero" as "Numero", "Fecha" as "Fecha", "Tipoasient" as "Tipo", "Clase" as "Clase", "Referen" as "Referencia", "Ccosto" as "Centrodecosto", "Moneda" as "Monedacomprobante" from ZooLogic.ASIENTO where  ASIENTO.ACOD != '' order by NUMERO,ACOD
			endtext
			use in select('c_ASIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ASIENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Pcuenta" as "Plandecuentas", "Pcuentad" as "Plandecuentasdetalle", "Leyenda" as "Leyenda", "Codccos" as "Centrodecosto", "Debe" as "Debe", "Haber" as "Haber", "Saldo" as "Saldo" from ZooLogic.ASIENTODET where CODIGO = <<"'" + this.FormatearTextoSql( c_ASIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AsientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AsientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AsientoDetalle
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
				lcOrden =  str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Numaper" as "Numeroapertura", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Reversaa" as "Reversaa", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Revpor" as "Reversadopor", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Acod" as "Codigo", "Obs" as "Observacion", "Fuente" as "Fuente", "Ejercicio" as "Ejercicio", "Contabiliz" as "Contabilizacion", "Cierreej" as "Cierreejercicio", "Rsocial" as "Razonsocial", "Numero" as "Numero", "Fecha" as "Fecha", "Tipoasient" as "Tipo", "Clase" as "Clase", "Referen" as "Referencia", "Ccosto" as "Centrodecosto", "Moneda" as "Monedacomprobante" from ZooLogic.ASIENTO where  str( NUMERO, 8, 0) + funciones.padr( ACOD, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ASIENTO.ACOD != '' order by NUMERO,ACOD
			endtext
			use in select('c_ASIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ASIENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Pcuenta" as "Plandecuentas", "Pcuentad" as "Plandecuentasdetalle", "Leyenda" as "Leyenda", "Codccos" as "Centrodecosto", "Debe" as "Debe", "Haber" as "Haber", "Saldo" as "Saldo" from ZooLogic.ASIENTODET where CODIGO = <<"'" + this.FormatearTextoSql( c_ASIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AsientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AsientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AsientoDetalle
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
				lcOrden =  str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Numaper" as "Numeroapertura", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Reversaa" as "Reversaa", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Revpor" as "Reversadopor", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Acod" as "Codigo", "Obs" as "Observacion", "Fuente" as "Fuente", "Ejercicio" as "Ejercicio", "Contabiliz" as "Contabilizacion", "Cierreej" as "Cierreejercicio", "Rsocial" as "Razonsocial", "Numero" as "Numero", "Fecha" as "Fecha", "Tipoasient" as "Tipo", "Clase" as "Clase", "Referen" as "Referencia", "Ccosto" as "Centrodecosto", "Moneda" as "Monedacomprobante" from ZooLogic.ASIENTO where  str( NUMERO, 8, 0) + funciones.padr( ACOD, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ASIENTO.ACOD != '' order by NUMERO desc,ACOD desc
			endtext
			use in select('c_ASIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ASIENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Pcuenta" as "Plandecuentas", "Pcuentad" as "Plandecuentasdetalle", "Leyenda" as "Leyenda", "Codccos" as "Centrodecosto", "Debe" as "Debe", "Haber" as "Haber", "Saldo" as "Saldo" from ZooLogic.ASIENTODET where CODIGO = <<"'" + this.FormatearTextoSql( c_ASIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AsientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AsientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AsientoDetalle
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
				lcOrden =  str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Numaper" as "Numeroapertura", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Reversaa" as "Reversaa", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Revpor" as "Reversadopor", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Acod" as "Codigo", "Obs" as "Observacion", "Fuente" as "Fuente", "Ejercicio" as "Ejercicio", "Contabiliz" as "Contabilizacion", "Cierreej" as "Cierreejercicio", "Rsocial" as "Razonsocial", "Numero" as "Numero", "Fecha" as "Fecha", "Tipoasient" as "Tipo", "Clase" as "Clase", "Referen" as "Referencia", "Ccosto" as "Centrodecosto", "Moneda" as "Monedacomprobante" from ZooLogic.ASIENTO where  ASIENTO.ACOD != '' order by NUMERO desc,ACOD desc
			endtext
			use in select('c_ASIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ASIENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Pcuenta" as "Plandecuentas", "Pcuentad" as "Plandecuentasdetalle", "Leyenda" as "Leyenda", "Codccos" as "Centrodecosto", "Debe" as "Debe", "Haber" as "Haber", "Saldo" as "Saldo" from ZooLogic.ASIENTODET where CODIGO = <<"'" + this.FormatearTextoSql( c_ASIENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AsientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AsientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AsientoDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Cotiz,Numaper,Esttrans,Smodifw,Haltafw,Hmodifw,Hora" + ;
"expo,Horaimpo,Saltafw,Bdmodifw,Umodifw,Reversaa,Valtafw,Bdaltafw,Revpor,Ualtafw,Zadsfw,Vmodifw,Acod," + ;
"Obs,Fuente,Ejercicio,Contabiliz,Cierreej,Rsocial,Numero,Fecha,Tipoasient,Clase,Referen,Ccosto,Moneda" + ;
" from ZooLogic.ASIENTO where  ASIENTO.ACOD != '' and " + lcFiltro )
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
			local  lxAsientoFecexpo, lxAsientoFaltafw, lxAsientoFecimpo, lxAsientoFmodifw, lxAsientoFectrans, lxAsientoCotiz, lxAsientoNumaper, lxAsientoEsttrans, lxAsientoSmodifw, lxAsientoHaltafw, lxAsientoHmodifw, lxAsientoHoraexpo, lxAsientoHoraimpo, lxAsientoSaltafw, lxAsientoBdmodifw, lxAsientoUmodifw, lxAsientoReversaa, lxAsientoValtafw, lxAsientoBdaltafw, lxAsientoRevpor, lxAsientoUaltafw, lxAsientoZadsfw, lxAsientoVmodifw, lxAsientoAcod, lxAsientoObs, lxAsientoFuente, lxAsientoEjercicio, lxAsientoContabiliz, lxAsientoCierreej, lxAsientoRsocial, lxAsientoNumero, lxAsientoFecha, lxAsientoTipoasient, lxAsientoClase, lxAsientoReferen, lxAsientoCcosto, lxAsientoMoneda
				lxAsientoFecexpo = ctod( '  /  /    ' )			lxAsientoFaltafw = ctod( '  /  /    ' )			lxAsientoFecimpo = ctod( '  /  /    ' )			lxAsientoFmodifw = ctod( '  /  /    ' )			lxAsientoFectrans = ctod( '  /  /    ' )			lxAsientoCotiz = 0			lxAsientoNumaper = 0			lxAsientoEsttrans = []			lxAsientoSmodifw = []			lxAsientoHaltafw = []			lxAsientoHmodifw = []			lxAsientoHoraexpo = []			lxAsientoHoraimpo = []			lxAsientoSaltafw = []			lxAsientoBdmodifw = []			lxAsientoUmodifw = []			lxAsientoReversaa = []			lxAsientoValtafw = []			lxAsientoBdaltafw = []			lxAsientoRevpor = []			lxAsientoUaltafw = []			lxAsientoZadsfw = []			lxAsientoVmodifw = []			lxAsientoAcod = []			lxAsientoObs = []			lxAsientoFuente = []			lxAsientoEjercicio = 0			lxAsientoContabiliz = 0			lxAsientoCierreej = 0			lxAsientoRsocial = []			lxAsientoNumero = 0			lxAsientoFecha = ctod( '  /  /    ' )			lxAsientoTipoasient = 0			lxAsientoClase = 0			lxAsientoReferen = []			lxAsientoCcosto = []			lxAsientoMoneda = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ASIENTODET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ASIENTO where "ACOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'ASIENTO' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where ACOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(ACOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ASIENTO.ACOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Numaper" as "Numeroapertura", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Reversaa" as "Reversaa", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Revpor" as "Reversadopor", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Acod" as "Codigo", "Obs" as "Observacion", "Fuente" as "Fuente", "Ejercicio" as "Ejercicio", "Contabiliz" as "Contabilizacion", "Cierreej" as "Cierreejercicio", "Rsocial" as "Razonsocial", "Numero" as "Numero", "Fecha" as "Fecha", "Tipoasient" as "Tipo", "Clase" as "Clase", "Referen" as "Referencia", "Ccosto" as "Centrodecosto", "Moneda" as "Monedacomprobante"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ASIENTO', '', tnTope )
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
	Function ObtenerDatosDetalleAsientoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ASIENTODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Pcuenta" as "Plandecuentas", "Pcuentad" as "Plandecuentasdetalle", "Leyenda" as "Leyenda", "Codccos" as "Centrodecosto", "Debe" as "Debe", "Haber" as "Haber", "Saldo" as "Saldo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAsientoDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ASIENTODET', 'AsientoDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAsientoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAsientoDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'NUMEROAPERTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMAPER AS NUMEROAPERTURA'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'REVERSAA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REVERSAA AS REVERSAA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'REVERSADOPOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REVPOR AS REVERSADOPOR'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'FUENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUENTE AS FUENTE'
				Case lcAtributo == 'EJERCICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EJERCICIO AS EJERCICIO'
				Case lcAtributo == 'CONTABILIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONTABILIZ AS CONTABILIZACION'
				Case lcAtributo == 'CIERREEJERCICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIERREEJ AS CIERREEJERCICIO'
				Case lcAtributo == 'RAZONSOCIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RSOCIAL AS RAZONSOCIAL'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOASIENT AS TIPO'
				Case lcAtributo == 'CLASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASE AS CLASE'
				Case lcAtributo == 'REFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REFEREN AS REFERENCIA'
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOSTO AS CENTRODECOSTO'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAsientoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
				Case lcAtributo == 'PLANDECUENTASDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTAD AS PLANDECUENTASDETALLE'
				Case lcAtributo == 'LEYENDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LEYENDA AS LEYENDA'
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCCOS AS CENTRODECOSTO'
				Case lcAtributo == 'DEBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DEBE AS DEBE'
				Case lcAtributo == 'HABER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HABER AS HABER'
				Case lcAtributo == 'SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALDO AS SALDO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROAPERTURA'
				lcCampo = 'NUMAPER'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'REVERSAA'
				lcCampo = 'REVERSAA'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'REVERSADOPOR'
				lcCampo = 'REVPOR'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ACOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'FUENTE'
				lcCampo = 'FUENTE'
			Case upper( alltrim( tcAtributo ) ) == 'EJERCICIO'
				lcCampo = 'EJERCICIO'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZACION'
				lcCampo = 'CONTABILIZ'
			Case upper( alltrim( tcAtributo ) ) == 'CIERREEJERCICIO'
				lcCampo = 'CIERREEJ'
			Case upper( alltrim( tcAtributo ) ) == 'RAZONSOCIAL'
				lcCampo = 'RSOCIAL'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPOASIENT'
			Case upper( alltrim( tcAtributo ) ) == 'CLASE'
				lcCampo = 'CLASE'
			Case upper( alltrim( tcAtributo ) ) == 'REFERENCIA'
				lcCampo = 'REFEREN'
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAsientoDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTASDETALLE'
				lcCampo = 'PCUENTAD'
			Case upper( alltrim( tcAtributo ) ) == 'LEYENDA'
				lcCampo = 'LEYENDA'
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CODCCOS'
			Case upper( alltrim( tcAtributo ) ) == 'DEBE'
				lcCampo = 'DEBE'
			Case upper( alltrim( tcAtributo ) ) == 'HABER'
				lcCampo = 'HABER'
			Case upper( alltrim( tcAtributo ) ) == 'SALDO'
				lcCampo = 'SALDO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ASIENTODETALLE'
			lcRetorno = 'ASIENTODET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAsientoFecexpo, lxAsientoFaltafw, lxAsientoFecimpo, lxAsientoFmodifw, lxAsientoFectrans, lxAsientoCotiz, lxAsientoNumaper, lxAsientoEsttrans, lxAsientoSmodifw, lxAsientoHaltafw, lxAsientoHmodifw, lxAsientoHoraexpo, lxAsientoHoraimpo, lxAsientoSaltafw, lxAsientoBdmodifw, lxAsientoUmodifw, lxAsientoReversaa, lxAsientoValtafw, lxAsientoBdaltafw, lxAsientoRevpor, lxAsientoUaltafw, lxAsientoZadsfw, lxAsientoVmodifw, lxAsientoAcod, lxAsientoObs, lxAsientoFuente, lxAsientoEjercicio, lxAsientoContabiliz, lxAsientoCierreej, lxAsientoRsocial, lxAsientoNumero, lxAsientoFecha, lxAsientoTipoasient, lxAsientoClase, lxAsientoReferen, lxAsientoCcosto, lxAsientoMoneda
				lxAsientoFecexpo =  .Fechaexpo			lxAsientoFaltafw =  .Fechaaltafw			lxAsientoFecimpo =  .Fechaimpo			lxAsientoFmodifw =  .Fechamodificacionfw			lxAsientoFectrans =  .Fechatransferencia			lxAsientoCotiz =  .Cotizacion			lxAsientoNumaper =  .Numeroapertura			lxAsientoEsttrans =  .Estadotransferencia			lxAsientoSmodifw =  .Seriemodificacionfw			lxAsientoHaltafw =  .Horaaltafw			lxAsientoHmodifw =  .Horamodificacionfw			lxAsientoHoraexpo =  .Horaexpo			lxAsientoHoraimpo =  .Horaimpo			lxAsientoSaltafw =  .Seriealtafw			lxAsientoBdmodifw =  .Basededatosmodificacionfw			lxAsientoUmodifw =  .Usuariomodificacionfw			lxAsientoReversaa =  .Reversaa			lxAsientoValtafw =  .Versionaltafw			lxAsientoBdaltafw =  .Basededatosaltafw			lxAsientoRevpor =  .Reversadopor			lxAsientoUaltafw =  .Usuarioaltafw			lxAsientoZadsfw =  .Zadsfw			lxAsientoVmodifw =  .Versionmodificacionfw			lxAsientoAcod =  .Codigo			lxAsientoObs =  .Observacion			lxAsientoFuente =  .Fuente			lxAsientoEjercicio =  .Ejercicio_PK 			lxAsientoContabiliz =  .Contabilizacion			lxAsientoCierreej =  .Cierreejercicio			lxAsientoRsocial =  upper( .RazonSocial_PK ) 			lxAsientoNumero =  .Numero			lxAsientoFecha =  .Fecha			lxAsientoTipoasient =  .Tipo			lxAsientoClase =  .Clase			lxAsientoReferen =  .Referencia			lxAsientoCcosto =  upper( .CentroDeCosto_PK ) 			lxAsientoMoneda =  upper( .MonedaComprobante_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ASIENTO ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Cotiz","Numaper","Esttrans","Smodifw","Haltafw","Hmodifw","Horaexpo","Horaimpo","Saltafw","Bdmodifw","Umodifw","Reversaa","Valtafw","Bdaltafw","Revpor","Ualtafw","Zadsfw","Vmodifw","Acod","Obs","Fuente","Ejercicio","Contabiliz","Cierreej","Rsocial","Numero","Fecha","Tipoasient","Clase","Referen","Ccosto","Moneda" ) values ( <<"'" + this.ConvertirDateSql( lxAsientoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAsientoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAsientoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAsientoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAsientoFectrans ) + "'" >>, <<lxAsientoCotiz >>, <<lxAsientoNumaper >>, <<"'" + this.FormatearTextoSql( lxAsientoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoReversaa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoRevpor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoAcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoFuente ) + "'" >>, <<lxAsientoEjercicio >>, <<lxAsientoContabiliz >>, <<lxAsientoCierreej >>, <<"'" + this.FormatearTextoSql( lxAsientoRsocial ) + "'" >>, <<lxAsientoNumero >>, <<"'" + this.ConvertirDateSql( lxAsientoFecha ) + "'" >>, <<lxAsientoTipoasient >>, <<lxAsientoClase >>, <<"'" + this.FormatearTextoSql( lxAsientoReferen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoCcosto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAsientoMoneda ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ASIENTO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AsientoDetalle
				if this.oEntidad.AsientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxPlandecuentas_PK = loItem.Plandecuentas_PK
					lxPlandecuentasdetalle = loItem.Plandecuentasdetalle
					lxLeyenda = loItem.Leyenda
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDebe = loItem.Debe
					lxHaber = loItem.Haber
					lxSaldo = loItem.Saldo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ASIENTODET("NROITEM","CODIGO","PCUENTA","PCUENTAD","Leyenda","CODCCOS","DEBE","HABER","SALDO" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxPlandecuentas_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlandecuentasdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxLeyenda ) + "'">>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<lxDebe>>, <<lxHaber>>, <<lxSaldo>> ) 
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
			local  lxAsientoFecexpo, lxAsientoFaltafw, lxAsientoFecimpo, lxAsientoFmodifw, lxAsientoFectrans, lxAsientoCotiz, lxAsientoNumaper, lxAsientoEsttrans, lxAsientoSmodifw, lxAsientoHaltafw, lxAsientoHmodifw, lxAsientoHoraexpo, lxAsientoHoraimpo, lxAsientoSaltafw, lxAsientoBdmodifw, lxAsientoUmodifw, lxAsientoReversaa, lxAsientoValtafw, lxAsientoBdaltafw, lxAsientoRevpor, lxAsientoUaltafw, lxAsientoZadsfw, lxAsientoVmodifw, lxAsientoAcod, lxAsientoObs, lxAsientoFuente, lxAsientoEjercicio, lxAsientoContabiliz, lxAsientoCierreej, lxAsientoRsocial, lxAsientoNumero, lxAsientoFecha, lxAsientoTipoasient, lxAsientoClase, lxAsientoReferen, lxAsientoCcosto, lxAsientoMoneda
				lxAsientoFecexpo =  .Fechaexpo			lxAsientoFaltafw =  .Fechaaltafw			lxAsientoFecimpo =  .Fechaimpo			lxAsientoFmodifw =  .Fechamodificacionfw			lxAsientoFectrans =  .Fechatransferencia			lxAsientoCotiz =  .Cotizacion			lxAsientoNumaper =  .Numeroapertura			lxAsientoEsttrans =  .Estadotransferencia			lxAsientoSmodifw =  .Seriemodificacionfw			lxAsientoHaltafw =  .Horaaltafw			lxAsientoHmodifw =  .Horamodificacionfw			lxAsientoHoraexpo =  .Horaexpo			lxAsientoHoraimpo =  .Horaimpo			lxAsientoSaltafw =  .Seriealtafw			lxAsientoBdmodifw =  .Basededatosmodificacionfw			lxAsientoUmodifw =  .Usuariomodificacionfw			lxAsientoReversaa =  .Reversaa			lxAsientoValtafw =  .Versionaltafw			lxAsientoBdaltafw =  .Basededatosaltafw			lxAsientoRevpor =  .Reversadopor			lxAsientoUaltafw =  .Usuarioaltafw			lxAsientoZadsfw =  .Zadsfw			lxAsientoVmodifw =  .Versionmodificacionfw			lxAsientoAcod =  .Codigo			lxAsientoObs =  .Observacion			lxAsientoFuente =  .Fuente			lxAsientoEjercicio =  .Ejercicio_PK 			lxAsientoContabiliz =  .Contabilizacion			lxAsientoCierreej =  .Cierreejercicio			lxAsientoRsocial =  upper( .RazonSocial_PK ) 			lxAsientoNumero =  .Numero			lxAsientoFecha =  .Fecha			lxAsientoTipoasient =  .Tipo			lxAsientoClase =  .Clase			lxAsientoReferen =  .Referencia			lxAsientoCcosto =  upper( .CentroDeCosto_PK ) 			lxAsientoMoneda =  upper( .MonedaComprobante_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Acod" = ] + lcValorClavePrimariaString  + [ and  ASIENTO.ACOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ASIENTO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAsientoFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAsientoFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAsientoFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAsientoFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAsientoFectrans ) + "'">>, "Cotiz" = <<lxAsientoCotiz>>, "Numaper" = <<lxAsientoNumaper>>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAsientoEsttrans ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAsientoSmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAsientoHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAsientoHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAsientoHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAsientoHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAsientoSaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAsientoBdmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAsientoUmodifw ) + "'">>, "Reversaa" = <<"'" + this.FormatearTextoSql( lxAsientoReversaa ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAsientoValtafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAsientoBdaltafw ) + "'">>, "Revpor" = <<"'" + this.FormatearTextoSql( lxAsientoRevpor ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAsientoUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAsientoZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAsientoVmodifw ) + "'">>, "Acod" = <<"'" + this.FormatearTextoSql( lxAsientoAcod ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxAsientoObs ) + "'">>, "Fuente" = <<"'" + this.FormatearTextoSql( lxAsientoFuente ) + "'">>, "Ejercicio" = <<lxAsientoEjercicio>>, "Contabiliz" = <<lxAsientoContabiliz>>, "Cierreej" = <<lxAsientoCierreej>>, "Rsocial" = <<"'" + this.FormatearTextoSql( lxAsientoRsocial ) + "'">>, "Numero" = <<lxAsientoNumero>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxAsientoFecha ) + "'">>, "Tipoasient" = <<lxAsientoTipoasient>>, "Clase" = <<lxAsientoClase>>, "Referen" = <<"'" + this.FormatearTextoSql( lxAsientoReferen ) + "'">>, "Ccosto" = <<"'" + this.FormatearTextoSql( lxAsientoCcosto ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxAsientoMoneda ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ASIENTO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ASIENTODET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AsientoDetalle
				if this.oEntidad.AsientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxPlandecuentas_PK = loItem.Plandecuentas_PK
					lxPlandecuentasdetalle = loItem.Plandecuentasdetalle
					lxLeyenda = loItem.Leyenda
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDebe = loItem.Debe
					lxHaber = loItem.Haber
					lxSaldo = loItem.Saldo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ASIENTODET("NROITEM","CODIGO","PCUENTA","PCUENTAD","Leyenda","CODCCOS","DEBE","HABER","SALDO" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxPlandecuentas_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlandecuentasdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxLeyenda ) + "'">>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<lxDebe>>, <<lxHaber>>, <<lxSaldo>> ) 
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

			lcFiltro = ["Acod" = ] + lcValorClavePrimariaString  + [ and  ASIENTO.ACOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ASIENTO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ASIENTODET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ASIENTO' 
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
		
			.oCompAsiento.lNuevo = .EsNuevo()
			.oCompAsiento.lEdicion = .EsEdicion()
			.oCompAsiento.lEliminar = .lEliminar
			.oCompAsiento.lAnular = .lAnular
			loColSentencias = .oCompAsiento.grabar()
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
			lcRetorno = [update ZooLogic.ASIENTO set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where ACOD = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  ASIENTO.ACOD != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ASIENTO where  ASIENTO.ACOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ASIENTO where ACOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ASIENTO.ACOD != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxASIENTONUMERO as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ASIENTO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ASIENTO Where  NUMERO = ] + transform( &lcCursor..NUMERO     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..ACOD
				if lxValorClavePK == curSeek.ACOD or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.ACOD and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.ACOD
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.ASIENTO set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, NumAper = ] + transform( &lcCursor..NumAper )+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ReversaA = ] + "'" + this.FormatearTextoSql( &lcCursor..ReversaA ) + "'"+ [, RevPor = ] + "'" + this.FormatearTextoSql( &lcCursor..RevPor ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ACOD = ] + "'" + this.FormatearTextoSql( &lcCursor..ACOD ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Fuente = ] + "'" + this.FormatearTextoSql( &lcCursor..Fuente ) + "'"+ [, Ejercicio = ] + transform( &lcCursor..Ejercicio )+ [, Contabiliz = ] + transform( &lcCursor..Contabiliz )+ [, CierreEj = ] + transform( &lcCursor..CierreEj )+ [, RSOCIAL = ] + "'" + this.FormatearTextoSql( &lcCursor..RSOCIAL ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, TipoAsient = ] + transform( &lcCursor..TipoAsient )+ [, Clase = ] + transform( &lcCursor..Clase )+ [, REFEREN = ] + "'" + this.FormatearTextoSql( &lcCursor..REFEREN ) + "'"+ [, CCOSTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CCOSTO ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + [ Where ACOD = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.ASIENTO Where ACOD = ] + "'" + this.FormatearTextoSql( &lcCursor..ACOD ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FECIMPO, FMODIFW, FECTRANS, Cotiz, NumAper, ESTTRANS, SMODIFW, HALTAFW, HMODIFW, HORAEXPO, HORAIMPO, SALTAFW, BDMODIFW, UMODIFW, ReversaA, VALTAFW, BDALTAFW, RevPor, UALTAFW, ZADSFW, VMODIFW, ACOD, Obs, Fuente, Ejercicio, Contabiliz, CierreEj, RSOCIAL, NUMERO, Fecha, TipoAsient, Clase, REFEREN, CCOSTO, Moneda
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..NumAper ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ReversaA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RevPor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ACOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Fuente ) + "'" + ',' + transform( &lcCursor..Ejercicio ) + ',' + transform( &lcCursor..Contabiliz ) + ',' + transform( &lcCursor..CierreEj ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..RSOCIAL ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NUMERO ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + transform( &lcCursor..TipoAsient ) + ',' + transform( &lcCursor..Clase ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..REFEREN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCOSTO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.ASIENTO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ASIENTO'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'ACOD','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','ACOD')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ASIENTODET Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMASIENTO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select ACOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CODIGO","PCUENTA","PCUENTAD","Leyenda","CODCCOS","DEBE","HABER","SALDO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ASIENTODET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.PCUENTA    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.PCUENTAD   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Leyenda    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODCCOS    ) + "'" + ',' + transform( cDetallesExistentes.DEBE       ) + ',' + transform( cDetallesExistentes.HABER      ) + ',' + transform( cDetallesExistentes.SALDO      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( ACOD C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Asiento número: ' + transform( &tcCursor..NUMERO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ASIENTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ASIENTO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ASIENTO_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMASIENTO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ASIENTO')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ASIENTO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ACOD
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..NUMERO )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ASIENTO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ASIENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,ACOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( ACOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ASIENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ASIENTO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ASIENTO
Create Table ZooLogic.TablaTrabajo_ASIENTO ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"cotiz" numeric( 15, 5 )  null, 
"numaper" numeric( 8, 0 )  null, 
"esttrans" char( 20 )  null, 
"smodifw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"reversaa" char( 20 )  null, 
"valtafw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"revpor" char( 20 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"acod" char( 20 )  null, 
"obs" varchar(max)  null, 
"fuente" char( 10 )  null, 
"ejercicio" numeric( 8, 0 )  null, 
"contabiliz" numeric( 8, 0 )  null, 
"cierreej" numeric( 8, 0 )  null, 
"rsocial" char( 10 )  null, 
"numero" numeric( 8, 0 )  null, 
"fecha" datetime  null, 
"tipoasient" numeric( 1, 0 )  null, 
"clase" numeric( 1, 0 )  null, 
"referen" char( 150 )  null, 
"ccosto" char( 20 )  null, 
"moneda" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ASIENTO' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ASIENTO' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ASIENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('numaper','numaper')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('reversaa','reversaa')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('revpor','revpor')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('acod','acod')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('fuente','fuente')
			.AgregarMapeo('ejercicio','ejercicio')
			.AgregarMapeo('contabiliz','contabiliz')
			.AgregarMapeo('cierreej','cierreej')
			.AgregarMapeo('rsocial','rsocial')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('tipoasient','tipoasient')
			.AgregarMapeo('clase','clase')
			.AgregarMapeo('referen','referen')
			.AgregarMapeo('ccosto','ccosto')
			.AgregarMapeo('moneda','moneda')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ASIENTO'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.NUMAPER = isnull( d.NUMAPER, t.NUMAPER ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.REVERSAA = isnull( d.REVERSAA, t.REVERSAA ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.REVPOR = isnull( d.REVPOR, t.REVPOR ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ACOD = isnull( d.ACOD, t.ACOD ),t.OBS = isnull( d.OBS, t.OBS ),t.FUENTE = isnull( d.FUENTE, t.FUENTE ),t.EJERCICIO = isnull( d.EJERCICIO, t.EJERCICIO ),t.CONTABILIZ = isnull( d.CONTABILIZ, t.CONTABILIZ ),t.CIERREEJ = isnull( d.CIERREEJ, t.CIERREEJ ),t.RSOCIAL = isnull( d.RSOCIAL, t.RSOCIAL ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.TIPOASIENT = isnull( d.TIPOASIENT, t.TIPOASIENT ),t.CLASE = isnull( d.CLASE, t.CLASE ),t.REFEREN = isnull( d.REFEREN, t.REFEREN ),t.CCOSTO = isnull( d.CCOSTO, t.CCOSTO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA )
					from ZooLogic.ASIENTO t inner join deleted d 
							 on t.ACOD = d.ACOD
							 and  t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.ASIENTO(Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Cotiz,Numaper,Esttrans,Smodifw,Haltafw,Hmodifw,Horaexpo,Horaimpo,Saltafw,Bdmodifw,Umodifw,Reversaa,Valtafw,Bdaltafw,Revpor,Ualtafw,Zadsfw,Vmodifw,Acod,Obs,Fuente,Ejercicio,Contabiliz,Cierreej,Rsocial,Numero,Fecha,Tipoasient,Clase,Referen,Ccosto,Moneda)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.COTIZ,0),isnull( d.NUMAPER,0),isnull( d.ESTTRANS,''),isnull( d.SMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.UMODIFW,''),isnull( d.REVERSAA,''),isnull( d.VALTAFW,''),isnull( d.BDALTAFW,''),isnull( d.REVPOR,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.ACOD,''),isnull( d.OBS,''),isnull( d.FUENTE,''),isnull( d.EJERCICIO,0),isnull( d.CONTABILIZ,0),isnull( d.CIERREEJ,0),isnull( d.RSOCIAL,''),isnull( d.NUMERO,0),isnull( d.FECHA,''),isnull( d.TIPOASIENT,0),isnull( d.CLASE,0),isnull( d.REFEREN,''),isnull( d.CCOSTO,''),isnull( d.MONEDA,'')
						From deleted d left join ZooLogic.ASIENTO pk 
							 on d.ACOD = pk.ACOD
						 left join ZooLogic.ASIENTO cc 
							 on  d.NUMERO = cc.NUMERO
						Where pk.ACOD Is Null 
							 and cc.NUMERO Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ASIENTO NÚMERO ' + cast( d.NUMERO as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.ASIENTO t inner join deleted d 
							on   t.NUMERO = d.NUMERO
						left join deleted h 
							 on t.ACOD = h.ACOD
							 where h.ACOD is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ASIENTO NÚMERO ' + cast( d.NUMERO as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.ASIENTO t inner join deleted d 
							 on t.ACOD = d.ACOD
						left join deleted h 
							on   t.NUMERO = h.NUMERO
							where   h.NUMERO is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ASIENTODET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ASIENTO_ASIENTODET
ON ZooLogic.TablaTrabajo_ASIENTO_ASIENTODET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),
t.PCUENTAD = isnull( d.PCUENTAD, t.PCUENTAD ),
t.LEYENDA = isnull( d.LEYENDA, t.LEYENDA ),
t.CODCCOS = isnull( d.CODCCOS, t.CODCCOS ),
t.DEBE = isnull( d.DEBE, t.DEBE ),
t.HABER = isnull( d.HABER, t.HABER ),
t.SALDO = isnull( d.SALDO, t.SALDO )
from ZooLogic.ASIENTODET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ASIENTODET
( 
"NROITEM",
"CODIGO",
"PCUENTA",
"PCUENTAD",
"LEYENDA",
"CODCCOS",
"DEBE",
"HABER",
"SALDO"
 )
Select 
d.NROITEM,
d.CODIGO,
d.PCUENTA,
d.PCUENTAD,
d.LEYENDA,
d.CODCCOS,
d.DEBE,
d.HABER,
d.SALDO
From deleted d left join ZooLogic.ASIENTODET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ASIENTO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ASIENTO
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ASIENTO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ASIENTO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ASIENTO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ASIENTO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ASIENTO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ASIENTO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Cotizacion = nvl( c_ASIENTO.Cotizacion, 0 )
					.Numeroapertura = nvl( c_ASIENTO.Numeroapertura, 0 )
					.Estadotransferencia = nvl( c_ASIENTO.Estadotransferencia, [] )
					.Seriemodificacionfw = nvl( c_ASIENTO.Seriemodificacionfw, [] )
					.Horaaltafw = nvl( c_ASIENTO.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_ASIENTO.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_ASIENTO.Horaexpo, [] )
					.Horaimpo = nvl( c_ASIENTO.Horaimpo, [] )
					.Seriealtafw = nvl( c_ASIENTO.Seriealtafw, [] )
					.Basededatosmodificacionfw = nvl( c_ASIENTO.Basededatosmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_ASIENTO.Usuariomodificacionfw, [] )
					.Reversaa = nvl( c_ASIENTO.Reversaa, [] )
					.Versionaltafw = nvl( c_ASIENTO.Versionaltafw, [] )
					.Basededatosaltafw = nvl( c_ASIENTO.Basededatosaltafw, [] )
					.Reversadopor = nvl( c_ASIENTO.Reversadopor, [] )
					.Usuarioaltafw = nvl( c_ASIENTO.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_ASIENTO.Versionmodificacionfw, [] )
					.Codigo = nvl( c_ASIENTO.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Fuente = nvl( c_ASIENTO.Fuente, [] )
					.Ejercicio_PK =  nvl( c_ASIENTO.Ejercicio, 0 )
					.Contabilizacion = nvl( c_ASIENTO.Contabilizacion, 0 )
					.Cierreejercicio = nvl( c_ASIENTO.Cierreejercicio, 0 )
					.Razonsocial_PK =  nvl( c_ASIENTO.Razonsocial, [] )
					.Numero = nvl( c_ASIENTO.Numero, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ASIENTO.Fecha, ctod( '  /  /    ' ) ) )
					.Tipo = nvl( c_ASIENTO.Tipo, 0 )
					.Clase = nvl( c_ASIENTO.Clase, 0 )
					.Referencia = nvl( c_ASIENTO.Referencia, [] )
					.Centrodecosto_PK =  nvl( c_ASIENTO.Centrodecosto, [] )
					.Monedacomprobante_PK =  nvl( c_ASIENTO.Monedacomprobante, [] )
					.Asientodetalle.Limpiar()
					.Asientodetalle.SetearEsNavegacion( .lProcesando )
					.Asientodetalle.Cargar()
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
			lxRetorno = c_ASIENTO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.AsientoDetalle
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
		return c_ASIENTO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ASIENTO' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ACOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,ACOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    ACOD from (
							select * 
								from ZooLogic.ASIENTO 
								Where   ASIENTO.ACOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ASIENTO", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ACOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Numaper" as "Numeroapertura", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Reversaa" as "Reversaa", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Revpor" as "Reversadopor", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Acod" as "Codigo", "Obs" as "Observacion", "Fuente" as "Fuente", "Ejercicio" as "Ejercicio", "Contabiliz" as "Contabilizacion", "Cierreej" as "Cierreejercicio", "Rsocial" as "Razonsocial", "Numero" as "Numero", "Fecha" as "Fecha", "Tipoasient" as "Tipo", "Clase" as "Clase", "Referen" as "Referencia", "Ccosto" as "Centrodecosto", "Moneda" as "Monedacomprobante"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ASIENTO 
								Where   ASIENTO.ACOD != ''
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
	Tabla = 'ASIENTO'
	Filtro = " ASIENTO.ACOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ASIENTO.ACOD != ''"
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
	<row entidad="ASIENTO                                 " atributo="FECHAEXPO                               " tabla="ASIENTO        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="FECHAALTAFW                             " tabla="ASIENTO        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="FECHAIMPO                               " tabla="ASIENTO        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="FECHAMODIFICACIONFW                     " tabla="ASIENTO        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="FECHATRANSFERENCIA                      " tabla="ASIENTO        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="COTIZACION                              " tabla="ASIENTO        " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="NUMEROAPERTURA                          " tabla="ASIENTO        " campo="NUMAPER   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="ESTADOTRANSFERENCIA                     " tabla="ASIENTO        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="SERIEMODIFICACIONFW                     " tabla="ASIENTO        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="HORAALTAFW                              " tabla="ASIENTO        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="HORAMODIFICACIONFW                      " tabla="ASIENTO        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="HORAEXPO                                " tabla="ASIENTO        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="HORAIMPO                                " tabla="ASIENTO        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="SERIEALTAFW                             " tabla="ASIENTO        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ASIENTO        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="USUARIOMODIFICACIONFW                   " tabla="ASIENTO        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="REVERSAA                                " tabla="ASIENTO        " campo="REVERSAA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="VERSIONALTAFW                           " tabla="ASIENTO        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="BASEDEDATOSALTAFW                       " tabla="ASIENTO        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="REVERSADOPOR                            " tabla="ASIENTO        " campo="REVPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="USUARIOALTAFW                           " tabla="ASIENTO        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="ZADSFW                                  " tabla="ASIENTO        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="VERSIONMODIFICACIONFW                   " tabla="ASIENTO        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="CODIGO                                  " tabla="ASIENTO        " campo="ACOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="198" etiqueta="Identificador                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="OBSERVACION                             " tabla="ASIENTO        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="DIFERENCIA                              " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Diferencia                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="FUENTE                                  " tabla="ASIENTO        " campo="FUENTE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=_screen.Zoo.App.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Fuente de los datos                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="EJERCICIO                               " tabla="ASIENTO        " campo="EJERCICIO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="EJERCICIO                               " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="406" etiqueta="Ejercicio                                                                                                                                                       " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="CONTABILIZACION                         " tabla="ASIENTO        " campo="CONTABILIZ" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Contabilización                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="CIERREEJERCICIO                         " tabla="ASIENTO        " campo="CIERREEJ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cierre                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="RAZONSOCIAL                             " tabla="ASIENTO        " campo="RSOCIAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="RAZONSOCIAL                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Razón social                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="NUMERO                                  " tabla="ASIENTO        " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Asiento número                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="FECHA                                   " tabla="ASIENTO        " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="4" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="TIPO                                    " tabla="ASIENTO        " campo="TIPOASIENT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="6" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="CLASE                                   " tabla="ASIENTO        " campo="CLASE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="6" etiqueta="Clase de asiento                                                                                                                                                " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="REFERENCIA                              " tabla="ASIENTO        " campo="REFEREN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Referencia                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="CENTRODECOSTO                           " tabla="ASIENTO        " campo="CCOSTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CENTRODECOSTO                           " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Centro de costos anitguo                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="60" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="CENTRODECOSTOVIRTUAL                    " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CENTRODECOSTO                           " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Centro de costos                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="MONEDACOMPROBANTE                       " tabla="ASIENTO        " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="=goParametros.Felino.Generales.MonedaSistema                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="0" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="70" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ASIENTO                                 " atributo="ASIENTODETALLE                          " tabla="ASIENTODET     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Cuentas                                                                                                                                                         " dominio="DETALLEITEMASIENTO            " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="100" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EJERCICIO                               " atributo="DESCRIPCION                             " tabla="EJERCICIO      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Eje.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join EJERCICIO On ASIENTO.EJERCICIO = EJERCICIO.NUMERO And  EJERCICIO.NUMERO != 0                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RAZONSOCIAL                             " atributo="DESCRIPCION                             " tabla="RAZONS         " campo="RZDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Raz.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join RAZONS On ASIENTO.RSOCIAL = RAZONS.RZCOD And  RAZONS.RZCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMASIENTO                             " atributo="PLANDECUENTAS                           " tabla="ASIENTODET     " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleCuentas, Cuenta                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ASIENTODET On ASIENTO.ACOD = ASIENTODET.CODIGO And  ASIENTO.ACOD != ''                                                                                                                                                                             " filtrobuscador="&quot; plancuenta.ctaimput = .t. &quot;                                                                                                                                                                           " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMASIENTO                             " atributo="PLANDECUENTASDETALLE                    " tabla="ASIENTODET     " campo="PCUENTAD  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleCuentas, Descripción                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="PLANDECUENTAS.DESCRIPCION                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ASIENTODET On ASIENTO.ACOD = ASIENTODET.CODIGO And  ASIENTO.ACOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMASIENTO                             " atributo="LEYENDA                                 " tabla="ASIENTODET     " campo="LEYENDA   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleCuentas, Leyenda                                                                                                                                         " dominio="OBSERVACION                   " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ASIENTODET On ASIENTO.ACOD = ASIENTODET.CODIGO And  ASIENTO.ACOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMASIENTO                             " atributo="CENTRODECOSTO                           " tabla="ASIENTODET     " campo="CODCCOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CENTRODECOSTO                           " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleCuentas, Centro de costos                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ASIENTODET On ASIENTO.ACOD = ASIENTODET.CODIGO And  ASIENTO.ACOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMASIENTO                             " atributo="DEBE                                    " tabla="ASIENTODET     " campo="DEBE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleCuentas, Debe                                                                                                                                            " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999,999,999,999.9999     " ofuncionalidad=" " relaciones=" Left Join ASIENTODET On ASIENTO.ACOD = ASIENTODET.CODIGO And  ASIENTO.ACOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMASIENTO                             " atributo="HABER                                   " tabla="ASIENTODET     " campo="HABER     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleCuentas, Haber                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999,999,999,999.9999     " ofuncionalidad=" " relaciones=" Left Join ASIENTODET On ASIENTO.ACOD = ASIENTODET.CODIGO And  ASIENTO.ACOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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