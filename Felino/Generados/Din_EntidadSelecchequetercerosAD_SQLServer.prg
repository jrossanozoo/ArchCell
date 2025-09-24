
define class Din_EntidadSELECCHEQUETERCEROSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SELECCHEQUETERCEROS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_SCTPK'
	cTablaPrincipal = 'SELCHEQTR'
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

		with this.oEntidad
			local  lxSelcheqtrFmodifw, lxSelcheqtrFecimpo, lxSelcheqtrFaltafw, lxSelcheqtrFectrans, lxSelcheqtrFecexpo, lxSelcheqtrHoraimpo, lxSelcheqtrHoraexpo, lxSelcheqtrBdaltafw, lxSelcheqtrHaltafw, lxSelcheqtrBdmodifw, lxSelcheqtrEsttrans, lxSelcheqtrHmodifw, lxSelcheqtrValtafw, lxSelcheqtrUmodifw, lxSelcheqtrUaltafw, lxSelcheqtrSmodifw, lxSelcheqtrZadsfw, lxSelcheqtrVmodifw, lxSelcheqtrSaltafw, lxSelcheqtrCodigo, lxSelcheqtrDescrip, lxSelcheqtrFchdesde, lxSelcheqtrFchhasta, lxSelcheqtrMntodesde, lxSelcheqtrMntohasta, lxSelcheqtrMondesde, lxSelcheqtrMonhasta, lxSelcheqtrCliedesde, lxSelcheqtrClihasta, lxSelcheqtrNumdesde, lxSelcheqtrNumhasta, lxSelcheqtrEntfdesde, lxSelcheqtrEntfhasta, lxSelcheqtrCodvaldesd, lxSelcheqtrCodvalhast, lxSelcheqtrFchemidesd, lxSelcheqtrFchemihast, lxSelcheqtrNumintdesd, lxSelcheqtrNuminthast, lxSelcheqtrCuitdesde, lxSelcheqtrCuithasta, lxSelcheqtrObs
				lxSelcheqtrFmodifw =  .Fechamodificacionfw			lxSelcheqtrFecimpo =  .Fechaimpo			lxSelcheqtrFaltafw =  .Fechaaltafw			lxSelcheqtrFectrans =  .Fechatransferencia			lxSelcheqtrFecexpo =  .Fechaexpo			lxSelcheqtrHoraimpo =  .Horaimpo			lxSelcheqtrHoraexpo =  .Horaexpo			lxSelcheqtrBdaltafw =  .Basededatosaltafw			lxSelcheqtrHaltafw =  .Horaaltafw			lxSelcheqtrBdmodifw =  .Basededatosmodificacionfw			lxSelcheqtrEsttrans =  .Estadotransferencia			lxSelcheqtrHmodifw =  .Horamodificacionfw			lxSelcheqtrValtafw =  .Versionaltafw			lxSelcheqtrUmodifw =  .Usuariomodificacionfw			lxSelcheqtrUaltafw =  .Usuarioaltafw			lxSelcheqtrSmodifw =  .Seriemodificacionfw			lxSelcheqtrZadsfw =  .Zadsfw			lxSelcheqtrVmodifw =  .Versionmodificacionfw			lxSelcheqtrSaltafw =  .Seriealtafw			lxSelcheqtrCodigo =  .Codigo			lxSelcheqtrDescrip =  .Descripcion			lxSelcheqtrFchdesde =  .Fechadesde			lxSelcheqtrFchhasta =  .Fechahasta			lxSelcheqtrMntodesde =  .Montodesde			lxSelcheqtrMntohasta =  .Montohasta			lxSelcheqtrMondesde =  upper( .MonDesde_PK ) 			lxSelcheqtrMonhasta =  upper( .MonHasta_PK ) 			lxSelcheqtrCliedesde =  upper( .CliDesde_PK ) 			lxSelcheqtrClihasta =  upper( .CliHasta_PK ) 			lxSelcheqtrNumdesde =  .Numdesde			lxSelcheqtrNumhasta =  .Numhasta			lxSelcheqtrEntfdesde =  upper( .EntFinDesde_PK ) 			lxSelcheqtrEntfhasta =  upper( .EntFinHasta_PK ) 			lxSelcheqtrCodvaldesd =  upper( .CodValDesde_PK ) 			lxSelcheqtrCodvalhast =  upper( .CodValHasta_PK ) 			lxSelcheqtrFchemidesd =  .Fchemdesde			lxSelcheqtrFchemihast =  .Fchemhasta			lxSelcheqtrNumintdesd =  .Numindesde			lxSelcheqtrNuminthast =  .Numinhasta			lxSelcheqtrCuitdesde =  .Cuitdesde			lxSelcheqtrCuithasta =  .Cuithasta			lxSelcheqtrObs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSelcheqtrCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.SELCHEQTR ( "Fmodifw","Fecimpo","Faltafw","Fectrans","Fecexpo","Horaimpo","Horaexpo","Bdaltafw","Haltafw","Bdmodifw","Esttrans","Hmodifw","Valtafw","Umodifw","Ualtafw","Smodifw","Zadsfw","Vmodifw","Saltafw","Codigo","Descrip","Fchdesde","Fchhasta","Mntodesde","Mntohasta","Mondesde","Monhasta","Cliedesde","Clihasta","Numdesde","Numhasta","Entfdesde","Entfhasta","Codvaldesd","Codvalhast","Fchemidesd","Fchemihast","Numintdesd","Numinthast","Cuitdesde","Cuithasta","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxSelcheqtrFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFchdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFchhasta ) + "'" >>, <<lxSelcheqtrMntodesde >>, <<lxSelcheqtrMntohasta >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrMondesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrMonhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCliedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrClihasta ) + "'" >>, <<lxSelcheqtrNumdesde >>, <<lxSelcheqtrNumhasta >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrEntfdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrEntfhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCodvaldesd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCodvalhast ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFchemidesd ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFchemihast ) + "'" >>, <<lxSelcheqtrNumintdesd >>, <<lxSelcheqtrNuminthast >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCuitdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCuithasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

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
			local  lxSelcheqtrFmodifw, lxSelcheqtrFecimpo, lxSelcheqtrFaltafw, lxSelcheqtrFectrans, lxSelcheqtrFecexpo, lxSelcheqtrHoraimpo, lxSelcheqtrHoraexpo, lxSelcheqtrBdaltafw, lxSelcheqtrHaltafw, lxSelcheqtrBdmodifw, lxSelcheqtrEsttrans, lxSelcheqtrHmodifw, lxSelcheqtrValtafw, lxSelcheqtrUmodifw, lxSelcheqtrUaltafw, lxSelcheqtrSmodifw, lxSelcheqtrZadsfw, lxSelcheqtrVmodifw, lxSelcheqtrSaltafw, lxSelcheqtrCodigo, lxSelcheqtrDescrip, lxSelcheqtrFchdesde, lxSelcheqtrFchhasta, lxSelcheqtrMntodesde, lxSelcheqtrMntohasta, lxSelcheqtrMondesde, lxSelcheqtrMonhasta, lxSelcheqtrCliedesde, lxSelcheqtrClihasta, lxSelcheqtrNumdesde, lxSelcheqtrNumhasta, lxSelcheqtrEntfdesde, lxSelcheqtrEntfhasta, lxSelcheqtrCodvaldesd, lxSelcheqtrCodvalhast, lxSelcheqtrFchemidesd, lxSelcheqtrFchemihast, lxSelcheqtrNumintdesd, lxSelcheqtrNuminthast, lxSelcheqtrCuitdesde, lxSelcheqtrCuithasta, lxSelcheqtrObs
				lxSelcheqtrFmodifw =  .Fechamodificacionfw			lxSelcheqtrFecimpo =  .Fechaimpo			lxSelcheqtrFaltafw =  .Fechaaltafw			lxSelcheqtrFectrans =  .Fechatransferencia			lxSelcheqtrFecexpo =  .Fechaexpo			lxSelcheqtrHoraimpo =  .Horaimpo			lxSelcheqtrHoraexpo =  .Horaexpo			lxSelcheqtrBdaltafw =  .Basededatosaltafw			lxSelcheqtrHaltafw =  .Horaaltafw			lxSelcheqtrBdmodifw =  .Basededatosmodificacionfw			lxSelcheqtrEsttrans =  .Estadotransferencia			lxSelcheqtrHmodifw =  .Horamodificacionfw			lxSelcheqtrValtafw =  .Versionaltafw			lxSelcheqtrUmodifw =  .Usuariomodificacionfw			lxSelcheqtrUaltafw =  .Usuarioaltafw			lxSelcheqtrSmodifw =  .Seriemodificacionfw			lxSelcheqtrZadsfw =  .Zadsfw			lxSelcheqtrVmodifw =  .Versionmodificacionfw			lxSelcheqtrSaltafw =  .Seriealtafw			lxSelcheqtrCodigo =  .Codigo			lxSelcheqtrDescrip =  .Descripcion			lxSelcheqtrFchdesde =  .Fechadesde			lxSelcheqtrFchhasta =  .Fechahasta			lxSelcheqtrMntodesde =  .Montodesde			lxSelcheqtrMntohasta =  .Montohasta			lxSelcheqtrMondesde =  upper( .MonDesde_PK ) 			lxSelcheqtrMonhasta =  upper( .MonHasta_PK ) 			lxSelcheqtrCliedesde =  upper( .CliDesde_PK ) 			lxSelcheqtrClihasta =  upper( .CliHasta_PK ) 			lxSelcheqtrNumdesde =  .Numdesde			lxSelcheqtrNumhasta =  .Numhasta			lxSelcheqtrEntfdesde =  upper( .EntFinDesde_PK ) 			lxSelcheqtrEntfhasta =  upper( .EntFinHasta_PK ) 			lxSelcheqtrCodvaldesd =  upper( .CodValDesde_PK ) 			lxSelcheqtrCodvalhast =  upper( .CodValHasta_PK ) 			lxSelcheqtrFchemidesd =  .Fchemdesde			lxSelcheqtrFchemihast =  .Fchemhasta			lxSelcheqtrNumintdesd =  .Numindesde			lxSelcheqtrNuminthast =  .Numinhasta			lxSelcheqtrCuitdesde =  .Cuitdesde			lxSelcheqtrCuithasta =  .Cuithasta			lxSelcheqtrObs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.SELCHEQTR set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFecexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSelcheqtrEsttrans ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrHmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrSmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrVmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrSaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxSelcheqtrDescrip ) + "'">>,"Fchdesde" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFchdesde ) + "'">>,"Fchhasta" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFchhasta ) + "'">>,"Mntodesde" = <<lxSelcheqtrMntodesde>>,"Mntohasta" = <<lxSelcheqtrMntohasta>>,"Mondesde" = <<"'" + this.FormatearTextoSql( lxSelcheqtrMondesde ) + "'">>,"Monhasta" = <<"'" + this.FormatearTextoSql( lxSelcheqtrMonhasta ) + "'">>,"Cliedesde" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCliedesde ) + "'">>,"Clihasta" = <<"'" + this.FormatearTextoSql( lxSelcheqtrClihasta ) + "'">>,"Numdesde" = <<lxSelcheqtrNumdesde>>,"Numhasta" = <<lxSelcheqtrNumhasta>>,"Entfdesde" = <<"'" + this.FormatearTextoSql( lxSelcheqtrEntfdesde ) + "'">>,"Entfhasta" = <<"'" + this.FormatearTextoSql( lxSelcheqtrEntfhasta ) + "'">>,"Codvaldesd" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodvaldesd ) + "'">>,"Codvalhast" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodvalhast ) + "'">>,"Fchemidesd" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFchemidesd ) + "'">>,"Fchemihast" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFchemihast ) + "'">>,"Numintdesd" = <<lxSelcheqtrNumintdesd>>,"Numinthast" = <<lxSelcheqtrNuminthast>>,"Cuitdesde" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCuitdesde ) + "'">>,"Cuithasta" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCuithasta ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxSelcheqtrObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodigo ) + "'">> and  SELCHEQTR.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.SELCHEQTR where " + this.ConvertirFuncionesSql( " SELCHEQTR.CODIGO != ''" ) )
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
			Local lxSelcheqtrCodigo
			lxSelcheqtrCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Mntodesde" as "Montodesde", "Mntohasta" as "Montohasta", "Mondesde" as "Mondesde", "Monhasta" as "Monhasta", "Cliedesde" as "Clidesde", "Clihasta" as "Clihasta", "Numdesde" as "Numdesde", "Numhasta" as "Numhasta", "Entfdesde" as "Entfindesde", "Entfhasta" as "Entfinhasta", "Codvaldesd" as "Codvaldesde", "Codvalhast" as "Codvalhasta", "Fchemidesd" as "Fchemdesde", "Fchemihast" as "Fchemhasta", "Numintdesd" as "Numindesde", "Numinthast" as "Numinhasta", "Cuitdesde" as "Cuitdesde", "Cuithasta" as "Cuithasta", "Obs" as "Obs" from ZooLogic.SELCHEQTR where "Codigo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodigo ) + "'">> and  SELCHEQTR.CODIGO != ''
			endtext
			use in select('c_SELECCHEQUETERCEROS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SELECCHEQUETERCEROS', set( 'Datasession' ) )

			if reccount( 'c_SELECCHEQUETERCEROS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxSelcheqtrCodigo as Variant
		llRetorno = .t.
		lxSelcheqtrCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.SELCHEQTR where "Codigo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodigo ) + "'">> and  SELCHEQTR.CODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Mntodesde" as "Montodesde", "Mntohasta" as "Montohasta", "Mondesde" as "Mondesde", "Monhasta" as "Monhasta", "Cliedesde" as "Clidesde", "Clihasta" as "Clihasta", "Numdesde" as "Numdesde", "Numhasta" as "Numhasta", "Entfdesde" as "Entfindesde", "Entfhasta" as "Entfinhasta", "Codvaldesd" as "Codvaldesde", "Codvalhast" as "Codvalhasta", "Fchemidesd" as "Fchemdesde", "Fchemihast" as "Fchemhasta", "Numintdesd" as "Numindesde", "Numinthast" as "Numinhasta", "Cuitdesde" as "Cuitdesde", "Cuithasta" as "Cuithasta", "Obs" as "Obs" from ZooLogic.SELCHEQTR where  SELCHEQTR.CODIGO != '' order by Codigo
			endtext
			use in select('c_SELECCHEQUETERCEROS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SELECCHEQUETERCEROS', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Mntodesde" as "Montodesde", "Mntohasta" as "Montohasta", "Mondesde" as "Mondesde", "Monhasta" as "Monhasta", "Cliedesde" as "Clidesde", "Clihasta" as "Clihasta", "Numdesde" as "Numdesde", "Numhasta" as "Numhasta", "Entfdesde" as "Entfindesde", "Entfhasta" as "Entfinhasta", "Codvaldesd" as "Codvaldesde", "Codvalhast" as "Codvalhasta", "Fchemidesd" as "Fchemdesde", "Fchemihast" as "Fchemhasta", "Numintdesd" as "Numindesde", "Numinthast" as "Numinhasta", "Cuitdesde" as "Cuitdesde", "Cuithasta" as "Cuithasta", "Obs" as "Obs" from ZooLogic.SELCHEQTR where  funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SELCHEQTR.CODIGO != '' order by Codigo
			endtext
			use in select('c_SELECCHEQUETERCEROS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SELECCHEQUETERCEROS', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Mntodesde" as "Montodesde", "Mntohasta" as "Montohasta", "Mondesde" as "Mondesde", "Monhasta" as "Monhasta", "Cliedesde" as "Clidesde", "Clihasta" as "Clihasta", "Numdesde" as "Numdesde", "Numhasta" as "Numhasta", "Entfdesde" as "Entfindesde", "Entfhasta" as "Entfinhasta", "Codvaldesd" as "Codvaldesde", "Codvalhast" as "Codvalhasta", "Fchemidesd" as "Fchemdesde", "Fchemihast" as "Fchemhasta", "Numintdesd" as "Numindesde", "Numinthast" as "Numinhasta", "Cuitdesde" as "Cuitdesde", "Cuithasta" as "Cuithasta", "Obs" as "Obs" from ZooLogic.SELCHEQTR where  funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SELCHEQTR.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_SELECCHEQUETERCEROS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SELECCHEQUETERCEROS', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Mntodesde" as "Montodesde", "Mntohasta" as "Montohasta", "Mondesde" as "Mondesde", "Monhasta" as "Monhasta", "Cliedesde" as "Clidesde", "Clihasta" as "Clihasta", "Numdesde" as "Numdesde", "Numhasta" as "Numhasta", "Entfdesde" as "Entfindesde", "Entfhasta" as "Entfinhasta", "Codvaldesd" as "Codvaldesde", "Codvalhast" as "Codvalhasta", "Fchemidesd" as "Fchemdesde", "Fchemihast" as "Fchemhasta", "Numintdesd" as "Numindesde", "Numinthast" as "Numinhasta", "Cuitdesde" as "Cuitdesde", "Cuithasta" as "Cuithasta", "Obs" as "Obs" from ZooLogic.SELCHEQTR where  SELCHEQTR.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_SELECCHEQUETERCEROS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SELECCHEQUETERCEROS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecimpo,Faltafw,Fectrans,Fecexpo,Horaimpo,Horaexpo,Bdaltafw,Haltafw,Bdmodifw,Esttran" + ;
"s,Hmodifw,Valtafw,Umodifw,Ualtafw,Smodifw,Zadsfw,Vmodifw,Saltafw,Codigo,Descrip,Fchdesde,Fchhasta,Mn" + ;
"todesde,Mntohasta,Mondesde,Monhasta,Cliedesde,Clihasta,Numdesde,Numhasta,Entfdesde,Entfhasta,Codvald" + ;
"esd,Codvalhast,Fchemidesd,Fchemihast,Numintdesd,Numinthast,Cuitdesde,Cuithasta,Obs" + ;
" from ZooLogic.SELCHEQTR where  SELCHEQTR.CODIGO != '' and " + lcFiltro )
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
			local  lxSelcheqtrFmodifw, lxSelcheqtrFecimpo, lxSelcheqtrFaltafw, lxSelcheqtrFectrans, lxSelcheqtrFecexpo, lxSelcheqtrHoraimpo, lxSelcheqtrHoraexpo, lxSelcheqtrBdaltafw, lxSelcheqtrHaltafw, lxSelcheqtrBdmodifw, lxSelcheqtrEsttrans, lxSelcheqtrHmodifw, lxSelcheqtrValtafw, lxSelcheqtrUmodifw, lxSelcheqtrUaltafw, lxSelcheqtrSmodifw, lxSelcheqtrZadsfw, lxSelcheqtrVmodifw, lxSelcheqtrSaltafw, lxSelcheqtrCodigo, lxSelcheqtrDescrip, lxSelcheqtrFchdesde, lxSelcheqtrFchhasta, lxSelcheqtrMntodesde, lxSelcheqtrMntohasta, lxSelcheqtrMondesde, lxSelcheqtrMonhasta, lxSelcheqtrCliedesde, lxSelcheqtrClihasta, lxSelcheqtrNumdesde, lxSelcheqtrNumhasta, lxSelcheqtrEntfdesde, lxSelcheqtrEntfhasta, lxSelcheqtrCodvaldesd, lxSelcheqtrCodvalhast, lxSelcheqtrFchemidesd, lxSelcheqtrFchemihast, lxSelcheqtrNumintdesd, lxSelcheqtrNuminthast, lxSelcheqtrCuitdesde, lxSelcheqtrCuithasta, lxSelcheqtrObs
				lxSelcheqtrFmodifw = ctod( '  /  /    ' )			lxSelcheqtrFecimpo = ctod( '  /  /    ' )			lxSelcheqtrFaltafw = ctod( '  /  /    ' )			lxSelcheqtrFectrans = ctod( '  /  /    ' )			lxSelcheqtrFecexpo = ctod( '  /  /    ' )			lxSelcheqtrHoraimpo = []			lxSelcheqtrHoraexpo = []			lxSelcheqtrBdaltafw = []			lxSelcheqtrHaltafw = []			lxSelcheqtrBdmodifw = []			lxSelcheqtrEsttrans = []			lxSelcheqtrHmodifw = []			lxSelcheqtrValtafw = []			lxSelcheqtrUmodifw = []			lxSelcheqtrUaltafw = []			lxSelcheqtrSmodifw = []			lxSelcheqtrZadsfw = []			lxSelcheqtrVmodifw = []			lxSelcheqtrSaltafw = []			lxSelcheqtrCodigo = []			lxSelcheqtrDescrip = []			lxSelcheqtrFchdesde = ctod( '  /  /    ' )			lxSelcheqtrFchhasta = ctod( '  /  /    ' )			lxSelcheqtrMntodesde = 0			lxSelcheqtrMntohasta = 0			lxSelcheqtrMondesde = []			lxSelcheqtrMonhasta = []			lxSelcheqtrCliedesde = []			lxSelcheqtrClihasta = []			lxSelcheqtrNumdesde = 0			lxSelcheqtrNumhasta = 0			lxSelcheqtrEntfdesde = []			lxSelcheqtrEntfhasta = []			lxSelcheqtrCodvaldesd = []			lxSelcheqtrCodvalhast = []			lxSelcheqtrFchemidesd = ctod( '  /  /    ' )			lxSelcheqtrFchemihast = ctod( '  /  /    ' )			lxSelcheqtrNumintdesd = 0			lxSelcheqtrNuminthast = 0			lxSelcheqtrCuitdesde = []			lxSelcheqtrCuithasta = []			lxSelcheqtrObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.SELCHEQTR where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SELCHEQTR' + '_' + tcCampo
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
		lcWhere = " Where  SELCHEQTR.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Mntodesde" as "Montodesde", "Mntohasta" as "Montohasta", "Mondesde" as "Mondesde", "Monhasta" as "Monhasta", "Cliedesde" as "Clidesde", "Clihasta" as "Clihasta", "Numdesde" as "Numdesde", "Numhasta" as "Numhasta", "Entfdesde" as "Entfindesde", "Entfhasta" as "Entfinhasta", "Codvaldesd" as "Codvaldesde", "Codvalhast" as "Codvalhasta", "Fchemidesd" as "Fchemdesde", "Fchemihast" as "Fchemhasta", "Numintdesd" as "Numindesde", "Numinthast" as "Numinhasta", "Cuitdesde" as "Cuitdesde", "Cuithasta" as "Cuithasta", "Obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SELCHEQTR', '', tnTope )
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
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCHDESDE AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCHHASTA AS FECHAHASTA'
				Case lcAtributo == 'MONTODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTODESDE AS MONTODESDE'
				Case lcAtributo == 'MONTOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTOHASTA AS MONTOHASTA'
				Case lcAtributo == 'MONDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESDE AS MONDESDE'
				Case lcAtributo == 'MONHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONHASTA AS MONHASTA'
				Case lcAtributo == 'CLIDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDESDE AS CLIDESDE'
				Case lcAtributo == 'CLIHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIHASTA AS CLIHASTA'
				Case lcAtributo == 'NUMDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMDESDE AS NUMDESDE'
				Case lcAtributo == 'NUMHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMHASTA AS NUMHASTA'
				Case lcAtributo == 'ENTFINDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTFDESDE AS ENTFINDESDE'
				Case lcAtributo == 'ENTFINHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTFHASTA AS ENTFINHASTA'
				Case lcAtributo == 'CODVALDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODVALDESD AS CODVALDESDE'
				Case lcAtributo == 'CODVALHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODVALHAST AS CODVALHASTA'
				Case lcAtributo == 'FCHEMDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCHEMIDESD AS FCHEMDESDE'
				Case lcAtributo == 'FCHEMHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCHEMIHAST AS FCHEMHASTA'
				Case lcAtributo == 'NUMINDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINTDESD AS NUMINDESDE'
				Case lcAtributo == 'NUMINHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINTHAST AS NUMINHASTA'
				Case lcAtributo == 'CUITDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUITDESDE AS CUITDESDE'
				Case lcAtributo == 'CUITHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUITHASTA AS CUITHASTA'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FCHDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FCHHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESDE'
				lcCampo = 'MNTODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOHASTA'
				lcCampo = 'MNTOHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MONDESDE'
				lcCampo = 'MONDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'MONHASTA'
				lcCampo = 'MONHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIDESDE'
				lcCampo = 'CLIEDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIHASTA'
				lcCampo = 'CLIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMDESDE'
				lcCampo = 'NUMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMHASTA'
				lcCampo = 'NUMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'ENTFINDESDE'
				lcCampo = 'ENTFDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'ENTFINHASTA'
				lcCampo = 'ENTFHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CODVALDESDE'
				lcCampo = 'CODVALDESD'
			Case upper( alltrim( tcAtributo ) ) == 'CODVALHASTA'
				lcCampo = 'CODVALHAST'
			Case upper( alltrim( tcAtributo ) ) == 'FCHEMDESDE'
				lcCampo = 'FCHEMIDESD'
			Case upper( alltrim( tcAtributo ) ) == 'FCHEMHASTA'
				lcCampo = 'FCHEMIHAST'
			Case upper( alltrim( tcAtributo ) ) == 'NUMINDESDE'
				lcCampo = 'NUMINTDESD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMINHASTA'
				lcCampo = 'NUMINTHAST'
			Case upper( alltrim( tcAtributo ) ) == 'CUITDESDE'
				lcCampo = 'CUITDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CUITHASTA'
				lcCampo = 'CUITHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxSelcheqtrFmodifw, lxSelcheqtrFecimpo, lxSelcheqtrFaltafw, lxSelcheqtrFectrans, lxSelcheqtrFecexpo, lxSelcheqtrHoraimpo, lxSelcheqtrHoraexpo, lxSelcheqtrBdaltafw, lxSelcheqtrHaltafw, lxSelcheqtrBdmodifw, lxSelcheqtrEsttrans, lxSelcheqtrHmodifw, lxSelcheqtrValtafw, lxSelcheqtrUmodifw, lxSelcheqtrUaltafw, lxSelcheqtrSmodifw, lxSelcheqtrZadsfw, lxSelcheqtrVmodifw, lxSelcheqtrSaltafw, lxSelcheqtrCodigo, lxSelcheqtrDescrip, lxSelcheqtrFchdesde, lxSelcheqtrFchhasta, lxSelcheqtrMntodesde, lxSelcheqtrMntohasta, lxSelcheqtrMondesde, lxSelcheqtrMonhasta, lxSelcheqtrCliedesde, lxSelcheqtrClihasta, lxSelcheqtrNumdesde, lxSelcheqtrNumhasta, lxSelcheqtrEntfdesde, lxSelcheqtrEntfhasta, lxSelcheqtrCodvaldesd, lxSelcheqtrCodvalhast, lxSelcheqtrFchemidesd, lxSelcheqtrFchemihast, lxSelcheqtrNumintdesd, lxSelcheqtrNuminthast, lxSelcheqtrCuitdesde, lxSelcheqtrCuithasta, lxSelcheqtrObs
				lxSelcheqtrFmodifw =  .Fechamodificacionfw			lxSelcheqtrFecimpo =  .Fechaimpo			lxSelcheqtrFaltafw =  .Fechaaltafw			lxSelcheqtrFectrans =  .Fechatransferencia			lxSelcheqtrFecexpo =  .Fechaexpo			lxSelcheqtrHoraimpo =  .Horaimpo			lxSelcheqtrHoraexpo =  .Horaexpo			lxSelcheqtrBdaltafw =  .Basededatosaltafw			lxSelcheqtrHaltafw =  .Horaaltafw			lxSelcheqtrBdmodifw =  .Basededatosmodificacionfw			lxSelcheqtrEsttrans =  .Estadotransferencia			lxSelcheqtrHmodifw =  .Horamodificacionfw			lxSelcheqtrValtafw =  .Versionaltafw			lxSelcheqtrUmodifw =  .Usuariomodificacionfw			lxSelcheqtrUaltafw =  .Usuarioaltafw			lxSelcheqtrSmodifw =  .Seriemodificacionfw			lxSelcheqtrZadsfw =  .Zadsfw			lxSelcheqtrVmodifw =  .Versionmodificacionfw			lxSelcheqtrSaltafw =  .Seriealtafw			lxSelcheqtrCodigo =  .Codigo			lxSelcheqtrDescrip =  .Descripcion			lxSelcheqtrFchdesde =  .Fechadesde			lxSelcheqtrFchhasta =  .Fechahasta			lxSelcheqtrMntodesde =  .Montodesde			lxSelcheqtrMntohasta =  .Montohasta			lxSelcheqtrMondesde =  upper( .MonDesde_PK ) 			lxSelcheqtrMonhasta =  upper( .MonHasta_PK ) 			lxSelcheqtrCliedesde =  upper( .CliDesde_PK ) 			lxSelcheqtrClihasta =  upper( .CliHasta_PK ) 			lxSelcheqtrNumdesde =  .Numdesde			lxSelcheqtrNumhasta =  .Numhasta			lxSelcheqtrEntfdesde =  upper( .EntFinDesde_PK ) 			lxSelcheqtrEntfhasta =  upper( .EntFinHasta_PK ) 			lxSelcheqtrCodvaldesd =  upper( .CodValDesde_PK ) 			lxSelcheqtrCodvalhast =  upper( .CodValHasta_PK ) 			lxSelcheqtrFchemidesd =  .Fchemdesde			lxSelcheqtrFchemihast =  .Fchemhasta			lxSelcheqtrNumintdesd =  .Numindesde			lxSelcheqtrNuminthast =  .Numinhasta			lxSelcheqtrCuitdesde =  .Cuitdesde			lxSelcheqtrCuithasta =  .Cuithasta			lxSelcheqtrObs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.SELCHEQTR ( "Fmodifw","Fecimpo","Faltafw","Fectrans","Fecexpo","Horaimpo","Horaexpo","Bdaltafw","Haltafw","Bdmodifw","Esttrans","Hmodifw","Valtafw","Umodifw","Ualtafw","Smodifw","Zadsfw","Vmodifw","Saltafw","Codigo","Descrip","Fchdesde","Fchhasta","Mntodesde","Mntohasta","Mondesde","Monhasta","Cliedesde","Clihasta","Numdesde","Numhasta","Entfdesde","Entfhasta","Codvaldesd","Codvalhast","Fchemidesd","Fchemihast","Numintdesd","Numinthast","Cuitdesde","Cuithasta","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxSelcheqtrFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFchdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFchhasta ) + "'" >>, <<lxSelcheqtrMntodesde >>, <<lxSelcheqtrMntohasta >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrMondesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrMonhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCliedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrClihasta ) + "'" >>, <<lxSelcheqtrNumdesde >>, <<lxSelcheqtrNumhasta >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrEntfdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrEntfhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCodvaldesd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCodvalhast ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFchemidesd ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSelcheqtrFchemihast ) + "'" >>, <<lxSelcheqtrNumintdesd >>, <<lxSelcheqtrNuminthast >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCuitdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrCuithasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSelcheqtrObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'SELCHEQTR' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxSelcheqtrFmodifw, lxSelcheqtrFecimpo, lxSelcheqtrFaltafw, lxSelcheqtrFectrans, lxSelcheqtrFecexpo, lxSelcheqtrHoraimpo, lxSelcheqtrHoraexpo, lxSelcheqtrBdaltafw, lxSelcheqtrHaltafw, lxSelcheqtrBdmodifw, lxSelcheqtrEsttrans, lxSelcheqtrHmodifw, lxSelcheqtrValtafw, lxSelcheqtrUmodifw, lxSelcheqtrUaltafw, lxSelcheqtrSmodifw, lxSelcheqtrZadsfw, lxSelcheqtrVmodifw, lxSelcheqtrSaltafw, lxSelcheqtrCodigo, lxSelcheqtrDescrip, lxSelcheqtrFchdesde, lxSelcheqtrFchhasta, lxSelcheqtrMntodesde, lxSelcheqtrMntohasta, lxSelcheqtrMondesde, lxSelcheqtrMonhasta, lxSelcheqtrCliedesde, lxSelcheqtrClihasta, lxSelcheqtrNumdesde, lxSelcheqtrNumhasta, lxSelcheqtrEntfdesde, lxSelcheqtrEntfhasta, lxSelcheqtrCodvaldesd, lxSelcheqtrCodvalhast, lxSelcheqtrFchemidesd, lxSelcheqtrFchemihast, lxSelcheqtrNumintdesd, lxSelcheqtrNuminthast, lxSelcheqtrCuitdesde, lxSelcheqtrCuithasta, lxSelcheqtrObs
				lxSelcheqtrFmodifw =  .Fechamodificacionfw			lxSelcheqtrFecimpo =  .Fechaimpo			lxSelcheqtrFaltafw =  .Fechaaltafw			lxSelcheqtrFectrans =  .Fechatransferencia			lxSelcheqtrFecexpo =  .Fechaexpo			lxSelcheqtrHoraimpo =  .Horaimpo			lxSelcheqtrHoraexpo =  .Horaexpo			lxSelcheqtrBdaltafw =  .Basededatosaltafw			lxSelcheqtrHaltafw =  .Horaaltafw			lxSelcheqtrBdmodifw =  .Basededatosmodificacionfw			lxSelcheqtrEsttrans =  .Estadotransferencia			lxSelcheqtrHmodifw =  .Horamodificacionfw			lxSelcheqtrValtafw =  .Versionaltafw			lxSelcheqtrUmodifw =  .Usuariomodificacionfw			lxSelcheqtrUaltafw =  .Usuarioaltafw			lxSelcheqtrSmodifw =  .Seriemodificacionfw			lxSelcheqtrZadsfw =  .Zadsfw			lxSelcheqtrVmodifw =  .Versionmodificacionfw			lxSelcheqtrSaltafw =  .Seriealtafw			lxSelcheqtrCodigo =  .Codigo			lxSelcheqtrDescrip =  .Descripcion			lxSelcheqtrFchdesde =  .Fechadesde			lxSelcheqtrFchhasta =  .Fechahasta			lxSelcheqtrMntodesde =  .Montodesde			lxSelcheqtrMntohasta =  .Montohasta			lxSelcheqtrMondesde =  upper( .MonDesde_PK ) 			lxSelcheqtrMonhasta =  upper( .MonHasta_PK ) 			lxSelcheqtrCliedesde =  upper( .CliDesde_PK ) 			lxSelcheqtrClihasta =  upper( .CliHasta_PK ) 			lxSelcheqtrNumdesde =  .Numdesde			lxSelcheqtrNumhasta =  .Numhasta			lxSelcheqtrEntfdesde =  upper( .EntFinDesde_PK ) 			lxSelcheqtrEntfhasta =  upper( .EntFinHasta_PK ) 			lxSelcheqtrCodvaldesd =  upper( .CodValDesde_PK ) 			lxSelcheqtrCodvalhast =  upper( .CodValHasta_PK ) 			lxSelcheqtrFchemidesd =  .Fchemdesde			lxSelcheqtrFchemihast =  .Fchemhasta			lxSelcheqtrNumintdesd =  .Numindesde			lxSelcheqtrNuminthast =  .Numinhasta			lxSelcheqtrCuitdesde =  .Cuitdesde			lxSelcheqtrCuithasta =  .Cuithasta			lxSelcheqtrObs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SELCHEQTR.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.SELCHEQTR set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFecexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSelcheqtrEsttrans ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrHmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrSmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrVmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSelcheqtrSaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxSelcheqtrDescrip ) + "'">>, "Fchdesde" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFchdesde ) + "'">>, "Fchhasta" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFchhasta ) + "'">>, "Mntodesde" = <<lxSelcheqtrMntodesde>>, "Mntohasta" = <<lxSelcheqtrMntohasta>>, "Mondesde" = <<"'" + this.FormatearTextoSql( lxSelcheqtrMondesde ) + "'">>, "Monhasta" = <<"'" + this.FormatearTextoSql( lxSelcheqtrMonhasta ) + "'">>, "Cliedesde" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCliedesde ) + "'">>, "Clihasta" = <<"'" + this.FormatearTextoSql( lxSelcheqtrClihasta ) + "'">>, "Numdesde" = <<lxSelcheqtrNumdesde>>, "Numhasta" = <<lxSelcheqtrNumhasta>>, "Entfdesde" = <<"'" + this.FormatearTextoSql( lxSelcheqtrEntfdesde ) + "'">>, "Entfhasta" = <<"'" + this.FormatearTextoSql( lxSelcheqtrEntfhasta ) + "'">>, "Codvaldesd" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodvaldesd ) + "'">>, "Codvalhast" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCodvalhast ) + "'">>, "Fchemidesd" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFchemidesd ) + "'">>, "Fchemihast" = <<"'" + this.ConvertirDateSql( lxSelcheqtrFchemihast ) + "'">>, "Numintdesd" = <<lxSelcheqtrNumintdesd>>, "Numinthast" = <<lxSelcheqtrNuminthast>>, "Cuitdesde" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCuitdesde ) + "'">>, "Cuithasta" = <<"'" + this.FormatearTextoSql( lxSelcheqtrCuithasta ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxSelcheqtrObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SELCHEQTR' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SELCHEQTR.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.SELCHEQTR where ' + lcFiltro )
			loColeccion.cTabla = 'SELCHEQTR' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.SELCHEQTR where  SELCHEQTR.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.SELCHEQTR where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SELCHEQTR.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SELECCHEQUETERCEROS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.SELCHEQTR Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.SELCHEQTR set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, FchDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FchDesde ) + "'"+ [, FchHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FchHasta ) + "'"+ [, MntoDesde = ] + transform( &lcCursor..MntoDesde )+ [, MntoHasta = ] + transform( &lcCursor..MntoHasta )+ [, MonDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MonDesde ) + "'"+ [, MonHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MonHasta ) + "'"+ [, ClieDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClieDesde ) + "'"+ [, CliHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CliHasta ) + "'"+ [, NumDesde = ] + transform( &lcCursor..NumDesde )+ [, NumHasta = ] + transform( &lcCursor..NumHasta )+ [, EntFDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..EntFDesde ) + "'"+ [, EntFHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..EntFHasta ) + "'"+ [, CodValDesd = ] + "'" + this.FormatearTextoSql( &lcCursor..CodValDesd ) + "'"+ [, CodValHast = ] + "'" + this.FormatearTextoSql( &lcCursor..CodValHast ) + "'"+ [, FchEmiDesd = ] + "'" + this.ConvertirDateSql( &lcCursor..FchEmiDesd ) + "'"+ [, FchEmiHast = ] + "'" + this.ConvertirDateSql( &lcCursor..FchEmiHast ) + "'"+ [, NumIntDesd = ] + transform( &lcCursor..NumIntDesd )+ [, NumIntHast = ] + transform( &lcCursor..NumIntHast )+ [, CuitDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CuitDesde ) + "'"+ [, CuitHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CuitHasta ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECIMPO, FALTAFW, FECTRANS, FECEXPO, HORAIMPO, HORAEXPO, BDALTAFW, HALTAFW, BDMODIFW, ESTTRANS, HMODIFW, VALTAFW, UMODIFW, UALTAFW, SMODIFW, ZADSFW, VMODIFW, SALTAFW, Codigo, Descrip, FchDesde, FchHasta, MntoDesde, MntoHasta, MonDesde, MonHasta, ClieDesde, CliHasta, NumDesde, NumHasta, EntFDesde, EntFHasta, CodValDesd, CodValHast, FchEmiDesd, FchEmiHast, NumIntDesd, NumIntHast, CuitDesde, CuitHasta, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FchDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FchHasta ) + "'" + ',' + transform( &lcCursor..MntoDesde ) + ',' + transform( &lcCursor..MntoHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClieDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CliHasta ) + "'" + ',' + transform( &lcCursor..NumDesde ) + ',' + transform( &lcCursor..NumHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..EntFDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EntFHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodValDesd ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodValHast ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FchEmiDesd ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FchEmiHast ) + "'" + ',' + transform( &lcCursor..NumIntDesd ) + ',' + transform( &lcCursor..NumIntHast ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CuitDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CuitHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.SELCHEQTR ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SELECCHEQUETERCEROS'
		if This.ActualizaEnRecepcion()
	endif
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
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'SELECCHEQUETERCEROS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SELECCHEQUETERCEROS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SELECCHEQUETERCEROS_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_SELCHEQTR')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SELECCHEQUETERCEROS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SELECCHEQUETERCEROS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SELECCHEQUETERCEROS'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SELECCHEQUETERCEROS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FchDesde  
		* Validar ANTERIORES A 1/1/1753  FchHasta  
		* Validar ANTERIORES A 1/1/1753  FchEmiDesd
		* Validar ANTERIORES A 1/1/1753  FchEmiHast
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SELCHEQTR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SELCHEQTR
Create Table ZooLogic.TablaTrabajo_SELCHEQTR ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"hmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"codigo" char( 38 )  null, 
"descrip" char( 1 )  null, 
"fchdesde" datetime  null, 
"fchhasta" datetime  null, 
"mntodesde" numeric( 15, 0 )  null, 
"mntohasta" numeric( 15, 0 )  null, 
"mondesde" char( 10 )  null, 
"monhasta" char( 10 )  null, 
"cliedesde" char( 5 )  null, 
"clihasta" char( 5 )  null, 
"numdesde" numeric( 8, 0 )  null, 
"numhasta" numeric( 8, 0 )  null, 
"entfdesde" char( 5 )  null, 
"entfhasta" char( 5 )  null, 
"codvaldesd" char( 5 )  null, 
"codvalhast" char( 5 )  null, 
"fchemidesd" datetime  null, 
"fchemihast" datetime  null, 
"numintdesd" numeric( 8, 0 )  null, 
"numinthast" numeric( 8, 0 )  null, 
"cuitdesde" char( 15 )  null, 
"cuithasta" char( 15 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_SELCHEQTR' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_SELCHEQTR' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SELECCHEQUETERCEROS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('fchdesde','fchdesde')
			.AgregarMapeo('fchhasta','fchhasta')
			.AgregarMapeo('mntodesde','mntodesde')
			.AgregarMapeo('mntohasta','mntohasta')
			.AgregarMapeo('mondesde','mondesde')
			.AgregarMapeo('monhasta','monhasta')
			.AgregarMapeo('cliedesde','cliedesde')
			.AgregarMapeo('clihasta','clihasta')
			.AgregarMapeo('numdesde','numdesde')
			.AgregarMapeo('numhasta','numhasta')
			.AgregarMapeo('entfdesde','entfdesde')
			.AgregarMapeo('entfhasta','entfhasta')
			.AgregarMapeo('codvaldesd','codvaldesd')
			.AgregarMapeo('codvalhast','codvalhast')
			.AgregarMapeo('fchemidesd','fchemidesd')
			.AgregarMapeo('fchemihast','fchemihast')
			.AgregarMapeo('numintdesd','numintdesd')
			.AgregarMapeo('numinthast','numinthast')
			.AgregarMapeo('cuitdesde','cuitdesde')
			.AgregarMapeo('cuithasta','cuithasta')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_SELCHEQTR'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.FCHDESDE = isnull( d.FCHDESDE, t.FCHDESDE ),t.FCHHASTA = isnull( d.FCHHASTA, t.FCHHASTA ),t.MNTODESDE = isnull( d.MNTODESDE, t.MNTODESDE ),t.MNTOHASTA = isnull( d.MNTOHASTA, t.MNTOHASTA ),t.MONDESDE = isnull( d.MONDESDE, t.MONDESDE ),t.MONHASTA = isnull( d.MONHASTA, t.MONHASTA ),t.CLIEDESDE = isnull( d.CLIEDESDE, t.CLIEDESDE ),t.CLIHASTA = isnull( d.CLIHASTA, t.CLIHASTA ),t.NUMDESDE = isnull( d.NUMDESDE, t.NUMDESDE ),t.NUMHASTA = isnull( d.NUMHASTA, t.NUMHASTA ),t.ENTFDESDE = isnull( d.ENTFDESDE, t.ENTFDESDE ),t.ENTFHASTA = isnull( d.ENTFHASTA, t.ENTFHASTA ),t.CODVALDESD = isnull( d.CODVALDESD, t.CODVALDESD ),t.CODVALHAST = isnull( d.CODVALHAST, t.CODVALHAST ),t.FCHEMIDESD = isnull( d.FCHEMIDESD, t.FCHEMIDESD ),t.FCHEMIHAST = isnull( d.FCHEMIHAST, t.FCHEMIHAST ),t.NUMINTDESD = isnull( d.NUMINTDESD, t.NUMINTDESD ),t.NUMINTHAST = isnull( d.NUMINTHAST, t.NUMINTHAST ),t.CUITDESDE = isnull( d.CUITDESDE, t.CUITDESDE ),t.CUITHASTA = isnull( d.CUITHASTA, t.CUITHASTA ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.SELCHEQTR t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.SELCHEQTR(Fmodifw,Fecimpo,Faltafw,Fectrans,Fecexpo,Horaimpo,Horaexpo,Bdaltafw,Haltafw,Bdmodifw,Esttrans,Hmodifw,Valtafw,Umodifw,Ualtafw,Smodifw,Zadsfw,Vmodifw,Saltafw,Codigo,Descrip,Fchdesde,Fchhasta,Mntodesde,Mntohasta,Mondesde,Monhasta,Cliedesde,Clihasta,Numdesde,Numhasta,Entfdesde,Entfhasta,Codvaldesd,Codvalhast,Fchemidesd,Fchemihast,Numintdesd,Numinthast,Cuitdesde,Cuithasta,Obs)
					Select isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.SALTAFW,''),isnull( d.CODIGO,''),isnull( d.DESCRIP,''),isnull( d.FCHDESDE,''),isnull( d.FCHHASTA,''),isnull( d.MNTODESDE,0),isnull( d.MNTOHASTA,0),isnull( d.MONDESDE,''),isnull( d.MONHASTA,''),isnull( d.CLIEDESDE,''),isnull( d.CLIHASTA,''),isnull( d.NUMDESDE,0),isnull( d.NUMHASTA,0),isnull( d.ENTFDESDE,''),isnull( d.ENTFHASTA,''),isnull( d.CODVALDESD,''),isnull( d.CODVALHAST,''),isnull( d.FCHEMIDESD,''),isnull( d.FCHEMIHAST,''),isnull( d.NUMINTDESD,0),isnull( d.NUMINTHAST,0),isnull( d.CUITDESDE,''),isnull( d.CUITHASTA,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.SELCHEQTR pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SELCHEQTR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SELCHEQTR
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SELECCHEQUETERCEROS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_SELECCHEQUETERCEROS.Horaimpo, [] )
					.Horaexpo = nvl( c_SELECCHEQUETERCEROS.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_SELECCHEQUETERCEROS.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_SELECCHEQUETERCEROS.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_SELECCHEQUETERCEROS.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_SELECCHEQUETERCEROS.Estadotransferencia, [] )
					.Horamodificacionfw = nvl( c_SELECCHEQUETERCEROS.Horamodificacionfw, [] )
					.Versionaltafw = nvl( c_SELECCHEQUETERCEROS.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_SELECCHEQUETERCEROS.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_SELECCHEQUETERCEROS.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_SELECCHEQUETERCEROS.Seriemodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_SELECCHEQUETERCEROS.Versionmodificacionfw, [] )
					.Seriealtafw = nvl( c_SELECCHEQUETERCEROS.Seriealtafw, [] )
					.Codigo = nvl( c_SELECCHEQUETERCEROS.Codigo, [] )
					.Descripcion = nvl( c_SELECCHEQUETERCEROS.Descripcion, [] )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fechahasta, ctod( '  /  /    ' ) ) )
					.Montodesde = nvl( c_SELECCHEQUETERCEROS.Montodesde, 0 )
					.Montohasta = nvl( c_SELECCHEQUETERCEROS.Montohasta, 0 )
					.Mondesde_PK =  nvl( c_SELECCHEQUETERCEROS.Mondesde, [] )
					.Monhasta_PK =  nvl( c_SELECCHEQUETERCEROS.Monhasta, [] )
					.Clidesde_PK =  nvl( c_SELECCHEQUETERCEROS.Clidesde, [] )
					.Clihasta_PK =  nvl( c_SELECCHEQUETERCEROS.Clihasta, [] )
					.Numdesde = nvl( c_SELECCHEQUETERCEROS.Numdesde, 0 )
					.Numhasta = nvl( c_SELECCHEQUETERCEROS.Numhasta, 0 )
					.Entfindesde_PK =  nvl( c_SELECCHEQUETERCEROS.Entfindesde, [] )
					.Entfinhasta_PK =  nvl( c_SELECCHEQUETERCEROS.Entfinhasta, [] )
					.Codvaldesde_PK =  nvl( c_SELECCHEQUETERCEROS.Codvaldesde, [] )
					.Codvalhasta_PK =  nvl( c_SELECCHEQUETERCEROS.Codvalhasta, [] )
					.Fchemdesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fchemdesde, ctod( '  /  /    ' ) ) )
					.Fchemhasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_SELECCHEQUETERCEROS.Fchemhasta, ctod( '  /  /    ' ) ) )
					.Numindesde = nvl( c_SELECCHEQUETERCEROS.Numindesde, 0 )
					.Numinhasta = nvl( c_SELECCHEQUETERCEROS.Numinhasta, 0 )
					.Cuitdesde = nvl( c_SELECCHEQUETERCEROS.Cuitdesde, [] )
					.Cuithasta = nvl( c_SELECCHEQUETERCEROS.Cuithasta, [] )
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
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_SELECCHEQUETERCEROS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.SELCHEQTR' )
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
								from ZooLogic.SELCHEQTR 
								Where   SELCHEQTR.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SELCHEQTR", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Mntodesde" as "Montodesde", "Mntohasta" as "Montohasta", "Mondesde" as "Mondesde", "Monhasta" as "Monhasta", "Cliedesde" as "Clidesde", "Clihasta" as "Clihasta", "Numdesde" as "Numdesde", "Numhasta" as "Numhasta", "Entfdesde" as "Entfindesde", "Entfhasta" as "Entfinhasta", "Codvaldesd" as "Codvaldesde", "Codvalhast" as "Codvalhasta", "Fchemidesd" as "Fchemdesde", "Fchemihast" as "Fchemhasta", "Numintdesd" as "Numindesde", "Numinthast" as "Numinhasta", "Cuitdesde" as "Cuitdesde", "Cuithasta" as "Cuithasta", "Obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.SELCHEQTR 
								Where   SELCHEQTR.CODIGO != ''
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
	Tabla = 'SELCHEQTR'
	Filtro = " SELCHEQTR.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SELCHEQTR.CODIGO != ''"
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
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FECHAMODIFICACIONFW                     " tabla="SELCHEQTR      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FECHAIMPO                               " tabla="SELCHEQTR      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FECHAALTAFW                             " tabla="SELCHEQTR      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FECHATRANSFERENCIA                      " tabla="SELCHEQTR      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FECHAEXPO                               " tabla="SELCHEQTR      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="HORAIMPO                                " tabla="SELCHEQTR      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="HORAEXPO                                " tabla="SELCHEQTR      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="BASEDEDATOSALTAFW                       " tabla="SELCHEQTR      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="HORAALTAFW                              " tabla="SELCHEQTR      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SELCHEQTR      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="ESTADOTRANSFERENCIA                     " tabla="SELCHEQTR      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="HORAMODIFICACIONFW                      " tabla="SELCHEQTR      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="VERSIONALTAFW                           " tabla="SELCHEQTR      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="USUARIOMODIFICACIONFW                   " tabla="SELCHEQTR      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="USUARIOALTAFW                           " tabla="SELCHEQTR      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="SERIEMODIFICACIONFW                     " tabla="SELCHEQTR      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="ZADSFW                                  " tabla="SELCHEQTR      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="VERSIONMODIFICACIONFW                   " tabla="SELCHEQTR      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="SERIEALTAFW                             " tabla="SELCHEQTR      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="CODIGO                                  " tabla="SELCHEQTR      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="DESCRIPCION                             " tabla="SELCHEQTR      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FECHADESDE                              " tabla="SELCHEQTR      " campo="FCHDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha desde                                                                                                                                                     " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FECHAHASTA                              " tabla="SELCHEQTR      " campo="FCHHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="402" etiqueta="Fecha hasta                                                                                                                                                     " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="MONTODESDE                              " tabla="SELCHEQTR      " campo="MNTODESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Monto desde                                                                                                                                                     " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="MONTOHASTA                              " tabla="SELCHEQTR      " campo="MNTOHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="9999999.99                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="406" etiqueta="Monto hasta                                                                                                                                                     " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="MONDESDE                                " tabla="SELCHEQTR      " campo="MONDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Moneda desde                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="MONHASTA                                " tabla="SELCHEQTR      " campo="MONHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="410" etiqueta="Moneda hasta                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="CLIDESDE                                " tabla="SELCHEQTR      " campo="CLIEDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Cliente desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="CLIHASTA                                " tabla="SELCHEQTR      " campo="CLIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZ                                                                                                                                                                                                                                                     " obligatorio="false" admitebusqueda="414" etiqueta="Cliente hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="NUMDESDE                                " tabla="SELCHEQTR      " campo="NUMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Número desde                                                                                                                                                    " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="NUMHASTA                                " tabla="SELCHEQTR      " campo="NUMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="99999999                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="418" etiqueta="Número hasta                                                                                                                                                    " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="ENTFINDESDE                             " tabla="SELCHEQTR      " campo="ENTFDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Entidad financiera desde                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="55" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="ENTFINHASTA                             " tabla="SELCHEQTR      " campo="ENTFHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZ                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="422" etiqueta="Entidad financiera hasta                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="CODVALDESDE                             " tabla="SELCHEQTR      " campo="CODVALDESD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Código de valor desde                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="65" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="CODVALHASTA                             " tabla="SELCHEQTR      " campo="CODVALHAST" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZ                                                                                                                                                                                                                                                     " obligatorio="false" admitebusqueda="426" etiqueta="Código de valor hasta                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FCHEMDESDE                              " tabla="SELCHEQTR      " campo="FCHEMIDESD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Fecha de emisión desde                                                                                                                                          " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="75" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="FCHEMHASTA                              " tabla="SELCHEQTR      " campo="FCHEMIHAST" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="430" etiqueta="Fecha de emisión hasta                                                                                                                                          " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="NUMINDESDE                              " tabla="SELCHEQTR      " campo="NUMINTDESD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Número interno desde                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="85" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="NUMINHASTA                              " tabla="SELCHEQTR      " campo="NUMINTHAST" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="99999999                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="434" etiqueta="Número interno hasta                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="CUITDESDE                               " tabla="SELCHEQTR      " campo="CUITDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Cuit desde                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="95" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="CUITHASTA                               " tabla="SELCHEQTR      " campo="CUITHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="99999999999                                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="438" etiqueta="Cuit hasta                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="98" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SELECCHEQUETERCEROS                     " atributo="OBS                                     " tabla="SELCHEQTR      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="99" subgrupo="99" orden="99" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On SELCHEQTR.MONDESDE = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On SELCHEQTR.MONHASTA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="413" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On SELCHEQTR.CLIEDESDE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="415" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On SELCHEQTR.CLIHASTA = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADFINANCIERA                       " atributo="DESCRIPCION                             " tabla="ENTFIN         " campo="EFDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTFIN On SELCHEQTR.ENTFDESDE = ENTFIN.EfCod And  ENTFIN.EFCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADFINANCIERA                       " atributo="DESCRIPCION                             " tabla="ENTFIN         " campo="EFDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTFIN On SELCHEQTR.ENTFHASTA = ENTFIN.EfCod And  ENTFIN.EFCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVALORES       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVALORES On SELCHEQTR.CODVALDESD = XVALORES.CLCOD And  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVALORES       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVALORES On SELCHEQTR.CODVALHAST = XVALORES.CLCOD And  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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