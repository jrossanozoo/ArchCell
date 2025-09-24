
define class Din_EntidadARQUEODECAJAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ARQUEODECAJA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_ARQPK'
	cTablaPrincipal = 'ARQCAJA'
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
			local  lxArqcajaFmodifw, lxArqcajaFectrans, lxArqcajaFecimpo, lxArqcajaFecexpo, lxArqcajaSmodifw, lxArqcajaHoraimpo, lxArqcajaHoraexpo, lxArqcajaUaltafw, lxArqcajaHmodifw, lxArqcajaEsttrans, lxArqcajaUmodifw, lxArqcajaVmodifw, lxArqcajaZadsfw, lxArqcajaBdaltafw, lxArqcajaValtafw, lxArqcajaSaltafw, lxArqcajaBdmodifw, lxArqcajaFaltafw, lxArqcajaNumero, lxArqcajaCaja, lxArqcajaHaltafw, lxArqcajaVendedor, lxArqcajaCodigo, lxArqcajaAobs
				lxArqcajaFmodifw =  .Fechamodificacionfw			lxArqcajaFectrans =  .Fechatransferencia			lxArqcajaFecimpo =  .Fechaimpo			lxArqcajaFecexpo =  .Fechaexpo			lxArqcajaSmodifw =  .Seriemodificacionfw			lxArqcajaHoraimpo =  .Horaimpo			lxArqcajaHoraexpo =  .Horaexpo			lxArqcajaUaltafw =  .Usuarioaltafw			lxArqcajaHmodifw =  .Horamodificacionfw			lxArqcajaEsttrans =  .Estadotransferencia			lxArqcajaUmodifw =  .Usuariomodificacionfw			lxArqcajaVmodifw =  .Versionmodificacionfw			lxArqcajaZadsfw =  .Zadsfw			lxArqcajaBdaltafw =  .Basededatosaltafw			lxArqcajaValtafw =  .Versionaltafw			lxArqcajaSaltafw =  .Seriealtafw			lxArqcajaBdmodifw =  .Basededatosmodificacionfw			lxArqcajaFaltafw =  .Fechaaltafw			lxArqcajaNumero =  .Numero			lxArqcajaCaja =  .Caja_PK 			lxArqcajaHaltafw =  .Horaaltafw			lxArqcajaVendedor =  upper( .Vendedor_PK ) 			lxArqcajaCodigo =  .Codigo			lxArqcajaAobs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxArqcajaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ARQCAJA ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Smodifw","Horaimpo","Horaexpo","Ualtafw","Hmodifw","Esttrans","Umodifw","Vmodifw","Zadsfw","Bdaltafw","Valtafw","Saltafw","Bdmodifw","Faltafw","Numero","Caja","Haltafw","Vendedor","Codigo","Aobs" ) values ( <<"'" + this.ConvertirDateSql( lxArqcajaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArqcajaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArqcajaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArqcajaFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaBdmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArqcajaFaltafw ) + "'" >>, <<lxArqcajaNumero >>, <<lxArqcajaCaja >>, <<"'" + this.FormatearTextoSql( lxArqcajaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaAobs ) + "'" >> )
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
			for each loItem in this.oEntidad.DetalleTotalPorGrupo
				if this.oEntidad.DetalleTotalPorGrupo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupa = loItem.Agrupa
					lxAgrupadesc = loItem.Agrupadesc
					lxTotalgrupo = loItem.Totalgrupo
					lxArqueado = loItem.Arqueado
					lxDifgrupo = loItem.Difgrupo
					lxArqueadoefec = loItem.Arqueadoefec
					lxArqueadootros = loItem.Arqueadootros
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQTOTDET("NROITEM","Agrupa","Codigo","AgrupaDet","TotGrupo","Arqueado","DifGrupo","ArqEfec","ArqOtros" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxAgrupa ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupadesc ) + "'">>, <<lxTotalgrupo>>, <<lxArqueado>>, <<lxDifgrupo>>, <<lxArqueadoefec>>, <<lxArqueadootros>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleRecuentoEfectivo
				if this.oEntidad.DetalleRecuentoEfectivo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMonedadenom = loItem.Monedadenom
					lxDescri = loItem.Descri
					lxTipo = loItem.Tipo
					lxValordenom = loItem.Valordenom
					lxCantidad = loItem.Cantidad
					lxTotal = loItem.Total
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQEFECTDET("NROITEM","Codigo","MonedaDen","Descri","Tipo","ValorDen","Cant","Tot" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxMonedadenom ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescri ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<lxValordenom>>, <<lxCantidad>>, <<lxTotal>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleOtros
				if this.oEntidad.DetalleOtros.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxValorgrupo_PK = loItem.Valorgrupo_PK
					lxMoneda_PK = loItem.Moneda_PK
					lxTotalarqueo = loItem.Totalarqueo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQOTROSDET("NROITEM","Codigo","Valor","ValorDet","ValorGrupo","Moneda","TotArqueo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorgrupo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMoneda_PK ) + "'">>, <<lxTotalarqueo>> ) 
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
			this.GenerarSentenciasComponentes()
			local  lxArqcajaFmodifw, lxArqcajaFectrans, lxArqcajaFecimpo, lxArqcajaFecexpo, lxArqcajaSmodifw, lxArqcajaHoraimpo, lxArqcajaHoraexpo, lxArqcajaUaltafw, lxArqcajaHmodifw, lxArqcajaEsttrans, lxArqcajaUmodifw, lxArqcajaVmodifw, lxArqcajaZadsfw, lxArqcajaBdaltafw, lxArqcajaValtafw, lxArqcajaSaltafw, lxArqcajaBdmodifw, lxArqcajaFaltafw, lxArqcajaNumero, lxArqcajaCaja, lxArqcajaHaltafw, lxArqcajaVendedor, lxArqcajaCodigo, lxArqcajaAobs
				lxArqcajaFmodifw =  .Fechamodificacionfw			lxArqcajaFectrans =  .Fechatransferencia			lxArqcajaFecimpo =  .Fechaimpo			lxArqcajaFecexpo =  .Fechaexpo			lxArqcajaSmodifw =  .Seriemodificacionfw			lxArqcajaHoraimpo =  .Horaimpo			lxArqcajaHoraexpo =  .Horaexpo			lxArqcajaUaltafw =  .Usuarioaltafw			lxArqcajaHmodifw =  .Horamodificacionfw			lxArqcajaEsttrans =  .Estadotransferencia			lxArqcajaUmodifw =  .Usuariomodificacionfw			lxArqcajaVmodifw =  .Versionmodificacionfw			lxArqcajaZadsfw =  .Zadsfw			lxArqcajaBdaltafw =  .Basededatosaltafw			lxArqcajaValtafw =  .Versionaltafw			lxArqcajaSaltafw =  .Seriealtafw			lxArqcajaBdmodifw =  .Basededatosmodificacionfw			lxArqcajaFaltafw =  .Fechaaltafw			lxArqcajaNumero =  .Numero			lxArqcajaCaja =  .Caja_PK 			lxArqcajaHaltafw =  .Horaaltafw			lxArqcajaVendedor =  upper( .Vendedor_PK ) 			lxArqcajaCodigo =  .Codigo			lxArqcajaAobs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ARQCAJA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxArqcajaFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxArqcajaFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxArqcajaFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxArqcajaFecexpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxArqcajaHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxArqcajaHoraexpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxArqcajaUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxArqcajaEsttrans ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxArqcajaZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxArqcajaBdaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxArqcajaValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxArqcajaSaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaBdmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxArqcajaFaltafw ) + "'">>,"Numero" = <<lxArqcajaNumero>>,"Caja" = <<lxArqcajaCaja>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxArqcajaHaltafw ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxArqcajaVendedor ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxArqcajaCodigo ) + "'">>,"Aobs" = <<"'" + this.FormatearTextoSql( lxArqcajaAobs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxArqcajaCodigo ) + "'">> and  ARQCAJA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ARQTOTDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ARQEFECTDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ARQOTROSDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleTotalPorGrupo
				if this.oEntidad.DetalleTotalPorGrupo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupa = loItem.Agrupa
					lxAgrupadesc = loItem.Agrupadesc
					lxTotalgrupo = loItem.Totalgrupo
					lxArqueado = loItem.Arqueado
					lxDifgrupo = loItem.Difgrupo
					lxArqueadoefec = loItem.Arqueadoefec
					lxArqueadootros = loItem.Arqueadootros
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQTOTDET("NROITEM","Agrupa","Codigo","AgrupaDet","TotGrupo","Arqueado","DifGrupo","ArqEfec","ArqOtros" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxAgrupa ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupadesc ) + "'">>, <<lxTotalgrupo>>, <<lxArqueado>>, <<lxDifgrupo>>, <<lxArqueadoefec>>, <<lxArqueadootros>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleRecuentoEfectivo
				if this.oEntidad.DetalleRecuentoEfectivo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMonedadenom = loItem.Monedadenom
					lxDescri = loItem.Descri
					lxTipo = loItem.Tipo
					lxValordenom = loItem.Valordenom
					lxCantidad = loItem.Cantidad
					lxTotal = loItem.Total
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQEFECTDET("NROITEM","Codigo","MonedaDen","Descri","Tipo","ValorDen","Cant","Tot" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxMonedadenom ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescri ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<lxValordenom>>, <<lxCantidad>>, <<lxTotal>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleOtros
				if this.oEntidad.DetalleOtros.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxValorgrupo_PK = loItem.Valorgrupo_PK
					lxMoneda_PK = loItem.Moneda_PK
					lxTotalarqueo = loItem.Totalarqueo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQOTROSDET("NROITEM","Codigo","Valor","ValorDet","ValorGrupo","Moneda","TotArqueo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorgrupo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMoneda_PK ) + "'">>, <<lxTotalarqueo>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.ARQCAJA where " + this.ConvertirFuncionesSql( " ARQCAJA.CODIGO != ''" ) )
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
			Local lxArqcajaCodigo
			lxArqcajaCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Numero" as "Numero", "Caja" as "Caja", "Haltafw" as "Horaaltafw", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Aobs" as "Observacion" from ZooLogic.ARQCAJA where "Codigo" = <<"'" + this.FormatearTextoSql( lxArqcajaCodigo ) + "'">> and  ARQCAJA.CODIGO != ''
			endtext
			use in select('c_ARQUEODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARQUEODECAJA', set( 'Datasession' ) )

			if reccount( 'c_ARQUEODECAJA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Agrupa" as "Agrupa", "Codigo" as "Codigo", "Agrupadet" as "Agrupadesc", "Totgrupo" as "Totalgrupo", "Arqueado" as "Arqueado", "Difgrupo" as "Difgrupo", "Arqefec" as "Arqueadoefec", "Arqotros" as "Arqueadootros" from ZooLogic.ARQTOTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleTotalPorGrupo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleTotalPorGrupo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleTotalPorGrupo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Monedaden" as "Monedadenom", "Descri" as "Descri", "Tipo" as "Tipo", "Valorden" as "Valordenom", "Cant" as "Cantidad", "Tot" as "Total" from ZooLogic.ARQEFECTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleRecuentoEfectivo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleRecuentoEfectivo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleRecuentoEfectivo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Valordet" as "Valordetalle", "Valorgrupo" as "Valorgrupo", "Moneda" as "Moneda", "Totarqueo" as "Totalarqueo" from ZooLogic.ARQOTROSDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleOtros')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOtros', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOtros
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxARQCAJANumero As Variant
			lxARQCAJANumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Numero" as "Numero", "Caja" as "Caja", "Haltafw" as "Horaaltafw", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Aobs" as "Observacion" from ZooLogic.ARQCAJA where  ARQCAJA.CODIGO != '' And Numero = <<lxARQCAJANumero>>
			endtext
			use in select('c_ARQUEODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARQUEODECAJA', set( 'Datasession' ) )
			if reccount( 'c_ARQUEODECAJA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Agrupa" as "Agrupa", "Codigo" as "Codigo", "Agrupadet" as "Agrupadesc", "Totgrupo" as "Totalgrupo", "Arqueado" as "Arqueado", "Difgrupo" as "Difgrupo", "Arqefec" as "Arqueadoefec", "Arqotros" as "Arqueadootros" from ZooLogic.ARQTOTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleTotalPorGrupo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleTotalPorGrupo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleTotalPorGrupo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Monedaden" as "Monedadenom", "Descri" as "Descri", "Tipo" as "Tipo", "Valorden" as "Valordenom", "Cant" as "Cantidad", "Tot" as "Total" from ZooLogic.ARQEFECTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleRecuentoEfectivo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleRecuentoEfectivo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleRecuentoEfectivo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Valordet" as "Valordetalle", "Valorgrupo" as "Valorgrupo", "Moneda" as "Moneda", "Totarqueo" as "Totalarqueo" from ZooLogic.ARQOTROSDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleOtros')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOtros', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOtros
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxArqcajaCodigo as Variant
		llRetorno = .t.
		lxArqcajaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ARQCAJA where "Codigo" = <<"'" + this.FormatearTextoSql( lxArqcajaCodigo ) + "'">> and  ARQCAJA.CODIGO != ''
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
				lcOrden =  .Vendedor_PK + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Numero" as "Numero", "Caja" as "Caja", "Haltafw" as "Horaaltafw", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Aobs" as "Observacion" from ZooLogic.ARQCAJA where  ARQCAJA.CODIGO != '' order by Vendedor,Codigo
			endtext
			use in select('c_ARQUEODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARQUEODECAJA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Agrupa" as "Agrupa", "Codigo" as "Codigo", "Agrupadet" as "Agrupadesc", "Totgrupo" as "Totalgrupo", "Arqueado" as "Arqueado", "Difgrupo" as "Difgrupo", "Arqefec" as "Arqueadoefec", "Arqotros" as "Arqueadootros" from ZooLogic.ARQTOTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleTotalPorGrupo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleTotalPorGrupo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleTotalPorGrupo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Monedaden" as "Monedadenom", "Descri" as "Descri", "Tipo" as "Tipo", "Valorden" as "Valordenom", "Cant" as "Cantidad", "Tot" as "Total" from ZooLogic.ARQEFECTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleRecuentoEfectivo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleRecuentoEfectivo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleRecuentoEfectivo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Valordet" as "Valordetalle", "Valorgrupo" as "Valorgrupo", "Moneda" as "Moneda", "Totarqueo" as "Totalarqueo" from ZooLogic.ARQOTROSDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleOtros')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOtros', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOtros
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
				lcOrden =  .Vendedor_PK + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Numero" as "Numero", "Caja" as "Caja", "Haltafw" as "Horaaltafw", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Aobs" as "Observacion" from ZooLogic.ARQCAJA where  funciones.padr( Vendedor, 5, ' ' ) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ARQCAJA.CODIGO != '' order by Vendedor,Codigo
			endtext
			use in select('c_ARQUEODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARQUEODECAJA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Agrupa" as "Agrupa", "Codigo" as "Codigo", "Agrupadet" as "Agrupadesc", "Totgrupo" as "Totalgrupo", "Arqueado" as "Arqueado", "Difgrupo" as "Difgrupo", "Arqefec" as "Arqueadoefec", "Arqotros" as "Arqueadootros" from ZooLogic.ARQTOTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleTotalPorGrupo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleTotalPorGrupo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleTotalPorGrupo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Monedaden" as "Monedadenom", "Descri" as "Descri", "Tipo" as "Tipo", "Valorden" as "Valordenom", "Cant" as "Cantidad", "Tot" as "Total" from ZooLogic.ARQEFECTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleRecuentoEfectivo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleRecuentoEfectivo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleRecuentoEfectivo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Valordet" as "Valordetalle", "Valorgrupo" as "Valorgrupo", "Moneda" as "Moneda", "Totarqueo" as "Totalarqueo" from ZooLogic.ARQOTROSDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleOtros')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOtros', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOtros
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
				lcOrden =  .Vendedor_PK + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Numero" as "Numero", "Caja" as "Caja", "Haltafw" as "Horaaltafw", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Aobs" as "Observacion" from ZooLogic.ARQCAJA where  funciones.padr( Vendedor, 5, ' ' ) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ARQCAJA.CODIGO != '' order by Vendedor desc,Codigo desc
			endtext
			use in select('c_ARQUEODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARQUEODECAJA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Agrupa" as "Agrupa", "Codigo" as "Codigo", "Agrupadet" as "Agrupadesc", "Totgrupo" as "Totalgrupo", "Arqueado" as "Arqueado", "Difgrupo" as "Difgrupo", "Arqefec" as "Arqueadoefec", "Arqotros" as "Arqueadootros" from ZooLogic.ARQTOTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleTotalPorGrupo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleTotalPorGrupo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleTotalPorGrupo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Monedaden" as "Monedadenom", "Descri" as "Descri", "Tipo" as "Tipo", "Valorden" as "Valordenom", "Cant" as "Cantidad", "Tot" as "Total" from ZooLogic.ARQEFECTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleRecuentoEfectivo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleRecuentoEfectivo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleRecuentoEfectivo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Valordet" as "Valordetalle", "Valorgrupo" as "Valorgrupo", "Moneda" as "Moneda", "Totarqueo" as "Totalarqueo" from ZooLogic.ARQOTROSDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleOtros')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOtros', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOtros
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
				lcOrden =  .Vendedor_PK + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Numero" as "Numero", "Caja" as "Caja", "Haltafw" as "Horaaltafw", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Aobs" as "Observacion" from ZooLogic.ARQCAJA where  ARQCAJA.CODIGO != '' order by Vendedor desc,Codigo desc
			endtext
			use in select('c_ARQUEODECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ARQUEODECAJA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Agrupa" as "Agrupa", "Codigo" as "Codigo", "Agrupadet" as "Agrupadesc", "Totgrupo" as "Totalgrupo", "Arqueado" as "Arqueado", "Difgrupo" as "Difgrupo", "Arqefec" as "Arqueadoefec", "Arqotros" as "Arqueadootros" from ZooLogic.ARQTOTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleTotalPorGrupo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleTotalPorGrupo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleTotalPorGrupo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Monedaden" as "Monedadenom", "Descri" as "Descri", "Tipo" as "Tipo", "Valorden" as "Valordenom", "Cant" as "Cantidad", "Tot" as "Total" from ZooLogic.ARQEFECTDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleRecuentoEfectivo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleRecuentoEfectivo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleRecuentoEfectivo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Valordet" as "Valordetalle", "Valorgrupo" as "Valorgrupo", "Moneda" as "Moneda", "Totarqueo" as "Totalarqueo" from ZooLogic.ARQOTROSDET where Codigo = <<"'" + this.FormatearTextoSql( c_ARQUEODECAJA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleOtros')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOtros', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOtros
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecimpo,Fecexpo,Smodifw,Horaimpo,Horaexpo,Ualtafw,Hmodifw,Esttrans,Umodifw," + ;
"Vmodifw,Zadsfw,Bdaltafw,Valtafw,Saltafw,Bdmodifw,Faltafw,Numero,Caja,Haltafw,Vendedor,Codigo,Aobs" + ;
" from ZooLogic.ARQCAJA where  ARQCAJA.CODIGO != '' and " + lcFiltro )
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
			local  lxArqcajaFmodifw, lxArqcajaFectrans, lxArqcajaFecimpo, lxArqcajaFecexpo, lxArqcajaSmodifw, lxArqcajaHoraimpo, lxArqcajaHoraexpo, lxArqcajaUaltafw, lxArqcajaHmodifw, lxArqcajaEsttrans, lxArqcajaUmodifw, lxArqcajaVmodifw, lxArqcajaZadsfw, lxArqcajaBdaltafw, lxArqcajaValtafw, lxArqcajaSaltafw, lxArqcajaBdmodifw, lxArqcajaFaltafw, lxArqcajaNumero, lxArqcajaCaja, lxArqcajaHaltafw, lxArqcajaVendedor, lxArqcajaCodigo, lxArqcajaAobs
				lxArqcajaFmodifw = ctod( '  /  /    ' )			lxArqcajaFectrans = ctod( '  /  /    ' )			lxArqcajaFecimpo = ctod( '  /  /    ' )			lxArqcajaFecexpo = ctod( '  /  /    ' )			lxArqcajaSmodifw = []			lxArqcajaHoraimpo = []			lxArqcajaHoraexpo = []			lxArqcajaUaltafw = []			lxArqcajaHmodifw = []			lxArqcajaEsttrans = []			lxArqcajaUmodifw = []			lxArqcajaVmodifw = []			lxArqcajaZadsfw = []			lxArqcajaBdaltafw = []			lxArqcajaValtafw = []			lxArqcajaSaltafw = []			lxArqcajaBdmodifw = []			lxArqcajaFaltafw = ctod( '  /  /    ' )			lxArqcajaNumero = 0			lxArqcajaCaja = 0			lxArqcajaHaltafw = []			lxArqcajaVendedor = []			lxArqcajaCodigo = []			lxArqcajaAobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ARQTOTDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ARQEFECTDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ARQOTROSDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ARQCAJA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ARQCAJA' + '_' + tcCampo
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
		lcWhere = " Where  ARQCAJA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Numero" as "Numero", "Caja" as "Caja", "Haltafw" as "Horaaltafw", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Aobs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ARQCAJA', '', tnTope )
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
	Function ObtenerDatosDetalleDetalleTotalPorGrupo( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ARQTOTDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Agrupa" as "Agrupa", "Codigo" as "Codigo", "Agrupadet" as "Agrupadesc", "Totgrupo" as "Totalgrupo", "Arqueado" as "Arqueado", "Difgrupo" as "Difgrupo", "Arqefec" as "Arqueadoefec", "Arqotros" as "Arqueadootros"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleTotalPorGrupo( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ARQTOTDET', 'DetalleTotalPorGrupo', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleTotalPorGrupo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleTotalPorGrupo( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleRecuentoEfectivo( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ARQEFECTDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Monedaden" as "Monedadenom", "Descri" as "Descri", "Tipo" as "Tipo", "Valorden" as "Valordenom", "Cant" as "Cantidad", "Tot" as "Total"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleRecuentoEfectivo( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ARQEFECTDET', 'DetalleRecuentoEfectivo', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleRecuentoEfectivo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleRecuentoEfectivo( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleOtros( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ARQOTROSDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valor" as "Valor", "Valordet" as "Valordetalle", "Valorgrupo" as "Valorgrupo", "Moneda" as "Moneda", "Totarqueo" as "Totalarqueo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleOtros( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ARQOTROSDET', 'DetalleOtros', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleOtros( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleOtros( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJA AS CAJA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AOBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleTotalPorGrupo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'AGRUPA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPA AS AGRUPA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'AGRUPADESC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPADET AS AGRUPADESC'
				Case lcAtributo == 'TOTALGRUPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTGRUPO AS TOTALGRUPO'
				Case lcAtributo == 'ARQUEADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARQUEADO AS ARQUEADO'
				Case lcAtributo == 'DIFGRUPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIFGRUPO AS DIFGRUPO'
				Case lcAtributo == 'ARQUEADOEFEC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARQEFEC AS ARQUEADOEFEC'
				Case lcAtributo == 'ARQUEADOOTROS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARQOTROS AS ARQUEADOOTROS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleRecuentoEfectivo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MONEDADENOM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDADEN AS MONEDADENOM'
				Case lcAtributo == 'DESCRI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRI'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'VALORDENOM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORDEN AS VALORDENOM'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANT AS CANTIDAD'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOT AS TOTAL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleOtros( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'VALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORDET AS VALORDETALLE'
				Case lcAtributo == 'VALORGRUPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORGRUPO AS VALORGRUPO'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDA'
				Case lcAtributo == 'TOTALARQUEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTARQUEO AS TOTALARQUEO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'CAJA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'AOBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleTotalPorGrupo( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPA'
				lcCampo = 'AGRUPA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPADESC'
				lcCampo = 'AGRUPADET'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALGRUPO'
				lcCampo = 'TOTGRUPO'
			Case upper( alltrim( tcAtributo ) ) == 'ARQUEADO'
				lcCampo = 'ARQUEADO'
			Case upper( alltrim( tcAtributo ) ) == 'DIFGRUPO'
				lcCampo = 'DIFGRUPO'
			Case upper( alltrim( tcAtributo ) ) == 'ARQUEADOEFEC'
				lcCampo = 'ARQEFEC'
			Case upper( alltrim( tcAtributo ) ) == 'ARQUEADOOTROS'
				lcCampo = 'ARQOTROS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleRecuentoEfectivo( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDADENOM'
				lcCampo = 'MONEDADEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRI'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDENOM'
				lcCampo = 'VALORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANT'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'TOT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleOtros( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDETALLE'
				lcCampo = 'VALORDET'
			Case upper( alltrim( tcAtributo ) ) == 'VALORGRUPO'
				lcCampo = 'VALORGRUPO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALARQUEO'
				lcCampo = 'TOTARQUEO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLETOTALPORGRUPO'
			lcRetorno = 'ARQTOTDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLERECUENTOEFECTIVO'
			lcRetorno = 'ARQEFECTDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLEOTROS'
			lcRetorno = 'ARQOTROSDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxArqcajaFmodifw, lxArqcajaFectrans, lxArqcajaFecimpo, lxArqcajaFecexpo, lxArqcajaSmodifw, lxArqcajaHoraimpo, lxArqcajaHoraexpo, lxArqcajaUaltafw, lxArqcajaHmodifw, lxArqcajaEsttrans, lxArqcajaUmodifw, lxArqcajaVmodifw, lxArqcajaZadsfw, lxArqcajaBdaltafw, lxArqcajaValtafw, lxArqcajaSaltafw, lxArqcajaBdmodifw, lxArqcajaFaltafw, lxArqcajaNumero, lxArqcajaCaja, lxArqcajaHaltafw, lxArqcajaVendedor, lxArqcajaCodigo, lxArqcajaAobs
				lxArqcajaFmodifw =  .Fechamodificacionfw			lxArqcajaFectrans =  .Fechatransferencia			lxArqcajaFecimpo =  .Fechaimpo			lxArqcajaFecexpo =  .Fechaexpo			lxArqcajaSmodifw =  .Seriemodificacionfw			lxArqcajaHoraimpo =  .Horaimpo			lxArqcajaHoraexpo =  .Horaexpo			lxArqcajaUaltafw =  .Usuarioaltafw			lxArqcajaHmodifw =  .Horamodificacionfw			lxArqcajaEsttrans =  .Estadotransferencia			lxArqcajaUmodifw =  .Usuariomodificacionfw			lxArqcajaVmodifw =  .Versionmodificacionfw			lxArqcajaZadsfw =  .Zadsfw			lxArqcajaBdaltafw =  .Basededatosaltafw			lxArqcajaValtafw =  .Versionaltafw			lxArqcajaSaltafw =  .Seriealtafw			lxArqcajaBdmodifw =  .Basededatosmodificacionfw			lxArqcajaFaltafw =  .Fechaaltafw			lxArqcajaNumero =  .Numero			lxArqcajaCaja =  .Caja_PK 			lxArqcajaHaltafw =  .Horaaltafw			lxArqcajaVendedor =  upper( .Vendedor_PK ) 			lxArqcajaCodigo =  .Codigo			lxArqcajaAobs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ARQCAJA ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Smodifw","Horaimpo","Horaexpo","Ualtafw","Hmodifw","Esttrans","Umodifw","Vmodifw","Zadsfw","Bdaltafw","Valtafw","Saltafw","Bdmodifw","Faltafw","Numero","Caja","Haltafw","Vendedor","Codigo","Aobs" ) values ( <<"'" + this.ConvertirDateSql( lxArqcajaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArqcajaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArqcajaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArqcajaFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaBdmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxArqcajaFaltafw ) + "'" >>, <<lxArqcajaNumero >>, <<lxArqcajaCaja >>, <<"'" + this.FormatearTextoSql( lxArqcajaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxArqcajaAobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ARQCAJA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleTotalPorGrupo
				if this.oEntidad.DetalleTotalPorGrupo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupa = loItem.Agrupa
					lxAgrupadesc = loItem.Agrupadesc
					lxTotalgrupo = loItem.Totalgrupo
					lxArqueado = loItem.Arqueado
					lxDifgrupo = loItem.Difgrupo
					lxArqueadoefec = loItem.Arqueadoefec
					lxArqueadootros = loItem.Arqueadootros
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQTOTDET("NROITEM","Agrupa","Codigo","AgrupaDet","TotGrupo","Arqueado","DifGrupo","ArqEfec","ArqOtros" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxAgrupa ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupadesc ) + "'">>, <<lxTotalgrupo>>, <<lxArqueado>>, <<lxDifgrupo>>, <<lxArqueadoefec>>, <<lxArqueadootros>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleRecuentoEfectivo
				if this.oEntidad.DetalleRecuentoEfectivo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMonedadenom = loItem.Monedadenom
					lxDescri = loItem.Descri
					lxTipo = loItem.Tipo
					lxValordenom = loItem.Valordenom
					lxCantidad = loItem.Cantidad
					lxTotal = loItem.Total
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQEFECTDET("NROITEM","Codigo","MonedaDen","Descri","Tipo","ValorDen","Cant","Tot" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxMonedadenom ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescri ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<lxValordenom>>, <<lxCantidad>>, <<lxTotal>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleOtros
				if this.oEntidad.DetalleOtros.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxValorgrupo_PK = loItem.Valorgrupo_PK
					lxMoneda_PK = loItem.Moneda_PK
					lxTotalarqueo = loItem.Totalarqueo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQOTROSDET("NROITEM","Codigo","Valor","ValorDet","ValorGrupo","Moneda","TotArqueo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorgrupo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMoneda_PK ) + "'">>, <<lxTotalarqueo>> ) 
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
			local  lxArqcajaFmodifw, lxArqcajaFectrans, lxArqcajaFecimpo, lxArqcajaFecexpo, lxArqcajaSmodifw, lxArqcajaHoraimpo, lxArqcajaHoraexpo, lxArqcajaUaltafw, lxArqcajaHmodifw, lxArqcajaEsttrans, lxArqcajaUmodifw, lxArqcajaVmodifw, lxArqcajaZadsfw, lxArqcajaBdaltafw, lxArqcajaValtafw, lxArqcajaSaltafw, lxArqcajaBdmodifw, lxArqcajaFaltafw, lxArqcajaNumero, lxArqcajaCaja, lxArqcajaHaltafw, lxArqcajaVendedor, lxArqcajaCodigo, lxArqcajaAobs
				lxArqcajaFmodifw =  .Fechamodificacionfw			lxArqcajaFectrans =  .Fechatransferencia			lxArqcajaFecimpo =  .Fechaimpo			lxArqcajaFecexpo =  .Fechaexpo			lxArqcajaSmodifw =  .Seriemodificacionfw			lxArqcajaHoraimpo =  .Horaimpo			lxArqcajaHoraexpo =  .Horaexpo			lxArqcajaUaltafw =  .Usuarioaltafw			lxArqcajaHmodifw =  .Horamodificacionfw			lxArqcajaEsttrans =  .Estadotransferencia			lxArqcajaUmodifw =  .Usuariomodificacionfw			lxArqcajaVmodifw =  .Versionmodificacionfw			lxArqcajaZadsfw =  .Zadsfw			lxArqcajaBdaltafw =  .Basededatosaltafw			lxArqcajaValtafw =  .Versionaltafw			lxArqcajaSaltafw =  .Seriealtafw			lxArqcajaBdmodifw =  .Basededatosmodificacionfw			lxArqcajaFaltafw =  .Fechaaltafw			lxArqcajaNumero =  .Numero			lxArqcajaCaja =  .Caja_PK 			lxArqcajaHaltafw =  .Horaaltafw			lxArqcajaVendedor =  upper( .Vendedor_PK ) 			lxArqcajaCodigo =  .Codigo			lxArqcajaAobs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ARQCAJA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ARQCAJA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxArqcajaFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxArqcajaFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxArqcajaFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxArqcajaFecexpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxArqcajaHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxArqcajaHoraexpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxArqcajaUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxArqcajaEsttrans ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxArqcajaZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxArqcajaBdaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxArqcajaValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxArqcajaSaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxArqcajaBdmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxArqcajaFaltafw ) + "'">>, "Numero" = <<lxArqcajaNumero>>, "Caja" = <<lxArqcajaCaja>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxArqcajaHaltafw ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxArqcajaVendedor ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxArqcajaCodigo ) + "'">>, "Aobs" = <<"'" + this.FormatearTextoSql( lxArqcajaAobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ARQCAJA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ARQTOTDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ARQEFECTDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ARQOTROSDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleTotalPorGrupo
				if this.oEntidad.DetalleTotalPorGrupo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupa = loItem.Agrupa
					lxAgrupadesc = loItem.Agrupadesc
					lxTotalgrupo = loItem.Totalgrupo
					lxArqueado = loItem.Arqueado
					lxDifgrupo = loItem.Difgrupo
					lxArqueadoefec = loItem.Arqueadoefec
					lxArqueadootros = loItem.Arqueadootros
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQTOTDET("NROITEM","Agrupa","Codigo","AgrupaDet","TotGrupo","Arqueado","DifGrupo","ArqEfec","ArqOtros" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxAgrupa ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupadesc ) + "'">>, <<lxTotalgrupo>>, <<lxArqueado>>, <<lxDifgrupo>>, <<lxArqueadoefec>>, <<lxArqueadootros>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleRecuentoEfectivo
				if this.oEntidad.DetalleRecuentoEfectivo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMonedadenom = loItem.Monedadenom
					lxDescri = loItem.Descri
					lxTipo = loItem.Tipo
					lxValordenom = loItem.Valordenom
					lxCantidad = loItem.Cantidad
					lxTotal = loItem.Total
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQEFECTDET("NROITEM","Codigo","MonedaDen","Descri","Tipo","ValorDen","Cant","Tot" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxMonedadenom ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescri ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<lxValordenom>>, <<lxCantidad>>, <<lxTotal>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleOtros
				if this.oEntidad.DetalleOtros.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxValorgrupo_PK = loItem.Valorgrupo_PK
					lxMoneda_PK = loItem.Moneda_PK
					lxTotalarqueo = loItem.Totalarqueo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ARQOTROSDET("NROITEM","Codigo","Valor","ValorDet","ValorGrupo","Moneda","TotArqueo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorgrupo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMoneda_PK ) + "'">>, <<lxTotalarqueo>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ARQCAJA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.ARQCAJA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ARQTOTDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ARQEFECTDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ARQOTROSDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ARQCAJA' 
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
		
			.oCompArqueodecaja.lNuevo = .EsNuevo()
			.oCompArqueodecaja.lEdicion = .EsEdicion()
			.oCompArqueodecaja.lEliminar = .lEliminar
			.oCompArqueodecaja.lAnular = .lAnular
			loColSentencias = .oCompArqueodecaja.grabar()
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
			lcRetorno = [update ZooLogic.ARQCAJA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  ARQCAJA.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ARQCAJA where  ARQCAJA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ARQCAJA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ARQCAJA.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ARQUEODECAJA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ARQCAJA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ARQCAJA set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Caja = ] + transform( &lcCursor..Caja )+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, AObs = ] + "'" + this.FormatearTextoSql( &lcCursor..AObs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECTRANS, FECIMPO, FECEXPO, SMODIFW, HORAIMPO, HORAEXPO, UALTAFW, HMODIFW, ESTTRANS, UMODIFW, VMODIFW, ZADSFW, BDALTAFW, VALTAFW, SALTAFW, BDMODIFW, FAltaFW, Numero, Caja, HAltaFW, Vendedor, Codigo, AObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + transform( &lcCursor..Caja ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ARQCAJA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ARQUEODECAJA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ARQTOTDET Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ARQEFECTDET Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ARQOTROSDET Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTOTALPORGRUPO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Agrupa","Codigo","AgrupaDet","TotGrupo","Arqueado","DifGrupo","ArqEfec","ArqOtros"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ARQTOTDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrupa     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupaDet  ) + "'" + ',' + transform( cDetallesExistentes.TotGrupo   ) + ',' + transform( cDetallesExistentes.Arqueado   ) + ',' + transform( cDetallesExistentes.DifGrupo   ) + ',' + transform( cDetallesExistentes.ArqEfec    ) + ',' + transform( cDetallesExistentes.ArqOtros   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMRECEFECTIVO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","MonedaDen","Descri","Tipo","ValorDen","Cant","Tot"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ARQEFECTDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MonedaDen  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Tipo       ) + "'" + ',' + transform( cDetallesExistentes.ValorDen   ) + ',' + transform( cDetallesExistentes.Cant       ) + ',' + transform( cDetallesExistentes.Tot        ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARQUEOOTROS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Valor","ValorDet","ValorGrupo","Moneda","TotArqueo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ARQOTROSDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Valor      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValorDet   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValorGrupo ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Moneda     ) + "'" + ',' + transform( cDetallesExistentes.TotArqueo  ) + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'ARQUEODECAJA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ARQUEODECAJA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ARQUEODECAJA_AOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTOTALPORGRUPO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMRECEFECTIVO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARQUEOOTROS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ARQCAJA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ARQUEODECAJA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ARQUEODECAJA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ARQUEODECAJA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ARQUEODECAJA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ARQCAJA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ARQCAJA
Create Table ZooLogic.TablaTrabajo_ARQCAJA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"faltafw" datetime  null, 
"numero" numeric( 10, 0 )  null, 
"caja" numeric( 2, 0 )  null, 
"haltafw" char( 8 )  null, 
"vendedor" char( 5 )  null, 
"codigo" char( 38 )  null, 
"aobs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ARQCAJA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ARQCAJA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ARQUEODECAJA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('caja','caja')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('aobs','aobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ARQCAJA'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.CAJA = isnull( d.CAJA, t.CAJA ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.AOBS = isnull( d.AOBS, t.AOBS )
					from ZooLogic.ARQCAJA t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.ARQCAJA(Fmodifw,Fectrans,Fecimpo,Fecexpo,Smodifw,Horaimpo,Horaexpo,Ualtafw,Hmodifw,Esttrans,Umodifw,Vmodifw,Zadsfw,Bdaltafw,Valtafw,Saltafw,Bdmodifw,Faltafw,Numero,Caja,Haltafw,Vendedor,Codigo,Aobs)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.BDMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.NUMERO,0),isnull( d.CAJA,0),convert( char(8), getdate(), 108 ),isnull( d.VENDEDOR,''),isnull( d.CODIGO,''),isnull( d.AOBS,'')
						From deleted d left join ZooLogic.ARQCAJA pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ARQTOTDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ARQCAJA_ARQTOTDET
ON ZooLogic.TablaTrabajo_ARQCAJA_ARQTOTDET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.AGRUPA = isnull( d.AGRUPA, t.AGRUPA ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUPADET = isnull( d.AGRUPADET, t.AGRUPADET ),
t.TOTGRUPO = isnull( d.TOTGRUPO, t.TOTGRUPO ),
t.ARQUEADO = isnull( d.ARQUEADO, t.ARQUEADO ),
t.DIFGRUPO = isnull( d.DIFGRUPO, t.DIFGRUPO ),
t.ARQEFEC = isnull( d.ARQEFEC, t.ARQEFEC ),
t.ARQOTROS = isnull( d.ARQOTROS, t.ARQOTROS )
from ZooLogic.ARQTOTDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ARQTOTDET
( 
"NROITEM",
"AGRUPA",
"CODIGO",
"AGRUPADET",
"TOTGRUPO",
"ARQUEADO",
"DIFGRUPO",
"ARQEFEC",
"ARQOTROS"
 )
Select 
d.NROITEM,
d.AGRUPA,
d.CODIGO,
d.AGRUPADET,
d.TOTGRUPO,
d.ARQUEADO,
d.DIFGRUPO,
d.ARQEFEC,
d.ARQOTROS
From deleted d left join ZooLogic.ARQTOTDET pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ARQEFECTDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ARQCAJA_ARQEFECTDET
ON ZooLogic.TablaTrabajo_ARQCAJA_ARQEFECTDET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.MONEDADEN = isnull( d.MONEDADEN, t.MONEDADEN ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.VALORDEN = isnull( d.VALORDEN, t.VALORDEN ),
t.CANT = isnull( d.CANT, t.CANT ),
t.TOT = isnull( d.TOT, t.TOT )
from ZooLogic.ARQEFECTDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ARQEFECTDET
( 
"NROITEM",
"CODIGO",
"MONEDADEN",
"DESCRI",
"TIPO",
"VALORDEN",
"CANT",
"TOT"
 )
Select 
d.NROITEM,
d.CODIGO,
d.MONEDADEN,
d.DESCRI,
d.TIPO,
d.VALORDEN,
d.CANT,
d.TOT
From deleted d left join ZooLogic.ARQEFECTDET pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ARQOTROSDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ARQCAJA_ARQOTROSDET
ON ZooLogic.TablaTrabajo_ARQCAJA_ARQOTROSDET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.VALOR = isnull( d.VALOR, t.VALOR ),
t.VALORDET = isnull( d.VALORDET, t.VALORDET ),
t.VALORGRUPO = isnull( d.VALORGRUPO, t.VALORGRUPO ),
t.MONEDA = isnull( d.MONEDA, t.MONEDA ),
t.TOTARQUEO = isnull( d.TOTARQUEO, t.TOTARQUEO )
from ZooLogic.ARQOTROSDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ARQOTROSDET
( 
"NROITEM",
"CODIGO",
"VALOR",
"VALORDET",
"VALORGRUPO",
"MONEDA",
"TOTARQUEO"
 )
Select 
d.NROITEM,
d.CODIGO,
d.VALOR,
d.VALORDET,
d.VALORGRUPO,
d.MONEDA,
d.TOTARQUEO
From deleted d left join ZooLogic.ARQOTROSDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ARQCAJA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ARQCAJA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ARQUEODECAJA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARQUEODECAJA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARQUEODECAJA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARQUEODECAJA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARQUEODECAJA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Seriemodificacionfw = nvl( c_ARQUEODECAJA.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_ARQUEODECAJA.Horaimpo, [] )
					.Horaexpo = nvl( c_ARQUEODECAJA.Horaexpo, [] )
					.Usuarioaltafw = nvl( c_ARQUEODECAJA.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_ARQUEODECAJA.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_ARQUEODECAJA.Estadotransferencia, [] )
					.Usuariomodificacionfw = nvl( c_ARQUEODECAJA.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ARQUEODECAJA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_ARQUEODECAJA.Basededatosaltafw, [] )
					.Versionaltafw = nvl( c_ARQUEODECAJA.Versionaltafw, [] )
					.Seriealtafw = nvl( c_ARQUEODECAJA.Seriealtafw, [] )
					.Basededatosmodificacionfw = nvl( c_ARQUEODECAJA.Basededatosmodificacionfw, [] )
					.Detalletotalporgrupo.Limpiar()
					.Detalletotalporgrupo.SetearEsNavegacion( .lProcesando )
					.Detalletotalporgrupo.Cargar()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ARQUEODECAJA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_ARQUEODECAJA.Numero, 0 )
					.Detallerecuentoefectivo.Limpiar()
					.Detallerecuentoefectivo.SetearEsNavegacion( .lProcesando )
					.Detallerecuentoefectivo.Cargar()
					.Caja_PK =  nvl( c_ARQUEODECAJA.Caja, 0 )
					.Horaaltafw = nvl( c_ARQUEODECAJA.Horaaltafw, [] )
					.Detalleotros.Limpiar()
					.Detalleotros.SetearEsNavegacion( .lProcesando )
					.Detalleotros.Cargar()
					.Vendedor_PK =  nvl( c_ARQUEODECAJA.Vendedor, [] )
					.Codigo = nvl( c_ARQUEODECAJA.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
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
			lxRetorno = c_ARQUEODECAJA.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.DetalleTotalPorGrupo
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

		loDetalle = this.oEntidad.DetalleRecuentoEfectivo
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

		loDetalle = this.oEntidad.DetalleOtros
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
		return c_ARQUEODECAJA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ARQCAJA' )
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
								from ZooLogic.ARQCAJA 
								Where   ARQCAJA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ARQCAJA", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Numero" as "Numero", "Caja" as "Caja", "Haltafw" as "Horaaltafw", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Aobs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ARQCAJA 
								Where   ARQCAJA.CODIGO != ''
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
	Tabla = 'ARQCAJA'
	Filtro = " ARQCAJA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ARQCAJA.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "ARQCAJA.Numero"
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
	<row entidad="ARQUEODECAJA                            " atributo="FECHAMODIFICACIONFW                     " tabla="ARQCAJA        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="FECHATRANSFERENCIA                      " tabla="ARQCAJA        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="FECHAIMPO                               " tabla="ARQCAJA        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="FECHAEXPO                               " tabla="ARQCAJA        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="SERIEMODIFICACIONFW                     " tabla="ARQCAJA        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="HORAIMPO                                " tabla="ARQCAJA        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="HORAEXPO                                " tabla="ARQCAJA        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="USUARIOALTAFW                           " tabla="ARQCAJA        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="HORAMODIFICACIONFW                      " tabla="ARQCAJA        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="ESTADOTRANSFERENCIA                     " tabla="ARQCAJA        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="USUARIOMODIFICACIONFW                   " tabla="ARQCAJA        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="VERSIONMODIFICACIONFW                   " tabla="ARQCAJA        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="ZADSFW                                  " tabla="ARQCAJA        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="BASEDEDATOSALTAFW                       " tabla="ARQCAJA        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="VERSIONALTAFW                           " tabla="ARQCAJA        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="SERIEALTAFW                             " tabla="ARQCAJA        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ARQCAJA        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="DETALLETOTALPORGRUPO                    " tabla="ARQTOTDET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Total por grupo                                                                                                                                                 " dominio="DETALLEITEMTOTALPORGRUPO      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="FECHAALTAFW                             " tabla="ARQCAJA        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="8" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="NUMERO                                  " tabla="ARQCAJA        " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CLAVEDEBUSQUEDA               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="DETALLERECUENTOEFECTIVO                 " tabla="ARQEFECTDET    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Recuento arqueo efectivo                                                                                                                                        " dominio="DETALLEITEMRECEFECTIVO        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="CAJA                                    " tabla="ARQCAJA        " campo="CAJA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Caja                                                                                                                                                            " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="HORAALTAFW                              " tabla="ARQCAJA        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="10" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="DETALLEOTROS                            " tabla="ARQOTROSDET    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Recuento arqueo otros                                                                                                                                           " dominio="DETALLEITEMARQUEOOTROS        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="VENDEDOR                                " tabla="ARQCAJA        " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="CODIGO                                  " tabla="ARQCAJA        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="198" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARQUEODECAJA                            " atributo="OBSERVACION                             " tabla="ARQCAJA        " campo="AOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Caj.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAJAESTA On ARQCAJA.CAJA = CAJAESTA.NumCaja And  CAJAESTA.NUMCAJA != 0                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On ARQCAJA.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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