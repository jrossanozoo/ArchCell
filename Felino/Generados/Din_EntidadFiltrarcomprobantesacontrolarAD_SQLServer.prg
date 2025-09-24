
define class Din_EntidadFILTRARCOMPROBANTESACONTROLARAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_FILTRARCOMPROBANTESACONTROLAR'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_FCCPK'
	cTablaPrincipal = 'COMPACONT'
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
			local  lxCompacontFecimpo, lxCompacontFecexpo, lxCompacontFmodifw, lxCompacontFaltafw, lxCompacontFectrans, lxCompacontHoraimpo, lxCompacontHmodifw, lxCompacontHaltafw, lxCompacontHoraexpo, lxCompacontSaltafw, lxCompacontSmodifw, lxCompacontVmodifw, lxCompacontZadsfw, lxCompacontUmodifw, lxCompacontValtafw, lxCompacontBdmodifw, lxCompacontUaltafw, lxCompacontEsttrans, lxCompacontBdaltafw, lxCompacontCodigo, lxCompacontDescrip, lxCompacontCliedesde, lxCompacontCliehasta, lxCompacontProvdesde, lxCompacontProvhasta, lxCompacontOrigdesde, lxCompacontOrighasta, lxCompacontFecomdesde, lxCompacontFecomhasta, lxCompacontFeentdesde, lxCompacontFeenthasta, lxCompacontVendesde, lxCompacontVenhasta, lxCompacontMotidesde, lxCompacontMotihasta, lxCompacontTrandesde, lxCompacontTranhasta, lxCompacontEntregapos, lxCompacontObs
				lxCompacontFecimpo =  .Fechaimpo			lxCompacontFecexpo =  .Fechaexpo			lxCompacontFmodifw =  .Fechamodificacionfw			lxCompacontFaltafw =  .Fechaaltafw			lxCompacontFectrans =  .Fechatransferencia			lxCompacontHoraimpo =  .Horaimpo			lxCompacontHmodifw =  .Horamodificacionfw			lxCompacontHaltafw =  .Horaaltafw			lxCompacontHoraexpo =  .Horaexpo			lxCompacontSaltafw =  .Seriealtafw			lxCompacontSmodifw =  .Seriemodificacionfw			lxCompacontVmodifw =  .Versionmodificacionfw			lxCompacontZadsfw =  .Zadsfw			lxCompacontUmodifw =  .Usuariomodificacionfw			lxCompacontValtafw =  .Versionaltafw			lxCompacontBdmodifw =  .Basededatosmodificacionfw			lxCompacontUaltafw =  .Usuarioaltafw			lxCompacontEsttrans =  .Estadotransferencia			lxCompacontBdaltafw =  .Basededatosaltafw			lxCompacontCodigo =  .Codigo			lxCompacontDescrip =  .Descripcion			lxCompacontCliedesde =  upper( .ClienteDesde_PK ) 			lxCompacontCliehasta =  upper( .ClienteHasta_PK ) 			lxCompacontProvdesde =  upper( .ProveedorDesde_PK ) 			lxCompacontProvhasta =  upper( .ProveedorHasta_PK ) 			lxCompacontOrigdesde =  upper( .OrigenDestinoDesde_PK ) 			lxCompacontOrighasta =  upper( .OrigenDestinoHasta_PK ) 			lxCompacontFecomdesde =  .Fechacomprobantedesde			lxCompacontFecomhasta =  .Fechacomprobantehasta			lxCompacontFeentdesde =  .Fechaentregadesde			lxCompacontFeenthasta =  .Fechaentregahasta			lxCompacontVendesde =  upper( .VendedorDesde_PK ) 			lxCompacontVenhasta =  upper( .VendedorHasta_PK ) 			lxCompacontMotidesde =  upper( .MotivoDesde_PK ) 			lxCompacontMotihasta =  upper( .MotivoHasta_PK ) 			lxCompacontTrandesde =  upper( .TransportistaDesde_PK ) 			lxCompacontTranhasta =  upper( .TransportistaHasta_PK ) 			lxCompacontEntregapos =  .Entregaposterior			lxCompacontObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCompacontCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPACONT ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Horaimpo","Hmodifw","Haltafw","Horaexpo","Saltafw","Smodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Bdmodifw","Ualtafw","Esttrans","Bdaltafw","Codigo","Descrip","Cliedesde","Cliehasta","Provdesde","Provhasta","Origdesde","Orighasta","Fecomdesde","Fecomhasta","Feentdesde","Feenthasta","Vendesde","Venhasta","Motidesde","Motihasta","Trandesde","Tranhasta","Entregapos","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCompacontFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontCliedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontCliehasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontOrigdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontOrighasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFecomdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFecomhasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFeentdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFeenthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontVendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontVenhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontMotidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontMotihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontTrandesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontTranhasta ) + "'" >>, <<lxCompacontEntregapos >>, <<"'" + this.FormatearTextoSql( lxCompacontObs ) + "'" >> )
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
			local  lxCompacontFecimpo, lxCompacontFecexpo, lxCompacontFmodifw, lxCompacontFaltafw, lxCompacontFectrans, lxCompacontHoraimpo, lxCompacontHmodifw, lxCompacontHaltafw, lxCompacontHoraexpo, lxCompacontSaltafw, lxCompacontSmodifw, lxCompacontVmodifw, lxCompacontZadsfw, lxCompacontUmodifw, lxCompacontValtafw, lxCompacontBdmodifw, lxCompacontUaltafw, lxCompacontEsttrans, lxCompacontBdaltafw, lxCompacontCodigo, lxCompacontDescrip, lxCompacontCliedesde, lxCompacontCliehasta, lxCompacontProvdesde, lxCompacontProvhasta, lxCompacontOrigdesde, lxCompacontOrighasta, lxCompacontFecomdesde, lxCompacontFecomhasta, lxCompacontFeentdesde, lxCompacontFeenthasta, lxCompacontVendesde, lxCompacontVenhasta, lxCompacontMotidesde, lxCompacontMotihasta, lxCompacontTrandesde, lxCompacontTranhasta, lxCompacontEntregapos, lxCompacontObs
				lxCompacontFecimpo =  .Fechaimpo			lxCompacontFecexpo =  .Fechaexpo			lxCompacontFmodifw =  .Fechamodificacionfw			lxCompacontFaltafw =  .Fechaaltafw			lxCompacontFectrans =  .Fechatransferencia			lxCompacontHoraimpo =  .Horaimpo			lxCompacontHmodifw =  .Horamodificacionfw			lxCompacontHaltafw =  .Horaaltafw			lxCompacontHoraexpo =  .Horaexpo			lxCompacontSaltafw =  .Seriealtafw			lxCompacontSmodifw =  .Seriemodificacionfw			lxCompacontVmodifw =  .Versionmodificacionfw			lxCompacontZadsfw =  .Zadsfw			lxCompacontUmodifw =  .Usuariomodificacionfw			lxCompacontValtafw =  .Versionaltafw			lxCompacontBdmodifw =  .Basededatosmodificacionfw			lxCompacontUaltafw =  .Usuarioaltafw			lxCompacontEsttrans =  .Estadotransferencia			lxCompacontBdaltafw =  .Basededatosaltafw			lxCompacontCodigo =  .Codigo			lxCompacontDescrip =  .Descripcion			lxCompacontCliedesde =  upper( .ClienteDesde_PK ) 			lxCompacontCliehasta =  upper( .ClienteHasta_PK ) 			lxCompacontProvdesde =  upper( .ProveedorDesde_PK ) 			lxCompacontProvhasta =  upper( .ProveedorHasta_PK ) 			lxCompacontOrigdesde =  upper( .OrigenDestinoDesde_PK ) 			lxCompacontOrighasta =  upper( .OrigenDestinoHasta_PK ) 			lxCompacontFecomdesde =  .Fechacomprobantedesde			lxCompacontFecomhasta =  .Fechacomprobantehasta			lxCompacontFeentdesde =  .Fechaentregadesde			lxCompacontFeenthasta =  .Fechaentregahasta			lxCompacontVendesde =  upper( .VendedorDesde_PK ) 			lxCompacontVenhasta =  upper( .VendedorHasta_PK ) 			lxCompacontMotidesde =  upper( .MotivoDesde_PK ) 			lxCompacontMotihasta =  upper( .MotivoHasta_PK ) 			lxCompacontTrandesde =  upper( .TransportistaDesde_PK ) 			lxCompacontTranhasta =  upper( .TransportistaHasta_PK ) 			lxCompacontEntregapos =  .Entregaposterior			lxCompacontObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.COMPACONT set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompacontFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompacontFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompacontFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCompacontFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCompacontFectrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompacontHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompacontHmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCompacontHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompacontHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCompacontSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCompacontSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompacontVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompacontZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCompacontUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCompacontValtafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompacontBdmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompacontUaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCompacontEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompacontBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCompacontCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxCompacontDescrip ) + "'">>,"Cliedesde" = <<"'" + this.FormatearTextoSql( lxCompacontCliedesde ) + "'">>,"Cliehasta" = <<"'" + this.FormatearTextoSql( lxCompacontCliehasta ) + "'">>,"Provdesde" = <<"'" + this.FormatearTextoSql( lxCompacontProvdesde ) + "'">>,"Provhasta" = <<"'" + this.FormatearTextoSql( lxCompacontProvhasta ) + "'">>,"Origdesde" = <<"'" + this.FormatearTextoSql( lxCompacontOrigdesde ) + "'">>,"Orighasta" = <<"'" + this.FormatearTextoSql( lxCompacontOrighasta ) + "'">>,"Fecomdesde" = <<"'" + this.ConvertirDateSql( lxCompacontFecomdesde ) + "'">>,"Fecomhasta" = <<"'" + this.ConvertirDateSql( lxCompacontFecomhasta ) + "'">>,"Feentdesde" = <<"'" + this.ConvertirDateSql( lxCompacontFeentdesde ) + "'">>,"Feenthasta" = <<"'" + this.ConvertirDateSql( lxCompacontFeenthasta ) + "'">>,"Vendesde" = <<"'" + this.FormatearTextoSql( lxCompacontVendesde ) + "'">>,"Venhasta" = <<"'" + this.FormatearTextoSql( lxCompacontVenhasta ) + "'">>,"Motidesde" = <<"'" + this.FormatearTextoSql( lxCompacontMotidesde ) + "'">>,"Motihasta" = <<"'" + this.FormatearTextoSql( lxCompacontMotihasta ) + "'">>,"Trandesde" = <<"'" + this.FormatearTextoSql( lxCompacontTrandesde ) + "'">>,"Tranhasta" = <<"'" + this.FormatearTextoSql( lxCompacontTranhasta ) + "'">>,"Entregapos" = <<lxCompacontEntregapos>>,"Obs" = <<"'" + this.FormatearTextoSql( lxCompacontObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompacontCodigo ) + "'">> and  COMPACONT.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.COMPACONT where " + this.ConvertirFuncionesSql( " COMPACONT.CODIGO != ''" ) )
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
			Local lxCompacontCodigo
			lxCompacontCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Origdesde" as "Origendestinodesde", "Orighasta" as "Origendestinohasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Feentdesde" as "Fechaentregadesde", "Feenthasta" as "Fechaentregahasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Entregapos" as "Entregaposterior", "Obs" as "Observacion" from ZooLogic.COMPACONT where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompacontCodigo ) + "'">> and  COMPACONT.CODIGO != ''
			endtext
			use in select('c_FILTRARCOMPROBANTESACONTROLAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESACONTROLAR', set( 'Datasession' ) )

			if reccount( 'c_FILTRARCOMPROBANTESACONTROLAR' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCompacontCodigo as Variant
		llRetorno = .t.
		lxCompacontCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPACONT where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompacontCodigo ) + "'">> and  COMPACONT.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Origdesde" as "Origendestinodesde", "Orighasta" as "Origendestinohasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Feentdesde" as "Fechaentregadesde", "Feenthasta" as "Fechaentregahasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Entregapos" as "Entregaposterior", "Obs" as "Observacion" from ZooLogic.COMPACONT where  COMPACONT.CODIGO != '' order by Codigo
			endtext
			use in select('c_FILTRARCOMPROBANTESACONTROLAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESACONTROLAR', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Origdesde" as "Origendestinodesde", "Orighasta" as "Origendestinohasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Feentdesde" as "Fechaentregadesde", "Feenthasta" as "Fechaentregahasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Entregapos" as "Entregaposterior", "Obs" as "Observacion" from ZooLogic.COMPACONT where  funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPACONT.CODIGO != '' order by Codigo
			endtext
			use in select('c_FILTRARCOMPROBANTESACONTROLAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESACONTROLAR', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Origdesde" as "Origendestinodesde", "Orighasta" as "Origendestinohasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Feentdesde" as "Fechaentregadesde", "Feenthasta" as "Fechaentregahasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Entregapos" as "Entregaposterior", "Obs" as "Observacion" from ZooLogic.COMPACONT where  funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPACONT.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_FILTRARCOMPROBANTESACONTROLAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESACONTROLAR', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Origdesde" as "Origendestinodesde", "Orighasta" as "Origendestinohasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Feentdesde" as "Fechaentregadesde", "Feenthasta" as "Fechaentregahasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Entregapos" as "Entregaposterior", "Obs" as "Observacion" from ZooLogic.COMPACONT where  COMPACONT.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_FILTRARCOMPROBANTESACONTROLAR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARCOMPROBANTESACONTROLAR', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Horaimpo,Hmodifw,Haltafw,Horaexpo,Saltafw,Smodifw,V" + ;
"modifw,Zadsfw,Umodifw,Valtafw,Bdmodifw,Ualtafw,Esttrans,Bdaltafw,Codigo,Descrip,Cliedesde,Cliehasta," + ;
"Provdesde,Provhasta,Origdesde,Orighasta,Fecomdesde,Fecomhasta,Feentdesde,Feenthasta,Vendesde,Venhast" + ;
"a,Motidesde,Motihasta,Trandesde,Tranhasta,Entregapos,Obs" + ;
" from ZooLogic.COMPACONT where  COMPACONT.CODIGO != '' and " + lcFiltro )
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
			local  lxCompacontFecimpo, lxCompacontFecexpo, lxCompacontFmodifw, lxCompacontFaltafw, lxCompacontFectrans, lxCompacontHoraimpo, lxCompacontHmodifw, lxCompacontHaltafw, lxCompacontHoraexpo, lxCompacontSaltafw, lxCompacontSmodifw, lxCompacontVmodifw, lxCompacontZadsfw, lxCompacontUmodifw, lxCompacontValtafw, lxCompacontBdmodifw, lxCompacontUaltafw, lxCompacontEsttrans, lxCompacontBdaltafw, lxCompacontCodigo, lxCompacontDescrip, lxCompacontCliedesde, lxCompacontCliehasta, lxCompacontProvdesde, lxCompacontProvhasta, lxCompacontOrigdesde, lxCompacontOrighasta, lxCompacontFecomdesde, lxCompacontFecomhasta, lxCompacontFeentdesde, lxCompacontFeenthasta, lxCompacontVendesde, lxCompacontVenhasta, lxCompacontMotidesde, lxCompacontMotihasta, lxCompacontTrandesde, lxCompacontTranhasta, lxCompacontEntregapos, lxCompacontObs
				lxCompacontFecimpo = ctod( '  /  /    ' )			lxCompacontFecexpo = ctod( '  /  /    ' )			lxCompacontFmodifw = ctod( '  /  /    ' )			lxCompacontFaltafw = ctod( '  /  /    ' )			lxCompacontFectrans = ctod( '  /  /    ' )			lxCompacontHoraimpo = []			lxCompacontHmodifw = []			lxCompacontHaltafw = []			lxCompacontHoraexpo = []			lxCompacontSaltafw = []			lxCompacontSmodifw = []			lxCompacontVmodifw = []			lxCompacontZadsfw = []			lxCompacontUmodifw = []			lxCompacontValtafw = []			lxCompacontBdmodifw = []			lxCompacontUaltafw = []			lxCompacontEsttrans = []			lxCompacontBdaltafw = []			lxCompacontCodigo = []			lxCompacontDescrip = []			lxCompacontCliedesde = []			lxCompacontCliehasta = []			lxCompacontProvdesde = []			lxCompacontProvhasta = []			lxCompacontOrigdesde = []			lxCompacontOrighasta = []			lxCompacontFecomdesde = ctod( '  /  /    ' )			lxCompacontFecomhasta = ctod( '  /  /    ' )			lxCompacontFeentdesde = ctod( '  /  /    ' )			lxCompacontFeenthasta = ctod( '  /  /    ' )			lxCompacontVendesde = []			lxCompacontVenhasta = []			lxCompacontMotidesde = []			lxCompacontMotihasta = []			lxCompacontTrandesde = []			lxCompacontTranhasta = []			lxCompacontEntregapos = 0			lxCompacontObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPACONT where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPACONT' + '_' + tcCampo
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
		lcWhere = " Where  COMPACONT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Origdesde" as "Origendestinodesde", "Orighasta" as "Origendestinohasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Feentdesde" as "Fechaentregadesde", "Feenthasta" as "Fechaentregahasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Entregapos" as "Entregaposterior", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPACONT', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'CLIENTEDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDESDE AS CLIENTEDESDE'
				Case lcAtributo == 'CLIENTEHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEHASTA AS CLIENTEHASTA'
				Case lcAtributo == 'PROVEEDORDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVDESDE AS PROVEEDORDESDE'
				Case lcAtributo == 'PROVEEDORHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVHASTA AS PROVEEDORHASTA'
				Case lcAtributo == 'ORIGENDESTINODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGDESDE AS ORIGENDESTINODESDE'
				Case lcAtributo == 'ORIGENDESTINOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGHASTA AS ORIGENDESTINOHASTA'
				Case lcAtributo == 'FECHACOMPROBANTEDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECOMDESDE AS FECHACOMPROBANTEDESDE'
				Case lcAtributo == 'FECHACOMPROBANTEHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECOMHASTA AS FECHACOMPROBANTEHASTA'
				Case lcAtributo == 'FECHAENTREGADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FEENTDESDE AS FECHAENTREGADESDE'
				Case lcAtributo == 'FECHAENTREGAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FEENTHASTA AS FECHAENTREGAHASTA'
				Case lcAtributo == 'VENDEDORDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDESDE AS VENDEDORDESDE'
				Case lcAtributo == 'VENDEDORHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENHASTA AS VENDEDORHASTA'
				Case lcAtributo == 'MOTIVODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIDESDE AS MOTIVODESDE'
				Case lcAtributo == 'MOTIVOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIHASTA AS MOTIVOHASTA'
				Case lcAtributo == 'TRANSPORTISTADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRANDESDE AS TRANSPORTISTADESDE'
				Case lcAtributo == 'TRANSPORTISTAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRANHASTA AS TRANSPORTISTAHASTA'
				Case lcAtributo == 'ENTREGAPOSTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTREGAPOS AS ENTREGAPOSTERIOR'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESDE'
				lcCampo = 'CLIEDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEHASTA'
				lcCampo = 'CLIEHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORDESDE'
				lcCampo = 'PROVDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORHASTA'
				lcCampo = 'PROVHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINODESDE'
				lcCampo = 'ORIGDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINOHASTA'
				lcCampo = 'ORIGHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTEDESDE'
				lcCampo = 'FECOMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTEHASTA'
				lcCampo = 'FECOMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAENTREGADESDE'
				lcCampo = 'FEENTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAENTREGAHASTA'
				lcCampo = 'FEENTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDORDESDE'
				lcCampo = 'VENDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDORHASTA'
				lcCampo = 'VENHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVODESDE'
				lcCampo = 'MOTIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVOHASTA'
				lcCampo = 'MOTIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTADESDE'
				lcCampo = 'TRANDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTAHASTA'
				lcCampo = 'TRANHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPOSTERIOR'
				lcCampo = 'ENTREGAPOS'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
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
			local  lxCompacontFecimpo, lxCompacontFecexpo, lxCompacontFmodifw, lxCompacontFaltafw, lxCompacontFectrans, lxCompacontHoraimpo, lxCompacontHmodifw, lxCompacontHaltafw, lxCompacontHoraexpo, lxCompacontSaltafw, lxCompacontSmodifw, lxCompacontVmodifw, lxCompacontZadsfw, lxCompacontUmodifw, lxCompacontValtafw, lxCompacontBdmodifw, lxCompacontUaltafw, lxCompacontEsttrans, lxCompacontBdaltafw, lxCompacontCodigo, lxCompacontDescrip, lxCompacontCliedesde, lxCompacontCliehasta, lxCompacontProvdesde, lxCompacontProvhasta, lxCompacontOrigdesde, lxCompacontOrighasta, lxCompacontFecomdesde, lxCompacontFecomhasta, lxCompacontFeentdesde, lxCompacontFeenthasta, lxCompacontVendesde, lxCompacontVenhasta, lxCompacontMotidesde, lxCompacontMotihasta, lxCompacontTrandesde, lxCompacontTranhasta, lxCompacontEntregapos, lxCompacontObs
				lxCompacontFecimpo =  .Fechaimpo			lxCompacontFecexpo =  .Fechaexpo			lxCompacontFmodifw =  .Fechamodificacionfw			lxCompacontFaltafw =  .Fechaaltafw			lxCompacontFectrans =  .Fechatransferencia			lxCompacontHoraimpo =  .Horaimpo			lxCompacontHmodifw =  .Horamodificacionfw			lxCompacontHaltafw =  .Horaaltafw			lxCompacontHoraexpo =  .Horaexpo			lxCompacontSaltafw =  .Seriealtafw			lxCompacontSmodifw =  .Seriemodificacionfw			lxCompacontVmodifw =  .Versionmodificacionfw			lxCompacontZadsfw =  .Zadsfw			lxCompacontUmodifw =  .Usuariomodificacionfw			lxCompacontValtafw =  .Versionaltafw			lxCompacontBdmodifw =  .Basededatosmodificacionfw			lxCompacontUaltafw =  .Usuarioaltafw			lxCompacontEsttrans =  .Estadotransferencia			lxCompacontBdaltafw =  .Basededatosaltafw			lxCompacontCodigo =  .Codigo			lxCompacontDescrip =  .Descripcion			lxCompacontCliedesde =  upper( .ClienteDesde_PK ) 			lxCompacontCliehasta =  upper( .ClienteHasta_PK ) 			lxCompacontProvdesde =  upper( .ProveedorDesde_PK ) 			lxCompacontProvhasta =  upper( .ProveedorHasta_PK ) 			lxCompacontOrigdesde =  upper( .OrigenDestinoDesde_PK ) 			lxCompacontOrighasta =  upper( .OrigenDestinoHasta_PK ) 			lxCompacontFecomdesde =  .Fechacomprobantedesde			lxCompacontFecomhasta =  .Fechacomprobantehasta			lxCompacontFeentdesde =  .Fechaentregadesde			lxCompacontFeenthasta =  .Fechaentregahasta			lxCompacontVendesde =  upper( .VendedorDesde_PK ) 			lxCompacontVenhasta =  upper( .VendedorHasta_PK ) 			lxCompacontMotidesde =  upper( .MotivoDesde_PK ) 			lxCompacontMotihasta =  upper( .MotivoHasta_PK ) 			lxCompacontTrandesde =  upper( .TransportistaDesde_PK ) 			lxCompacontTranhasta =  upper( .TransportistaHasta_PK ) 			lxCompacontEntregapos =  .Entregaposterior			lxCompacontObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPACONT ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Horaimpo","Hmodifw","Haltafw","Horaexpo","Saltafw","Smodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Bdmodifw","Ualtafw","Esttrans","Bdaltafw","Codigo","Descrip","Cliedesde","Cliehasta","Provdesde","Provhasta","Origdesde","Orighasta","Fecomdesde","Fecomhasta","Feentdesde","Feenthasta","Vendesde","Venhasta","Motidesde","Motihasta","Trandesde","Tranhasta","Entregapos","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCompacontFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontCliedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontCliehasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontOrigdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontOrighasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFecomdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFecomhasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFeentdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompacontFeenthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontVendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontVenhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontMotidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontMotihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontTrandesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompacontTranhasta ) + "'" >>, <<lxCompacontEntregapos >>, <<"'" + this.FormatearTextoSql( lxCompacontObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMPACONT' 
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
			local  lxCompacontFecimpo, lxCompacontFecexpo, lxCompacontFmodifw, lxCompacontFaltafw, lxCompacontFectrans, lxCompacontHoraimpo, lxCompacontHmodifw, lxCompacontHaltafw, lxCompacontHoraexpo, lxCompacontSaltafw, lxCompacontSmodifw, lxCompacontVmodifw, lxCompacontZadsfw, lxCompacontUmodifw, lxCompacontValtafw, lxCompacontBdmodifw, lxCompacontUaltafw, lxCompacontEsttrans, lxCompacontBdaltafw, lxCompacontCodigo, lxCompacontDescrip, lxCompacontCliedesde, lxCompacontCliehasta, lxCompacontProvdesde, lxCompacontProvhasta, lxCompacontOrigdesde, lxCompacontOrighasta, lxCompacontFecomdesde, lxCompacontFecomhasta, lxCompacontFeentdesde, lxCompacontFeenthasta, lxCompacontVendesde, lxCompacontVenhasta, lxCompacontMotidesde, lxCompacontMotihasta, lxCompacontTrandesde, lxCompacontTranhasta, lxCompacontEntregapos, lxCompacontObs
				lxCompacontFecimpo =  .Fechaimpo			lxCompacontFecexpo =  .Fechaexpo			lxCompacontFmodifw =  .Fechamodificacionfw			lxCompacontFaltafw =  .Fechaaltafw			lxCompacontFectrans =  .Fechatransferencia			lxCompacontHoraimpo =  .Horaimpo			lxCompacontHmodifw =  .Horamodificacionfw			lxCompacontHaltafw =  .Horaaltafw			lxCompacontHoraexpo =  .Horaexpo			lxCompacontSaltafw =  .Seriealtafw			lxCompacontSmodifw =  .Seriemodificacionfw			lxCompacontVmodifw =  .Versionmodificacionfw			lxCompacontZadsfw =  .Zadsfw			lxCompacontUmodifw =  .Usuariomodificacionfw			lxCompacontValtafw =  .Versionaltafw			lxCompacontBdmodifw =  .Basededatosmodificacionfw			lxCompacontUaltafw =  .Usuarioaltafw			lxCompacontEsttrans =  .Estadotransferencia			lxCompacontBdaltafw =  .Basededatosaltafw			lxCompacontCodigo =  .Codigo			lxCompacontDescrip =  .Descripcion			lxCompacontCliedesde =  upper( .ClienteDesde_PK ) 			lxCompacontCliehasta =  upper( .ClienteHasta_PK ) 			lxCompacontProvdesde =  upper( .ProveedorDesde_PK ) 			lxCompacontProvhasta =  upper( .ProveedorHasta_PK ) 			lxCompacontOrigdesde =  upper( .OrigenDestinoDesde_PK ) 			lxCompacontOrighasta =  upper( .OrigenDestinoHasta_PK ) 			lxCompacontFecomdesde =  .Fechacomprobantedesde			lxCompacontFecomhasta =  .Fechacomprobantehasta			lxCompacontFeentdesde =  .Fechaentregadesde			lxCompacontFeenthasta =  .Fechaentregahasta			lxCompacontVendesde =  upper( .VendedorDesde_PK ) 			lxCompacontVenhasta =  upper( .VendedorHasta_PK ) 			lxCompacontMotidesde =  upper( .MotivoDesde_PK ) 			lxCompacontMotihasta =  upper( .MotivoHasta_PK ) 			lxCompacontTrandesde =  upper( .TransportistaDesde_PK ) 			lxCompacontTranhasta =  upper( .TransportistaHasta_PK ) 			lxCompacontEntregapos =  .Entregaposterior			lxCompacontObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPACONT.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPACONT set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompacontFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompacontFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompacontFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompacontFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCompacontFectrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompacontHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompacontHmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCompacontHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompacontHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCompacontSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCompacontSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompacontVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompacontZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCompacontUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCompacontValtafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompacontBdmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompacontUaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCompacontEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompacontBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCompacontCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxCompacontDescrip ) + "'">>, "Cliedesde" = <<"'" + this.FormatearTextoSql( lxCompacontCliedesde ) + "'">>, "Cliehasta" = <<"'" + this.FormatearTextoSql( lxCompacontCliehasta ) + "'">>, "Provdesde" = <<"'" + this.FormatearTextoSql( lxCompacontProvdesde ) + "'">>, "Provhasta" = <<"'" + this.FormatearTextoSql( lxCompacontProvhasta ) + "'">>, "Origdesde" = <<"'" + this.FormatearTextoSql( lxCompacontOrigdesde ) + "'">>, "Orighasta" = <<"'" + this.FormatearTextoSql( lxCompacontOrighasta ) + "'">>, "Fecomdesde" = <<"'" + this.ConvertirDateSql( lxCompacontFecomdesde ) + "'">>, "Fecomhasta" = <<"'" + this.ConvertirDateSql( lxCompacontFecomhasta ) + "'">>, "Feentdesde" = <<"'" + this.ConvertirDateSql( lxCompacontFeentdesde ) + "'">>, "Feenthasta" = <<"'" + this.ConvertirDateSql( lxCompacontFeenthasta ) + "'">>, "Vendesde" = <<"'" + this.FormatearTextoSql( lxCompacontVendesde ) + "'">>, "Venhasta" = <<"'" + this.FormatearTextoSql( lxCompacontVenhasta ) + "'">>, "Motidesde" = <<"'" + this.FormatearTextoSql( lxCompacontMotidesde ) + "'">>, "Motihasta" = <<"'" + this.FormatearTextoSql( lxCompacontMotihasta ) + "'">>, "Trandesde" = <<"'" + this.FormatearTextoSql( lxCompacontTrandesde ) + "'">>, "Tranhasta" = <<"'" + this.FormatearTextoSql( lxCompacontTranhasta ) + "'">>, "Entregapos" = <<lxCompacontEntregapos>>, "Obs" = <<"'" + this.FormatearTextoSql( lxCompacontObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPACONT' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPACONT.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COMPACONT where ' + lcFiltro )
			loColeccion.cTabla = 'COMPACONT' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPACONT where  COMPACONT.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPACONT where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPACONT.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESACONTROLAR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPACONT Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPACONT set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, ClieDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClieDesde ) + "'"+ [, ClieHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClieHasta ) + "'"+ [, ProvDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'"+ [, ProvHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'"+ [, OrigDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..OrigDesde ) + "'"+ [, OrigHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..OrigHasta ) + "'"+ [, FeComDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FeComDesde ) + "'"+ [, FeComHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FeComHasta ) + "'"+ [, FeEntDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FeEntDesde ) + "'"+ [, FeEntHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FeEntHasta ) + "'"+ [, VenDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..VenDesde ) + "'"+ [, VenHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..VenHasta ) + "'"+ [, MotiDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MotiDesde ) + "'"+ [, MotiHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MotiHasta ) + "'"+ [, TranDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TranDesde ) + "'"+ [, TranHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TranHasta ) + "'"+ [, EntregaPos = ] + transform( &lcCursor..EntregaPos )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECEXPO, FMODIFW, FALTAFW, FECTRANS, HORAIMPO, HMODIFW, HALTAFW, HORAEXPO, SALTAFW, SMODIFW, VMODIFW, ZADSFW, UMODIFW, VALTAFW, BDMODIFW, UALTAFW, ESTTRANS, BDALTAFW, Codigo, Descrip, ClieDesde, ClieHasta, ProvDesde, ProvHasta, OrigDesde, OrigHasta, FeComDesde, FeComHasta, FeEntDesde, FeEntHasta, VenDesde, VenHasta, MotiDesde, MotiHasta, TranDesde, TranHasta, EntregaPos, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClieDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClieHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OrigDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OrigHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FeComDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FeComHasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FeEntDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FeEntHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VenDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VenHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MotiDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MotiHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TranDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TranHasta ) + "'" + ',' + transform( &lcCursor..EntregaPos ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPACONT ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESACONTROLAR'
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
			Case  lcAlias == lcPrefijo + 'FILTRARCOMPROBANTESACONTROLAR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FILTRARCOMPROBANTESACONTROLAR_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FILTRARCOMPROBANTESACONTROLAR_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COMPACONT')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'FILTRARCOMPROBANTESACONTROLAR'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad FILTRARCOMPROBANTESACONTROLAR. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESACONTROLAR'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESACONTROLAR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FeComDesde
		* Validar ANTERIORES A 1/1/1753  FeComHasta
		* Validar ANTERIORES A 1/1/1753  FeEntDesde
		* Validar ANTERIORES A 1/1/1753  FeEntHasta
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPACONT') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPACONT
Create Table ZooLogic.TablaTrabajo_COMPACONT ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"bdmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"descrip" char( 1 )  null, 
"cliedesde" char( 5 )  null, 
"cliehasta" char( 5 )  null, 
"provdesde" char( 5 )  null, 
"provhasta" char( 5 )  null, 
"origdesde" char( 8 )  null, 
"orighasta" char( 8 )  null, 
"fecomdesde" datetime  null, 
"fecomhasta" datetime  null, 
"feentdesde" datetime  null, 
"feenthasta" datetime  null, 
"vendesde" char( 5 )  null, 
"venhasta" char( 5 )  null, 
"motidesde" char( 3 )  null, 
"motihasta" char( 3 )  null, 
"trandesde" char( 6 )  null, 
"tranhasta" char( 6 )  null, 
"entregapos" numeric( 1, 0 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COMPACONT' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COMPACONT' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARCOMPROBANTESACONTROLAR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('cliedesde','cliedesde')
			.AgregarMapeo('cliehasta','cliehasta')
			.AgregarMapeo('provdesde','provdesde')
			.AgregarMapeo('provhasta','provhasta')
			.AgregarMapeo('origdesde','origdesde')
			.AgregarMapeo('orighasta','orighasta')
			.AgregarMapeo('fecomdesde','fecomdesde')
			.AgregarMapeo('fecomhasta','fecomhasta')
			.AgregarMapeo('feentdesde','feentdesde')
			.AgregarMapeo('feenthasta','feenthasta')
			.AgregarMapeo('vendesde','vendesde')
			.AgregarMapeo('venhasta','venhasta')
			.AgregarMapeo('motidesde','motidesde')
			.AgregarMapeo('motihasta','motihasta')
			.AgregarMapeo('trandesde','trandesde')
			.AgregarMapeo('tranhasta','tranhasta')
			.AgregarMapeo('entregapos','entregapos')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COMPACONT'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.CLIEDESDE = isnull( d.CLIEDESDE, t.CLIEDESDE ),t.CLIEHASTA = isnull( d.CLIEHASTA, t.CLIEHASTA ),t.PROVDESDE = isnull( d.PROVDESDE, t.PROVDESDE ),t.PROVHASTA = isnull( d.PROVHASTA, t.PROVHASTA ),t.ORIGDESDE = isnull( d.ORIGDESDE, t.ORIGDESDE ),t.ORIGHASTA = isnull( d.ORIGHASTA, t.ORIGHASTA ),t.FECOMDESDE = isnull( d.FECOMDESDE, t.FECOMDESDE ),t.FECOMHASTA = isnull( d.FECOMHASTA, t.FECOMHASTA ),t.FEENTDESDE = isnull( d.FEENTDESDE, t.FEENTDESDE ),t.FEENTHASTA = isnull( d.FEENTHASTA, t.FEENTHASTA ),t.VENDESDE = isnull( d.VENDESDE, t.VENDESDE ),t.VENHASTA = isnull( d.VENHASTA, t.VENHASTA ),t.MOTIDESDE = isnull( d.MOTIDESDE, t.MOTIDESDE ),t.MOTIHASTA = isnull( d.MOTIHASTA, t.MOTIHASTA ),t.TRANDESDE = isnull( d.TRANDESDE, t.TRANDESDE ),t.TRANHASTA = isnull( d.TRANHASTA, t.TRANHASTA ),t.ENTREGAPOS = isnull( d.ENTREGAPOS, t.ENTREGAPOS ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.COMPACONT t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.COMPACONT(Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Horaimpo,Hmodifw,Haltafw,Horaexpo,Saltafw,Smodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Bdmodifw,Ualtafw,Esttrans,Bdaltafw,Codigo,Descrip,Cliedesde,Cliehasta,Provdesde,Provhasta,Origdesde,Orighasta,Fecomdesde,Fecomhasta,Feentdesde,Feenthasta,Vendesde,Venhasta,Motidesde,Motihasta,Trandesde,Tranhasta,Entregapos,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.DESCRIP,''),isnull( d.CLIEDESDE,''),isnull( d.CLIEHASTA,''),isnull( d.PROVDESDE,''),isnull( d.PROVHASTA,''),isnull( d.ORIGDESDE,''),isnull( d.ORIGHASTA,''),isnull( d.FECOMDESDE,''),isnull( d.FECOMHASTA,''),isnull( d.FEENTDESDE,''),isnull( d.FEENTHASTA,''),isnull( d.VENDESDE,''),isnull( d.VENHASTA,''),isnull( d.MOTIDESDE,''),isnull( d.MOTIHASTA,''),isnull( d.TRANDESDE,''),isnull( d.TRANHASTA,''),isnull( d.ENTREGAPOS,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.COMPACONT pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPACONT') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPACONT
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_FILTRARCOMPROBANTESACONTROLAR' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Horamodificacionfw, [] )
					.Horaaltafw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Horaaltafw, [] )
					.Horaexpo = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Horaexpo, [] )
					.Seriealtafw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Versionaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Basededatosmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Usuarioaltafw, [] )
					.Estadotransferencia = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Basededatosaltafw, [] )
					.Codigo = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Codigo, [] )
					.Descripcion = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Descripcion, [] )
					.Clientedesde_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Clientedesde, [] )
					.Clientehasta_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Clientehasta, [] )
					.Proveedordesde_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Proveedordesde, [] )
					.Proveedorhasta_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Proveedorhasta, [] )
					.Origendestinodesde_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Origendestinodesde, [] )
					.Origendestinohasta_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Origendestinohasta, [] )
					.Fechacomprobantedesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechacomprobantedesde, ctod( '  /  /    ' ) ) )
					.Fechacomprobantehasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechacomprobantehasta, ctod( '  /  /    ' ) ) )
					.Fechaentregadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechaentregadesde, ctod( '  /  /    ' ) ) )
					.Fechaentregahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARCOMPROBANTESACONTROLAR.Fechaentregahasta, ctod( '  /  /    ' ) ) )
					.Vendedordesde_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Vendedordesde, [] )
					.Vendedorhasta_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Vendedorhasta, [] )
					.Motivodesde_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Motivodesde, [] )
					.Motivohasta_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Motivohasta, [] )
					.Transportistadesde_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Transportistadesde, [] )
					.Transportistahasta_PK =  nvl( c_FILTRARCOMPROBANTESACONTROLAR.Transportistahasta, [] )
					.Entregaposterior = nvl( c_FILTRARCOMPROBANTESACONTROLAR.Entregaposterior, 0 )
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
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_FILTRARCOMPROBANTESACONTROLAR.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPACONT' )
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
								from ZooLogic.COMPACONT 
								Where   COMPACONT.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPACONT", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Cliedesde" as "Clientedesde", "Cliehasta" as "Clientehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Origdesde" as "Origendestinodesde", "Orighasta" as "Origendestinohasta", "Fecomdesde" as "Fechacomprobantedesde", "Fecomhasta" as "Fechacomprobantehasta", "Feentdesde" as "Fechaentregadesde", "Feenthasta" as "Fechaentregahasta", "Vendesde" as "Vendedordesde", "Venhasta" as "Vendedorhasta", "Motidesde" as "Motivodesde", "Motihasta" as "Motivohasta", "Trandesde" as "Transportistadesde", "Tranhasta" as "Transportistahasta", "Entregapos" as "Entregaposterior", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPACONT 
								Where   COMPACONT.CODIGO != ''
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
	Tabla = 'COMPACONT'
	Filtro = " COMPACONT.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPACONT.CODIGO != ''"
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
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHAIMPO                               " tabla="COMPACONT      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHAEXPO                               " tabla="COMPACONT      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHAMODIFICACIONFW                     " tabla="COMPACONT      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHAALTAFW                             " tabla="COMPACONT      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHATRANSFERENCIA                      " tabla="COMPACONT      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="HORAIMPO                                " tabla="COMPACONT      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="HORAMODIFICACIONFW                      " tabla="COMPACONT      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="HORAALTAFW                              " tabla="COMPACONT      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="HORAEXPO                                " tabla="COMPACONT      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="SERIEALTAFW                             " tabla="COMPACONT      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="SERIEMODIFICACIONFW                     " tabla="COMPACONT      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPACONT      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="ZADSFW                                  " tabla="COMPACONT      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPACONT      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="VERSIONALTAFW                           " tabla="COMPACONT      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPACONT      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="USUARIOALTAFW                           " tabla="COMPACONT      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPACONT      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="BASEDEDATOSALTAFW                       " tabla="COMPACONT      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="CODIGO                                  " tabla="COMPACONT      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="DESCRIPCION                             " tabla="COMPACONT      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="CLIENTEDESDE                            " tabla="COMPACONT      " campo="CLIEDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Cliente desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="CLIENTEHASTA                            " tabla="COMPACONT      " campo="CLIEHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="402" etiqueta="Cliente hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="PROVEEDORDESDE                          " tabla="COMPACONT      " campo="PROVDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Proveedor desde                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="PROVEEDORHASTA                          " tabla="COMPACONT      " campo="PROVHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="406" etiqueta="Proveedor hasta                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="ORIGENDESTINODESDE                      " tabla="COMPACONT      " campo="ORIGDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Origen/destino desde                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="ORIGENDESTINOHASTA                      " tabla="COMPACONT      " campo="ORIGHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="ZZZZZZZZ                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="410" etiqueta="Origen/destino hasta                                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHACOMPROBANTEDESDE                   " tabla="COMPACONT      " campo="FECOMDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Fecha de comprobante desde                                                                                                                                      " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHACOMPROBANTEHASTA                   " tabla="COMPACONT      " campo="FECOMHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="414" etiqueta="Fecha de comprobante hasta                                                                                                                                      " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHAENTREGADESDE                       " tabla="COMPACONT      " campo="FEENTDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Fecha de entrega desde                                                                                                                                          " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="FECHAENTREGAHASTA                       " tabla="COMPACONT      " campo="FEENTHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="418" etiqueta="Fecha de entrega hasta                                                                                                                                          " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="VENDEDORDESDE                           " tabla="COMPACONT      " campo="VENDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Vendedor desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="55" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="VENDEDORHASTA                           " tabla="COMPACONT      " campo="VENHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="422" etiqueta="Vendedor hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="MOTIVODESDE                             " tabla="COMPACONT      " campo="MOTIDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Motivo desde                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="65" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="MOTIVOHASTA                             " tabla="COMPACONT      " campo="MOTIHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="426" etiqueta="Motivo hasta                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="TRANSPORTISTADESDE                      " tabla="COMPACONT      " campo="TRANDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Transportista desde                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="75" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="TRANSPORTISTAHASTA                      " tabla="COMPACONT      " campo="TRANHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="6" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZ                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="430" etiqueta="Transportista hasta                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="ENTREGAPOSTERIOR                        " tabla="COMPACONT      " campo="ENTREGAPOS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Tipos de entrega                                                                                                                                                " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="85" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARCOMPROBANTESACONTROLAR           " atributo="OBSERVACION                             " tabla="COMPACONT      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="99" subgrupo="99" orden="99" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="401" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPACONT.CLIEDESDE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="403" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPACONT.CLIEHASTA = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On COMPACONT.PROVDESDE = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On COMPACONT.PROVHASTA = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On COMPACONT.ORIGDESDE = ORDAT.codigo And  ORDAT.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On COMPACONT.ORIGHASTA = ORDAT.codigo And  ORDAT.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPACONT.VENDESDE = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPACONT.VENHASTA = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On COMPACONT.MOTIDESDE = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On COMPACONT.MOTIHASTA = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="429" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On COMPACONT.TRANDESDE = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="431" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On COMPACONT.TRANHASTA = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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