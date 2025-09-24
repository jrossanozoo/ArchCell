
define class Din_EntidadCRITERIOSVALORESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CRITERIOSVALORES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CAVPK'
	cTablaPrincipal = 'CACEPV'
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
			local  lxCacepvFecexpo, lxCacepvFecimpo, lxCacepvFectrans, lxCacepvFaltafw, lxCacepvTimestamp, lxCacepvUaltafw, lxCacepvUmodifw, lxCacepvHoraimpo, lxCacepvVmodifw, lxCacepvZadsfw, lxCacepvValtafw, lxCacepvBdaltafw, lxCacepvHaltafw, lxCacepvHoraexpo, lxCacepvEsttrans, lxCacepvBdmodifw, lxCacepvSmodifw, lxCacepvSaltafw, lxCacepvClobs, lxCacepvNumero, lxCacepvCdesc, lxCacepvComp, lxCacepvSucdesde, lxCacepvFmodifw, lxCacepvHmodifw, lxCacepvVdesde, lxCacepvSuchasta, lxCacepvVhasta, lxCacepvHoradesde, lxCacepvHorahasta, lxCacepvDialu, lxCacepvDiama, lxCacepvClcfi, lxCacepvDiami, lxCacepvDiaju, lxCacepvDiavi, lxCacepvDiasa, lxCacepvDiado, lxCacepvJjco, lxCacepvCuotas, lxCacepvCantdesde, lxCacepvCanthasta, lxCacepvTotaldesde, lxCacepvTotalhasta, lxCacepvDesdesde, lxCacepvRecdesde, lxCacepvDeshasta, lxCacepvRechasta, lxCacepvFpodesd, lxCacepvFpodesh, lxCacepvFporecd, lxCacepvFporech, lxCacepvCodlista
				lxCacepvFecexpo =  .Fechaexpo			lxCacepvFecimpo =  .Fechaimpo			lxCacepvFectrans =  .Fechatransferencia			lxCacepvFaltafw =  .Fechaaltafw			lxCacepvTimestamp = goLibrerias.ObtenerTimestamp()			lxCacepvUaltafw =  .Usuarioaltafw			lxCacepvUmodifw =  .Usuariomodificacionfw			lxCacepvHoraimpo =  .Horaimpo			lxCacepvVmodifw =  .Versionmodificacionfw			lxCacepvZadsfw =  .Zadsfw			lxCacepvValtafw =  .Versionaltafw			lxCacepvBdaltafw =  .Basededatosaltafw			lxCacepvHaltafw =  .Horaaltafw			lxCacepvHoraexpo =  .Horaexpo			lxCacepvEsttrans =  .Estadotransferencia			lxCacepvBdmodifw =  .Basededatosmodificacionfw			lxCacepvSmodifw =  .Seriemodificacionfw			lxCacepvSaltafw =  .Seriealtafw			lxCacepvClobs =  .Observacion			lxCacepvNumero =  .Numero			lxCacepvCdesc =  .Descripcion			lxCacepvComp =  .Comportamiento			lxCacepvSucdesde =  upper( .SucursalDesde_PK ) 			lxCacepvFmodifw =  .Fechamodificacionfw			lxCacepvHmodifw =  .Horamodificacionfw			lxCacepvVdesde =  .Vigenciadesde			lxCacepvSuchasta =  upper( .SucursalHasta_PK ) 			lxCacepvVhasta =  .Vigenciahasta			lxCacepvHoradesde =  .Horadesde			lxCacepvHorahasta =  .Horahasta			lxCacepvDialu =  .Dialu			lxCacepvDiama =  .Diama			lxCacepvClcfi =  .Tipo			lxCacepvDiami =  .Diami			lxCacepvDiaju =  .Diaju			lxCacepvDiavi =  .Diavi			lxCacepvDiasa =  .Diasa			lxCacepvDiado =  .Diado			lxCacepvJjco =  upper( .Valor_PK ) 			lxCacepvCuotas =  .Cuotas			lxCacepvCantdesde =  .Cantidadarticulosdesde			lxCacepvCanthasta =  .Cantidadarticuloshasta			lxCacepvTotaldesde =  .Totaldesde			lxCacepvTotalhasta =  .Totalhasta			lxCacepvDesdesde =  .Montodescuentodesde			lxCacepvRecdesde =  .Montorecargodesde			lxCacepvDeshasta =  .Montodescuentohasta			lxCacepvRechasta =  .Montorecargohasta			lxCacepvFpodesd =  .Porcentajedescuentodesde			lxCacepvFpodesh =  .Porcentajedescuentohasta			lxCacepvFporecd =  .Porcentajerecargodesde			lxCacepvFporech =  .Porcentajerecargohasta			lxCacepvCodlista =  upper( .ListaDePrecios_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCacepvNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CACEPV ( "Fecexpo","Fecimpo","Fectrans","Faltafw","Timestamp","Ualtafw","Umodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Bdaltafw","Haltafw","Horaexpo","Esttrans","Bdmodifw","Smodifw","Saltafw","Clobs","Numero","Cdesc","Comp","Sucdesde","Fmodifw","Hmodifw","Vdesde","Suchasta","Vhasta","Horadesde","Horahasta","Dialu","Diama","Clcfi","Diami","Diaju","Diavi","Diasa","Diado","Jjco","Cuotas","Cantdesde","Canthasta","Totaldesde","Totalhasta","Desdesde","Recdesde","Deshasta","Rechasta","Fpodesd","Fpodesh","Fporecd","Fporech","Codlista" ) values ( <<"'" + this.ConvertirDateSql( lxCacepvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvFaltafw ) + "'" >>, <<lxCacepvTimestamp >>, <<"'" + this.FormatearTextoSql( lxCacepvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvClobs ) + "'" >>, <<lxCacepvNumero >>, <<"'" + this.FormatearTextoSql( lxCacepvCdesc ) + "'" >>, <<lxCacepvComp >>, <<"'" + this.FormatearTextoSql( lxCacepvSucdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvVdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvSuchasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvVhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHoradesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHorahasta ) + "'" >>, <<iif( lxCacepvDialu, 1, 0 ) >>, <<iif( lxCacepvDiama, 1, 0 ) >>, <<lxCacepvClcfi >>, <<iif( lxCacepvDiami, 1, 0 ) >>, <<iif( lxCacepvDiaju, 1, 0 ) >>, <<iif( lxCacepvDiavi, 1, 0 ) >>, <<iif( lxCacepvDiasa, 1, 0 ) >>, <<iif( lxCacepvDiado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCacepvJjco ) + "'" >>, <<lxCacepvCuotas >>, <<lxCacepvCantdesde >>, <<lxCacepvCanthasta >>, <<lxCacepvTotaldesde >>, <<lxCacepvTotalhasta >>, <<lxCacepvDesdesde >>, <<lxCacepvRecdesde >>, <<lxCacepvDeshasta >>, <<lxCacepvRechasta >>, <<lxCacepvFpodesd >>, <<lxCacepvFpodesh >>, <<lxCacepvFporecd >>, <<lxCacepvFporech >>, <<"'" + this.FormatearTextoSql( lxCacepvCodlista ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
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
		this.oEntidad.Timestamp = lxCacepvTimestamp
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
		return this.oEntidad.NUMERO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxCacepvFecexpo, lxCacepvFecimpo, lxCacepvFectrans, lxCacepvFaltafw, lxCacepvTimestamp, lxCacepvUaltafw, lxCacepvUmodifw, lxCacepvHoraimpo, lxCacepvVmodifw, lxCacepvZadsfw, lxCacepvValtafw, lxCacepvBdaltafw, lxCacepvHaltafw, lxCacepvHoraexpo, lxCacepvEsttrans, lxCacepvBdmodifw, lxCacepvSmodifw, lxCacepvSaltafw, lxCacepvClobs, lxCacepvNumero, lxCacepvCdesc, lxCacepvComp, lxCacepvSucdesde, lxCacepvFmodifw, lxCacepvHmodifw, lxCacepvVdesde, lxCacepvSuchasta, lxCacepvVhasta, lxCacepvHoradesde, lxCacepvHorahasta, lxCacepvDialu, lxCacepvDiama, lxCacepvClcfi, lxCacepvDiami, lxCacepvDiaju, lxCacepvDiavi, lxCacepvDiasa, lxCacepvDiado, lxCacepvJjco, lxCacepvCuotas, lxCacepvCantdesde, lxCacepvCanthasta, lxCacepvTotaldesde, lxCacepvTotalhasta, lxCacepvDesdesde, lxCacepvRecdesde, lxCacepvDeshasta, lxCacepvRechasta, lxCacepvFpodesd, lxCacepvFpodesh, lxCacepvFporecd, lxCacepvFporech, lxCacepvCodlista
				lxCacepvFecexpo =  .Fechaexpo			lxCacepvFecimpo =  .Fechaimpo			lxCacepvFectrans =  .Fechatransferencia			lxCacepvFaltafw =  .Fechaaltafw			lxCacepvTimestamp = goLibrerias.ObtenerTimestamp()			lxCacepvUaltafw =  .Usuarioaltafw			lxCacepvUmodifw =  .Usuariomodificacionfw			lxCacepvHoraimpo =  .Horaimpo			lxCacepvVmodifw =  .Versionmodificacionfw			lxCacepvZadsfw =  .Zadsfw			lxCacepvValtafw =  .Versionaltafw			lxCacepvBdaltafw =  .Basededatosaltafw			lxCacepvHaltafw =  .Horaaltafw			lxCacepvHoraexpo =  .Horaexpo			lxCacepvEsttrans =  .Estadotransferencia			lxCacepvBdmodifw =  .Basededatosmodificacionfw			lxCacepvSmodifw =  .Seriemodificacionfw			lxCacepvSaltafw =  .Seriealtafw			lxCacepvClobs =  .Observacion			lxCacepvNumero =  .Numero			lxCacepvCdesc =  .Descripcion			lxCacepvComp =  .Comportamiento			lxCacepvSucdesde =  upper( .SucursalDesde_PK ) 			lxCacepvFmodifw =  .Fechamodificacionfw			lxCacepvHmodifw =  .Horamodificacionfw			lxCacepvVdesde =  .Vigenciadesde			lxCacepvSuchasta =  upper( .SucursalHasta_PK ) 			lxCacepvVhasta =  .Vigenciahasta			lxCacepvHoradesde =  .Horadesde			lxCacepvHorahasta =  .Horahasta			lxCacepvDialu =  .Dialu			lxCacepvDiama =  .Diama			lxCacepvClcfi =  .Tipo			lxCacepvDiami =  .Diami			lxCacepvDiaju =  .Diaju			lxCacepvDiavi =  .Diavi			lxCacepvDiasa =  .Diasa			lxCacepvDiado =  .Diado			lxCacepvJjco =  upper( .Valor_PK ) 			lxCacepvCuotas =  .Cuotas			lxCacepvCantdesde =  .Cantidadarticulosdesde			lxCacepvCanthasta =  .Cantidadarticuloshasta			lxCacepvTotaldesde =  .Totaldesde			lxCacepvTotalhasta =  .Totalhasta			lxCacepvDesdesde =  .Montodescuentodesde			lxCacepvRecdesde =  .Montorecargodesde			lxCacepvDeshasta =  .Montodescuentohasta			lxCacepvRechasta =  .Montorecargohasta			lxCacepvFpodesd =  .Porcentajedescuentodesde			lxCacepvFpodesh =  .Porcentajedescuentohasta			lxCacepvFporecd =  .Porcentajerecargodesde			lxCacepvFporech =  .Porcentajerecargohasta			lxCacepvCodlista =  upper( .ListaDePrecios_PK ) 
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CACEPV set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCacepvFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCacepvFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCacepvFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCacepvFaltafw ) + "'">>,"Timestamp" = <<lxCacepvTimestamp>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCacepvUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCacepvUmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCacepvHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCacepvVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCacepvZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCacepvValtafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCacepvBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCacepvHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCacepvHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCacepvEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCacepvBdmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCacepvSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCacepvSaltafw ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxCacepvClobs ) + "'">>,"Numero" = <<lxCacepvNumero>>,"Cdesc" = <<"'" + this.FormatearTextoSql( lxCacepvCdesc ) + "'">>,"Comp" = <<lxCacepvComp>>,"Sucdesde" = <<"'" + this.FormatearTextoSql( lxCacepvSucdesde ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCacepvFmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCacepvHmodifw ) + "'">>,"Vdesde" = <<"'" + this.ConvertirDateSql( lxCacepvVdesde ) + "'">>,"Suchasta" = <<"'" + this.FormatearTextoSql( lxCacepvSuchasta ) + "'">>,"Vhasta" = <<"'" + this.ConvertirDateSql( lxCacepvVhasta ) + "'">>,"Horadesde" = <<"'" + this.FormatearTextoSql( lxCacepvHoradesde ) + "'">>,"Horahasta" = <<"'" + this.FormatearTextoSql( lxCacepvHorahasta ) + "'">>,"Dialu" = <<iif( lxCacepvDialu, 1, 0 )>>,"Diama" = <<iif( lxCacepvDiama, 1, 0 )>>,"Clcfi" = <<lxCacepvClcfi>>,"Diami" = <<iif( lxCacepvDiami, 1, 0 )>>,"Diaju" = <<iif( lxCacepvDiaju, 1, 0 )>>,"Diavi" = <<iif( lxCacepvDiavi, 1, 0 )>>,"Diasa" = <<iif( lxCacepvDiasa, 1, 0 )>>,"Diado" = <<iif( lxCacepvDiado, 1, 0 )>>,"Jjco" = <<"'" + this.FormatearTextoSql( lxCacepvJjco ) + "'">>,"Cuotas" = <<lxCacepvCuotas>>,"Cantdesde" = <<lxCacepvCantdesde>>,"Canthasta" = <<lxCacepvCanthasta>>,"Totaldesde" = <<lxCacepvTotaldesde>>,"Totalhasta" = <<lxCacepvTotalhasta>>,"Desdesde" = <<lxCacepvDesdesde>>,"Recdesde" = <<lxCacepvRecdesde>>,"Deshasta" = <<lxCacepvDeshasta>>,"Rechasta" = <<lxCacepvRechasta>>,"Fpodesd" = <<lxCacepvFpodesd>>,"Fpodesh" = <<lxCacepvFpodesh>>,"Fporecd" = <<lxCacepvFporecd>>,"Fporech" = <<lxCacepvFporech>>,"Codlista" = <<"'" + this.FormatearTextoSql( lxCacepvCodlista ) + "'">> where "Numero" = <<lxCacepvNumero>> and  CACEPV.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxCacepvTimestamp
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValidarTimestamp() as void
		Local lnTimestamp as integer
		if !this.oEntidad.lEsSubentidad
			lnTimestamp = this.ObtenerTimestampActual()
			if this.oEntidad.Timestamp = lnTimestamp 
			else 
				local loEx as Object
				loEx = Newobject( 'ZooException', 'ZooException.prg' )
				With loEx
					.Message = 'Error al intentar Grabar'
					.Details = 'No se puede grabar, el registro ha cambiado'
					.Grabar()
					.Throw()
				endwith
			endif
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 numero from ZooLogic.CACEPV where " + this.ConvertirFuncionesSql( " CACEPV.NUMERO != 0" ) )
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
			Local lxCacepvNumero
			lxCacepvNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Clobs" as "Observacion", "Numero" as "Numero", "Cdesc" as "Descripcion", "Comp" as "Comportamiento", "Sucdesde" as "Sucursaldesde", "Fmodifw" as "Fechamodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vdesde" as "Vigenciadesde", "Suchasta" as "Sucursalhasta", "Vhasta" as "Vigenciahasta", "Horadesde" as "Horadesde", "Horahasta" as "Horahasta", "Dialu" as "Dialu", "Diama" as "Diama", "Clcfi" as "Tipo", "Diami" as "Diami", "Diaju" as "Diaju", "Diavi" as "Diavi", "Diasa" as "Diasa", "Diado" as "Diado", "Jjco" as "Valor", "Cuotas" as "Cuotas", "Cantdesde" as "Cantidadarticulosdesde", "Canthasta" as "Cantidadarticuloshasta", "Totaldesde" as "Totaldesde", "Totalhasta" as "Totalhasta", "Desdesde" as "Montodescuentodesde", "Recdesde" as "Montorecargodesde", "Deshasta" as "Montodescuentohasta", "Rechasta" as "Montorecargohasta", "Fpodesd" as "Porcentajedescuentodesde", "Fpodesh" as "Porcentajedescuentohasta", "Fporecd" as "Porcentajerecargodesde", "Fporech" as "Porcentajerecargohasta", "Codlista" as "Listadeprecios" from ZooLogic.CACEPV where "Numero" = <<lxCacepvNumero>> and  CACEPV.NUMERO != 0
			endtext
			use in select('c_CRITERIOSVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CRITERIOSVALORES', set( 'Datasession' ) )

			if reccount( 'c_CRITERIOSVALORES' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCacepvNumero as Variant
		llRetorno = .t.
		lxCacepvNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CACEPV where "Numero" = <<lxCacepvNumero>> and  CACEPV.NUMERO != 0
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
				lcOrden =  str( .NUMERO, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Clobs" as "Observacion", "Numero" as "Numero", "Cdesc" as "Descripcion", "Comp" as "Comportamiento", "Sucdesde" as "Sucursaldesde", "Fmodifw" as "Fechamodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vdesde" as "Vigenciadesde", "Suchasta" as "Sucursalhasta", "Vhasta" as "Vigenciahasta", "Horadesde" as "Horadesde", "Horahasta" as "Horahasta", "Dialu" as "Dialu", "Diama" as "Diama", "Clcfi" as "Tipo", "Diami" as "Diami", "Diaju" as "Diaju", "Diavi" as "Diavi", "Diasa" as "Diasa", "Diado" as "Diado", "Jjco" as "Valor", "Cuotas" as "Cuotas", "Cantdesde" as "Cantidadarticulosdesde", "Canthasta" as "Cantidadarticuloshasta", "Totaldesde" as "Totaldesde", "Totalhasta" as "Totalhasta", "Desdesde" as "Montodescuentodesde", "Recdesde" as "Montorecargodesde", "Deshasta" as "Montodescuentohasta", "Rechasta" as "Montorecargohasta", "Fpodesd" as "Porcentajedescuentodesde", "Fpodesh" as "Porcentajedescuentohasta", "Fporecd" as "Porcentajerecargodesde", "Fporech" as "Porcentajerecargohasta", "Codlista" as "Listadeprecios" from ZooLogic.CACEPV where  CACEPV.NUMERO != 0 order by numero
			endtext
			use in select('c_CRITERIOSVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CRITERIOSVALORES', set( 'Datasession' ) )
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
				lcOrden =  str( .NUMERO, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Clobs" as "Observacion", "Numero" as "Numero", "Cdesc" as "Descripcion", "Comp" as "Comportamiento", "Sucdesde" as "Sucursaldesde", "Fmodifw" as "Fechamodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vdesde" as "Vigenciadesde", "Suchasta" as "Sucursalhasta", "Vhasta" as "Vigenciahasta", "Horadesde" as "Horadesde", "Horahasta" as "Horahasta", "Dialu" as "Dialu", "Diama" as "Diama", "Clcfi" as "Tipo", "Diami" as "Diami", "Diaju" as "Diaju", "Diavi" as "Diavi", "Diasa" as "Diasa", "Diado" as "Diado", "Jjco" as "Valor", "Cuotas" as "Cuotas", "Cantdesde" as "Cantidadarticulosdesde", "Canthasta" as "Cantidadarticuloshasta", "Totaldesde" as "Totaldesde", "Totalhasta" as "Totalhasta", "Desdesde" as "Montodescuentodesde", "Recdesde" as "Montorecargodesde", "Deshasta" as "Montodescuentohasta", "Rechasta" as "Montorecargohasta", "Fpodesd" as "Porcentajedescuentodesde", "Fpodesh" as "Porcentajedescuentohasta", "Fporecd" as "Porcentajerecargodesde", "Fporech" as "Porcentajerecargohasta", "Codlista" as "Listadeprecios" from ZooLogic.CACEPV where  str( numero, 10, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CACEPV.NUMERO != 0 order by numero
			endtext
			use in select('c_CRITERIOSVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CRITERIOSVALORES', set( 'Datasession' ) )
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
				lcOrden =  str( .NUMERO, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Clobs" as "Observacion", "Numero" as "Numero", "Cdesc" as "Descripcion", "Comp" as "Comportamiento", "Sucdesde" as "Sucursaldesde", "Fmodifw" as "Fechamodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vdesde" as "Vigenciadesde", "Suchasta" as "Sucursalhasta", "Vhasta" as "Vigenciahasta", "Horadesde" as "Horadesde", "Horahasta" as "Horahasta", "Dialu" as "Dialu", "Diama" as "Diama", "Clcfi" as "Tipo", "Diami" as "Diami", "Diaju" as "Diaju", "Diavi" as "Diavi", "Diasa" as "Diasa", "Diado" as "Diado", "Jjco" as "Valor", "Cuotas" as "Cuotas", "Cantdesde" as "Cantidadarticulosdesde", "Canthasta" as "Cantidadarticuloshasta", "Totaldesde" as "Totaldesde", "Totalhasta" as "Totalhasta", "Desdesde" as "Montodescuentodesde", "Recdesde" as "Montorecargodesde", "Deshasta" as "Montodescuentohasta", "Rechasta" as "Montorecargohasta", "Fpodesd" as "Porcentajedescuentodesde", "Fpodesh" as "Porcentajedescuentohasta", "Fporecd" as "Porcentajerecargodesde", "Fporech" as "Porcentajerecargohasta", "Codlista" as "Listadeprecios" from ZooLogic.CACEPV where  str( numero, 10, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CACEPV.NUMERO != 0 order by numero desc
			endtext
			use in select('c_CRITERIOSVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CRITERIOSVALORES', set( 'Datasession' ) )
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
				lcOrden =  str( .NUMERO, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Clobs" as "Observacion", "Numero" as "Numero", "Cdesc" as "Descripcion", "Comp" as "Comportamiento", "Sucdesde" as "Sucursaldesde", "Fmodifw" as "Fechamodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vdesde" as "Vigenciadesde", "Suchasta" as "Sucursalhasta", "Vhasta" as "Vigenciahasta", "Horadesde" as "Horadesde", "Horahasta" as "Horahasta", "Dialu" as "Dialu", "Diama" as "Diama", "Clcfi" as "Tipo", "Diami" as "Diami", "Diaju" as "Diaju", "Diavi" as "Diavi", "Diasa" as "Diasa", "Diado" as "Diado", "Jjco" as "Valor", "Cuotas" as "Cuotas", "Cantdesde" as "Cantidadarticulosdesde", "Canthasta" as "Cantidadarticuloshasta", "Totaldesde" as "Totaldesde", "Totalhasta" as "Totalhasta", "Desdesde" as "Montodescuentodesde", "Recdesde" as "Montorecargodesde", "Deshasta" as "Montodescuentohasta", "Rechasta" as "Montorecargohasta", "Fpodesd" as "Porcentajedescuentodesde", "Fpodesh" as "Porcentajedescuentohasta", "Fporecd" as "Porcentajerecargodesde", "Fporech" as "Porcentajerecargohasta", "Codlista" as "Listadeprecios" from ZooLogic.CACEPV where  CACEPV.NUMERO != 0 order by numero desc
			endtext
			use in select('c_CRITERIOSVALORES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CRITERIOSVALORES', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.NUMERO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fecimpo,Fectrans,Faltafw,Timestamp,Ualtafw,Umodifw,Horaimpo,Vmodifw,Zadsfw,Valtafw,B" + ;
"daltafw,Haltafw,Horaexpo,Esttrans,Bdmodifw,Smodifw,Saltafw,Clobs,Numero,Cdesc,Comp,Sucdesde,Fmodifw," + ;
"Hmodifw,Vdesde,Suchasta,Vhasta,Horadesde,Horahasta,Dialu,Diama,Clcfi,Diami,Diaju,Diavi,Diasa,Diado,J" + ;
"jco,Cuotas,Cantdesde,Canthasta,Totaldesde,Totalhasta,Desdesde,Recdesde,Deshasta,Rechasta,Fpodesd,Fpo" + ;
"desh,Fporecd,Fporech,Codlista" + ;
" from ZooLogic.CACEPV where  CACEPV.NUMERO != 0 and " + lcFiltro )
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
			local  lxCacepvFecexpo, lxCacepvFecimpo, lxCacepvFectrans, lxCacepvFaltafw, lxCacepvTimestamp, lxCacepvUaltafw, lxCacepvUmodifw, lxCacepvHoraimpo, lxCacepvVmodifw, lxCacepvZadsfw, lxCacepvValtafw, lxCacepvBdaltafw, lxCacepvHaltafw, lxCacepvHoraexpo, lxCacepvEsttrans, lxCacepvBdmodifw, lxCacepvSmodifw, lxCacepvSaltafw, lxCacepvClobs, lxCacepvNumero, lxCacepvCdesc, lxCacepvComp, lxCacepvSucdesde, lxCacepvFmodifw, lxCacepvHmodifw, lxCacepvVdesde, lxCacepvSuchasta, lxCacepvVhasta, lxCacepvHoradesde, lxCacepvHorahasta, lxCacepvDialu, lxCacepvDiama, lxCacepvClcfi, lxCacepvDiami, lxCacepvDiaju, lxCacepvDiavi, lxCacepvDiasa, lxCacepvDiado, lxCacepvJjco, lxCacepvCuotas, lxCacepvCantdesde, lxCacepvCanthasta, lxCacepvTotaldesde, lxCacepvTotalhasta, lxCacepvDesdesde, lxCacepvRecdesde, lxCacepvDeshasta, lxCacepvRechasta, lxCacepvFpodesd, lxCacepvFpodesh, lxCacepvFporecd, lxCacepvFporech, lxCacepvCodlista
				lxCacepvFecexpo = ctod( '  /  /    ' )			lxCacepvFecimpo = ctod( '  /  /    ' )			lxCacepvFectrans = ctod( '  /  /    ' )			lxCacepvFaltafw = ctod( '  /  /    ' )			lxCacepvTimestamp = goLibrerias.ObtenerTimestamp()			lxCacepvUaltafw = []			lxCacepvUmodifw = []			lxCacepvHoraimpo = []			lxCacepvVmodifw = []			lxCacepvZadsfw = []			lxCacepvValtafw = []			lxCacepvBdaltafw = []			lxCacepvHaltafw = []			lxCacepvHoraexpo = []			lxCacepvEsttrans = []			lxCacepvBdmodifw = []			lxCacepvSmodifw = []			lxCacepvSaltafw = []			lxCacepvClobs = []			lxCacepvNumero = 0			lxCacepvCdesc = []			lxCacepvComp = 0			lxCacepvSucdesde = []			lxCacepvFmodifw = ctod( '  /  /    ' )			lxCacepvHmodifw = []			lxCacepvVdesde = ctod( '  /  /    ' )			lxCacepvSuchasta = []			lxCacepvVhasta = ctod( '  /  /    ' )			lxCacepvHoradesde = []			lxCacepvHorahasta = []			lxCacepvDialu = .F.			lxCacepvDiama = .F.			lxCacepvClcfi = 0			lxCacepvDiami = .F.			lxCacepvDiaju = .F.			lxCacepvDiavi = .F.			lxCacepvDiasa = .F.			lxCacepvDiado = .F.			lxCacepvJjco = []			lxCacepvCuotas = 0			lxCacepvCantdesde = 0			lxCacepvCanthasta = 0			lxCacepvTotaldesde = 0			lxCacepvTotalhasta = 0			lxCacepvDesdesde = 0			lxCacepvRecdesde = 0			lxCacepvDeshasta = 0			lxCacepvRechasta = 0			lxCacepvFpodesd = 0			lxCacepvFpodesh = 0			lxCacepvFporecd = 0			lxCacepvFporech = 0			lxCacepvCodlista = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CACEPV where "numero" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CACEPV' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where numero = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(numero, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CACEPV.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Clobs" as "Observacion", "Numero" as "Numero", "Cdesc" as "Descripcion", "Comp" as "Comportamiento", "Sucdesde" as "Sucursaldesde", "Fmodifw" as "Fechamodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vdesde" as "Vigenciadesde", "Suchasta" as "Sucursalhasta", "Vhasta" as "Vigenciahasta", "Horadesde" as "Horadesde", "Horahasta" as "Horahasta", "Dialu" as "Dialu", "Diama" as "Diama", "Clcfi" as "Tipo", "Diami" as "Diami", "Diaju" as "Diaju", "Diavi" as "Diavi", "Diasa" as "Diasa", "Diado" as "Diado", "Jjco" as "Valor", "Cuotas" as "Cuotas", "Cantdesde" as "Cantidadarticulosdesde", "Canthasta" as "Cantidadarticuloshasta", "Totaldesde" as "Totaldesde", "Totalhasta" as "Totalhasta", "Desdesde" as "Montodescuentodesde", "Recdesde" as "Montorecargodesde", "Deshasta" as "Montodescuentohasta", "Rechasta" as "Montorecargohasta", "Fpodesd" as "Porcentajedescuentodesde", "Fpodesh" as "Porcentajedescuentohasta", "Fporecd" as "Porcentajerecargodesde", "Fporech" as "Porcentajerecargohasta", "Codlista" as "Listadeprecios"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CACEPV', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDESC AS DESCRIPCION'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'SUCURSALDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCDESDE AS SUCURSALDESDE'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VIGENCIADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VDESDE AS VIGENCIADESDE'
				Case lcAtributo == 'SUCURSALHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCHASTA AS SUCURSALHASTA'
				Case lcAtributo == 'VIGENCIAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VHASTA AS VIGENCIAHASTA'
				Case lcAtributo == 'HORADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORADESDE AS HORADESDE'
				Case lcAtributo == 'HORAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAHASTA AS HORAHASTA'
				Case lcAtributo == 'DIALU'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIALU AS DIALU'
				Case lcAtributo == 'DIAMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIAMA AS DIAMA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS TIPO'
				Case lcAtributo == 'DIAMI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIAMI AS DIAMI'
				Case lcAtributo == 'DIAJU'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIAJU AS DIAJU'
				Case lcAtributo == 'DIAVI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIAVI AS DIAVI'
				Case lcAtributo == 'DIASA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIASA AS DIASA'
				Case lcAtributo == 'DIADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIADO AS DIADO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCO AS VALOR'
				Case lcAtributo == 'CUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUOTAS AS CUOTAS'
				Case lcAtributo == 'CANTIDADARTICULOSDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTDESDE AS CANTIDADARTICULOSDESDE'
				Case lcAtributo == 'CANTIDADARTICULOSHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTHASTA AS CANTIDADARTICULOSHASTA'
				Case lcAtributo == 'TOTALDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALDESDE AS TOTALDESDE'
				Case lcAtributo == 'TOTALHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALHASTA AS TOTALHASTA'
				Case lcAtributo == 'MONTODESCUENTODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDESDE AS MONTODESCUENTODESDE'
				Case lcAtributo == 'MONTORECARGODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECDESDE AS MONTORECARGODESDE'
				Case lcAtributo == 'MONTODESCUENTOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESHASTA AS MONTODESCUENTOHASTA'
				Case lcAtributo == 'MONTORECARGOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECHASTA AS MONTORECARGOHASTA'
				Case lcAtributo == 'PORCENTAJEDESCUENTODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODESD AS PORCENTAJEDESCUENTODESDE'
				Case lcAtributo == 'PORCENTAJEDESCUENTOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODESH AS PORCENTAJEDESCUENTOHASTA'
				Case lcAtributo == 'PORCENTAJERECARGODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORECD AS PORCENTAJERECARGODESDE'
				Case lcAtributo == 'PORCENTAJERECARGOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORECH AS PORCENTAJERECARGOHASTA'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CDESC'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'SUCURSALDESDE'
				lcCampo = 'SUCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIADESDE'
				lcCampo = 'VDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'SUCURSALHASTA'
				lcCampo = 'SUCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTA'
				lcCampo = 'VHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'HORADESDE'
				lcCampo = 'HORADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'HORAHASTA'
				lcCampo = 'HORAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'DIALU'
				lcCampo = 'DIALU'
			Case upper( alltrim( tcAtributo ) ) == 'DIAMA'
				lcCampo = 'DIAMA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'DIAMI'
				lcCampo = 'DIAMI'
			Case upper( alltrim( tcAtributo ) ) == 'DIAJU'
				lcCampo = 'DIAJU'
			Case upper( alltrim( tcAtributo ) ) == 'DIAVI'
				lcCampo = 'DIAVI'
			Case upper( alltrim( tcAtributo ) ) == 'DIASA'
				lcCampo = 'DIASA'
			Case upper( alltrim( tcAtributo ) ) == 'DIADO'
				lcCampo = 'DIADO'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'JJCO'
			Case upper( alltrim( tcAtributo ) ) == 'CUOTAS'
				lcCampo = 'CUOTAS'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADARTICULOSDESDE'
				lcCampo = 'CANTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADARTICULOSHASTA'
				lcCampo = 'CANTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESDE'
				lcCampo = 'TOTALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALHASTA'
				lcCampo = 'TOTALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTODESDE'
				lcCampo = 'DESDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTORECARGODESDE'
				lcCampo = 'RECDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOHASTA'
				lcCampo = 'DESHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTORECARGOHASTA'
				lcCampo = 'RECHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTODESDE'
				lcCampo = 'FPODESD'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTOHASTA'
				lcCampo = 'FPODESH'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJERECARGODESDE'
				lcCampo = 'FPORECD'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJERECARGOHASTA'
				lcCampo = 'FPORECH'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
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
			local  lxCacepvFecexpo, lxCacepvFecimpo, lxCacepvFectrans, lxCacepvFaltafw, lxCacepvTimestamp, lxCacepvUaltafw, lxCacepvUmodifw, lxCacepvHoraimpo, lxCacepvVmodifw, lxCacepvZadsfw, lxCacepvValtafw, lxCacepvBdaltafw, lxCacepvHaltafw, lxCacepvHoraexpo, lxCacepvEsttrans, lxCacepvBdmodifw, lxCacepvSmodifw, lxCacepvSaltafw, lxCacepvClobs, lxCacepvNumero, lxCacepvCdesc, lxCacepvComp, lxCacepvSucdesde, lxCacepvFmodifw, lxCacepvHmodifw, lxCacepvVdesde, lxCacepvSuchasta, lxCacepvVhasta, lxCacepvHoradesde, lxCacepvHorahasta, lxCacepvDialu, lxCacepvDiama, lxCacepvClcfi, lxCacepvDiami, lxCacepvDiaju, lxCacepvDiavi, lxCacepvDiasa, lxCacepvDiado, lxCacepvJjco, lxCacepvCuotas, lxCacepvCantdesde, lxCacepvCanthasta, lxCacepvTotaldesde, lxCacepvTotalhasta, lxCacepvDesdesde, lxCacepvRecdesde, lxCacepvDeshasta, lxCacepvRechasta, lxCacepvFpodesd, lxCacepvFpodesh, lxCacepvFporecd, lxCacepvFporech, lxCacepvCodlista
				lxCacepvFecexpo =  .Fechaexpo			lxCacepvFecimpo =  .Fechaimpo			lxCacepvFectrans =  .Fechatransferencia			lxCacepvFaltafw =  .Fechaaltafw			lxCacepvTimestamp = goLibrerias.ObtenerTimestamp()			lxCacepvUaltafw =  .Usuarioaltafw			lxCacepvUmodifw =  .Usuariomodificacionfw			lxCacepvHoraimpo =  .Horaimpo			lxCacepvVmodifw =  .Versionmodificacionfw			lxCacepvZadsfw =  .Zadsfw			lxCacepvValtafw =  .Versionaltafw			lxCacepvBdaltafw =  .Basededatosaltafw			lxCacepvHaltafw =  .Horaaltafw			lxCacepvHoraexpo =  .Horaexpo			lxCacepvEsttrans =  .Estadotransferencia			lxCacepvBdmodifw =  .Basededatosmodificacionfw			lxCacepvSmodifw =  .Seriemodificacionfw			lxCacepvSaltafw =  .Seriealtafw			lxCacepvClobs =  .Observacion			lxCacepvNumero =  .Numero			lxCacepvCdesc =  .Descripcion			lxCacepvComp =  .Comportamiento			lxCacepvSucdesde =  upper( .SucursalDesde_PK ) 			lxCacepvFmodifw =  .Fechamodificacionfw			lxCacepvHmodifw =  .Horamodificacionfw			lxCacepvVdesde =  .Vigenciadesde			lxCacepvSuchasta =  upper( .SucursalHasta_PK ) 			lxCacepvVhasta =  .Vigenciahasta			lxCacepvHoradesde =  .Horadesde			lxCacepvHorahasta =  .Horahasta			lxCacepvDialu =  .Dialu			lxCacepvDiama =  .Diama			lxCacepvClcfi =  .Tipo			lxCacepvDiami =  .Diami			lxCacepvDiaju =  .Diaju			lxCacepvDiavi =  .Diavi			lxCacepvDiasa =  .Diasa			lxCacepvDiado =  .Diado			lxCacepvJjco =  upper( .Valor_PK ) 			lxCacepvCuotas =  .Cuotas			lxCacepvCantdesde =  .Cantidadarticulosdesde			lxCacepvCanthasta =  .Cantidadarticuloshasta			lxCacepvTotaldesde =  .Totaldesde			lxCacepvTotalhasta =  .Totalhasta			lxCacepvDesdesde =  .Montodescuentodesde			lxCacepvRecdesde =  .Montorecargodesde			lxCacepvDeshasta =  .Montodescuentohasta			lxCacepvRechasta =  .Montorecargohasta			lxCacepvFpodesd =  .Porcentajedescuentodesde			lxCacepvFpodesh =  .Porcentajedescuentohasta			lxCacepvFporecd =  .Porcentajerecargodesde			lxCacepvFporech =  .Porcentajerecargohasta			lxCacepvCodlista =  upper( .ListaDePrecios_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CACEPV ( "Fecexpo","Fecimpo","Fectrans","Faltafw","Timestamp","Ualtafw","Umodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Bdaltafw","Haltafw","Horaexpo","Esttrans","Bdmodifw","Smodifw","Saltafw","Clobs","Numero","Cdesc","Comp","Sucdesde","Fmodifw","Hmodifw","Vdesde","Suchasta","Vhasta","Horadesde","Horahasta","Dialu","Diama","Clcfi","Diami","Diaju","Diavi","Diasa","Diado","Jjco","Cuotas","Cantdesde","Canthasta","Totaldesde","Totalhasta","Desdesde","Recdesde","Deshasta","Rechasta","Fpodesd","Fpodesh","Fporecd","Fporech","Codlista" ) values ( <<"'" + this.ConvertirDateSql( lxCacepvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvFaltafw ) + "'" >>, <<lxCacepvTimestamp >>, <<"'" + this.FormatearTextoSql( lxCacepvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvClobs ) + "'" >>, <<lxCacepvNumero >>, <<"'" + this.FormatearTextoSql( lxCacepvCdesc ) + "'" >>, <<lxCacepvComp >>, <<"'" + this.FormatearTextoSql( lxCacepvSucdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvVdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvSuchasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCacepvVhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHoradesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCacepvHorahasta ) + "'" >>, <<iif( lxCacepvDialu, 1, 0 ) >>, <<iif( lxCacepvDiama, 1, 0 ) >>, <<lxCacepvClcfi >>, <<iif( lxCacepvDiami, 1, 0 ) >>, <<iif( lxCacepvDiaju, 1, 0 ) >>, <<iif( lxCacepvDiavi, 1, 0 ) >>, <<iif( lxCacepvDiasa, 1, 0 ) >>, <<iif( lxCacepvDiado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCacepvJjco ) + "'" >>, <<lxCacepvCuotas >>, <<lxCacepvCantdesde >>, <<lxCacepvCanthasta >>, <<lxCacepvTotaldesde >>, <<lxCacepvTotalhasta >>, <<lxCacepvDesdesde >>, <<lxCacepvRecdesde >>, <<lxCacepvDeshasta >>, <<lxCacepvRechasta >>, <<lxCacepvFpodesd >>, <<lxCacepvFpodesh >>, <<lxCacepvFporecd >>, <<lxCacepvFporech >>, <<"'" + this.FormatearTextoSql( lxCacepvCodlista ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CACEPV' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCacepvFecexpo, lxCacepvFecimpo, lxCacepvFectrans, lxCacepvFaltafw, lxCacepvTimestamp, lxCacepvUaltafw, lxCacepvUmodifw, lxCacepvHoraimpo, lxCacepvVmodifw, lxCacepvZadsfw, lxCacepvValtafw, lxCacepvBdaltafw, lxCacepvHaltafw, lxCacepvHoraexpo, lxCacepvEsttrans, lxCacepvBdmodifw, lxCacepvSmodifw, lxCacepvSaltafw, lxCacepvClobs, lxCacepvNumero, lxCacepvCdesc, lxCacepvComp, lxCacepvSucdesde, lxCacepvFmodifw, lxCacepvHmodifw, lxCacepvVdesde, lxCacepvSuchasta, lxCacepvVhasta, lxCacepvHoradesde, lxCacepvHorahasta, lxCacepvDialu, lxCacepvDiama, lxCacepvClcfi, lxCacepvDiami, lxCacepvDiaju, lxCacepvDiavi, lxCacepvDiasa, lxCacepvDiado, lxCacepvJjco, lxCacepvCuotas, lxCacepvCantdesde, lxCacepvCanthasta, lxCacepvTotaldesde, lxCacepvTotalhasta, lxCacepvDesdesde, lxCacepvRecdesde, lxCacepvDeshasta, lxCacepvRechasta, lxCacepvFpodesd, lxCacepvFpodesh, lxCacepvFporecd, lxCacepvFporech, lxCacepvCodlista
				lxCacepvFecexpo =  .Fechaexpo			lxCacepvFecimpo =  .Fechaimpo			lxCacepvFectrans =  .Fechatransferencia			lxCacepvFaltafw =  .Fechaaltafw			lxCacepvTimestamp = goLibrerias.ObtenerTimestamp()			lxCacepvUaltafw =  .Usuarioaltafw			lxCacepvUmodifw =  .Usuariomodificacionfw			lxCacepvHoraimpo =  .Horaimpo			lxCacepvVmodifw =  .Versionmodificacionfw			lxCacepvZadsfw =  .Zadsfw			lxCacepvValtafw =  .Versionaltafw			lxCacepvBdaltafw =  .Basededatosaltafw			lxCacepvHaltafw =  .Horaaltafw			lxCacepvHoraexpo =  .Horaexpo			lxCacepvEsttrans =  .Estadotransferencia			lxCacepvBdmodifw =  .Basededatosmodificacionfw			lxCacepvSmodifw =  .Seriemodificacionfw			lxCacepvSaltafw =  .Seriealtafw			lxCacepvClobs =  .Observacion			lxCacepvNumero =  .Numero			lxCacepvCdesc =  .Descripcion			lxCacepvComp =  .Comportamiento			lxCacepvSucdesde =  upper( .SucursalDesde_PK ) 			lxCacepvFmodifw =  .Fechamodificacionfw			lxCacepvHmodifw =  .Horamodificacionfw			lxCacepvVdesde =  .Vigenciadesde			lxCacepvSuchasta =  upper( .SucursalHasta_PK ) 			lxCacepvVhasta =  .Vigenciahasta			lxCacepvHoradesde =  .Horadesde			lxCacepvHorahasta =  .Horahasta			lxCacepvDialu =  .Dialu			lxCacepvDiama =  .Diama			lxCacepvClcfi =  .Tipo			lxCacepvDiami =  .Diami			lxCacepvDiaju =  .Diaju			lxCacepvDiavi =  .Diavi			lxCacepvDiasa =  .Diasa			lxCacepvDiado =  .Diado			lxCacepvJjco =  upper( .Valor_PK ) 			lxCacepvCuotas =  .Cuotas			lxCacepvCantdesde =  .Cantidadarticulosdesde			lxCacepvCanthasta =  .Cantidadarticuloshasta			lxCacepvTotaldesde =  .Totaldesde			lxCacepvTotalhasta =  .Totalhasta			lxCacepvDesdesde =  .Montodescuentodesde			lxCacepvRecdesde =  .Montorecargodesde			lxCacepvDeshasta =  .Montodescuentohasta			lxCacepvRechasta =  .Montorecargohasta			lxCacepvFpodesd =  .Porcentajedescuentodesde			lxCacepvFpodesh =  .Porcentajedescuentohasta			lxCacepvFporecd =  .Porcentajerecargodesde			lxCacepvFporech =  .Porcentajerecargohasta			lxCacepvCodlista =  upper( .ListaDePrecios_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  CACEPV.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.CACEPV set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCacepvFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCacepvFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCacepvFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCacepvFaltafw ) + "'">>, "Timestamp" = <<lxCacepvTimestamp>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCacepvUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCacepvUmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCacepvHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCacepvVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCacepvZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCacepvValtafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCacepvBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCacepvHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCacepvHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCacepvEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCacepvBdmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCacepvSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCacepvSaltafw ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxCacepvClobs ) + "'">>, "Numero" = <<lxCacepvNumero>>, "Cdesc" = <<"'" + this.FormatearTextoSql( lxCacepvCdesc ) + "'">>, "Comp" = <<lxCacepvComp>>, "Sucdesde" = <<"'" + this.FormatearTextoSql( lxCacepvSucdesde ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCacepvFmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCacepvHmodifw ) + "'">>, "Vdesde" = <<"'" + this.ConvertirDateSql( lxCacepvVdesde ) + "'">>, "Suchasta" = <<"'" + this.FormatearTextoSql( lxCacepvSuchasta ) + "'">>, "Vhasta" = <<"'" + this.ConvertirDateSql( lxCacepvVhasta ) + "'">>, "Horadesde" = <<"'" + this.FormatearTextoSql( lxCacepvHoradesde ) + "'">>, "Horahasta" = <<"'" + this.FormatearTextoSql( lxCacepvHorahasta ) + "'">>, "Dialu" = <<iif( lxCacepvDialu, 1, 0 )>>, "Diama" = <<iif( lxCacepvDiama, 1, 0 )>>, "Clcfi" = <<lxCacepvClcfi>>, "Diami" = <<iif( lxCacepvDiami, 1, 0 )>>, "Diaju" = <<iif( lxCacepvDiaju, 1, 0 )>>, "Diavi" = <<iif( lxCacepvDiavi, 1, 0 )>>, "Diasa" = <<iif( lxCacepvDiasa, 1, 0 )>>, "Diado" = <<iif( lxCacepvDiado, 1, 0 )>>, "Jjco" = <<"'" + this.FormatearTextoSql( lxCacepvJjco ) + "'">>, "Cuotas" = <<lxCacepvCuotas>>, "Cantdesde" = <<lxCacepvCantdesde>>, "Canthasta" = <<lxCacepvCanthasta>>, "Totaldesde" = <<lxCacepvTotaldesde>>, "Totalhasta" = <<lxCacepvTotalhasta>>, "Desdesde" = <<lxCacepvDesdesde>>, "Recdesde" = <<lxCacepvRecdesde>>, "Deshasta" = <<lxCacepvDeshasta>>, "Rechasta" = <<lxCacepvRechasta>>, "Fpodesd" = <<lxCacepvFpodesd>>, "Fpodesh" = <<lxCacepvFpodesh>>, "Fporecd" = <<lxCacepvFporecd>>, "Fporech" = <<lxCacepvFporech>>, "Codlista" = <<"'" + this.FormatearTextoSql( lxCacepvCodlista ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CACEPV' 
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
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  CACEPV.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.CACEPV where ' + lcFiltro )
			loColeccion.cTabla = 'CACEPV' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CACEPV where  CACEPV.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CACEPV where numero = " + transform( this.oEntidad.NUMERO )+ " and  CACEPV.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CRITERIOSVALORES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CACEPV Where numero = ] + transform( &lcCursor..numero ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CACEPV set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, numero = ] + transform( &lcCursor..numero )+ [, cdesc = ] + "'" + this.FormatearTextoSql( &lcCursor..cdesc ) + "'"+ [, comp = ] + transform( &lcCursor..comp )+ [, sucdesde = ] + "'" + this.FormatearTextoSql( &lcCursor..sucdesde ) + "'"+ [, FModiFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FModiFW ) + "'"+ [, HModiFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HModiFW ) + "'"+ [, vDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..vDesde ) + "'"+ [, suchasta = ] + "'" + this.FormatearTextoSql( &lcCursor..suchasta ) + "'"+ [, vHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..vHasta ) + "'"+ [, HoraDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..HoraDesde ) + "'"+ [, HoraHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..HoraHasta ) + "'"+ [, DiaLu = ] + Transform( iif( &lcCursor..DiaLu, 1, 0 ))+ [, DiaMa = ] + Transform( iif( &lcCursor..DiaMa, 1, 0 ))+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, DiaMi = ] + Transform( iif( &lcCursor..DiaMi, 1, 0 ))+ [, DiaJu = ] + Transform( iif( &lcCursor..DiaJu, 1, 0 ))+ [, DiaVi = ] + Transform( iif( &lcCursor..DiaVi, 1, 0 ))+ [, DiaSa = ] + Transform( iif( &lcCursor..DiaSa, 1, 0 ))+ [, DiaDo = ] + Transform( iif( &lcCursor..DiaDo, 1, 0 ))+ [, JJCO = ] + "'" + this.FormatearTextoSql( &lcCursor..JJCO ) + "'"+ [, cuotas = ] + transform( &lcCursor..cuotas )+ [, CantDesde = ] + transform( &lcCursor..CantDesde )+ [, CantHasta = ] + transform( &lcCursor..CantHasta )+ [, TotalDesde = ] + transform( &lcCursor..TotalDesde )+ [, TotalHasta = ] + transform( &lcCursor..TotalHasta )+ [, DesDesde = ] + transform( &lcCursor..DesDesde )+ [, RecDesde = ] + transform( &lcCursor..RecDesde )+ [, DesHasta = ] + transform( &lcCursor..DesHasta )+ [, RecHasta = ] + transform( &lcCursor..RecHasta )+ [, FPODESd = ] + transform( &lcCursor..FPODESd )+ [, FPODESh = ] + transform( &lcCursor..FPODESh )+ [, FPORecd = ] + transform( &lcCursor..FPORecd )+ [, FPORech = ] + transform( &lcCursor..FPORech )+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + [ Where numero = ] + transform( &lcCursor..numero ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECIMPO, FECTRANS, FALTAFW, TIMESTAMP, UALTAFW, UMODIFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, BDALTAFW, HALTAFW, HORAEXPO, ESTTRANS, BDMODIFW, SMODIFW, SALTAFW, CLOBS, numero, cdesc, comp, sucdesde, FModiFW, HModiFW, vDesde, suchasta, vHasta, HoraDesde, HoraHasta, DiaLu, DiaMa, CLCFI, DiaMi, DiaJu, DiaVi, DiaSa, DiaDo, JJCO, cuotas, CantDesde, CantHasta, TotalDesde, TotalHasta, DesDesde, RecDesde, DesHasta, RecHasta, FPODESd, FPODESh, FPORecd, FPORech, CodLista
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + transform( &lcCursor..numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cdesc ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..comp ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..sucdesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FModiFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HModiFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..vDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..suchasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..vHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HoraDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HoraHasta ) + "'" + ',' + Transform( iif( &lcCursor..DiaLu, 1, 0 )) + ',' + Transform( iif( &lcCursor..DiaMa, 1, 0 )) + ',' + transform( &lcCursor..CLCFI ) + ',' + Transform( iif( &lcCursor..DiaMi, 1, 0 )) + ',' + Transform( iif( &lcCursor..DiaJu, 1, 0 )) + ',' + Transform( iif( &lcCursor..DiaVi, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..DiaSa, 1, 0 )) + ',' + Transform( iif( &lcCursor..DiaDo, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..JJCO ) + "'" + ',' + transform( &lcCursor..cuotas ) + ',' + transform( &lcCursor..CantDesde ) + ',' + transform( &lcCursor..CantHasta ) + ',' + transform( &lcCursor..TotalDesde ) + ',' + transform( &lcCursor..TotalHasta ) + ',' + transform( &lcCursor..DesDesde )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecDesde ) + ',' + transform( &lcCursor..DesHasta ) + ',' + transform( &lcCursor..RecHasta ) + ',' + transform( &lcCursor..FPODESd ) + ',' + transform( &lcCursor..FPODESh ) + ',' + transform( &lcCursor..FPORecd ) + ',' + transform( &lcCursor..FPORech ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CACEPV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CRITERIOSVALORES'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( numero N (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..numero     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CRITERIOSVALORES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CRITERIOSVALORES_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CRITERIOSVALORES_CLOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_cacepv')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CRITERIOSVALORES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..numero
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CRITERIOSVALORES. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CRITERIOSVALORES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,numero as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( numero, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CRITERIOSVALORES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FModiFW   
		* Validar ANTERIORES A 1/1/1753  vDesde    
		* Validar ANTERIORES A 1/1/1753  vHasta    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_cacepv') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_cacepv
Create Table ZooLogic.TablaTrabajo_cacepv ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"clobs" varchar(max)  null, 
"numero" numeric( 10, 0 )  null, 
"cdesc" char( 80 )  null, 
"comp" numeric( 1, 0 )  null, 
"sucdesde" char( 5 )  null, 
"fmodifw" datetime  null, 
"hmodifw" char( 8 )  null, 
"vdesde" datetime  null, 
"suchasta" char( 5 )  null, 
"vhasta" datetime  null, 
"horadesde" char( 5 )  null, 
"horahasta" char( 5 )  null, 
"dialu" bit  null, 
"diama" bit  null, 
"clcfi" numeric( 2, 0 )  null, 
"diami" bit  null, 
"diaju" bit  null, 
"diavi" bit  null, 
"diasa" bit  null, 
"diado" bit  null, 
"jjco" char( 5 )  null, 
"cuotas" numeric( 3, 0 )  null, 
"cantdesde" numeric( 10, 2 )  null, 
"canthasta" numeric( 10, 2 )  null, 
"totaldesde" numeric( 15, 2 )  null, 
"totalhasta" numeric( 15, 2 )  null, 
"desdesde" numeric( 15, 2 )  null, 
"recdesde" numeric( 15, 2 )  null, 
"deshasta" numeric( 15, 2 )  null, 
"rechasta" numeric( 15, 2 )  null, 
"fpodesd" numeric( 6, 2 )  null, 
"fpodesh" numeric( 6, 2 )  null, 
"fporecd" numeric( 6, 2 )  null, 
"fporech" numeric( 6, 2 )  null, 
"codlista" char( 6 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_cacepv' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_cacepv' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CRITERIOSVALORES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('cdesc','cdesc')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('sucdesde','sucdesde')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vdesde','vdesde')
			.AgregarMapeo('suchasta','suchasta')
			.AgregarMapeo('vhasta','vhasta')
			.AgregarMapeo('horadesde','horadesde')
			.AgregarMapeo('horahasta','horahasta')
			.AgregarMapeo('dialu','dialu')
			.AgregarMapeo('diama','diama')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('diami','diami')
			.AgregarMapeo('diaju','diaju')
			.AgregarMapeo('diavi','diavi')
			.AgregarMapeo('diasa','diasa')
			.AgregarMapeo('diado','diado')
			.AgregarMapeo('jjco','jjco')
			.AgregarMapeo('cuotas','cuotas')
			.AgregarMapeo('cantdesde','cantdesde')
			.AgregarMapeo('canthasta','canthasta')
			.AgregarMapeo('totaldesde','totaldesde')
			.AgregarMapeo('totalhasta','totalhasta')
			.AgregarMapeo('desdesde','desdesde')
			.AgregarMapeo('recdesde','recdesde')
			.AgregarMapeo('deshasta','deshasta')
			.AgregarMapeo('rechasta','rechasta')
			.AgregarMapeo('fpodesd','fpodesd')
			.AgregarMapeo('fpodesh','fpodesh')
			.AgregarMapeo('fporecd','fporecd')
			.AgregarMapeo('fporech','fporech')
			.AgregarMapeo('codlista','codlista')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_cacepv'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.CDESC = isnull( d.CDESC, t.CDESC ),t.COMP = isnull( d.COMP, t.COMP ),t.SUCDESDE = isnull( d.SUCDESDE, t.SUCDESDE ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VDESDE = isnull( d.VDESDE, t.VDESDE ),t.SUCHASTA = isnull( d.SUCHASTA, t.SUCHASTA ),t.VHASTA = isnull( d.VHASTA, t.VHASTA ),t.HORADESDE = isnull( d.HORADESDE, t.HORADESDE ),t.HORAHASTA = isnull( d.HORAHASTA, t.HORAHASTA ),t.DIALU = isnull( d.DIALU, t.DIALU ),t.DIAMA = isnull( d.DIAMA, t.DIAMA ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.DIAMI = isnull( d.DIAMI, t.DIAMI ),t.DIAJU = isnull( d.DIAJU, t.DIAJU ),t.DIAVI = isnull( d.DIAVI, t.DIAVI ),t.DIASA = isnull( d.DIASA, t.DIASA ),t.DIADO = isnull( d.DIADO, t.DIADO ),t.JJCO = isnull( d.JJCO, t.JJCO ),t.CUOTAS = isnull( d.CUOTAS, t.CUOTAS ),t.CANTDESDE = isnull( d.CANTDESDE, t.CANTDESDE ),t.CANTHASTA = isnull( d.CANTHASTA, t.CANTHASTA ),t.TOTALDESDE = isnull( d.TOTALDESDE, t.TOTALDESDE ),t.TOTALHASTA = isnull( d.TOTALHASTA, t.TOTALHASTA ),t.DESDESDE = isnull( d.DESDESDE, t.DESDESDE ),t.RECDESDE = isnull( d.RECDESDE, t.RECDESDE ),t.DESHASTA = isnull( d.DESHASTA, t.DESHASTA ),t.RECHASTA = isnull( d.RECHASTA, t.RECHASTA ),t.FPODESD = isnull( d.FPODESD, t.FPODESD ),t.FPODESH = isnull( d.FPODESH, t.FPODESH ),t.FPORECD = isnull( d.FPORECD, t.FPORECD ),t.FPORECH = isnull( d.FPORECH, t.FPORECH ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA )
					from ZooLogic.CACEPV t inner join deleted d 
							 on t.numero = d.numero
				-- Fin Updates
				insert into ZooLogic.CACEPV(Fecexpo,Fecimpo,Fectrans,Faltafw,Timestamp,Ualtafw,Umodifw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Bdaltafw,Haltafw,Horaexpo,Esttrans,Bdmodifw,Smodifw,Saltafw,Clobs,Numero,Cdesc,Comp,Sucdesde,Fmodifw,Hmodifw,Vdesde,Suchasta,Vhasta,Horadesde,Horahasta,Dialu,Diama,Clcfi,Diami,Diaju,Diavi,Diasa,Diado,Jjco,Cuotas,Cantdesde,Canthasta,Totaldesde,Totalhasta,Desdesde,Recdesde,Deshasta,Rechasta,Fpodesd,Fpodesh,Fporecd,Fporech,Codlista)
					Select isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.TIMESTAMP,0),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.CLOBS,''),isnull( d.NUMERO,0),isnull( d.CDESC,''),isnull( d.COMP,0),isnull( d.SUCDESDE,''),isnull( d.FMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VDESDE,''),isnull( d.SUCHASTA,''),isnull( d.VHASTA,''),isnull( d.HORADESDE,''),isnull( d.HORAHASTA,''),isnull( d.DIALU,0),isnull( d.DIAMA,0),isnull( d.CLCFI,0),isnull( d.DIAMI,0),isnull( d.DIAJU,0),isnull( d.DIAVI,0),isnull( d.DIASA,0),isnull( d.DIADO,0),isnull( d.JJCO,''),isnull( d.CUOTAS,0),isnull( d.CANTDESDE,0),isnull( d.CANTHASTA,0),isnull( d.TOTALDESDE,0),isnull( d.TOTALHASTA,0),isnull( d.DESDESDE,0),isnull( d.RECDESDE,0),isnull( d.DESHASTA,0),isnull( d.RECHASTA,0),isnull( d.FPODESD,0),isnull( d.FPODESH,0),isnull( d.FPORECD,0),isnull( d.FPORECH,0),isnull( d.CODLISTA,'')
						From deleted d left join ZooLogic.CACEPV pk 
							 on d.numero = pk.numero
						Where pk.numero Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_cacepv') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_cacepv
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CRITERIOSVALORES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CRITERIOSVALORES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CRITERIOSVALORES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CRITERIOSVALORES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CRITERIOSVALORES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_CRITERIOSVALORES.Timestamp, 0 )
					.Usuarioaltafw = nvl( c_CRITERIOSVALORES.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CRITERIOSVALORES.Usuariomodificacionfw, [] )
					.Horaimpo = nvl( c_CRITERIOSVALORES.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_CRITERIOSVALORES.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_CRITERIOSVALORES.Versionaltafw, [] )
					.Basededatosaltafw = nvl( c_CRITERIOSVALORES.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_CRITERIOSVALORES.Horaaltafw, [] )
					.Horaexpo = nvl( c_CRITERIOSVALORES.Horaexpo, [] )
					.Estadotransferencia = nvl( c_CRITERIOSVALORES.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_CRITERIOSVALORES.Basededatosmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CRITERIOSVALORES.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_CRITERIOSVALORES.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Numero = nvl( c_CRITERIOSVALORES.Numero, 0 )
					.Descripcion = nvl( c_CRITERIOSVALORES.Descripcion, [] )
					.Comportamiento = nvl( c_CRITERIOSVALORES.Comportamiento, 0 )
					.Sucursaldesde_PK =  nvl( c_CRITERIOSVALORES.Sucursaldesde, [] )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CRITERIOSVALORES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Horamodificacionfw = nvl( c_CRITERIOSVALORES.Horamodificacionfw, [] )
					.Vigenciadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CRITERIOSVALORES.Vigenciadesde, ctod( '  /  /    ' ) ) )
					.Sucursalhasta_PK =  nvl( c_CRITERIOSVALORES.Sucursalhasta, [] )
					.Vigenciahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CRITERIOSVALORES.Vigenciahasta, ctod( '  /  /    ' ) ) )
					.Horadesde = nvl( c_CRITERIOSVALORES.Horadesde, [] )
					.Horahasta = nvl( c_CRITERIOSVALORES.Horahasta, [] )
					.Dialu = nvl( c_CRITERIOSVALORES.Dialu, .F. )
					.Diama = nvl( c_CRITERIOSVALORES.Diama, .F. )
					.Tipo = nvl( c_CRITERIOSVALORES.Tipo, 0 )
					.Diami = nvl( c_CRITERIOSVALORES.Diami, .F. )
					.Diaju = nvl( c_CRITERIOSVALORES.Diaju, .F. )
					.Diavi = nvl( c_CRITERIOSVALORES.Diavi, .F. )
					.Diasa = nvl( c_CRITERIOSVALORES.Diasa, .F. )
					.Diado = nvl( c_CRITERIOSVALORES.Diado, .F. )
					.Valor_PK =  nvl( c_CRITERIOSVALORES.Valor, [] )
					.Cuotas = nvl( c_CRITERIOSVALORES.Cuotas, 0 )
					.Cantidadarticulosdesde = nvl( c_CRITERIOSVALORES.Cantidadarticulosdesde, 0 )
					.Cantidadarticuloshasta = nvl( c_CRITERIOSVALORES.Cantidadarticuloshasta, 0 )
					.Totaldesde = nvl( c_CRITERIOSVALORES.Totaldesde, 0 )
					.Totalhasta = nvl( c_CRITERIOSVALORES.Totalhasta, 0 )
					.Montodescuentodesde = nvl( c_CRITERIOSVALORES.Montodescuentodesde, 0 )
					.Montorecargodesde = nvl( c_CRITERIOSVALORES.Montorecargodesde, 0 )
					.Montodescuentohasta = nvl( c_CRITERIOSVALORES.Montodescuentohasta, 0 )
					.Montorecargohasta = nvl( c_CRITERIOSVALORES.Montorecargohasta, 0 )
					.Porcentajedescuentodesde = nvl( c_CRITERIOSVALORES.Porcentajedescuentodesde, 0 )
					.Porcentajedescuentohasta = nvl( c_CRITERIOSVALORES.Porcentajedescuentohasta, 0 )
					.Porcentajerecargodesde = nvl( c_CRITERIOSVALORES.Porcentajerecargodesde, 0 )
					.Porcentajerecargohasta = nvl( c_CRITERIOSVALORES.Porcentajerecargohasta, 0 )
					.Listadeprecios_PK =  nvl( c_CRITERIOSVALORES.Listadeprecios, [] )
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
		return c_CRITERIOSVALORES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CACEPV' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "numero"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,numero as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    numero from (
							select * 
								from ZooLogic.CACEPV 
								Where   CACEPV.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CACEPV", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "numero"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Clobs" as "Observacion", "Numero" as "Numero", "Cdesc" as "Descripcion", "Comp" as "Comportamiento", "Sucdesde" as "Sucursaldesde", "Fmodifw" as "Fechamodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vdesde" as "Vigenciadesde", "Suchasta" as "Sucursalhasta", "Vhasta" as "Vigenciahasta", "Horadesde" as "Horadesde", "Horahasta" as "Horahasta", "Dialu" as "Dialu", "Diama" as "Diama", "Clcfi" as "Tipo", "Diami" as "Diami", "Diaju" as "Diaju", "Diavi" as "Diavi", "Diasa" as "Diasa", "Diado" as "Diado", "Jjco" as "Valor", "Cuotas" as "Cuotas", "Cantdesde" as "Cantidadarticulosdesde", "Canthasta" as "Cantidadarticuloshasta", "Totaldesde" as "Totaldesde", "Totalhasta" as "Totalhasta", "Desdesde" as "Montodescuentodesde", "Recdesde" as "Montorecargodesde", "Deshasta" as "Montodescuentohasta", "Rechasta" as "Montorecargohasta", "Fpodesd" as "Porcentajedescuentodesde", "Fpodesh" as "Porcentajedescuentohasta", "Fporecd" as "Porcentajerecargodesde", "Fporech" as "Porcentajerecargohasta", "Codlista" as "Listadeprecios"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CACEPV 
								Where   CACEPV.NUMERO != 0
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
	Tabla = 'CACEPV'
	Filtro = " CACEPV.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CACEPV.NUMERO != 0"
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
	<row entidad="CRITERIOSVALORES                        " atributo="FECHAEXPO                               " tabla="CACEPV         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="FECHAIMPO                               " tabla="CACEPV         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="FECHATRANSFERENCIA                      " tabla="CACEPV         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="FECHAALTAFW                             " tabla="CACEPV         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="TIMESTAMP                               " tabla="CACEPV         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="USUARIOALTAFW                           " tabla="CACEPV         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="USUARIOMODIFICACIONFW                   " tabla="CACEPV         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="HORAIMPO                                " tabla="CACEPV         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="VERSIONMODIFICACIONFW                   " tabla="CACEPV         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="ZADSFW                                  " tabla="CACEPV         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="VERSIONALTAFW                           " tabla="CACEPV         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="BASEDEDATOSALTAFW                       " tabla="CACEPV         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="HORAALTAFW                              " tabla="CACEPV         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="HORAEXPO                                " tabla="CACEPV         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="ESTADOTRANSFERENCIA                     " tabla="CACEPV         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CACEPV         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="SERIEMODIFICACIONFW                     " tabla="CACEPV         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="SERIEALTAFW                             " tabla="CACEPV         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="OBSERVACION                             " tabla="CACEPV         " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="NUMERO                                  " tabla="CACEPV         " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Código                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="DESCRIPCION                             " tabla="CACEPV         " campo="CDESC     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="COMPORTAMIENTO                          " tabla="CACEPV         " campo="COMP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Comportamiento                                                                                                                                                  " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="SUCURSALDESDE                           " tabla="CACEPV         " campo="SUCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Sucursal                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="FECHAMODIFICACIONFW                     " tabla="CACEPV         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="HORAMODIFICACIONFW                      " tabla="CACEPV         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="VIGENCIADESDE                           " tabla="CACEPV         " campo="VDESDE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Fecha                                                                                                                                                           " dominio="EtiquetaFechaDesdeHasta       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="SUCURSALHASTA                           " tabla="CACEPV         " campo="SUCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="=replicate('Z',10)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="414" etiqueta="Sucursal                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="VIGENCIAHASTA                           " tabla="CACEPV         " campo="VHASTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Fecha hasta                                                                                                                                                     " dominio="EtiquetaFechaDesdeHasta       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="HORADESDE                               " tabla="CACEPV         " campo="HORADESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="0000                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="418" etiqueta="Hora                                                                                                                                                            " dominio="EtiquetaHoraDesdeHasta        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="HORAHASTA                               " tabla="CACEPV         " campo="HORAHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="2359                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="420" etiqueta="Hora hasta                                                                                                                                                      " dominio="EtiquetaHoraDesdeHasta        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="DIALU                                   " tabla="CACEPV         " campo="DIALU     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="422" etiqueta="Lunes                                                                                                                                                           " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="28" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="DIAMA                                   " tabla="CACEPV         " campo="DIAMA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="424" etiqueta="Martes                                                                                                                                                          " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="29" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="TIPO                                    " tabla="CACEPV         " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOTIPODEVALORESCONBLANCO   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="DIAMI                                   " tabla="CACEPV         " campo="DIAMI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="426" etiqueta="Miércoles                                                                                                                                                       " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="DIAJU                                   " tabla="CACEPV         " campo="DIAJU     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="428" etiqueta="Jueves                                                                                                                                                          " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="31" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="DIAVI                                   " tabla="CACEPV         " campo="DIAVI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="430" etiqueta="Viernes                                                                                                                                                         " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="32" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="DIASA                                   " tabla="CACEPV         " campo="DIASA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="432" etiqueta="Sábado                                                                                                                                                          " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="33" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="DIADO                                   " tabla="CACEPV         " campo="DIADO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="434" etiqueta="Domingo                                                                                                                                                         " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="34" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="VALOR                                   " tabla="CACEPV         " campo="JJCO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Valor                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="CUOTAS                                  " tabla="CACEPV         " campo="CUOTAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Cuotas                                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="CANTIDADARTICULOSDESDE                  " tabla="CACEPV         " campo="CANTDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Cantidad                                                                                                                                                        " dominio="EtiquetaCantidadDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="CANTIDADARTICULOSHASTA                  " tabla="CACEPV         " campo="CANTHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="9999999.99                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="442" etiqueta="Cantidad                                                                                                                                                        " dominio="EtiquetaCantidadDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="75" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="TOTALDESDE                              " tabla="CACEPV         " campo="TOTALDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Total                                                                                                                                                           " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="TOTALHASTA                              " tabla="CACEPV         " campo="TOTALHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="999999999999.99                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="10" etiqueta="Total                                                                                                                                                           " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="85" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="MONTODESCUENTODESDE                     " tabla="CACEPV         " campo="DESDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Monto descuento                                                                                                                                                 " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="MONTORECARGODESDE                       " tabla="CACEPV         " campo="RECDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Monto recargo                                                                                                                                                   " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="MONTODESCUENTOHASTA                     " tabla="CACEPV         " campo="DESHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="999999999999.99                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="448" etiqueta="Monto descuento 2                                                                                                                                               " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="95" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="MONTORECARGOHASTA                       " tabla="CACEPV         " campo="RECHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="999999999999.99                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="450" etiqueta="Monto recargo                                                                                                                                                   " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="95" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="PORCENTAJEDESCUENTODESDE                " tabla="CACEPV         " campo="FPODESD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Porcentaje descuento                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="100" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="PORCENTAJEDESCUENTOHASTA                " tabla="CACEPV         " campo="FPODESH   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="100.00                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="454" etiqueta="Des%                                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="105" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="PORCENTAJERECARGODESDE                  " tabla="CACEPV         " campo="FPORECD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Porcentaje recargo                                                                                                                                              " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="106" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="PORCENTAJERECARGOHASTA                  " tabla="CACEPV         " campo="FPORECH   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="100.00                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="458" etiqueta="Des%                                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="107" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CRITERIOSVALORES                        " atributo="LISTADEPRECIOS                          " tabla="CACEPV         " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="110" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="NOMBRE                                  " tabla="SUC            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Suc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On CACEPV.SUCDESDE = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="NOMBRE                                  " tabla="SUC            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Suc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On CACEPV.SUCHASTA = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVALORES       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVALORES On CACEPV.JJCO = XVALORES.CLCOD And  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="461" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On CACEPV.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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