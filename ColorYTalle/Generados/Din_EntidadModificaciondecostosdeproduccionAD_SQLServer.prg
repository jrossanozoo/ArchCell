
define class Din_EntidadMODIFICACIONDECOSTOSDEPRODUCCIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MODIFICACIONDECOSTOSDEPRODUCCION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 12, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 12, 0)]
	cTagClaveCandidata = '_MCPCC'
	cTagClavePk = '_MCPPK'
	cTablaPrincipal = 'MODCOSTOP'
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
			local  lxModcostopFecexpo, lxModcostopFectrans, lxModcostopFmodifw, lxModcostopFaltafw, lxModcostopFecimpo, lxModcostopSaltafw, lxModcostopHmodifw, lxModcostopSmodifw, lxModcostopUmodifw, lxModcostopUaltafw, lxModcostopZadsfw, lxModcostopValtafw, lxModcostopVmodifw, lxModcostopHoraimpo, lxModcostopHaltafw, lxModcostopHoraexpo, lxModcostopBdmodifw, lxModcostopBdaltafw, lxModcostopEsttrans, lxModcostopCodigo, lxModcostopCobs, lxModcostopFecha, lxModcostopProceso, lxModcostopTaller, lxModcostopNumero
				lxModcostopFecexpo =  .Fechaexpo			lxModcostopFectrans =  .Fechatransferencia			lxModcostopFmodifw =  .Fechamodificacionfw			lxModcostopFaltafw =  .Fechaaltafw			lxModcostopFecimpo =  .Fechaimpo			lxModcostopSaltafw =  .Seriealtafw			lxModcostopHmodifw =  .Horamodificacionfw			lxModcostopSmodifw =  .Seriemodificacionfw			lxModcostopUmodifw =  .Usuariomodificacionfw			lxModcostopUaltafw =  .Usuarioaltafw			lxModcostopZadsfw =  .Zadsfw			lxModcostopValtafw =  .Versionaltafw			lxModcostopVmodifw =  .Versionmodificacionfw			lxModcostopHoraimpo =  .Horaimpo			lxModcostopHaltafw =  .Horaaltafw			lxModcostopHoraexpo =  .Horaexpo			lxModcostopBdmodifw =  .Basededatosmodificacionfw			lxModcostopBdaltafw =  .Basededatosaltafw			lxModcostopEsttrans =  .Estadotransferencia			lxModcostopCodigo =  .Codigo			lxModcostopCobs =  .Observ			lxModcostopFecha =  .Fecha			lxModcostopProceso =  upper( .Proceso_PK ) 			lxModcostopTaller =  upper( .Taller_PK ) 			lxModcostopNumero =  .Numero
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxModcostopCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MODCOSTOP ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Esttrans","Codigo","Cobs","Fecha","Proceso","Taller","Numero" ) values ( <<"'" + this.ConvertirDateSql( lxModcostopFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopCobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopProceso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopTaller ) + "'" >>, <<lxModcostopNumero >> )
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
			for each loItem in this.oEntidad.ModCostos
				if this.oEntidad.ModCostos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxTaller_PK = loItem.Taller_PK
					lxTallerdetalle = loItem.Tallerdetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxDesdecantidad = loItem.Desdecantidad
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxCostodelista = loItem.Costodelista
					lxCostoactualizado = loItem.Costoactualizado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODCOSTPROD("CODIGO","NROITEM","SemiElab","SemiDeta","Proceso","ProcDeta","Taller","TallerDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","CodLisCost","CostoVig","CostoNue" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallerdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxDesdecantidad>>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxCostodelista>>, <<lxCostoactualizado>> ) 
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
			local  lxModcostopFecexpo, lxModcostopFectrans, lxModcostopFmodifw, lxModcostopFaltafw, lxModcostopFecimpo, lxModcostopSaltafw, lxModcostopHmodifw, lxModcostopSmodifw, lxModcostopUmodifw, lxModcostopUaltafw, lxModcostopZadsfw, lxModcostopValtafw, lxModcostopVmodifw, lxModcostopHoraimpo, lxModcostopHaltafw, lxModcostopHoraexpo, lxModcostopBdmodifw, lxModcostopBdaltafw, lxModcostopEsttrans, lxModcostopCodigo, lxModcostopCobs, lxModcostopFecha, lxModcostopProceso, lxModcostopTaller, lxModcostopNumero
				lxModcostopFecexpo =  .Fechaexpo			lxModcostopFectrans =  .Fechatransferencia			lxModcostopFmodifw =  .Fechamodificacionfw			lxModcostopFaltafw =  .Fechaaltafw			lxModcostopFecimpo =  .Fechaimpo			lxModcostopSaltafw =  .Seriealtafw			lxModcostopHmodifw =  .Horamodificacionfw			lxModcostopSmodifw =  .Seriemodificacionfw			lxModcostopUmodifw =  .Usuariomodificacionfw			lxModcostopUaltafw =  .Usuarioaltafw			lxModcostopZadsfw =  .Zadsfw			lxModcostopValtafw =  .Versionaltafw			lxModcostopVmodifw =  .Versionmodificacionfw			lxModcostopHoraimpo =  .Horaimpo			lxModcostopHaltafw =  .Horaaltafw			lxModcostopHoraexpo =  .Horaexpo			lxModcostopBdmodifw =  .Basededatosmodificacionfw			lxModcostopBdaltafw =  .Basededatosaltafw			lxModcostopEsttrans =  .Estadotransferencia			lxModcostopCodigo =  .Codigo			lxModcostopCobs =  .Observ			lxModcostopFecha =  .Fecha			lxModcostopProceso =  upper( .Proceso_PK ) 			lxModcostopTaller =  upper( .Taller_PK ) 			lxModcostopNumero =  .Numero
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.MODCOSTOP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxModcostopFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxModcostopFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxModcostopFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxModcostopFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxModcostopFecimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxModcostopSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxModcostopSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxModcostopUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxModcostopUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxModcostopZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxModcostopValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxModcostopHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxModcostopHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxModcostopHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxModcostopBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxModcostopEsttrans ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxModcostopCobs ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxModcostopFecha ) + "'">>,"Proceso" = <<"'" + this.FormatearTextoSql( lxModcostopProceso ) + "'">>,"Taller" = <<"'" + this.FormatearTextoSql( lxModcostopTaller ) + "'">>,"Numero" = <<lxModcostopNumero>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">> and  MODCOSTOP.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODCOSTPROD where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModCostos
				if this.oEntidad.ModCostos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxTaller_PK = loItem.Taller_PK
					lxTallerdetalle = loItem.Tallerdetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxDesdecantidad = loItem.Desdecantidad
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxCostodelista = loItem.Costodelista
					lxCostoactualizado = loItem.Costoactualizado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODCOSTPROD("CODIGO","NROITEM","SemiElab","SemiDeta","Proceso","ProcDeta","Taller","TallerDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","CodLisCost","CostoVig","CostoNue" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallerdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxDesdecantidad>>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxCostodelista>>, <<lxCostoactualizado>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.MODCOSTOP where " + this.ConvertirFuncionesSql( " MODCOSTOP.CODIGO != ''" ) )
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
			Local lxModcostopCodigo
			lxModcostopCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Cobs" as "Observ", "Fecha" as "Fecha", "Proceso" as "Proceso", "Taller" as "Taller", "Numero" as "Numero" from ZooLogic.MODCOSTOP where "Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">> and  MODCOSTOP.CODIGO != ''
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )

			if reccount( 'c_MODIFICACIONDECOSTOSDEPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxMODCOSTOPNumero As Variant
			lxMODCOSTOPNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Cobs" as "Observ", "Fecha" as "Fecha", "Proceso" as "Proceso", "Taller" as "Taller", "Numero" as "Numero" from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != '' And Numero = <<lxMODCOSTOPNumero>>
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			if reccount( 'c_MODIFICACIONDECOSTOSDEPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxModcostopCodigo as Variant
		llRetorno = .t.
		lxModcostopCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MODCOSTOP where "Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">> and  MODCOSTOP.CODIGO != ''
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
				lcOrden =  str( .Numero, 12, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Cobs" as "Observ", "Fecha" as "Fecha", "Proceso" as "Proceso", "Taller" as "Taller", "Numero" as "Numero" from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != '' order by Numero,Codigo
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
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
				lcOrden =  str( .Numero, 12, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Cobs" as "Observ", "Fecha" as "Fecha", "Proceso" as "Proceso", "Taller" as "Taller", "Numero" as "Numero" from ZooLogic.MODCOSTOP where  str( Numero, 12, 0) + funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MODCOSTOP.CODIGO != '' order by Numero,Codigo
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
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
				lcOrden =  str( .Numero, 12, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Cobs" as "Observ", "Fecha" as "Fecha", "Proceso" as "Proceso", "Taller" as "Taller", "Numero" as "Numero" from ZooLogic.MODCOSTOP where  str( Numero, 12, 0) + funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MODCOSTOP.CODIGO != '' order by Numero desc,Codigo desc
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
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
				lcOrden =  str( .Numero, 12, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Cobs" as "Observ", "Fecha" as "Fecha", "Proceso" as "Proceso", "Taller" as "Taller", "Numero" as "Numero" from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != '' order by Numero desc,Codigo desc
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valt" + ;
"afw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Esttrans,Codigo,Cobs,Fecha,Proceso,Taller,Nu" + ;
"mero" + ;
" from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != '' and " + lcFiltro )
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
			local  lxModcostopFecexpo, lxModcostopFectrans, lxModcostopFmodifw, lxModcostopFaltafw, lxModcostopFecimpo, lxModcostopSaltafw, lxModcostopHmodifw, lxModcostopSmodifw, lxModcostopUmodifw, lxModcostopUaltafw, lxModcostopZadsfw, lxModcostopValtafw, lxModcostopVmodifw, lxModcostopHoraimpo, lxModcostopHaltafw, lxModcostopHoraexpo, lxModcostopBdmodifw, lxModcostopBdaltafw, lxModcostopEsttrans, lxModcostopCodigo, lxModcostopCobs, lxModcostopFecha, lxModcostopProceso, lxModcostopTaller, lxModcostopNumero
				lxModcostopFecexpo = ctod( '  /  /    ' )			lxModcostopFectrans = ctod( '  /  /    ' )			lxModcostopFmodifw = ctod( '  /  /    ' )			lxModcostopFaltafw = ctod( '  /  /    ' )			lxModcostopFecimpo = ctod( '  /  /    ' )			lxModcostopSaltafw = []			lxModcostopHmodifw = []			lxModcostopSmodifw = []			lxModcostopUmodifw = []			lxModcostopUaltafw = []			lxModcostopZadsfw = []			lxModcostopValtafw = []			lxModcostopVmodifw = []			lxModcostopHoraimpo = []			lxModcostopHaltafw = []			lxModcostopHoraexpo = []			lxModcostopBdmodifw = []			lxModcostopBdaltafw = []			lxModcostopEsttrans = []			lxModcostopCodigo = []			lxModcostopCobs = []			lxModcostopFecha = ctod( '  /  /    ' )			lxModcostopProceso = []			lxModcostopTaller = []			lxModcostopNumero = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODCOSTPROD where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MODCOSTOP where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MODCOSTOP' + '_' + tcCampo
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
		lcWhere = " Where  MODCOSTOP.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Cobs" as "Observ", "Fecha" as "Fecha", "Proceso" as "Proceso", "Taller" as "Taller", "Numero" as "Numero"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODCOSTOP', '', tnTope )
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
	Function ObtenerDatosDetalleModCostos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MODCOSTPROD.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigo" as "Codigo", "Nroitem" as "Nroitem", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Codtalle" as "Talle", "Talledeta" as "Talledetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleModCostos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODCOSTPROD', 'ModCostos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleModCostos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleModCostos( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
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
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERV'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleModCostos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'SEMIELABORADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIELAB AS SEMIELABORADO'
				Case lcAtributo == 'SEMIELABORADODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIDETA AS SEMIELABORADODETALLE'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'PROCESODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCDETA AS PROCESODETALLE'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'TALLERDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLERDETA AS TALLERDETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORDETA AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLEDETA AS TALLEDETALLE'
				Case lcAtributo == 'DESDECANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS DESDECANTIDAD'
				Case lcAtributo == 'LISTADECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISCOST AS LISTADECOSTO'
				Case lcAtributo == 'COSTODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTOVIG AS COSTODELISTA'
				Case lcAtributo == 'COSTOACTUALIZADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTONUE AS COSTOACTUALIZADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERV'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleModCostos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADO'
				lcCampo = 'SEMIELAB'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADODETALLE'
				lcCampo = 'SEMIDETA'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODETALLE'
				lcCampo = 'PROCDETA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'TALLERDETALLE'
				lcCampo = 'TALLERDETA'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLORDETA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TALLEDETA'
			Case upper( alltrim( tcAtributo ) ) == 'DESDECANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADECOSTO'
				lcCampo = 'CODLISCOST'
			Case upper( alltrim( tcAtributo ) ) == 'COSTODELISTA'
				lcCampo = 'COSTOVIG'
			Case upper( alltrim( tcAtributo ) ) == 'COSTOACTUALIZADO'
				lcCampo = 'COSTONUE'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'MODCOSTOS'
			lcRetorno = 'MODCOSTPROD'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxModcostopFecexpo, lxModcostopFectrans, lxModcostopFmodifw, lxModcostopFaltafw, lxModcostopFecimpo, lxModcostopSaltafw, lxModcostopHmodifw, lxModcostopSmodifw, lxModcostopUmodifw, lxModcostopUaltafw, lxModcostopZadsfw, lxModcostopValtafw, lxModcostopVmodifw, lxModcostopHoraimpo, lxModcostopHaltafw, lxModcostopHoraexpo, lxModcostopBdmodifw, lxModcostopBdaltafw, lxModcostopEsttrans, lxModcostopCodigo, lxModcostopCobs, lxModcostopFecha, lxModcostopProceso, lxModcostopTaller, lxModcostopNumero
				lxModcostopFecexpo =  .Fechaexpo			lxModcostopFectrans =  .Fechatransferencia			lxModcostopFmodifw =  .Fechamodificacionfw			lxModcostopFaltafw =  .Fechaaltafw			lxModcostopFecimpo =  .Fechaimpo			lxModcostopSaltafw =  .Seriealtafw			lxModcostopHmodifw =  .Horamodificacionfw			lxModcostopSmodifw =  .Seriemodificacionfw			lxModcostopUmodifw =  .Usuariomodificacionfw			lxModcostopUaltafw =  .Usuarioaltafw			lxModcostopZadsfw =  .Zadsfw			lxModcostopValtafw =  .Versionaltafw			lxModcostopVmodifw =  .Versionmodificacionfw			lxModcostopHoraimpo =  .Horaimpo			lxModcostopHaltafw =  .Horaaltafw			lxModcostopHoraexpo =  .Horaexpo			lxModcostopBdmodifw =  .Basededatosmodificacionfw			lxModcostopBdaltafw =  .Basededatosaltafw			lxModcostopEsttrans =  .Estadotransferencia			lxModcostopCodigo =  .Codigo			lxModcostopCobs =  .Observ			lxModcostopFecha =  .Fecha			lxModcostopProceso =  upper( .Proceso_PK ) 			lxModcostopTaller =  upper( .Taller_PK ) 			lxModcostopNumero =  .Numero
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MODCOSTOP ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Esttrans","Codigo","Cobs","Fecha","Proceso","Taller","Numero" ) values ( <<"'" + this.ConvertirDateSql( lxModcostopFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopCobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopProceso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopTaller ) + "'" >>, <<lxModcostopNumero >> )
		endtext
		loColeccion.cTabla = 'MODCOSTOP' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModCostos
				if this.oEntidad.ModCostos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxTaller_PK = loItem.Taller_PK
					lxTallerdetalle = loItem.Tallerdetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxDesdecantidad = loItem.Desdecantidad
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxCostodelista = loItem.Costodelista
					lxCostoactualizado = loItem.Costoactualizado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODCOSTPROD("CODIGO","NROITEM","SemiElab","SemiDeta","Proceso","ProcDeta","Taller","TallerDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","CodLisCost","CostoVig","CostoNue" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallerdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxDesdecantidad>>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxCostodelista>>, <<lxCostoactualizado>> ) 
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
			local  lxModcostopFecexpo, lxModcostopFectrans, lxModcostopFmodifw, lxModcostopFaltafw, lxModcostopFecimpo, lxModcostopSaltafw, lxModcostopHmodifw, lxModcostopSmodifw, lxModcostopUmodifw, lxModcostopUaltafw, lxModcostopZadsfw, lxModcostopValtafw, lxModcostopVmodifw, lxModcostopHoraimpo, lxModcostopHaltafw, lxModcostopHoraexpo, lxModcostopBdmodifw, lxModcostopBdaltafw, lxModcostopEsttrans, lxModcostopCodigo, lxModcostopCobs, lxModcostopFecha, lxModcostopProceso, lxModcostopTaller, lxModcostopNumero
				lxModcostopFecexpo =  .Fechaexpo			lxModcostopFectrans =  .Fechatransferencia			lxModcostopFmodifw =  .Fechamodificacionfw			lxModcostopFaltafw =  .Fechaaltafw			lxModcostopFecimpo =  .Fechaimpo			lxModcostopSaltafw =  .Seriealtafw			lxModcostopHmodifw =  .Horamodificacionfw			lxModcostopSmodifw =  .Seriemodificacionfw			lxModcostopUmodifw =  .Usuariomodificacionfw			lxModcostopUaltafw =  .Usuarioaltafw			lxModcostopZadsfw =  .Zadsfw			lxModcostopValtafw =  .Versionaltafw			lxModcostopVmodifw =  .Versionmodificacionfw			lxModcostopHoraimpo =  .Horaimpo			lxModcostopHaltafw =  .Horaaltafw			lxModcostopHoraexpo =  .Horaexpo			lxModcostopBdmodifw =  .Basededatosmodificacionfw			lxModcostopBdaltafw =  .Basededatosaltafw			lxModcostopEsttrans =  .Estadotransferencia			lxModcostopCodigo =  .Codigo			lxModcostopCobs =  .Observ			lxModcostopFecha =  .Fecha			lxModcostopProceso =  upper( .Proceso_PK ) 			lxModcostopTaller =  upper( .Taller_PK ) 			lxModcostopNumero =  .Numero
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MODCOSTOP.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MODCOSTOP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxModcostopFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxModcostopFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxModcostopFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxModcostopFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxModcostopFecimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxModcostopSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxModcostopSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxModcostopUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxModcostopUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxModcostopZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxModcostopValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxModcostopHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxModcostopHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxModcostopHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxModcostopBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxModcostopEsttrans ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxModcostopCobs ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxModcostopFecha ) + "'">>, "Proceso" = <<"'" + this.FormatearTextoSql( lxModcostopProceso ) + "'">>, "Taller" = <<"'" + this.FormatearTextoSql( lxModcostopTaller ) + "'">>, "Numero" = <<lxModcostopNumero>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MODCOSTOP' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.MODCOSTPROD where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModCostos
				if this.oEntidad.ModCostos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxTaller_PK = loItem.Taller_PK
					lxTallerdetalle = loItem.Tallerdetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxDesdecantidad = loItem.Desdecantidad
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxCostodelista = loItem.Costodelista
					lxCostoactualizado = loItem.Costoactualizado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODCOSTPROD("CODIGO","NROITEM","SemiElab","SemiDeta","Proceso","ProcDeta","Taller","TallerDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","CodLisCost","CostoVig","CostoNue" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallerdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxDesdecantidad>>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxCostodelista>>, <<lxCostoactualizado>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MODCOSTOP.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MODCOSTOP where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.MODCOSTPROD where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MODCOSTOP' 
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
			.ModCostos.oItem.oCompCostosproduccion.lNuevo = .EsNuevo()
			.ModCostos.oItem.oCompCostosproduccion.lEdicion = .EsEdicion()
			.ModCostos.oItem.oCompCostosproduccion.lEliminar = .lEliminar
			.ModCostos.oItem.oCompCostosproduccion.lAnular = .lAnular
			loColSentencias = .ModCostos.oItem.oCompCostosproduccion.grabar()
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
			lcRetorno = [update ZooLogic.MODCOSTOP set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  MODCOSTOP.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MODCOSTOP where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MODCOSTOP.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxMODCOSTOPNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MODCOSTOP Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.MODCOSTOP set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, CObs = ] + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, Proceso = ] + "'" + this.FormatearTextoSql( &lcCursor..Proceso ) + "'"+ [, Taller = ] + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.MODCOSTOP Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, SALTAFW, HMODIFW, SMODIFW, UMODIFW, UALTAFW, ZADSFW, VALTAFW, VMODIFW, HORAIMPO, HALTAFW, HORAEXPO, BDMODIFW, BDALTAFW, ESTTRANS, Codigo, CObs, FECHA, Proceso, Taller, Numero
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proceso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'" + ',' + transform( &lcCursor..Numero )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.MODCOSTOP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MODCOSTPROD Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMODCOSTOPROD'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"CODIGO","NROITEM","SemiElab","SemiDeta","Proceso","ProcDeta","Taller","TallerDeta","codColor","ColorDeta","codTalle","TalleDeta","Cantidad","CodLisCost","CostoVig","CostoNue"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MODCOSTPROD ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiElab   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ProcDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Taller     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TallerDeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDeta  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodLisCost ) + "'" + ',' + transform( cDetallesExistentes.CostoVig   ) + ',' + transform( cDetallesExistentes.CostoNue   ) + ' )'  )
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
		this.oEntidad.ModCostos.oItem.oCompCostosproduccion.Recibir( this.oEntidad, 'ModCostos',this.oEntidad.cPrefijoRecibir + 'ITEMMODCOSTOPROD',this.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION')
		
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
			Case  lcAlias == lcPrefijo + 'MODIFICACIONDECOSTOSDEPRODUCCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MODIFICACIONDECOSTOSDEPRODUCCION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MODIFICACIONDECOSTOSDEPRODUCCION_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMODCOSTOPROD'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MODCOSTOP')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MODIFICACIONDECOSTOSDEPRODUCCION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MODIFICACIONDECOSTOSDEPRODUCCION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECHA     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MODCOSTOP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MODCOSTOP
Create Table ZooLogic.TablaTrabajo_MODCOSTOP ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
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
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codigo" char( 20 )  null, 
"cobs" varchar(max)  null, 
"fecha" datetime  null, 
"proceso" char( 15 )  null, 
"taller" char( 15 )  null, 
"numero" numeric( 12, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MODCOSTOP' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MODCOSTOP' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
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
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('proceso','proceso')
			.AgregarMapeo('taller','taller')
			.AgregarMapeo('numero','numero')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MODCOSTOP'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.COBS = isnull( d.COBS, t.COBS ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.PROCESO = isnull( d.PROCESO, t.PROCESO ),t.TALLER = isnull( d.TALLER, t.TALLER ),t.NUMERO = isnull( d.NUMERO, t.NUMERO )
					from ZooLogic.MODCOSTOP t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.MODCOSTOP(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Esttrans,Codigo,Cobs,Fecha,Proceso,Taller,Numero)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODIGO,''),isnull( d.COBS,''),isnull( d.FECHA,''),isnull( d.PROCESO,''),isnull( d.TALLER,''),isnull( d.NUMERO,0)
						From deleted d left join ZooLogic.MODCOSTOP pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.MODCOSTOP cc 
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
					from ZooLogic.MODCOSTOP t inner join deleted d 
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
					from ZooLogic.MODCOSTOP t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MODCOSTPROD( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MODCOSTOP_MODCOSTPROD
ON ZooLogic.TablaTrabajo_MODCOSTOP_MODCOSTPROD
AFTER DELETE
As
Begin
Update t Set 
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.SEMIELAB = isnull( d.SEMIELAB, t.SEMIELAB ),
t.SEMIDETA = isnull( d.SEMIDETA, t.SEMIDETA ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.PROCDETA = isnull( d.PROCDETA, t.PROCDETA ),
t.TALLER = isnull( d.TALLER, t.TALLER ),
t.TALLERDETA = isnull( d.TALLERDETA, t.TALLERDETA ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.COLORDETA = isnull( d.COLORDETA, t.COLORDETA ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.TALLEDETA = isnull( d.TALLEDETA, t.TALLEDETA ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.CODLISCOST = isnull( d.CODLISCOST, t.CODLISCOST ),
t.COSTOVIG = isnull( d.COSTOVIG, t.COSTOVIG ),
t.COSTONUE = isnull( d.COSTONUE, t.COSTONUE )
from ZooLogic.MODCOSTPROD t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MODCOSTPROD
( 
"CODIGO",
"NROITEM",
"SEMIELAB",
"SEMIDETA",
"PROCESO",
"PROCDETA",
"TALLER",
"TALLERDETA",
"CODCOLOR",
"COLORDETA",
"CODTALLE",
"TALLEDETA",
"CANTIDAD",
"CODLISCOST",
"COSTOVIG",
"COSTONUE"
 )
Select 
d.CODIGO,
d.NROITEM,
d.SEMIELAB,
d.SEMIDETA,
d.PROCESO,
d.PROCDETA,
d.TALLER,
d.TALLERDETA,
d.CODCOLOR,
d.COLORDETA,
d.CODTALLE,
d.TALLEDETA,
d.CANTIDAD,
d.CODLISCOST,
d.COSTOVIG,
d.COSTONUE
From deleted d left join ZooLogic.MODCOSTPROD pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MODCOSTOP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MODCOSTOP
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MODIFICACIONDECOSTOSDEPRODUCCION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Horaimpo, [] )
					.Horaaltafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Horaaltafw, [] )
					.Horaexpo = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Estadotransferencia, [] )
					.Codigo = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observ')
					.Observ = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fecha, ctod( '  /  /    ' ) ) )
					.Proceso_PK =  nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Proceso, [] )
					.Modcostos.Limpiar()
					.Modcostos.SetearEsNavegacion( .lProcesando )
					.Modcostos.Cargar()
					.Taller_PK =  nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Taller, [] )
					.Numero = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Numero, 0 )
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
			lxRetorno = c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.ModCostos
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
		return c_MODIFICACIONDECOSTOSDEPRODUCCION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MODCOSTOP' )
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
								from ZooLogic.MODCOSTOP 
								Where   MODCOSTOP.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MODCOSTOP", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Cobs" as "Observ", "Fecha" as "Fecha", "Proceso" as "Proceso", "Taller" as "Taller", "Numero" as "Numero"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MODCOSTOP 
								Where   MODCOSTOP.CODIGO != ''
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
	Tabla = 'MODCOSTOP'
	Filtro = " MODCOSTOP.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MODCOSTOP.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "MODCOSTOP.Numero"
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
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHAEXPO                               " tabla="MODCOSTOP      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHATRANSFERENCIA                      " tabla="MODCOSTOP      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHAMODIFICACIONFW                     " tabla="MODCOSTOP      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHAALTAFW                             " tabla="MODCOSTOP      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHAIMPO                               " tabla="MODCOSTOP      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="SERIEALTAFW                             " tabla="MODCOSTOP      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="HORAMODIFICACIONFW                      " tabla="MODCOSTOP      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="SERIEMODIFICACIONFW                     " tabla="MODCOSTOP      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="USUARIOMODIFICACIONFW                   " tabla="MODCOSTOP      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="USUARIOALTAFW                           " tabla="MODCOSTOP      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="ZADSFW                                  " tabla="MODCOSTOP      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="VERSIONALTAFW                           " tabla="MODCOSTOP      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="VERSIONMODIFICACIONFW                   " tabla="MODCOSTOP      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="HORAIMPO                                " tabla="MODCOSTOP      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="HORAALTAFW                              " tabla="MODCOSTOP      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="HORAEXPO                                " tabla="MODCOSTOP      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MODCOSTOP      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="BASEDEDATOSALTAFW                       " tabla="MODCOSTOP      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="ESTADOTRANSFERENCIA                     " tabla="MODCOSTOP      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="CODIGO                                  " tabla="MODCOSTOP      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Identificador                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="OBSERV                                  " tabla="MODCOSTOP      " campo="COBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHA                                   " tabla="MODCOSTOP      " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="402" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="PROCESO                                 " tabla="MODCOSTOP      " campo="PROCESO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROCESOPRODUCCION                       " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Proceso                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="MODCOSTOS                               " tabla="MODCOSTPROD    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Costos de talleres                                                                                                                                              " dominio="DETALLEITEMMODCOSTOPROD       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="TALLER                                  " tabla="MODCOSTOP      " campo="TALLER    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLER                                  " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Taller                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="NUMERO                                  " tabla="MODCOSTOP      " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="CLAVEDEBUSQUEDA               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="DESCRIPCION                             " tabla="PROCPRODUC     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROCPRODUC On MODCOSTOP.PROCESO = PROCPRODUC.Codigo And  PROCPRODUC.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="DESCRIPCION                             " tabla="TALLER         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLER On MODCOSTOP.TALLER = TALLER.Codigo And  TALLER.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMMODCOSTOPROD                        " atributo="SEMIELABORADO                           " tabla="MODCOSTPROD    " campo="SEMIELAB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INSUMO                                  " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleCostosDeTalleres, Semielaborado                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="SEMIELABORADODETALLE                    " tabla="MODCOSTPROD    " campo="SEMIDETA  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleCostosDeTalleres, Descripción                                                                                                                            " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Semielaborado.Descripcion                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="PROCESO                                 " tabla="MODCOSTPROD    " campo="PROCESO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROCESOPRODUCCION                       " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleCostosDeTalleres, Proceso                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="PROCESODETALLE                          " tabla="MODCOSTPROD    " campo="PROCDETA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleCostosDeTalleres, Descripción del proceso                                                                                                                " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Proceso.Descripcion                                                                                                                                                                                                                                           " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="TALLER                                  " tabla="MODCOSTPROD    " campo="TALLER    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLER                                  " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleCostosDeTalleres, Taller                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="TALLERDETALLE                           " tabla="MODCOSTPROD    " campo="TALLERDETA" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleCostosDeTalleres, Descripción del taller                                                                                                                 " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Taller.Descripcion                                                                                                                                                                                                                                            " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="COLOR                                   " tabla="MODCOSTPROD    " campo="CODCOLOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleCostosDeTalleres, Color                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="COLORDETALLE                            " tabla="MODCOSTPROD    " campo="COLORDETA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetalleCostosDeTalleres, Descripción del color                                                                                                                  " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="TALLE                                   " tabla="MODCOSTPROD    " campo="CODTALLE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleCostosDeTalleres, Talle                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="TALLEDETALLE                            " tabla="MODCOSTPROD    " campo="TALLEDETA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleCostosDeTalleres, Descripción del talle                                                                                                                  " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Talle.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="DESDECANTIDAD                           " tabla="MODCOSTPROD    " campo="CANTIDAD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="211" etiqueta="DetalleCostosDeTalleres, Desde cantidad                                                                                                                         " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="LISTADECOSTO                            " tabla="MODCOSTPROD    " campo="CODLISCOST" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADECOSTOSDEPRODUCCION               " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="212" etiqueta="DetalleCostosDeTalleres, L. precio                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="COSTODELISTA                            " tabla="MODCOSTPROD    " campo="COSTOVIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="213" etiqueta="DetalleCostosDeTalleres, C. vigente                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="COSTOACTUALIZADO                        " tabla="MODCOSTPROD    " campo="COSTONUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="214" etiqueta="DetalleCostosDeTalleres, C. nuevo                                                                                                                               " dominio="PRECIONONEGATIVO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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