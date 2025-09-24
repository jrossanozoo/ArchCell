
define class Din_EntidadTIDIFERENCIASDEINVENTARIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TIDIFERENCIASDEINVENTARIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_TINPK'
	cTablaPrincipal = 'TIDIFINV'
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
			local  lxTidifinvFecimpo, lxTidifinvFectrans, lxTidifinvFmodifw, lxTidifinvFecexpo, lxTidifinvFaltafw, lxTidifinvHoraexpo, lxTidifinvHoraimpo, lxTidifinvSmodifw, lxTidifinvHmodifw, lxTidifinvValtafw, lxTidifinvVmodifw, lxTidifinvUmodifw, lxTidifinvSaltafw, lxTidifinvUaltafw, lxTidifinvHaltafw, lxTidifinvZadsfw, lxTidifinvBdmodifw, lxTidifinvBdaltafw, lxTidifinvEsttrans, lxTidifinvCodigo, lxTidifinvModo, lxTidifinvIdinvcont, lxTidifinvDescrip, lxTidifinvIdinvfis, lxTidifinvMobs, lxTidifinvFecha, lxTidifinvMsorigdest, lxTidifinvMsmotivo, lxTidifinvMsfecha, lxTidifinvMovgen
				lxTidifinvFecimpo =  .Fechaimpo			lxTidifinvFectrans =  .Fechatransferencia			lxTidifinvFmodifw =  .Fechamodificacionfw			lxTidifinvFecexpo =  .Fechaexpo			lxTidifinvFaltafw =  .Fechaaltafw			lxTidifinvHoraexpo =  .Horaexpo			lxTidifinvHoraimpo =  .Horaimpo			lxTidifinvSmodifw =  .Seriemodificacionfw			lxTidifinvHmodifw =  .Horamodificacionfw			lxTidifinvValtafw =  .Versionaltafw			lxTidifinvVmodifw =  .Versionmodificacionfw			lxTidifinvUmodifw =  .Usuariomodificacionfw			lxTidifinvSaltafw =  .Seriealtafw			lxTidifinvUaltafw =  .Usuarioaltafw			lxTidifinvHaltafw =  .Horaaltafw			lxTidifinvZadsfw =  .Zadsfw			lxTidifinvBdmodifw =  .Basededatosmodificacionfw			lxTidifinvBdaltafw =  .Basededatosaltafw			lxTidifinvEsttrans =  .Estadotransferencia			lxTidifinvCodigo =  .Codigo			lxTidifinvModo =  .Modo			lxTidifinvIdinvcont =  .Idinventarioacontrolar_PK 			lxTidifinvDescrip =  .Descripcion			lxTidifinvIdinvfis =  .Idinventariofisico_PK 			lxTidifinvMobs =  .Obs			lxTidifinvFecha =  .Fecha			lxTidifinvMsorigdest =  upper( .MSOrigenDestino_PK ) 			lxTidifinvMsmotivo =  upper( .MSMotivo_PK ) 			lxTidifinvMsfecha =  .Msfecha			lxTidifinvMovgen =  .Movimientogenerado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTidifinvCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TIDIFINV ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Horaexpo","Horaimpo","Smodifw","Hmodifw","Valtafw","Vmodifw","Umodifw","Saltafw","Ualtafw","Haltafw","Zadsfw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Modo","Idinvcont","Descrip","Idinvfis","Mobs","Fecha","Msorigdest","Msmotivo","Msfecha","Movgen" ) values ( <<"'" + this.ConvertirDateSql( lxTidifinvFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvEsttrans ) + "'" >>, <<lxTidifinvCodigo >>, <<lxTidifinvModo >>, <<lxTidifinvIdinvcont >>, <<"'" + this.FormatearTextoSql( lxTidifinvDescrip ) + "'" >>, <<lxTidifinvIdinvfis >>, <<"'" + this.FormatearTextoSql( lxTidifinvMobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvMsorigdest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvMsmotivo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvMsfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvMovgen ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.InventariosFisicosDetalle
				if this.oEntidad.InventariosFisicosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxInventariofisico_PK = loItem.Inventariofisico_PK
					lxInventariofisicodetalle = loItem.Inventariofisicodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TIItemDifInv("Codigo","NROITEM","IdInvFis","InvFisDesc" ) values ( <<transform( lxValorClavePrimaria )>>, <<lxNroitem>>, <<lxInventariofisico_PK>>, <<"'" + this.FormatearTextoSql( lxInventariofisicodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
			dodefault()
			local lxCodigo
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			this.oSP.EliminarDiferenciasDeInventarioTemporalAntesDeComenzar(lxCodigo)
			local lxCodigo
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			this.oSP.InsertarDiferenciasDeInventarioTemporal(lxCodigo)
			local lxIDInventarioAControlar, lxCodigo, lxModo
			if empty( this.oEntidad.IDInventarioAControlar_pk )
				lxIDInventarioAControlar = null
			else
				lxIDInventarioAControlar = this.oEntidad.IDInventarioAControlar_pk
			endif
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			if empty( this.oEntidad.Modo )
				lxModo = null
			else
				lxModo = this.oEntidad.Modo
			endif
			this.oSP.InsertarDiferenciasDeInventario(lxIDInventarioAControlar, lxCodigo, lxModo)
			local lxCodigo
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			this.oSP.EliminarDiferenciasDeInventarioTemporalDespuesDeFinalizar(lxCodigo)
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
			local  lxTidifinvFecimpo, lxTidifinvFectrans, lxTidifinvFmodifw, lxTidifinvFecexpo, lxTidifinvFaltafw, lxTidifinvHoraexpo, lxTidifinvHoraimpo, lxTidifinvSmodifw, lxTidifinvHmodifw, lxTidifinvValtafw, lxTidifinvVmodifw, lxTidifinvUmodifw, lxTidifinvSaltafw, lxTidifinvUaltafw, lxTidifinvHaltafw, lxTidifinvZadsfw, lxTidifinvBdmodifw, lxTidifinvBdaltafw, lxTidifinvEsttrans, lxTidifinvCodigo, lxTidifinvModo, lxTidifinvIdinvcont, lxTidifinvDescrip, lxTidifinvIdinvfis, lxTidifinvMobs, lxTidifinvFecha, lxTidifinvMsorigdest, lxTidifinvMsmotivo, lxTidifinvMsfecha, lxTidifinvMovgen
				lxTidifinvFecimpo =  .Fechaimpo			lxTidifinvFectrans =  .Fechatransferencia			lxTidifinvFmodifw =  .Fechamodificacionfw			lxTidifinvFecexpo =  .Fechaexpo			lxTidifinvFaltafw =  .Fechaaltafw			lxTidifinvHoraexpo =  .Horaexpo			lxTidifinvHoraimpo =  .Horaimpo			lxTidifinvSmodifw =  .Seriemodificacionfw			lxTidifinvHmodifw =  .Horamodificacionfw			lxTidifinvValtafw =  .Versionaltafw			lxTidifinvVmodifw =  .Versionmodificacionfw			lxTidifinvUmodifw =  .Usuariomodificacionfw			lxTidifinvSaltafw =  .Seriealtafw			lxTidifinvUaltafw =  .Usuarioaltafw			lxTidifinvHaltafw =  .Horaaltafw			lxTidifinvZadsfw =  .Zadsfw			lxTidifinvBdmodifw =  .Basededatosmodificacionfw			lxTidifinvBdaltafw =  .Basededatosaltafw			lxTidifinvEsttrans =  .Estadotransferencia			lxTidifinvCodigo =  .Codigo			lxTidifinvModo =  .Modo			lxTidifinvIdinvcont =  .Idinventarioacontrolar_PK 			lxTidifinvDescrip =  .Descripcion			lxTidifinvIdinvfis =  .Idinventariofisico_PK 			lxTidifinvMobs =  .Obs			lxTidifinvFecha =  .Fecha			lxTidifinvMsorigdest =  upper( .MSOrigenDestino_PK ) 			lxTidifinvMsmotivo =  upper( .MSMotivo_PK ) 			lxTidifinvMsfecha =  .Msfecha			lxTidifinvMovgen =  .Movimientogenerado
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TIDIFINV set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTidifinvFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTidifinvFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTidifinvFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTidifinvFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTidifinvFaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTidifinvHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTidifinvHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvHmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTidifinvValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTidifinvUaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvHaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTidifinvZadsfw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTidifinvEsttrans ) + "'">>,"Codigo" = <<lxTidifinvCodigo>>,"Modo" = <<lxTidifinvModo>>,"Idinvcont" = <<lxTidifinvIdinvcont>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxTidifinvDescrip ) + "'">>,"Idinvfis" = <<lxTidifinvIdinvfis>>,"Mobs" = <<"'" + this.FormatearTextoSql( lxTidifinvMobs ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxTidifinvFecha ) + "'">>,"Msorigdest" = <<"'" + this.FormatearTextoSql( lxTidifinvMsorigdest ) + "'">>,"Msmotivo" = <<"'" + this.FormatearTextoSql( lxTidifinvMsmotivo ) + "'">>,"Msfecha" = <<"'" + this.ConvertirDateSql( lxTidifinvMsfecha ) + "'">>,"Movgen" = <<"'" + this.FormatearTextoSql( lxTidifinvMovgen ) + "'">> where "Codigo" = <<lxTidifinvCodigo>> and  TIDIFINV.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TIItemDifInv where "CODIGO" = ' + transform( .oEntidad.CODIGO ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.InventariosFisicosDetalle
				if this.oEntidad.InventariosFisicosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxInventariofisico_PK = loItem.Inventariofisico_PK
					lxInventariofisicodetalle = loItem.Inventariofisicodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TIItemDifInv("Codigo","NROITEM","IdInvFis","InvFisDesc" ) values ( <<transform( lxValorClavePrimaria )>>, <<lxNroitem>>, <<lxInventariofisico_PK>>, <<"'" + this.FormatearTextoSql( lxInventariofisicodetalle ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.TIDIFINV where " + this.ConvertirFuncionesSql( " TIDIFINV.CODIGO != 0" ) )
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
			Local lxTidifinvCodigo
			lxTidifinvCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Modo" as "Modo", "Idinvcont" as "Idinventarioacontrolar", "Descrip" as "Descripcion", "Idinvfis" as "Idinventariofisico", "Mobs" as "Obs", "Fecha" as "Fecha", "Msorigdest" as "Msorigendestino", "Msmotivo" as "Msmotivo", "Msfecha" as "Msfecha", "Movgen" as "Movimientogenerado" from ZooLogic.TIDIFINV where "Codigo" = <<lxTidifinvCodigo>> and  TIDIFINV.CODIGO != 0
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIO', set( 'Datasession' ) )

			if reccount( 'c_TIDIFERENCIASDEINVENTARIO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Idinvfis" as "Inventariofisico", "Invfisdesc" as "Inventariofisicodetalle" from ZooLogic.TIItemDifInv where CODIGO = <<transform( c_TIDIFERENCIASDEINVENTARIO.CODIGO )>> Order by NroItem
			endtext
			use in select('c_InventariosFisicosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_InventariosFisicosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_InventariosFisicosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTidifinvCodigo as Variant
		llRetorno = .t.
		lxTidifinvCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TIDIFINV where "Codigo" = <<lxTidifinvCodigo>> and  TIDIFINV.CODIGO != 0
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Modo" as "Modo", "Idinvcont" as "Idinventarioacontrolar", "Descrip" as "Descripcion", "Idinvfis" as "Idinventariofisico", "Mobs" as "Obs", "Fecha" as "Fecha", "Msorigdest" as "Msorigendestino", "Msmotivo" as "Msmotivo", "Msfecha" as "Msfecha", "Movgen" as "Movimientogenerado" from ZooLogic.TIDIFINV where  TIDIFINV.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Idinvfis" as "Inventariofisico", "Invfisdesc" as "Inventariofisicodetalle" from ZooLogic.TIItemDifInv where CODIGO = <<transform( c_TIDIFERENCIASDEINVENTARIO.CODIGO )>> Order by NroItem
			endtext
			use in select('c_InventariosFisicosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_InventariosFisicosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_InventariosFisicosDetalle
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Modo" as "Modo", "Idinvcont" as "Idinventarioacontrolar", "Descrip" as "Descripcion", "Idinvfis" as "Idinventariofisico", "Mobs" as "Obs", "Fecha" as "Fecha", "Msorigdest" as "Msorigendestino", "Msmotivo" as "Msmotivo", "Msfecha" as "Msfecha", "Movgen" as "Movimientogenerado" from ZooLogic.TIDIFINV where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIDIFINV.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Idinvfis" as "Inventariofisico", "Invfisdesc" as "Inventariofisicodetalle" from ZooLogic.TIItemDifInv where CODIGO = <<transform( c_TIDIFERENCIASDEINVENTARIO.CODIGO )>> Order by NroItem
			endtext
			use in select('c_InventariosFisicosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_InventariosFisicosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_InventariosFisicosDetalle
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Modo" as "Modo", "Idinvcont" as "Idinventarioacontrolar", "Descrip" as "Descripcion", "Idinvfis" as "Idinventariofisico", "Mobs" as "Obs", "Fecha" as "Fecha", "Msorigdest" as "Msorigendestino", "Msmotivo" as "Msmotivo", "Msfecha" as "Msfecha", "Movgen" as "Movimientogenerado" from ZooLogic.TIDIFINV where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIDIFINV.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Idinvfis" as "Inventariofisico", "Invfisdesc" as "Inventariofisicodetalle" from ZooLogic.TIItemDifInv where CODIGO = <<transform( c_TIDIFERENCIASDEINVENTARIO.CODIGO )>> Order by NroItem
			endtext
			use in select('c_InventariosFisicosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_InventariosFisicosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_InventariosFisicosDetalle
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Modo" as "Modo", "Idinvcont" as "Idinventarioacontrolar", "Descrip" as "Descripcion", "Idinvfis" as "Idinventariofisico", "Mobs" as "Obs", "Fecha" as "Fecha", "Msorigdest" as "Msorigendestino", "Msmotivo" as "Msmotivo", "Msfecha" as "Msfecha", "Movgen" as "Movimientogenerado" from ZooLogic.TIDIFINV where  TIDIFINV.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_TIDIFERENCIASDEINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIDIFERENCIASDEINVENTARIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Idinvfis" as "Inventariofisico", "Invfisdesc" as "Inventariofisicodetalle" from ZooLogic.TIItemDifInv where CODIGO = <<transform( c_TIDIFERENCIASDEINVENTARIO.CODIGO )>> Order by NroItem
			endtext
			use in select('c_InventariosFisicosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_InventariosFisicosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_InventariosFisicosDetalle
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.CODIGO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Horaexpo,Horaimpo,Smodifw,Hmodifw,Valtafw,Vmodifw,U" + ;
"modifw,Saltafw,Ualtafw,Haltafw,Zadsfw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Modo,Idinvcont,Descrip,Idinv" + ;
"fis,Mobs,Fecha,Msorigdest,Msmotivo,Msfecha,Movgen" + ;
" from ZooLogic.TIDIFINV where  TIDIFINV.CODIGO != 0 and " + lcFiltro )
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
			local  lxTidifinvFecimpo, lxTidifinvFectrans, lxTidifinvFmodifw, lxTidifinvFecexpo, lxTidifinvFaltafw, lxTidifinvHoraexpo, lxTidifinvHoraimpo, lxTidifinvSmodifw, lxTidifinvHmodifw, lxTidifinvValtafw, lxTidifinvVmodifw, lxTidifinvUmodifw, lxTidifinvSaltafw, lxTidifinvUaltafw, lxTidifinvHaltafw, lxTidifinvZadsfw, lxTidifinvBdmodifw, lxTidifinvBdaltafw, lxTidifinvEsttrans, lxTidifinvCodigo, lxTidifinvModo, lxTidifinvIdinvcont, lxTidifinvDescrip, lxTidifinvIdinvfis, lxTidifinvMobs, lxTidifinvFecha, lxTidifinvMsorigdest, lxTidifinvMsmotivo, lxTidifinvMsfecha, lxTidifinvMovgen
				lxTidifinvFecimpo = ctod( '  /  /    ' )			lxTidifinvFectrans = ctod( '  /  /    ' )			lxTidifinvFmodifw = ctod( '  /  /    ' )			lxTidifinvFecexpo = ctod( '  /  /    ' )			lxTidifinvFaltafw = ctod( '  /  /    ' )			lxTidifinvHoraexpo = []			lxTidifinvHoraimpo = []			lxTidifinvSmodifw = []			lxTidifinvHmodifw = []			lxTidifinvValtafw = []			lxTidifinvVmodifw = []			lxTidifinvUmodifw = []			lxTidifinvSaltafw = []			lxTidifinvUaltafw = []			lxTidifinvHaltafw = []			lxTidifinvZadsfw = []			lxTidifinvBdmodifw = []			lxTidifinvBdaltafw = []			lxTidifinvEsttrans = []			lxTidifinvCodigo = 0			lxTidifinvModo = 0			lxTidifinvIdinvcont = 0			lxTidifinvDescrip = []			lxTidifinvIdinvfis = 0			lxTidifinvMobs = []			lxTidifinvFecha = ctod( '  /  /    ' )			lxTidifinvMsorigdest = []			lxTidifinvMsmotivo = []			lxTidifinvMsfecha = ctod( '  /  /    ' )			lxTidifinvMovgen = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			local lxCodigo
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			this.oSP.EliminarEnTIDIFERENCIASDEINVENTARIODetalle(lxCodigo)
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TIItemDifInv where "CODIGO" = ' + transform( .oEntidad.CODIGO ) )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TIDIFINV where "CODIGO" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TIDIFINV' + '_' + tcCampo
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
		lcWhere = " Where  TIDIFINV.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Modo" as "Modo", "Idinvcont" as "Idinventarioacontrolar", "Descrip" as "Descripcion", "Idinvfis" as "Idinventariofisico", "Mobs" as "Obs", "Fecha" as "Fecha", "Msorigdest" as "Msorigendestino", "Msmotivo" as "Msmotivo", "Msfecha" as "Msfecha", "Movgen" as "Movimientogenerado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TIDIFINV', '', tnTope )
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
	Function ObtenerDatosDetalleInventariosFisicosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  TIITEMDIFINV.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigo" as "Codigo", "Nroitem" as "Nroitem", "Idinvfis" as "Inventariofisico", "Invfisdesc" as "Inventariofisicodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleInventariosFisicosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TIItemDifInv', 'InventariosFisicosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleInventariosFisicosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleInventariosFisicosDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MODO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODO AS MODO'
				Case lcAtributo == 'IDINVENTARIOACONTROLAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDINVCONT AS IDINVENTARIOACONTROLAR'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'IDINVENTARIOFISICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDINVFIS AS IDINVENTARIOFISICO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'MSORIGENDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MSORIGDEST AS MSORIGENDESTINO'
				Case lcAtributo == 'MSMOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MSMOTIVO AS MSMOTIVO'
				Case lcAtributo == 'MSFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MSFECHA AS MSFECHA'
				Case lcAtributo == 'MOVIMIENTOGENERADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOVGEN AS MOVIMIENTOGENERADO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleInventariosFisicosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'INVENTARIOFISICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDINVFIS AS INVENTARIOFISICO'
				Case lcAtributo == 'INVENTARIOFISICODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVFISDESC AS INVENTARIOFISICODETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MODO'
				lcCampo = 'MODO'
			Case upper( alltrim( tcAtributo ) ) == 'IDINVENTARIOACONTROLAR'
				lcCampo = 'IDINVCONT'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'IDINVENTARIOFISICO'
				lcCampo = 'IDINVFIS'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'MSORIGENDESTINO'
				lcCampo = 'MSORIGDEST'
			Case upper( alltrim( tcAtributo ) ) == 'MSMOTIVO'
				lcCampo = 'MSMOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'MSFECHA'
				lcCampo = 'MSFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIMIENTOGENERADO'
				lcCampo = 'MOVGEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleInventariosFisicosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIOFISICO'
				lcCampo = 'IDINVFIS'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIOFISICODETALLE'
				lcCampo = 'INVFISDESC'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'INVENTARIOSFISICOSDETALLE'
			lcRetorno = 'TIITEMDIFINV'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxTidifinvFecimpo, lxTidifinvFectrans, lxTidifinvFmodifw, lxTidifinvFecexpo, lxTidifinvFaltafw, lxTidifinvHoraexpo, lxTidifinvHoraimpo, lxTidifinvSmodifw, lxTidifinvHmodifw, lxTidifinvValtafw, lxTidifinvVmodifw, lxTidifinvUmodifw, lxTidifinvSaltafw, lxTidifinvUaltafw, lxTidifinvHaltafw, lxTidifinvZadsfw, lxTidifinvBdmodifw, lxTidifinvBdaltafw, lxTidifinvEsttrans, lxTidifinvCodigo, lxTidifinvModo, lxTidifinvIdinvcont, lxTidifinvDescrip, lxTidifinvIdinvfis, lxTidifinvMobs, lxTidifinvFecha, lxTidifinvMsorigdest, lxTidifinvMsmotivo, lxTidifinvMsfecha, lxTidifinvMovgen
				lxTidifinvFecimpo =  .Fechaimpo			lxTidifinvFectrans =  .Fechatransferencia			lxTidifinvFmodifw =  .Fechamodificacionfw			lxTidifinvFecexpo =  .Fechaexpo			lxTidifinvFaltafw =  .Fechaaltafw			lxTidifinvHoraexpo =  .Horaexpo			lxTidifinvHoraimpo =  .Horaimpo			lxTidifinvSmodifw =  .Seriemodificacionfw			lxTidifinvHmodifw =  .Horamodificacionfw			lxTidifinvValtafw =  .Versionaltafw			lxTidifinvVmodifw =  .Versionmodificacionfw			lxTidifinvUmodifw =  .Usuariomodificacionfw			lxTidifinvSaltafw =  .Seriealtafw			lxTidifinvUaltafw =  .Usuarioaltafw			lxTidifinvHaltafw =  .Horaaltafw			lxTidifinvZadsfw =  .Zadsfw			lxTidifinvBdmodifw =  .Basededatosmodificacionfw			lxTidifinvBdaltafw =  .Basededatosaltafw			lxTidifinvEsttrans =  .Estadotransferencia			lxTidifinvCodigo =  .Codigo			lxTidifinvModo =  .Modo			lxTidifinvIdinvcont =  .Idinventarioacontrolar_PK 			lxTidifinvDescrip =  .Descripcion			lxTidifinvIdinvfis =  .Idinventariofisico_PK 			lxTidifinvMobs =  .Obs			lxTidifinvFecha =  .Fecha			lxTidifinvMsorigdest =  upper( .MSOrigenDestino_PK ) 			lxTidifinvMsmotivo =  upper( .MSMotivo_PK ) 			lxTidifinvMsfecha =  .Msfecha			lxTidifinvMovgen =  .Movimientogenerado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TIDIFINV ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Horaexpo","Horaimpo","Smodifw","Hmodifw","Valtafw","Vmodifw","Umodifw","Saltafw","Ualtafw","Haltafw","Zadsfw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Modo","Idinvcont","Descrip","Idinvfis","Mobs","Fecha","Msorigdest","Msmotivo","Msfecha","Movgen" ) values ( <<"'" + this.ConvertirDateSql( lxTidifinvFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvEsttrans ) + "'" >>, <<lxTidifinvCodigo >>, <<lxTidifinvModo >>, <<lxTidifinvIdinvcont >>, <<"'" + this.FormatearTextoSql( lxTidifinvDescrip ) + "'" >>, <<lxTidifinvIdinvfis >>, <<"'" + this.FormatearTextoSql( lxTidifinvMobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvMsorigdest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvMsmotivo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTidifinvMsfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTidifinvMovgen ) + "'" >> )
		endtext
		loColeccion.cTabla = 'TIDIFINV' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.InventariosFisicosDetalle
				if this.oEntidad.InventariosFisicosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxInventariofisico_PK = loItem.Inventariofisico_PK
					lxInventariofisicodetalle = loItem.Inventariofisicodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TIItemDifInv("Codigo","NROITEM","IdInvFis","InvFisDesc" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<lxInventariofisico_PK>>, <<"'" + this.FormatearTextoSql( lxInventariofisicodetalle ) + "'">> ) 
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
			local  lxTidifinvFecimpo, lxTidifinvFectrans, lxTidifinvFmodifw, lxTidifinvFecexpo, lxTidifinvFaltafw, lxTidifinvHoraexpo, lxTidifinvHoraimpo, lxTidifinvSmodifw, lxTidifinvHmodifw, lxTidifinvValtafw, lxTidifinvVmodifw, lxTidifinvUmodifw, lxTidifinvSaltafw, lxTidifinvUaltafw, lxTidifinvHaltafw, lxTidifinvZadsfw, lxTidifinvBdmodifw, lxTidifinvBdaltafw, lxTidifinvEsttrans, lxTidifinvCodigo, lxTidifinvModo, lxTidifinvIdinvcont, lxTidifinvDescrip, lxTidifinvIdinvfis, lxTidifinvMobs, lxTidifinvFecha, lxTidifinvMsorigdest, lxTidifinvMsmotivo, lxTidifinvMsfecha, lxTidifinvMovgen
				lxTidifinvFecimpo =  .Fechaimpo			lxTidifinvFectrans =  .Fechatransferencia			lxTidifinvFmodifw =  .Fechamodificacionfw			lxTidifinvFecexpo =  .Fechaexpo			lxTidifinvFaltafw =  .Fechaaltafw			lxTidifinvHoraexpo =  .Horaexpo			lxTidifinvHoraimpo =  .Horaimpo			lxTidifinvSmodifw =  .Seriemodificacionfw			lxTidifinvHmodifw =  .Horamodificacionfw			lxTidifinvValtafw =  .Versionaltafw			lxTidifinvVmodifw =  .Versionmodificacionfw			lxTidifinvUmodifw =  .Usuariomodificacionfw			lxTidifinvSaltafw =  .Seriealtafw			lxTidifinvUaltafw =  .Usuarioaltafw			lxTidifinvHaltafw =  .Horaaltafw			lxTidifinvZadsfw =  .Zadsfw			lxTidifinvBdmodifw =  .Basededatosmodificacionfw			lxTidifinvBdaltafw =  .Basededatosaltafw			lxTidifinvEsttrans =  .Estadotransferencia			lxTidifinvCodigo =  .Codigo			lxTidifinvModo =  .Modo			lxTidifinvIdinvcont =  .Idinventarioacontrolar_PK 			lxTidifinvDescrip =  .Descripcion			lxTidifinvIdinvfis =  .Idinventariofisico_PK 			lxTidifinvMobs =  .Obs			lxTidifinvFecha =  .Fecha			lxTidifinvMsorigdest =  upper( .MSOrigenDestino_PK ) 			lxTidifinvMsmotivo =  upper( .MSMotivo_PK ) 			lxTidifinvMsfecha =  .Msfecha			lxTidifinvMovgen =  .Movimientogenerado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIDIFINV.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.TIDIFINV set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTidifinvFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTidifinvFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTidifinvFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTidifinvFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTidifinvFaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTidifinvHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTidifinvHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvHmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTidifinvValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTidifinvUaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvHaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTidifinvZadsfw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTidifinvBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTidifinvBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTidifinvEsttrans ) + "'">>, "Codigo" = <<lxTidifinvCodigo>>, "Modo" = <<lxTidifinvModo>>, "Idinvcont" = <<lxTidifinvIdinvcont>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxTidifinvDescrip ) + "'">>, "Idinvfis" = <<lxTidifinvIdinvfis>>, "Mobs" = <<"'" + this.FormatearTextoSql( lxTidifinvMobs ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxTidifinvFecha ) + "'">>, "Msorigdest" = <<"'" + this.FormatearTextoSql( lxTidifinvMsorigdest ) + "'">>, "Msmotivo" = <<"'" + this.FormatearTextoSql( lxTidifinvMsmotivo ) + "'">>, "Msfecha" = <<"'" + this.ConvertirDateSql( lxTidifinvMsfecha ) + "'">>, "Movgen" = <<"'" + this.FormatearTextoSql( lxTidifinvMovgen ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TIDIFINV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.TIItemDifInv where "CODIGO" = ] + transform( .oEntidad.CODIGO ))

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.InventariosFisicosDetalle
				if this.oEntidad.InventariosFisicosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxInventariofisico_PK = loItem.Inventariofisico_PK
					lxInventariofisicodetalle = loItem.Inventariofisicodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TIItemDifInv("Codigo","NROITEM","IdInvFis","InvFisDesc" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<lxInventariofisico_PK>>, <<"'" + this.FormatearTextoSql( lxInventariofisicodetalle ) + "'">> ) 
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
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIDIFINV.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.TIDIFINV where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.TIItemDifInv where "CODIGO" = ] + transform( .oEntidad.CODIGO ))
			loColeccion.cTabla = 'TIDIFINV' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TIDIFINV where  TIDIFINV.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TIDIFINV where CODIGO = " + transform( this.oEntidad.CODIGO )+ " and  TIDIFINV.CODIGO != 0" )
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
					if empty( .oNumeraciones.ObtenerServicio('CODIGO') ) and iif( type( '.CODIGO' ) = 'C', int( val( .CODIGO ) ),.CODIGO ) = .oNumeraciones.UltimoNumero( 'CODIGO' )
						.oNumeraciones.Actualizar( 'CODIGO' )
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
					.CODIGO = .oNumeraciones.grabar( 'CODIGO' )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TIDIFINV Where CODIGO = ] + transform( &lcCursor..CODIGO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.TIDIFINV set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, MODO = ] + transform( &lcCursor..MODO )+ [, IDInvCont = ] + transform( &lcCursor..IDInvCont )+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, IdInvFis = ] + transform( &lcCursor..IdInvFis )+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, MSORIGDEST = ] + "'" + this.FormatearTextoSql( &lcCursor..MSORIGDEST ) + "'"+ [, MSMOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MSMOTIVO ) + "'"+ [, MSFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..MSFECHA ) + "'"+ [, MovGen = ] + "'" + this.FormatearTextoSql( &lcCursor..MovGen ) + "'" + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, HORAEXPO, HORAIMPO, SMODIFW, HMODIFW, VALTAFW, VMODIFW, UMODIFW, SALTAFW, UALTAFW, HALTAFW, ZADSFW, BDMODIFW, BDALTAFW, ESTTRANS, CODIGO, MODO, IDInvCont, Descrip, IdInvFis, MObs, FECHA, MSORIGDEST, MSMOTIVO, MSFECHA, MovGen
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + transform( &lcCursor..MODO )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IDInvCont ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + transform( &lcCursor..IdInvFis ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MSORIGDEST ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MSMOTIVO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..MSFECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MovGen ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.TIDIFINV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIO'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','N')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.TIItemDifInv Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMINVENTARIOSFISICO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Codigo","NROITEM","IdInvFis","InvFisDesc"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.TIItemDifInv ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.Codigo     ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IdInvFis   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InvFisDesc ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TIDIFERENCIASDEINVENTARIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TIDIFERENCIASDEINVENTARIO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMINVENTARIOSFISICO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TIDifInv')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TIDIFERENCIASDEINVENTARIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TIDIFERENCIASDEINVENTARIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECHA     
		* Validar ANTERIORES A 1/1/1753  MSFECHA   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TIDifInv') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TIDifInv
Create Table ZooLogic.TablaTrabajo_TIDifInv ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codigo" numeric( 8, 0 )  null, 
"modo" numeric( 1, 0 )  null, 
"idinvcont" numeric( 8, 0 )  null, 
"descrip" char( 40 )  null, 
"idinvfis" numeric( 8, 0 )  null, 
"mobs" char( 200 )  null, 
"fecha" datetime  null, 
"msorigdest" char( 8 )  null, 
"msmotivo" char( 3 )  null, 
"msfecha" datetime  null, 
"movgen" char( 20 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TIDifInv' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TIDifInv' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIDIFERENCIASDEINVENTARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('modo','modo')
			.AgregarMapeo('idinvcont','idinvcont')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('idinvfis','idinvfis')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('msorigdest','msorigdest')
			.AgregarMapeo('msmotivo','msmotivo')
			.AgregarMapeo('msfecha','msfecha')
			.AgregarMapeo('movgen','movgen')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TIDifInv'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MODO = isnull( d.MODO, t.MODO ),t.IDINVCONT = isnull( d.IDINVCONT, t.IDINVCONT ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.IDINVFIS = isnull( d.IDINVFIS, t.IDINVFIS ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.MSORIGDEST = isnull( d.MSORIGDEST, t.MSORIGDEST ),t.MSMOTIVO = isnull( d.MSMOTIVO, t.MSMOTIVO ),t.MSFECHA = isnull( d.MSFECHA, t.MSFECHA ),t.MOVGEN = isnull( d.MOVGEN, t.MOVGEN )
					from ZooLogic.TIDIFINV t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.TIDIFINV(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Horaexpo,Horaimpo,Smodifw,Hmodifw,Valtafw,Vmodifw,Umodifw,Saltafw,Ualtafw,Haltafw,Zadsfw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Modo,Idinvcont,Descrip,Idinvfis,Mobs,Fecha,Msorigdest,Msmotivo,Msfecha,Movgen)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.ZADSFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODIGO,0),isnull( d.MODO,0),isnull( d.IDINVCONT,0),isnull( d.DESCRIP,''),isnull( d.IDINVFIS,0),isnull( d.MOBS,''),isnull( d.FECHA,''),isnull( d.MSORIGDEST,''),isnull( d.MSMOTIVO,''),isnull( d.MSFECHA,''),isnull( d.MOVGEN,'')
						From deleted d left join ZooLogic.TIDIFINV pk 
							 on d.CODIGO = pk.CODIGO
						Where pk.CODIGO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_TIItemDifInv( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_TIDIFINV_TIItemDifInv
ON ZooLogic.TablaTrabajo_TIDIFINV_TIItemDifInv
AFTER DELETE
As
Begin
Update t Set 
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.IDINVFIS = isnull( d.IDINVFIS, t.IDINVFIS ),
t.INVFISDESC = isnull( d.INVFISDESC, t.INVFISDESC )
from ZooLogic.TIItemDifInv t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.TIItemDifInv
( 
"CODIGO",
"NROITEM",
"IDINVFIS",
"INVFISDESC"
 )
Select 
d.CODIGO,
d.NROITEM,
d.IDINVFIS,
d.INVFISDESC
From deleted d left join ZooLogic.TIItemDifInv pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TIDifInv') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TIDifInv
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TIDIFERENCIASDEINVENTARIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_TIDIFERENCIASDEINVENTARIO.Horaexpo, [] )
					.Horaimpo = nvl( c_TIDIFERENCIASDEINVENTARIO.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIO.Horamodificacionfw, [] )
					.Versionaltafw = nvl( c_TIDIFERENCIASDEINVENTARIO.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIO.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIO.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_TIDIFERENCIASDEINVENTARIO.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_TIDIFERENCIASDEINVENTARIO.Usuarioaltafw, [] )
					.Horaaltafw = nvl( c_TIDIFERENCIASDEINVENTARIO.Horaaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosmodificacionfw = nvl( c_TIDIFERENCIASDEINVENTARIO.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_TIDIFERENCIASDEINVENTARIO.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_TIDIFERENCIASDEINVENTARIO.Estadotransferencia, [] )
					.Codigo = nvl( c_TIDIFERENCIASDEINVENTARIO.Codigo, 0 )
					.Modo = nvl( c_TIDIFERENCIASDEINVENTARIO.Modo, 0 )
					.Inventariosfisicosdetalle.Limpiar()
					.Inventariosfisicosdetalle.SetearEsNavegacion( .lProcesando )
					.Inventariosfisicosdetalle.Cargar()
					.Idinventarioacontrolar_PK =  nvl( c_TIDIFERENCIASDEINVENTARIO.Idinventarioacontrolar, 0 )
					.Descripcion = nvl( c_TIDIFERENCIASDEINVENTARIO.Descripcion, [] )
					.Idinventariofisico_PK =  nvl( c_TIDIFERENCIASDEINVENTARIO.Idinventariofisico, 0 )
					.Obs = nvl( c_TIDIFERENCIASDEINVENTARIO.Obs, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIO.Fecha, ctod( '  /  /    ' ) ) )
					.Msorigendestino_PK =  nvl( c_TIDIFERENCIASDEINVENTARIO.Msorigendestino, [] )
					.Msmotivo_PK =  nvl( c_TIDIFERENCIASDEINVENTARIO.Msmotivo, [] )
					.Msfecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIDIFERENCIASDEINVENTARIO.Msfecha, ctod( '  /  /    ' ) ) )
					.Movimientogenerado = nvl( c_TIDIFERENCIASDEINVENTARIO.Movimientogenerado, [] )
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
		
		loDetalle = this.oEntidad.InventariosFisicosDetalle
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
		return c_TIDIFERENCIASDEINVENTARIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TIDIFINV' )
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
								from ZooLogic.TIDIFINV 
								Where   TIDIFINV.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TIDIFINV", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Modo" as "Modo", "Idinvcont" as "Idinventarioacontrolar", "Descrip" as "Descripcion", "Idinvfis" as "Idinventariofisico", "Mobs" as "Obs", "Fecha" as "Fecha", "Msorigdest" as "Msorigendestino", "Msmotivo" as "Msmotivo", "Msfecha" as "Msfecha", "Movgen" as "Movimientogenerado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TIDIFINV 
								Where   TIDIFINV.CODIGO != 0
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
	Tabla = 'TIDIFINV'
	Filtro = " TIDIFINV.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TIDIFINV.CODIGO != 0"
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
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="FECHAIMPO                               " tabla="TIDIFINV       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="FECHATRANSFERENCIA                      " tabla="TIDIFINV       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="FECHAMODIFICACIONFW                     " tabla="TIDIFINV       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="FECHAEXPO                               " tabla="TIDIFINV       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="FECHAALTAFW                             " tabla="TIDIFINV       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="HORAEXPO                                " tabla="TIDIFINV       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="HORAIMPO                                " tabla="TIDIFINV       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="SERIEMODIFICACIONFW                     " tabla="TIDIFINV       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="HORAMODIFICACIONFW                      " tabla="TIDIFINV       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="VERSIONALTAFW                           " tabla="TIDIFINV       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="VERSIONMODIFICACIONFW                   " tabla="TIDIFINV       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="USUARIOMODIFICACIONFW                   " tabla="TIDIFINV       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="SERIEALTAFW                             " tabla="TIDIFINV       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="USUARIOALTAFW                           " tabla="TIDIFINV       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="HORAALTAFW                              " tabla="TIDIFINV       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="ZADSFW                                  " tabla="TIDIFINV       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TIDIFINV       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="BASEDEDATOSALTAFW                       " tabla="TIDIFINV       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="ESTADOTRANSFERENCIA                     " tabla="TIDIFINV       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="CODIGO                                  " tabla="TIDIFINV       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="MODO                                    " tabla="TIDIFINV       " campo="MODO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Modo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="INVENTARIOSFISICOSDETALLE               " tabla="TIITEMDIFINV   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Inventario físico detalle                                                                                                                                       " dominio="DETALLEITEMINVENTARIOSFISICO  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="IDINVENTARIOACONTROLAR                  " tabla="TIDIFINV       " campo="IDINVCONT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIInventarioACont                       " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Inventario a controlar                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="DESCRIPCION                             " tabla="TIDIFINV       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="IDINVENTARIOFISICO                      " tabla="TIDIFINV       " campo="IDINVFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIInventarioFisico                      " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Inventario a controlar                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="OBS                                     " tabla="TIDIFINV       " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="FECHA                                   " tabla="TIDIFINV       " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="6" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="MSORIGENDESTINO                         " tabla="TIDIFINV       " campo="MSORIGDEST" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="14" etiqueta="Origen/destino                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="MSMOTIVO                                " tabla="TIDIFINV       " campo="MSMOTIVO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="12" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="MSFECHA                                 " tabla="TIDIFINV       " campo="MSFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="16" etiqueta="Fecha movimiento de datos                                                                                                                                       " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIDIFERENCIASDEINVENTARIO               " atributo="MOVIMIENTOGENERADO                      " tabla="TIDIFINV       " campo="MOVGEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Movimiento stock                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="DESCRIPCION                             " tabla="TIINVCONT      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Inv.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIINVCONT On TIDIFINV.IDINVCONT = TIINVCONT.CODIGO And  TIINVCONT.CODIGO != 0                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICO                      " atributo="DESCRIPCION                             " tabla="TIINVFIS       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Inv.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIINVFIS On TIDIFINV.IDINVFIS = TIINVFIS.CODIGO And  TIINVFIS.CODIGO != 0                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On TIDIFINV.MSORIGDEST = ORDAT.CODIGO And  ORDAT.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On TIDIFINV.MSMOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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