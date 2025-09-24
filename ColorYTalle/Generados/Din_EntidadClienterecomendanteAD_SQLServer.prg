
define class Din_EntidadCLIENTERECOMENDANTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CLIENTERECOMENDANTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CLRPK'
	cTablaPrincipal = 'CLI'
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
			local  lxCliFaltafw, lxCliFectrans, lxCliFecimpo, lxCliFmodifw, lxCliFecexpo, lxCliCd1, lxCliClser, lxCliClfing, lxCliHaltafw, lxCliNomrecom, lxCliHmodifw, lxCliHoraimpo, lxCliSaltafw, lxCliGlobalid, lxCliCodrecom, lxCliUmodifw, lxCliCltlf, lxCliEsttrans, lxCliVmodifw, lxCliZadsfw, lxCliValtafw, lxCliClprov, lxCliUaltafw, lxCliSmodifw, lxCliClpin, lxCliHoraexpo, lxCliBdmodifw, lxCliBdaltafw, lxCliCltpo, lxCliCentid, lxCliInactivofw, lxCliClcod, lxCliClvend, lxCliClobs, lxCliPcuit, lxCliCltipodoc, lxCliClcalle, lxCliClmovil, lxCliClimpd, lxCliCliva, lxCliCltrans, lxCliClclas, lxCliClcodfant, lxCliClnrodoc, lxCliClcfi, lxCliClnro, lxCliClfax, lxCliCllisprec, lxCliCltipocli, lxCliClemail, lxCliClpiso, lxCliCnx1, lxCliClprinom, lxCliClcategcli, lxCliClco_dto, lxCliClfecha, lxCliClcuit, lxCliClpageweb, lxCliCldepto, lxCliCltopeccte, lxCliClacum, lxCliClsegnom, lxCliSexo, lxCliCltope, lxCliClloc, lxCliClapell, lxCliEstado, lxCliClcondpag, lxCliClcp, lxCliHijos, lxCliClnom, lxCliRut, lxCliClprv, lxCliClpais
				lxCliFaltafw =  .Fechaaltafw			lxCliFectrans =  .Fechatransferencia			lxCliFecimpo =  .Fechaimpo			lxCliFmodifw =  .Fechamodificacionfw			lxCliFecexpo =  .Fechaexpo			lxCliCd1 =  .Fechaultimamodificacion			lxCliClser =  .Clasificacion2			lxCliClfing =  .Fechadealta			lxCliHaltafw =  .Horaaltafw			lxCliNomrecom =  .Nombrerecomendante			lxCliHmodifw =  .Horamodificacionfw			lxCliHoraimpo =  .Horaimpo			lxCliSaltafw =  .Seriealtafw			lxCliGlobalid =  .Idglobal			lxCliCodrecom =  .Codrecomendante			lxCliUmodifw =  .Usuariomodificacionfw			lxCliCltlf =  .Telefono			lxCliEsttrans =  .Estadotransferencia			lxCliVmodifw =  .Versionmodificacionfw			lxCliZadsfw =  .Zadsfw			lxCliValtafw =  .Versionaltafw			lxCliClprov =  .Jurisdiccion			lxCliUaltafw =  .Usuarioaltafw			lxCliSmodifw =  .Seriemodificacionfw			lxCliClpin =  .Pin			lxCliHoraexpo =  .Horaexpo			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliBdaltafw =  .Basededatosaltafw			lxCliCltpo =  .Tipointerno			lxCliCentid =  .Idcentralizador			lxCliInactivofw =  .Inactivofw			lxCliClcod =  .Codigo			lxCliClvend =  upper( .Vendedor_PK ) 			lxCliClobs =  .Observacion			lxCliPcuit =  .Cuitpais			lxCliCltipodoc =  .Tipodocumento			lxCliClcalle =  .Calle			lxCliClmovil =  .Movil			lxCliClimpd =  .Clasificacionsecundaria			lxCliCliva =  .Situacionfiscal_PK 			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliClnrodoc =  .Nrodocumento			lxCliClcfi =  .Cfi			lxCliClnro =  .Numero			lxCliClfax =  .Fax			lxCliCllisprec =  upper( .ListaDePrecio_PK ) 			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliClemail =  .Email			lxCliClpiso =  .Piso			lxCliCnx1 =  .Credito			lxCliClprinom =  .Primernombre			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliClcuit =  .Cuit			lxCliClpageweb =  .Paginaweb			lxCliCldepto =  .Departamento			lxCliCltopeccte =  .Topectacte			lxCliClacum =  .Dolaresacumulados			lxCliClsegnom =  .Segundonombre			lxCliSexo =  .Sexo			lxCliCltope =  .Topefacturacion			lxCliClloc =  .Localidad			lxCliClapell =  .Apellido			lxCliEstado =  .Estadocivil			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClcp =  .Codigopostal			lxCliHijos =  .Hijos			lxCliClnom =  .Nombre			lxCliRut =  .Rut			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClpais =  upper( .Pais_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCliClcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CLI ( "Faltafw","Fectrans","Fecimpo","Fmodifw","Fecexpo","Cd1","Clser","Clfing","Haltafw","Nomrecom","Hmodifw","Horaimpo","Saltafw","Globalid","Codrecom","Umodifw","Cltlf","Esttrans","Vmodifw","Zadsfw","Valtafw","Clprov","Ualtafw","Smodifw","Clpin","Horaexpo","Bdmodifw","Bdaltafw","Cltpo","Centid","Inactivofw","Clcod","Clvend","Clobs","Pcuit","Cltipodoc","Clcalle","Clmovil","Climpd","Cliva","Cltrans","Clclas","Clcodfant","Clnrodoc","Clcfi","Clnro","Clfax","Cllisprec","Cltipocli","Clemail","Clpiso","Cnx1","Clprinom","Clcategcli","Clco_dto","Clfecha","Clcuit","Clpageweb","Cldepto","Cltopeccte","Clacum","Clsegnom","Sexo","Cltope","Clloc","Clapell","Estado","Clcondpag","Clcp","Hijos","Clnom","Rut","Clprv","Clpais" ) values ( <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'" >>, <<lxCliClser >>, <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliNomrecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCodrecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'" >>, <<lxCliCltpo >>, <<lxCliCentid >>, <<iif( lxCliInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClvend ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClmovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'" >>, <<lxCliCliva >>, <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'" >>, <<lxCliClcfi >>, <<lxCliClnro >>, <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCllisprec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'" >>, <<lxCliCnx1 >>, <<"'" + this.FormatearTextoSql( lxCliClprinom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'" >>, <<lxCliCltopeccte >>, <<lxCliClacum >>, <<"'" + this.FormatearTextoSql( lxCliClsegnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'" >>, <<lxCliCltope >>, <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClapell ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'" >>, <<lxCliHijos >>, <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Contacto
				if this.oEntidad.Contacto.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto = loItem.Contacto
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CONTACTODET("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxContacto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
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
			local  lxCliFaltafw, lxCliFectrans, lxCliFecimpo, lxCliFmodifw, lxCliFecexpo, lxCliCd1, lxCliClser, lxCliClfing, lxCliHaltafw, lxCliNomrecom, lxCliHmodifw, lxCliHoraimpo, lxCliSaltafw, lxCliGlobalid, lxCliCodrecom, lxCliUmodifw, lxCliCltlf, lxCliEsttrans, lxCliVmodifw, lxCliZadsfw, lxCliValtafw, lxCliClprov, lxCliUaltafw, lxCliSmodifw, lxCliClpin, lxCliHoraexpo, lxCliBdmodifw, lxCliBdaltafw, lxCliCltpo, lxCliCentid, lxCliInactivofw, lxCliClcod, lxCliClvend, lxCliClobs, lxCliPcuit, lxCliCltipodoc, lxCliClcalle, lxCliClmovil, lxCliClimpd, lxCliCliva, lxCliCltrans, lxCliClclas, lxCliClcodfant, lxCliClnrodoc, lxCliClcfi, lxCliClnro, lxCliClfax, lxCliCllisprec, lxCliCltipocli, lxCliClemail, lxCliClpiso, lxCliCnx1, lxCliClprinom, lxCliClcategcli, lxCliClco_dto, lxCliClfecha, lxCliClcuit, lxCliClpageweb, lxCliCldepto, lxCliCltopeccte, lxCliClacum, lxCliClsegnom, lxCliSexo, lxCliCltope, lxCliClloc, lxCliClapell, lxCliEstado, lxCliClcondpag, lxCliClcp, lxCliHijos, lxCliClnom, lxCliRut, lxCliClprv, lxCliClpais
				lxCliFaltafw =  .Fechaaltafw			lxCliFectrans =  .Fechatransferencia			lxCliFecimpo =  .Fechaimpo			lxCliFmodifw =  .Fechamodificacionfw			lxCliFecexpo =  .Fechaexpo			lxCliCd1 =  .Fechaultimamodificacion			lxCliClser =  .Clasificacion2			lxCliClfing =  .Fechadealta			lxCliHaltafw =  .Horaaltafw			lxCliNomrecom =  .Nombrerecomendante			lxCliHmodifw =  .Horamodificacionfw			lxCliHoraimpo =  .Horaimpo			lxCliSaltafw =  .Seriealtafw			lxCliGlobalid =  .Idglobal			lxCliCodrecom =  .Codrecomendante			lxCliUmodifw =  .Usuariomodificacionfw			lxCliCltlf =  .Telefono			lxCliEsttrans =  .Estadotransferencia			lxCliVmodifw =  .Versionmodificacionfw			lxCliZadsfw =  .Zadsfw			lxCliValtafw =  .Versionaltafw			lxCliClprov =  .Jurisdiccion			lxCliUaltafw =  .Usuarioaltafw			lxCliSmodifw =  .Seriemodificacionfw			lxCliClpin =  .Pin			lxCliHoraexpo =  .Horaexpo			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliBdaltafw =  .Basededatosaltafw			lxCliCltpo =  .Tipointerno			lxCliCentid =  .Idcentralizador			lxCliInactivofw =  .Inactivofw			lxCliClcod =  .Codigo			lxCliClvend =  upper( .Vendedor_PK ) 			lxCliClobs =  .Observacion			lxCliPcuit =  .Cuitpais			lxCliCltipodoc =  .Tipodocumento			lxCliClcalle =  .Calle			lxCliClmovil =  .Movil			lxCliClimpd =  .Clasificacionsecundaria			lxCliCliva =  .Situacionfiscal_PK 			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliClnrodoc =  .Nrodocumento			lxCliClcfi =  .Cfi			lxCliClnro =  .Numero			lxCliClfax =  .Fax			lxCliCllisprec =  upper( .ListaDePrecio_PK ) 			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliClemail =  .Email			lxCliClpiso =  .Piso			lxCliCnx1 =  .Credito			lxCliClprinom =  .Primernombre			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliClcuit =  .Cuit			lxCliClpageweb =  .Paginaweb			lxCliCldepto =  .Departamento			lxCliCltopeccte =  .Topectacte			lxCliClacum =  .Dolaresacumulados			lxCliClsegnom =  .Segundonombre			lxCliSexo =  .Sexo			lxCliCltope =  .Topefacturacion			lxCliClloc =  .Localidad			lxCliClapell =  .Apellido			lxCliEstado =  .Estadocivil			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClcp =  .Codigopostal			lxCliHijos =  .Hijos			lxCliClnom =  .Nombre			lxCliRut =  .Rut			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClpais =  upper( .Pais_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CLI set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'">>,"Cd1" = <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'">>,"Clser" = <<lxCliClser>>,"Clfing" = <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'">>,"Nomrecom" = <<"'" + this.FormatearTextoSql( lxCliNomrecom ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'">>,"Globalid" = <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'">>,"Codrecom" = <<"'" + this.FormatearTextoSql( lxCliCodrecom ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'">>,"Clprov" = <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'">>,"Clpin" = <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'">>,"Cltpo" = <<lxCliCltpo>>,"Centid" = <<lxCliCentid>>,"Inactivofw" = <<iif( lxCliInactivofw, 1, 0 )>>,"Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">>,"Clvend" = <<"'" + this.FormatearTextoSql( lxCliClvend ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'">>,"Pcuit" = <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'">>,"Cltipodoc" = <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'">>,"Clcalle" = <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'">>,"Clmovil" = <<"'" + this.FormatearTextoSql( lxCliClmovil ) + "'">>,"Climpd" = <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'">>,"Cliva" = <<lxCliCliva>>,"Cltrans" = <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'">>,"Clclas" = <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'">>,"Clcodfant" = <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'">>,"Clnrodoc" = <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'">>,"Clcfi" = <<lxCliClcfi>>,"Clnro" = <<lxCliClnro>>,"Clfax" = <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'">>,"Cllisprec" = <<"'" + this.FormatearTextoSql( lxCliCllisprec ) + "'">>,"Cltipocli" = <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'">>,"Clemail" = <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'">>,"Clpiso" = <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'">>,"Cnx1" = <<lxCliCnx1>>,"Clprinom" = <<"'" + this.FormatearTextoSql( lxCliClprinom ) + "'">>,"Clcategcli" = <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'">>,"Clco_dto" = <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'">>,"Clfecha" = <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'">>,"Clcuit" = <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'">>,"Clpageweb" = <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'">>,"Cldepto" = <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'">>,"Cltopeccte" = <<lxCliCltopeccte>>,"Clacum" = <<lxCliClacum>>,"Clsegnom" = <<"'" + this.FormatearTextoSql( lxCliClsegnom ) + "'">>,"Sexo" = <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'">>,"Cltope" = <<lxCliCltope>>,"Clloc" = <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'">>,"Clapell" = <<"'" + this.FormatearTextoSql( lxCliClapell ) + "'">>,"Estado" = <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'">>,"Clcondpag" = <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'">>,"Clcp" = <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'">>,"Hijos" = <<lxCliHijos>>,"Clnom" = <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'">>,"Rut" = <<"'" + this.FormatearTextoSql( lxCliRut ) + "'">>,"Clprv" = <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'">>,"Clpais" = <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'">> where "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">> and  CLI.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CONTACTODET where "CONCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Contacto
				if this.oEntidad.Contacto.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto = loItem.Contacto
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CONTACTODET("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxContacto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CLCOD from ZooLogic.CLI where " + this.ConvertirFuncionesSql( " CLI.CLCOD != ''" ) )
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
			Local lxCliClcod
			lxCliClcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Cd1" as "Fechaultimamodificacion", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Haltafw" as "Horaaltafw", "Nomrecom" as "Nombrerecomendante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Globalid" as "Idglobal", "Codrecom" as "Codrecomendante", "Umodifw" as "Usuariomodificacionfw", "Cltlf" as "Telefono", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Clprov" as "Jurisdiccion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Clpin" as "Pin", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clvend" as "Vendedor", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Cltipodoc" as "Tipodocumento", "Clcalle" as "Calle", "Clmovil" as "Movil", "Climpd" as "Clasificacionsecundaria", "Cliva" as "Situacionfiscal", "Cltrans" as "Transportista", "Clclas" as "Clasificacion", "Clcodfant" as "Codnombrefantasia", "Clnrodoc" as "Nrodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clfax" as "Fax", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Clemail" as "Email", "Clpiso" as "Piso", "Cnx1" as "Credito", "Clprinom" as "Primernombre", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clcuit" as "Cuit", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Cltopeccte" as "Topectacte", "Clacum" as "Dolaresacumulados", "Clsegnom" as "Segundonombre", "Sexo" as "Sexo", "Cltope" as "Topefacturacion", "Clloc" as "Localidad", "Clapell" as "Apellido", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clnom" as "Nombre", "Rut" as "Rut", "Clprv" as "Provincia", "Clpais" as "Pais" from ZooLogic.CLI where "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">> and  CLI.CLCOD != ''
			endtext
			use in select('c_CLIENTERECOMENDANTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTERECOMENDANTE', set( 'Datasession' ) )

			if reccount( 'c_CLIENTERECOMENDANTE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTERECOMENDANTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCliClcod as Variant
		llRetorno = .t.
		lxCliClcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CLI where "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">> and  CLI.CLCOD != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Cd1" as "Fechaultimamodificacion", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Haltafw" as "Horaaltafw", "Nomrecom" as "Nombrerecomendante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Globalid" as "Idglobal", "Codrecom" as "Codrecomendante", "Umodifw" as "Usuariomodificacionfw", "Cltlf" as "Telefono", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Clprov" as "Jurisdiccion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Clpin" as "Pin", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clvend" as "Vendedor", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Cltipodoc" as "Tipodocumento", "Clcalle" as "Calle", "Clmovil" as "Movil", "Climpd" as "Clasificacionsecundaria", "Cliva" as "Situacionfiscal", "Cltrans" as "Transportista", "Clclas" as "Clasificacion", "Clcodfant" as "Codnombrefantasia", "Clnrodoc" as "Nrodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clfax" as "Fax", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Clemail" as "Email", "Clpiso" as "Piso", "Cnx1" as "Credito", "Clprinom" as "Primernombre", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clcuit" as "Cuit", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Cltopeccte" as "Topectacte", "Clacum" as "Dolaresacumulados", "Clsegnom" as "Segundonombre", "Sexo" as "Sexo", "Cltope" as "Topefacturacion", "Clloc" as "Localidad", "Clapell" as "Apellido", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clnom" as "Nombre", "Rut" as "Rut", "Clprv" as "Provincia", "Clpais" as "Pais" from ZooLogic.CLI where  CLI.CLCOD != '' order by CLCOD
			endtext
			use in select('c_CLIENTERECOMENDANTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTERECOMENDANTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTERECOMENDANTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Cd1" as "Fechaultimamodificacion", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Haltafw" as "Horaaltafw", "Nomrecom" as "Nombrerecomendante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Globalid" as "Idglobal", "Codrecom" as "Codrecomendante", "Umodifw" as "Usuariomodificacionfw", "Cltlf" as "Telefono", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Clprov" as "Jurisdiccion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Clpin" as "Pin", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clvend" as "Vendedor", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Cltipodoc" as "Tipodocumento", "Clcalle" as "Calle", "Clmovil" as "Movil", "Climpd" as "Clasificacionsecundaria", "Cliva" as "Situacionfiscal", "Cltrans" as "Transportista", "Clclas" as "Clasificacion", "Clcodfant" as "Codnombrefantasia", "Clnrodoc" as "Nrodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clfax" as "Fax", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Clemail" as "Email", "Clpiso" as "Piso", "Cnx1" as "Credito", "Clprinom" as "Primernombre", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clcuit" as "Cuit", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Cltopeccte" as "Topectacte", "Clacum" as "Dolaresacumulados", "Clsegnom" as "Segundonombre", "Sexo" as "Sexo", "Cltope" as "Topefacturacion", "Clloc" as "Localidad", "Clapell" as "Apellido", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clnom" as "Nombre", "Rut" as "Rut", "Clprv" as "Provincia", "Clpais" as "Pais" from ZooLogic.CLI where  funciones.padr( CLCOD, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CLI.CLCOD != '' order by CLCOD
			endtext
			use in select('c_CLIENTERECOMENDANTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTERECOMENDANTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTERECOMENDANTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Cd1" as "Fechaultimamodificacion", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Haltafw" as "Horaaltafw", "Nomrecom" as "Nombrerecomendante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Globalid" as "Idglobal", "Codrecom" as "Codrecomendante", "Umodifw" as "Usuariomodificacionfw", "Cltlf" as "Telefono", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Clprov" as "Jurisdiccion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Clpin" as "Pin", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clvend" as "Vendedor", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Cltipodoc" as "Tipodocumento", "Clcalle" as "Calle", "Clmovil" as "Movil", "Climpd" as "Clasificacionsecundaria", "Cliva" as "Situacionfiscal", "Cltrans" as "Transportista", "Clclas" as "Clasificacion", "Clcodfant" as "Codnombrefantasia", "Clnrodoc" as "Nrodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clfax" as "Fax", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Clemail" as "Email", "Clpiso" as "Piso", "Cnx1" as "Credito", "Clprinom" as "Primernombre", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clcuit" as "Cuit", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Cltopeccte" as "Topectacte", "Clacum" as "Dolaresacumulados", "Clsegnom" as "Segundonombre", "Sexo" as "Sexo", "Cltope" as "Topefacturacion", "Clloc" as "Localidad", "Clapell" as "Apellido", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clnom" as "Nombre", "Rut" as "Rut", "Clprv" as "Provincia", "Clpais" as "Pais" from ZooLogic.CLI where  funciones.padr( CLCOD, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CLI.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_CLIENTERECOMENDANTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTERECOMENDANTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTERECOMENDANTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Cd1" as "Fechaultimamodificacion", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Haltafw" as "Horaaltafw", "Nomrecom" as "Nombrerecomendante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Globalid" as "Idglobal", "Codrecom" as "Codrecomendante", "Umodifw" as "Usuariomodificacionfw", "Cltlf" as "Telefono", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Clprov" as "Jurisdiccion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Clpin" as "Pin", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clvend" as "Vendedor", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Cltipodoc" as "Tipodocumento", "Clcalle" as "Calle", "Clmovil" as "Movil", "Climpd" as "Clasificacionsecundaria", "Cliva" as "Situacionfiscal", "Cltrans" as "Transportista", "Clclas" as "Clasificacion", "Clcodfant" as "Codnombrefantasia", "Clnrodoc" as "Nrodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clfax" as "Fax", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Clemail" as "Email", "Clpiso" as "Piso", "Cnx1" as "Credito", "Clprinom" as "Primernombre", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clcuit" as "Cuit", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Cltopeccte" as "Topectacte", "Clacum" as "Dolaresacumulados", "Clsegnom" as "Segundonombre", "Sexo" as "Sexo", "Cltope" as "Topefacturacion", "Clloc" as "Localidad", "Clapell" as "Apellido", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clnom" as "Nombre", "Rut" as "Rut", "Clprv" as "Provincia", "Clpais" as "Pais" from ZooLogic.CLI where  CLI.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_CLIENTERECOMENDANTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTERECOMENDANTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTERECOMENDANTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fecimpo,Fmodifw,Fecexpo,Cd1,Clser,Clfing,Haltafw,Nomrecom,Hmodifw,Horaimpo," + ;
"Saltafw,Globalid,Codrecom,Umodifw,Cltlf,Esttrans,Vmodifw,Zadsfw,Valtafw,Clprov,Ualtafw,Smodifw,Clpin" + ;
",Horaexpo,Bdmodifw,Bdaltafw,Cltpo,Centid,Inactivofw,Clcod,Clvend,Clobs,Pcuit,Cltipodoc,Clcalle,Clmov" + ;
"il,Climpd,Cliva,Cltrans,Clclas,Clcodfant,Clnrodoc,Clcfi,Clnro,Clfax,Cllisprec,Cltipocli,Clemail,Clpi" + ;
"so,Cnx1,Clprinom,Clcategcli,Clco_dto,Clfecha,Clcuit,Clpageweb,Cldepto,Cltopeccte,Clacum,Clsegnom,Sex" + ;
"o,Cltope,Clloc,Clapell,Estado,Clcondpag,Clcp,Hijos,Clnom,Rut,Clprv,Clpais" + ;
" from ZooLogic.CLI where  CLI.CLCOD != '' and " + lcFiltro )
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
			local  lxCliFaltafw, lxCliFectrans, lxCliFecimpo, lxCliFmodifw, lxCliFecexpo, lxCliCd1, lxCliClser, lxCliClfing, lxCliHaltafw, lxCliNomrecom, lxCliHmodifw, lxCliHoraimpo, lxCliSaltafw, lxCliGlobalid, lxCliCodrecom, lxCliUmodifw, lxCliCltlf, lxCliEsttrans, lxCliVmodifw, lxCliZadsfw, lxCliValtafw, lxCliClprov, lxCliUaltafw, lxCliSmodifw, lxCliClpin, lxCliHoraexpo, lxCliBdmodifw, lxCliBdaltafw, lxCliCltpo, lxCliCentid, lxCliInactivofw, lxCliClcod, lxCliClvend, lxCliClobs, lxCliPcuit, lxCliCltipodoc, lxCliClcalle, lxCliClmovil, lxCliClimpd, lxCliCliva, lxCliCltrans, lxCliClclas, lxCliClcodfant, lxCliClnrodoc, lxCliClcfi, lxCliClnro, lxCliClfax, lxCliCllisprec, lxCliCltipocli, lxCliClemail, lxCliClpiso, lxCliCnx1, lxCliClprinom, lxCliClcategcli, lxCliClco_dto, lxCliClfecha, lxCliClcuit, lxCliClpageweb, lxCliCldepto, lxCliCltopeccte, lxCliClacum, lxCliClsegnom, lxCliSexo, lxCliCltope, lxCliClloc, lxCliClapell, lxCliEstado, lxCliClcondpag, lxCliClcp, lxCliHijos, lxCliClnom, lxCliRut, lxCliClprv, lxCliClpais
				lxCliFaltafw = ctod( '  /  /    ' )			lxCliFectrans = ctod( '  /  /    ' )			lxCliFecimpo = ctod( '  /  /    ' )			lxCliFmodifw = ctod( '  /  /    ' )			lxCliFecexpo = ctod( '  /  /    ' )			lxCliCd1 = ctod( '  /  /    ' )			lxCliClser = 0			lxCliClfing = ctod( '  /  /    ' )			lxCliHaltafw = []			lxCliNomrecom = []			lxCliHmodifw = []			lxCliHoraimpo = []			lxCliSaltafw = []			lxCliGlobalid = []			lxCliCodrecom = []			lxCliUmodifw = []			lxCliCltlf = []			lxCliEsttrans = []			lxCliVmodifw = []			lxCliZadsfw = []			lxCliValtafw = []			lxCliClprov = []			lxCliUaltafw = []			lxCliSmodifw = []			lxCliClpin = []			lxCliHoraexpo = []			lxCliBdmodifw = []			lxCliBdaltafw = []			lxCliCltpo = 0			lxCliCentid = 0			lxCliInactivofw = .F.			lxCliClcod = []			lxCliClvend = []			lxCliClobs = []			lxCliPcuit = []			lxCliCltipodoc = []			lxCliClcalle = []			lxCliClmovil = []			lxCliClimpd = []			lxCliCliva = 0			lxCliCltrans = []			lxCliClclas = []			lxCliClcodfant = []			lxCliClnrodoc = []			lxCliClcfi = 0			lxCliClnro = 0			lxCliClfax = []			lxCliCllisprec = []			lxCliCltipocli = []			lxCliClemail = []			lxCliClpiso = []			lxCliCnx1 = 0			lxCliClprinom = []			lxCliClcategcli = []			lxCliClco_dto = []			lxCliClfecha = ctod( '  /  /    ' )			lxCliClcuit = []			lxCliClpageweb = []			lxCliCldepto = []			lxCliCltopeccte = 0			lxCliClacum = 0			lxCliClsegnom = []			lxCliSexo = []			lxCliCltope = 0			lxCliClloc = []			lxCliClapell = []			lxCliEstado = []			lxCliClcondpag = []			lxCliClcp = []			lxCliHijos = 0			lxCliClnom = []			lxCliRut = []			lxCliClprv = []			lxCliClpais = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CONTACTODET where "CONCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CLI where "CLCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CLI' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CLCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CLCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CLI.CLCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Cd1" as "Fechaultimamodificacion", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Haltafw" as "Horaaltafw", "Nomrecom" as "Nombrerecomendante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Globalid" as "Idglobal", "Codrecom" as "Codrecomendante", "Umodifw" as "Usuariomodificacionfw", "Cltlf" as "Telefono", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Clprov" as "Jurisdiccion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Clpin" as "Pin", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clvend" as "Vendedor", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Cltipodoc" as "Tipodocumento", "Clcalle" as "Calle", "Clmovil" as "Movil", "Climpd" as "Clasificacionsecundaria", "Cliva" as "Situacionfiscal", "Cltrans" as "Transportista", "Clclas" as "Clasificacion", "Clcodfant" as "Codnombrefantasia", "Clnrodoc" as "Nrodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clfax" as "Fax", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Clemail" as "Email", "Clpiso" as "Piso", "Cnx1" as "Credito", "Clprinom" as "Primernombre", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clcuit" as "Cuit", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Cltopeccte" as "Topectacte", "Clacum" as "Dolaresacumulados", "Clsegnom" as "Segundonombre", "Sexo" as "Sexo", "Cltope" as "Topefacturacion", "Clloc" as "Localidad", "Clapell" as "Apellido", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clnom" as "Nombre", "Rut" as "Rut", "Clprv" as "Provincia", "Clpais" as "Pais"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CLI', '', tnTope )
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
	Function ObtenerDatosDetalleContacto( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CONTACTODET.CONCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleContacto( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CONTACTODET', 'Contacto', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleContacto( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleContacto( lcAtributo )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAULTIMAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CD1 AS FECHAULTIMAMODIFICACION'
				Case lcAtributo == 'CLASIFICACION2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSER AS CLASIFICACION2'
				Case lcAtributo == 'FECHADEALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFING AS FECHADEALTA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'NOMBRERECOMENDANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMRECOM AS NOMBRERECOMENDANTE'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'IDGLOBAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GLOBALID AS IDGLOBAL'
				Case lcAtributo == 'CODRECOMENDANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODRECOM AS CODRECOMENDANTE'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPROV AS JURISDICCION'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'PIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPIN AS PIN'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'TIPOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTPO AS TIPOINTERNO'
				Case lcAtributo == 'IDCENTRALIZADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTID AS IDCENTRALIZADOR'
				Case lcAtributo == 'INACTIVOFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INACTIVOFW AS INACTIVOFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVEND AS VENDEDOR'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'CUITPAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUIT AS CUITPAIS'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCALLE AS CALLE'
				Case lcAtributo == 'MOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMOVIL AS MOVIL'
				Case lcAtributo == 'CLASIFICACIONSECUNDARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIMPD AS CLASIFICACIONSECUNDARIA'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIVA AS SITUACIONFISCAL'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTRANS AS TRANSPORTISTA'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCLAS AS CLASIFICACION'
				Case lcAtributo == 'CODNOMBREFANTASIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCODFANT AS CODNOMBREFANTASIA'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'CFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS CFI'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRO AS NUMERO'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFAX AS FAX'
				Case lcAtributo == 'LISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLISPREC AS LISTADEPRECIO'
				Case lcAtributo == 'TIPOCLI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPOCLI AS TIPOCLI'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPISO AS PISO'
				Case lcAtributo == 'CREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNX1 AS CREDITO'
				Case lcAtributo == 'PRIMERNOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRINOM AS PRIMERNOMBRE'
				Case lcAtributo == 'CATEGCLI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCATEGCLI AS CATEGCLI'
				Case lcAtributo == 'DESCUENTOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCO_DTO AS DESCUENTOPREFERENTE'
				Case lcAtributo == 'FECHANACIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFECHA AS FECHANACIMIENTO'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCUIT AS CUIT'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'TOPECTACTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTOPECCTE AS TOPECTACTE'
				Case lcAtributo == 'DOLARESACUMULADOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLACUM AS DOLARESACUMULADOS'
				Case lcAtributo == 'SEGUNDONOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSEGNOM AS SEGUNDONOMBRE'
				Case lcAtributo == 'SEXO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEXO AS SEXO'
				Case lcAtributo == 'TOPEFACTURACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTOPE AS TOPEFACTURACION'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'APELLIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAPELL AS APELLIDO'
				Case lcAtributo == 'ESTADOCIVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADOCIVIL'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCONDPAG AS CONDICIONDEPAGO'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'HIJOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HIJOS AS HIJOS'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'RUT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUT AS RUT'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAIS AS PAIS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleContacto( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCOD AS CODIGO'
				Case lcAtributo == 'CONTACTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCON AS CONTACTO'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONNOM AS NOMBRE'
				Case lcAtributo == 'TELEFONOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONTEL AS TELEFONOS'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONMAIL AS EMAIL'
				Case lcAtributo == 'NOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONNOT AS NOTAS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTIMAMODIFICACION'
				lcCampo = 'CD1'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION2'
				lcCampo = 'CLSER'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADEALTA'
				lcCampo = 'CLFING'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRERECOMENDANTE'
				lcCampo = 'NOMRECOM'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'IDGLOBAL'
				lcCampo = 'GLOBALID'
			Case upper( alltrim( tcAtributo ) ) == 'CODRECOMENDANTE'
				lcCampo = 'CODRECOM'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'CLPROV'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'PIN'
				lcCampo = 'CLPIN'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO'
				lcCampo = 'CLTPO'
			Case upper( alltrim( tcAtributo ) ) == 'IDCENTRALIZADOR'
				lcCampo = 'CENTID'
			Case upper( alltrim( tcAtributo ) ) == 'INACTIVOFW'
				lcCampo = 'INACTIVOFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'CLVEND'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CUITPAIS'
				lcCampo = 'PCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'CLTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'CLCALLE'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIL'
				lcCampo = 'CLMOVIL'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACIONSECUNDARIA'
				lcCampo = 'CLIMPD'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'CLIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'CLTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLCLAS'
			Case upper( alltrim( tcAtributo ) ) == 'CODNOMBREFANTASIA'
				lcCampo = 'CLCODFANT'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CLNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CFI'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CLNRO'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'CLFAX'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIO'
				lcCampo = 'CLLISPREC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCLI'
				lcCampo = 'CLTIPOCLI'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'CLPISO'
			Case upper( alltrim( tcAtributo ) ) == 'CREDITO'
				lcCampo = 'CNX1'
			Case upper( alltrim( tcAtributo ) ) == 'PRIMERNOMBRE'
				lcCampo = 'CLPRINOM'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGCLI'
				lcCampo = 'CLCATEGCLI'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPREFERENTE'
				lcCampo = 'CLCO_DTO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANACIMIENTO'
				lcCampo = 'CLFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CLCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'CLPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'CLDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'TOPECTACTE'
				lcCampo = 'CLTOPECCTE'
			Case upper( alltrim( tcAtributo ) ) == 'DOLARESACUMULADOS'
				lcCampo = 'CLACUM'
			Case upper( alltrim( tcAtributo ) ) == 'SEGUNDONOMBRE'
				lcCampo = 'CLSEGNOM'
			Case upper( alltrim( tcAtributo ) ) == 'SEXO'
				lcCampo = 'SEXO'
			Case upper( alltrim( tcAtributo ) ) == 'TOPEFACTURACION'
				lcCampo = 'CLTOPE'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'APELLIDO'
				lcCampo = 'CLAPELL'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOCIVIL'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CLCONDPAG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'HIJOS'
				lcCampo = 'HIJOS'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'RUT'
				lcCampo = 'RUT'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'CLPAIS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleContacto( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CONCOD'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTO'
				lcCampo = 'CONCON'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CONNOM'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONOS'
				lcCampo = 'CONTEL'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CONMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'NOTAS'
				lcCampo = 'CONNOT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'CONTACTO'
			lcRetorno = 'CONTACTODET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCliFaltafw, lxCliFectrans, lxCliFecimpo, lxCliFmodifw, lxCliFecexpo, lxCliCd1, lxCliClser, lxCliClfing, lxCliHaltafw, lxCliNomrecom, lxCliHmodifw, lxCliHoraimpo, lxCliSaltafw, lxCliGlobalid, lxCliCodrecom, lxCliUmodifw, lxCliCltlf, lxCliEsttrans, lxCliVmodifw, lxCliZadsfw, lxCliValtafw, lxCliClprov, lxCliUaltafw, lxCliSmodifw, lxCliClpin, lxCliHoraexpo, lxCliBdmodifw, lxCliBdaltafw, lxCliCltpo, lxCliCentid, lxCliInactivofw, lxCliClcod, lxCliClvend, lxCliClobs, lxCliPcuit, lxCliCltipodoc, lxCliClcalle, lxCliClmovil, lxCliClimpd, lxCliCliva, lxCliCltrans, lxCliClclas, lxCliClcodfant, lxCliClnrodoc, lxCliClcfi, lxCliClnro, lxCliClfax, lxCliCllisprec, lxCliCltipocli, lxCliClemail, lxCliClpiso, lxCliCnx1, lxCliClprinom, lxCliClcategcli, lxCliClco_dto, lxCliClfecha, lxCliClcuit, lxCliClpageweb, lxCliCldepto, lxCliCltopeccte, lxCliClacum, lxCliClsegnom, lxCliSexo, lxCliCltope, lxCliClloc, lxCliClapell, lxCliEstado, lxCliClcondpag, lxCliClcp, lxCliHijos, lxCliClnom, lxCliRut, lxCliClprv, lxCliClpais
				lxCliFaltafw =  .Fechaaltafw			lxCliFectrans =  .Fechatransferencia			lxCliFecimpo =  .Fechaimpo			lxCliFmodifw =  .Fechamodificacionfw			lxCliFecexpo =  .Fechaexpo			lxCliCd1 =  .Fechaultimamodificacion			lxCliClser =  .Clasificacion2			lxCliClfing =  .Fechadealta			lxCliHaltafw =  .Horaaltafw			lxCliNomrecom =  .Nombrerecomendante			lxCliHmodifw =  .Horamodificacionfw			lxCliHoraimpo =  .Horaimpo			lxCliSaltafw =  .Seriealtafw			lxCliGlobalid =  .Idglobal			lxCliCodrecom =  .Codrecomendante			lxCliUmodifw =  .Usuariomodificacionfw			lxCliCltlf =  .Telefono			lxCliEsttrans =  .Estadotransferencia			lxCliVmodifw =  .Versionmodificacionfw			lxCliZadsfw =  .Zadsfw			lxCliValtafw =  .Versionaltafw			lxCliClprov =  .Jurisdiccion			lxCliUaltafw =  .Usuarioaltafw			lxCliSmodifw =  .Seriemodificacionfw			lxCliClpin =  .Pin			lxCliHoraexpo =  .Horaexpo			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliBdaltafw =  .Basededatosaltafw			lxCliCltpo =  .Tipointerno			lxCliCentid =  .Idcentralizador			lxCliInactivofw =  .Inactivofw			lxCliClcod =  .Codigo			lxCliClvend =  upper( .Vendedor_PK ) 			lxCliClobs =  .Observacion			lxCliPcuit =  .Cuitpais			lxCliCltipodoc =  .Tipodocumento			lxCliClcalle =  .Calle			lxCliClmovil =  .Movil			lxCliClimpd =  .Clasificacionsecundaria			lxCliCliva =  .Situacionfiscal_PK 			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliClnrodoc =  .Nrodocumento			lxCliClcfi =  .Cfi			lxCliClnro =  .Numero			lxCliClfax =  .Fax			lxCliCllisprec =  upper( .ListaDePrecio_PK ) 			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliClemail =  .Email			lxCliClpiso =  .Piso			lxCliCnx1 =  .Credito			lxCliClprinom =  .Primernombre			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliClcuit =  .Cuit			lxCliClpageweb =  .Paginaweb			lxCliCldepto =  .Departamento			lxCliCltopeccte =  .Topectacte			lxCliClacum =  .Dolaresacumulados			lxCliClsegnom =  .Segundonombre			lxCliSexo =  .Sexo			lxCliCltope =  .Topefacturacion			lxCliClloc =  .Localidad			lxCliClapell =  .Apellido			lxCliEstado =  .Estadocivil			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClcp =  .Codigopostal			lxCliHijos =  .Hijos			lxCliClnom =  .Nombre			lxCliRut =  .Rut			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClpais =  upper( .Pais_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CLI ( "Faltafw","Fectrans","Fecimpo","Fmodifw","Fecexpo","Cd1","Clser","Clfing","Haltafw","Nomrecom","Hmodifw","Horaimpo","Saltafw","Globalid","Codrecom","Umodifw","Cltlf","Esttrans","Vmodifw","Zadsfw","Valtafw","Clprov","Ualtafw","Smodifw","Clpin","Horaexpo","Bdmodifw","Bdaltafw","Cltpo","Centid","Inactivofw","Clcod","Clvend","Clobs","Pcuit","Cltipodoc","Clcalle","Clmovil","Climpd","Cliva","Cltrans","Clclas","Clcodfant","Clnrodoc","Clcfi","Clnro","Clfax","Cllisprec","Cltipocli","Clemail","Clpiso","Cnx1","Clprinom","Clcategcli","Clco_dto","Clfecha","Clcuit","Clpageweb","Cldepto","Cltopeccte","Clacum","Clsegnom","Sexo","Cltope","Clloc","Clapell","Estado","Clcondpag","Clcp","Hijos","Clnom","Rut","Clprv","Clpais" ) values ( <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'" >>, <<lxCliClser >>, <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliNomrecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCodrecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'" >>, <<lxCliCltpo >>, <<lxCliCentid >>, <<iif( lxCliInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClvend ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClmovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'" >>, <<lxCliCliva >>, <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'" >>, <<lxCliClcfi >>, <<lxCliClnro >>, <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCllisprec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'" >>, <<lxCliCnx1 >>, <<"'" + this.FormatearTextoSql( lxCliClprinom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'" >>, <<lxCliCltopeccte >>, <<lxCliClacum >>, <<"'" + this.FormatearTextoSql( lxCliClsegnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'" >>, <<lxCliCltope >>, <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClapell ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'" >>, <<lxCliHijos >>, <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CLI' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Contacto
				if this.oEntidad.Contacto.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto = loItem.Contacto
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CONTACTODET("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxContacto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
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
			local  lxCliFaltafw, lxCliFectrans, lxCliFecimpo, lxCliFmodifw, lxCliFecexpo, lxCliCd1, lxCliClser, lxCliClfing, lxCliHaltafw, lxCliNomrecom, lxCliHmodifw, lxCliHoraimpo, lxCliSaltafw, lxCliGlobalid, lxCliCodrecom, lxCliUmodifw, lxCliCltlf, lxCliEsttrans, lxCliVmodifw, lxCliZadsfw, lxCliValtafw, lxCliClprov, lxCliUaltafw, lxCliSmodifw, lxCliClpin, lxCliHoraexpo, lxCliBdmodifw, lxCliBdaltafw, lxCliCltpo, lxCliCentid, lxCliInactivofw, lxCliClcod, lxCliClvend, lxCliClobs, lxCliPcuit, lxCliCltipodoc, lxCliClcalle, lxCliClmovil, lxCliClimpd, lxCliCliva, lxCliCltrans, lxCliClclas, lxCliClcodfant, lxCliClnrodoc, lxCliClcfi, lxCliClnro, lxCliClfax, lxCliCllisprec, lxCliCltipocli, lxCliClemail, lxCliClpiso, lxCliCnx1, lxCliClprinom, lxCliClcategcli, lxCliClco_dto, lxCliClfecha, lxCliClcuit, lxCliClpageweb, lxCliCldepto, lxCliCltopeccte, lxCliClacum, lxCliClsegnom, lxCliSexo, lxCliCltope, lxCliClloc, lxCliClapell, lxCliEstado, lxCliClcondpag, lxCliClcp, lxCliHijos, lxCliClnom, lxCliRut, lxCliClprv, lxCliClpais
				lxCliFaltafw =  .Fechaaltafw			lxCliFectrans =  .Fechatransferencia			lxCliFecimpo =  .Fechaimpo			lxCliFmodifw =  .Fechamodificacionfw			lxCliFecexpo =  .Fechaexpo			lxCliCd1 =  .Fechaultimamodificacion			lxCliClser =  .Clasificacion2			lxCliClfing =  .Fechadealta			lxCliHaltafw =  .Horaaltafw			lxCliNomrecom =  .Nombrerecomendante			lxCliHmodifw =  .Horamodificacionfw			lxCliHoraimpo =  .Horaimpo			lxCliSaltafw =  .Seriealtafw			lxCliGlobalid =  .Idglobal			lxCliCodrecom =  .Codrecomendante			lxCliUmodifw =  .Usuariomodificacionfw			lxCliCltlf =  .Telefono			lxCliEsttrans =  .Estadotransferencia			lxCliVmodifw =  .Versionmodificacionfw			lxCliZadsfw =  .Zadsfw			lxCliValtafw =  .Versionaltafw			lxCliClprov =  .Jurisdiccion			lxCliUaltafw =  .Usuarioaltafw			lxCliSmodifw =  .Seriemodificacionfw			lxCliClpin =  .Pin			lxCliHoraexpo =  .Horaexpo			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliBdaltafw =  .Basededatosaltafw			lxCliCltpo =  .Tipointerno			lxCliCentid =  .Idcentralizador			lxCliInactivofw =  .Inactivofw			lxCliClcod =  .Codigo			lxCliClvend =  upper( .Vendedor_PK ) 			lxCliClobs =  .Observacion			lxCliPcuit =  .Cuitpais			lxCliCltipodoc =  .Tipodocumento			lxCliClcalle =  .Calle			lxCliClmovil =  .Movil			lxCliClimpd =  .Clasificacionsecundaria			lxCliCliva =  .Situacionfiscal_PK 			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliClnrodoc =  .Nrodocumento			lxCliClcfi =  .Cfi			lxCliClnro =  .Numero			lxCliClfax =  .Fax			lxCliCllisprec =  upper( .ListaDePrecio_PK ) 			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliClemail =  .Email			lxCliClpiso =  .Piso			lxCliCnx1 =  .Credito			lxCliClprinom =  .Primernombre			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliClcuit =  .Cuit			lxCliClpageweb =  .Paginaweb			lxCliCldepto =  .Departamento			lxCliCltopeccte =  .Topectacte			lxCliClacum =  .Dolaresacumulados			lxCliClsegnom =  .Segundonombre			lxCliSexo =  .Sexo			lxCliCltope =  .Topefacturacion			lxCliClloc =  .Localidad			lxCliClapell =  .Apellido			lxCliEstado =  .Estadocivil			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClcp =  .Codigopostal			lxCliHijos =  .Hijos			lxCliClnom =  .Nombre			lxCliRut =  .Rut			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClpais =  upper( .Pais_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  CLI.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CLI set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'">>, "Cd1" = <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'">>, "Clser" = <<lxCliClser>>, "Clfing" = <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'">>, "Nomrecom" = <<"'" + this.FormatearTextoSql( lxCliNomrecom ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'">>, "Globalid" = <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'">>, "Codrecom" = <<"'" + this.FormatearTextoSql( lxCliCodrecom ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'">>, "Clprov" = <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'">>, "Clpin" = <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'">>, "Cltpo" = <<lxCliCltpo>>, "Centid" = <<lxCliCentid>>, "Inactivofw" = <<iif( lxCliInactivofw, 1, 0 )>>, "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">>, "Clvend" = <<"'" + this.FormatearTextoSql( lxCliClvend ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'">>, "Pcuit" = <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'">>, "Cltipodoc" = <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'">>, "Clcalle" = <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'">>, "Clmovil" = <<"'" + this.FormatearTextoSql( lxCliClmovil ) + "'">>, "Climpd" = <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'">>, "Cliva" = <<lxCliCliva>>, "Cltrans" = <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'">>, "Clclas" = <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'">>, "Clcodfant" = <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'">>, "Clnrodoc" = <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'">>, "Clcfi" = <<lxCliClcfi>>, "Clnro" = <<lxCliClnro>>, "Clfax" = <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'">>, "Cllisprec" = <<"'" + this.FormatearTextoSql( lxCliCllisprec ) + "'">>, "Cltipocli" = <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'">>, "Clemail" = <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'">>, "Clpiso" = <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'">>, "Cnx1" = <<lxCliCnx1>>, "Clprinom" = <<"'" + this.FormatearTextoSql( lxCliClprinom ) + "'">>, "Clcategcli" = <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'">>, "Clco_dto" = <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'">>, "Clfecha" = <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'">>, "Clcuit" = <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'">>, "Clpageweb" = <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'">>, "Cldepto" = <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'">>, "Cltopeccte" = <<lxCliCltopeccte>>, "Clacum" = <<lxCliClacum>>, "Clsegnom" = <<"'" + this.FormatearTextoSql( lxCliClsegnom ) + "'">>, "Sexo" = <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'">>, "Cltope" = <<lxCliCltope>>, "Clloc" = <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'">>, "Clapell" = <<"'" + this.FormatearTextoSql( lxCliClapell ) + "'">>, "Estado" = <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'">>, "Clcondpag" = <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'">>, "Clcp" = <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'">>, "Hijos" = <<lxCliHijos>>, "Clnom" = <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'">>, "Rut" = <<"'" + this.FormatearTextoSql( lxCliRut ) + "'">>, "Clprv" = <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'">>, "Clpais" = <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CLI' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CONTACTODET where "CONCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Contacto
				if this.oEntidad.Contacto.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto = loItem.Contacto
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CONTACTODET("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxContacto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
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

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  CLI.CLCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.CLI where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CONTACTODET where "CONCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CLI' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CLI where  CLI.CLCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CLI where CLCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CLI.CLCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCLICLIVA as variant, lxCLICLCLAS as variant, lxCLICLLisPrec as variant, lxCLICLCUIT as variant, lxCLICLTOPECCTE as variant, lxCLIRUT as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTERECOMENDANTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CLI Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CLI set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, CD1 = ] + "'" + this.ConvertirDateSql( &lcCursor..CD1 ) + "'"+ [, CLSER = ] + transform( &lcCursor..CLSER )+ [, CLFING = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'"+ [, NOMRECOM = ] + "'" + this.FormatearTextoSql( &lcCursor..NOMRECOM ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, globalid = ] + "'" + this.FormatearTextoSql( &lcCursor..globalid ) + "'"+ [, CODRECOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CODRECOM ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, CLPROV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPROV ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, CLPIN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPIN ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CLTPO = ] + transform( &lcCursor..CLTPO )+ [, centid = ] + transform( &lcCursor..centid )+ [, InactivoFW = ] + Transform( iif( &lcCursor..InactivoFW, 1, 0 ))+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLVend = ] + "'" + this.FormatearTextoSql( &lcCursor..CLVend ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, PCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUIT ) + "'"+ [, CLTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"+ [, CLCalle = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCalle ) + "'"+ [, CLMovil = ] + "'" + this.FormatearTextoSql( &lcCursor..CLMovil ) + "'"+ [, CLIMPD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'"+ [, CLIVA = ] + transform( &lcCursor..CLIVA )+ [, CLTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTRANS ) + "'"+ [, CLCLAS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'"+ [, CLCODFANT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANT ) + "'"+ [, CLNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'"+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, CLNro = ] + transform( &lcCursor..CLNro )+ [, CLFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"+ [, CLLisPrec = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLisPrec ) + "'"+ [, CLTipoCli = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCli ) + "'"+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"+ [, ClPiso = ] + "'" + this.FormatearTextoSql( &lcCursor..ClPiso ) + "'"+ [, CNX1 = ] + transform( &lcCursor..CNX1 )+ [, CLPRINOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRINOM ) + "'"+ [, CLCategCli = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCategCli ) + "'"+ [, CLCO_DTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCO_DTO ) + "'"+ [, CLFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'"+ [, CLCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"+ [, CLPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'"+ [, CLDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'"+ [, CLTOPECCTE = ] + transform( &lcCursor..CLTOPECCTE )+ [, CLACUM = ] + transform( &lcCursor..CLACUM )+ [, CLSEGNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLSEGNOM ) + "'"+ [, Sexo = ] + "'" + this.FormatearTextoSql( &lcCursor..Sexo ) + "'"+ [, CLTOPE = ] + transform( &lcCursor..CLTOPE )+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLAPELL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLAPELL ) + "'"+ [, Estado = ] + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"+ [, CLCONDPAG = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'"+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, Hijos = ] + transform( &lcCursor..Hijos )+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, RUT = ] + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'"+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"+ [, CLPAIS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAIS ) + "'" + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FALTAFW, FECTRANS, FECIMPO, FMODIFW, FECEXPO, CD1, CLSER, CLFING, HALTAFW, NOMRECOM, HMODIFW, HORAIMPO, SALTAFW, globalid, CODRECOM, UMODIFW, CLTLF, ESTTRANS, VMODIFW, ZADSFW, VALTAFW, CLPROV, UALTAFW, SMODIFW, CLPIN, HORAEXPO, BDMODIFW, BDALTAFW, CLTPO, centid, InactivoFW, CLCOD, CLVend, CLOBS, PCUIT, CLTIPODOC, CLCalle, CLMovil, CLIMPD, CLIVA, CLTRANS, CLCLAS, CLCODFANT, CLNRODOC, CLCFI, CLNro, CLFAX, CLLisPrec, CLTipoCli, CLEMAIL, ClPiso, CNX1, CLPRINOM, CLCategCli, CLCO_DTO, CLFECHA, CLCUIT, CLPAGEWEB, CLDEPTO, CLTOPECCTE, CLACUM, CLSEGNOM, Sexo, CLTOPE, CLLOC, CLAPELL, Estado, CLCONDPAG, CLCP, Hijos, CLNOM, RUT, CLPRV, CLPAIS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CD1 ) + "'" + ',' + transform( &lcCursor..CLSER )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NOMRECOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..globalid ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODRECOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPROV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPIN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLTPO ) + ',' + transform( &lcCursor..centid ) + ',' + Transform( iif( &lcCursor..InactivoFW, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLVend ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUIT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCalle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLMovil ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'" + ',' + transform( &lcCursor..CLIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANT ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'" + ',' + transform( &lcCursor..CLCFI ) + ',' + transform( &lcCursor..CLNro ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLisPrec ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCli ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClPiso ) + "'" + ',' + transform( &lcCursor..CNX1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRINOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCategCli ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCO_DTO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'" + ',' + transform( &lcCursor..CLTOPECCTE ) + ',' + transform( &lcCursor..CLACUM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLSEGNOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Sexo ) + "'" + ',' + transform( &lcCursor..CLTOPE ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLAPELL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'" + ',' + transform( &lcCursor..Hijos ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAIS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CLI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTERECOMENDANTE'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CLCOD','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CLCOD')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CONTACTODET Where CONCOD] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCONTACTO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CONCOD in ( select CLCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CONTACTODET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Concod     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ConCon     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CONNOM     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CONTEL     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CONMAIL    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CONNOT     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CLCOD C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CLCOD      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CLIENTERECOMENDANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CLIENTERECOMENDANTE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CLIENTERECOMENDANTE_CLOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCONTACTO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CLI')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CLIENTERECOMENDANTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CLCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CLIENTERECOMENDANTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTERECOMENDANTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CLCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CLCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTERECOMENDANTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  CD1       
		* Validar ANTERIORES A 1/1/1753  CLFING    
		* Validar ANTERIORES A 1/1/1753  CLFECHA   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CLI
Create Table ZooLogic.TablaTrabajo_CLI ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"cd1" datetime  null, 
"clser" numeric( 1, 0 )  null, 
"clfing" datetime  null, 
"haltafw" char( 8 )  null, 
"nomrecom" char( 60 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"globalid" char( 38 )  null, 
"codrecom" char( 10 )  null, 
"umodifw" char( 100 )  null, 
"cltlf" char( 30 )  null, 
"esttrans" char( 20 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"clprov" char( 2 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"clpin" char( 60 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"cltpo" numeric( 1, 0 )  null, 
"centid" numeric( 10, 0 )  null, 
"inactivofw" bit  null, 
"clcod" char( 10 )  null, 
"clvend" char( 10 )  null, 
"clobs" varchar(max)  null, 
"pcuit" char( 20 )  null, 
"cltipodoc" char( 2 )  null, 
"clcalle" char( 250 )  null, 
"clmovil" char( 30 )  null, 
"climpd" char( 8 )  null, 
"cliva" numeric( 2, 0 )  null, 
"cltrans" char( 15 )  null, 
"clclas" char( 10 )  null, 
"clcodfant" char( 50 )  null, 
"clnrodoc" char( 10 )  null, 
"clcfi" numeric( 1, 0 )  null, 
"clnro" numeric( 5, 0 )  null, 
"clfax" char( 20 )  null, 
"cllisprec" char( 6 )  null, 
"cltipocli" char( 10 )  null, 
"clemail" char( 250 )  null, 
"clpiso" char( 3 )  null, 
"cnx1" numeric( 15, 2 )  null, 
"clprinom" char( 60 )  null, 
"clcategcli" char( 10 )  null, 
"clco_dto" char( 10 )  null, 
"clfecha" datetime  null, 
"clcuit" char( 15 )  null, 
"clpageweb" char( 60 )  null, 
"cldepto" char( 3 )  null, 
"cltopeccte" numeric( 15, 2 )  null, 
"clacum" numeric( 15, 2 )  null, 
"clsegnom" char( 60 )  null, 
"sexo" char( 10 )  null, 
"cltope" numeric( 15, 2 )  null, 
"clloc" char( 70 )  null, 
"clapell" char( 60 )  null, 
"estado" char( 13 )  null, 
"clcondpag" char( 5 )  null, 
"clcp" char( 8 )  null, 
"hijos" numeric( 2, 0 )  null, 
"clnom" char( 185 )  null, 
"rut" char( 12 )  null, 
"clprv" char( 2 )  null, 
"clpais" char( 3 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CLI' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CLI' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTERECOMENDANTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('cd1','cd1')
			.AgregarMapeo('clser','clser')
			.AgregarMapeo('clfing','clfing')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('nomrecom','nomrecom')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('globalid','globalid')
			.AgregarMapeo('codrecom','codrecom')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('clprov','clprov')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('clpin','clpin')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('cltpo','cltpo')
			.AgregarMapeo('centid','centid')
			.AgregarMapeo('inactivofw','inactivofw')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clvend','clvend')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('pcuit','pcuit')
			.AgregarMapeo('cltipodoc','cltipodoc')
			.AgregarMapeo('clcalle','clcalle')
			.AgregarMapeo('clmovil','clmovil')
			.AgregarMapeo('climpd','climpd')
			.AgregarMapeo('cliva','cliva')
			.AgregarMapeo('cltrans','cltrans')
			.AgregarMapeo('clclas','clclas')
			.AgregarMapeo('clcodfant','clcodfant')
			.AgregarMapeo('clnrodoc','clnrodoc')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('clnro','clnro')
			.AgregarMapeo('clfax','clfax')
			.AgregarMapeo('cllisprec','cllisprec')
			.AgregarMapeo('cltipocli','cltipocli')
			.AgregarMapeo('clemail','clemail')
			.AgregarMapeo('clpiso','clpiso')
			.AgregarMapeo('cnx1','cnx1')
			.AgregarMapeo('clprinom','clprinom')
			.AgregarMapeo('clcategcli','clcategcli')
			.AgregarMapeo('clco_dto','clco_dto')
			.AgregarMapeo('clfecha','clfecha')
			.AgregarMapeo('clcuit','clcuit')
			.AgregarMapeo('clpageweb','clpageweb')
			.AgregarMapeo('cldepto','cldepto')
			.AgregarMapeo('cltopeccte','cltopeccte')
			.AgregarMapeo('clacum','clacum')
			.AgregarMapeo('clsegnom','clsegnom')
			.AgregarMapeo('sexo','sexo')
			.AgregarMapeo('cltope','cltope')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('clapell','clapell')
			.AgregarMapeo('estado','estado')
			.AgregarMapeo('clcondpag','clcondpag')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('hijos','hijos')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('rut','rut')
			.AgregarMapeo('clprv','clprv')
			.AgregarMapeo('clpais','clpais')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CLI'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.CD1 = isnull( d.CD1, t.CD1 ),t.CLSER = isnull( d.CLSER, t.CLSER ),t.CLFING = isnull( d.CLFING, t.CLFING ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.NOMRECOM = isnull( d.NOMRECOM, t.NOMRECOM ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.GLOBALID = isnull( d.GLOBALID, t.GLOBALID ),t.CODRECOM = isnull( d.CODRECOM, t.CODRECOM ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.CLPROV = isnull( d.CLPROV, t.CLPROV ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.CLPIN = isnull( d.CLPIN, t.CLPIN ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CLTPO = isnull( d.CLTPO, t.CLTPO ),t.CENTID = isnull( d.CENTID, t.CENTID ),t.INACTIVOFW = isnull( d.INACTIVOFW, t.INACTIVOFW ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLVEND = isnull( d.CLVEND, t.CLVEND ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.PCUIT = isnull( d.PCUIT, t.PCUIT ),t.CLTIPODOC = isnull( d.CLTIPODOC, t.CLTIPODOC ),t.CLCALLE = isnull( d.CLCALLE, t.CLCALLE ),t.CLMOVIL = isnull( d.CLMOVIL, t.CLMOVIL ),t.CLIMPD = isnull( d.CLIMPD, t.CLIMPD ),t.CLIVA = isnull( d.CLIVA, t.CLIVA ),t.CLTRANS = isnull( d.CLTRANS, t.CLTRANS ),t.CLCLAS = isnull( d.CLCLAS, t.CLCLAS ),t.CLCODFANT = isnull( d.CLCODFANT, t.CLCODFANT ),t.CLNRODOC = isnull( d.CLNRODOC, t.CLNRODOC ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.CLNRO = isnull( d.CLNRO, t.CLNRO ),t.CLFAX = isnull( d.CLFAX, t.CLFAX ),t.CLLISPREC = isnull( d.CLLISPREC, t.CLLISPREC ),t.CLTIPOCLI = isnull( d.CLTIPOCLI, t.CLTIPOCLI ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL ),t.CLPISO = isnull( d.CLPISO, t.CLPISO ),t.CNX1 = isnull( d.CNX1, t.CNX1 ),t.CLPRINOM = isnull( d.CLPRINOM, t.CLPRINOM ),t.CLCATEGCLI = isnull( d.CLCATEGCLI, t.CLCATEGCLI ),t.CLCO_DTO = isnull( d.CLCO_DTO, t.CLCO_DTO ),t.CLFECHA = isnull( d.CLFECHA, t.CLFECHA ),t.CLCUIT = isnull( d.CLCUIT, t.CLCUIT ),t.CLPAGEWEB = isnull( d.CLPAGEWEB, t.CLPAGEWEB ),t.CLDEPTO = isnull( d.CLDEPTO, t.CLDEPTO ),t.CLTOPECCTE = isnull( d.CLTOPECCTE, t.CLTOPECCTE ),t.CLACUM = isnull( d.CLACUM, t.CLACUM ),t.CLSEGNOM = isnull( d.CLSEGNOM, t.CLSEGNOM ),t.SEXO = isnull( d.SEXO, t.SEXO ),t.CLTOPE = isnull( d.CLTOPE, t.CLTOPE ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLAPELL = isnull( d.CLAPELL, t.CLAPELL ),t.ESTADO = isnull( d.ESTADO, t.ESTADO ),t.CLCONDPAG = isnull( d.CLCONDPAG, t.CLCONDPAG ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.HIJOS = isnull( d.HIJOS, t.HIJOS ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.RUT = isnull( d.RUT, t.RUT ),t.CLPRV = isnull( d.CLPRV, t.CLPRV ),t.CLPAIS = isnull( d.CLPAIS, t.CLPAIS )
					from ZooLogic.CLI t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.CLI(Faltafw,Fectrans,Fecimpo,Fmodifw,Fecexpo,Cd1,Clser,Clfing,Haltafw,Nomrecom,Hmodifw,Horaimpo,Saltafw,Globalid,Codrecom,Umodifw,Cltlf,Esttrans,Vmodifw,Zadsfw,Valtafw,Clprov,Ualtafw,Smodifw,Clpin,Horaexpo,Bdmodifw,Bdaltafw,Cltpo,Centid,Inactivofw,Clcod,Clvend,Clobs,Pcuit,Cltipodoc,Clcalle,Clmovil,Climpd,Cliva,Cltrans,Clclas,Clcodfant,Clnrodoc,Clcfi,Clnro,Clfax,Cllisprec,Cltipocli,Clemail,Clpiso,Cnx1,Clprinom,Clcategcli,Clco_dto,Clfecha,Clcuit,Clpageweb,Cldepto,Cltopeccte,Clacum,Clsegnom,Sexo,Cltope,Clloc,Clapell,Estado,Clcondpag,Clcp,Hijos,Clnom,Rut,Clprv,Clpais)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.CD1,''),isnull( d.CLSER,0),isnull( d.CLFING,''),convert( char(8), getdate(), 108 ),isnull( d.NOMRECOM,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.GLOBALID,''),isnull( d.CODRECOM,''),isnull( d.UMODIFW,''),isnull( d.CLTLF,''),isnull( d.ESTTRANS,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.CLPROV,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.CLPIN,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.CLTPO,0),isnull( d.CENTID,0),isnull( d.INACTIVOFW,0),isnull( d.CLCOD,''),isnull( d.CLVEND,''),isnull( d.CLOBS,''),isnull( d.PCUIT,''),isnull( d.CLTIPODOC,''),isnull( d.CLCALLE,''),isnull( d.CLMOVIL,''),isnull( d.CLIMPD,''),isnull( d.CLIVA,0),isnull( d.CLTRANS,''),isnull( d.CLCLAS,''),isnull( d.CLCODFANT,''),isnull( d.CLNRODOC,''),isnull( d.CLCFI,0),isnull( d.CLNRO,0),isnull( d.CLFAX,''),isnull( d.CLLISPREC,''),isnull( d.CLTIPOCLI,''),isnull( d.CLEMAIL,''),isnull( d.CLPISO,''),isnull( d.CNX1,0),isnull( d.CLPRINOM,''),isnull( d.CLCATEGCLI,''),isnull( d.CLCO_DTO,''),isnull( d.CLFECHA,''),isnull( d.CLCUIT,''),isnull( d.CLPAGEWEB,''),isnull( d.CLDEPTO,''),isnull( d.CLTOPECCTE,0),isnull( d.CLACUM,0),isnull( d.CLSEGNOM,''),isnull( d.SEXO,''),isnull( d.CLTOPE,0),isnull( d.CLLOC,''),isnull( d.CLAPELL,''),isnull( d.ESTADO,''),isnull( d.CLCONDPAG,''),isnull( d.CLCP,''),isnull( d.HIJOS,0),isnull( d.CLNOM,''),isnull( d.RUT,''),isnull( d.CLPRV,''),isnull( d.CLPAIS,'')
						From deleted d left join ZooLogic.CLI pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CONTACTODET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CLI_CONTACTODET
ON ZooLogic.TablaTrabajo_CLI_CONTACTODET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CONCOD = isnull( d.CONCOD, t.CONCOD ),
t.CONCON = isnull( d.CONCON, t.CONCON ),
t.CONNOM = isnull( d.CONNOM, t.CONNOM ),
t.CONTEL = isnull( d.CONTEL, t.CONTEL ),
t.CONMAIL = isnull( d.CONMAIL, t.CONMAIL ),
t.CONNOT = isnull( d.CONNOT, t.CONNOT )
from ZooLogic.CONTACTODET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CONTACTODET
( 
"NROITEM",
"CONCOD",
"CONCON",
"CONNOM",
"CONTEL",
"CONMAIL",
"CONNOT"
 )
Select 
d.NROITEM,
d.CONCOD,
d.CONCON,
d.CONNOM,
d.CONTEL,
d.CONMAIL,
d.CONNOT
From deleted d left join ZooLogic.CONTACTODET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CLI
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CLIENTERECOMENDANTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTERECOMENDANTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTERECOMENDANTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTERECOMENDANTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTERECOMENDANTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTERECOMENDANTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaultimamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTERECOMENDANTE.Fechaultimamodificacion, ctod( '  /  /    ' ) ) )
					.Clasificacion2 = nvl( c_CLIENTERECOMENDANTE.Clasificacion2, 0 )
					.Fechadealta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTERECOMENDANTE.Fechadealta, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_CLIENTERECOMENDANTE.Horaaltafw, [] )
					.Nombrerecomendante = nvl( c_CLIENTERECOMENDANTE.Nombrerecomendante, [] )
					.Horamodificacionfw = nvl( c_CLIENTERECOMENDANTE.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_CLIENTERECOMENDANTE.Horaimpo, [] )
					.Seriealtafw = nvl( c_CLIENTERECOMENDANTE.Seriealtafw, [] )
					.Idglobal = nvl( c_CLIENTERECOMENDANTE.Idglobal, [] )
					.Codrecomendante = nvl( c_CLIENTERECOMENDANTE.Codrecomendante, [] )
					.Usuariomodificacionfw = nvl( c_CLIENTERECOMENDANTE.Usuariomodificacionfw, [] )
					.Telefono = nvl( c_CLIENTERECOMENDANTE.Telefono, [] )
					.Estadotransferencia = nvl( c_CLIENTERECOMENDANTE.Estadotransferencia, [] )
					.Versionmodificacionfw = nvl( c_CLIENTERECOMENDANTE.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_CLIENTERECOMENDANTE.Versionaltafw, [] )
					.Jurisdiccion = nvl( c_CLIENTERECOMENDANTE.Jurisdiccion, [] )
					.Usuarioaltafw = nvl( c_CLIENTERECOMENDANTE.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_CLIENTERECOMENDANTE.Seriemodificacionfw, [] )
					.Pin = nvl( c_CLIENTERECOMENDANTE.Pin, [] )
					.Horaexpo = nvl( c_CLIENTERECOMENDANTE.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_CLIENTERECOMENDANTE.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CLIENTERECOMENDANTE.Basededatosaltafw, [] )
					.Tipointerno = nvl( c_CLIENTERECOMENDANTE.Tipointerno, 0 )
					.Idcentralizador = nvl( c_CLIENTERECOMENDANTE.Idcentralizador, 0 )
					.Inactivofw = nvl( c_CLIENTERECOMENDANTE.Inactivofw, .F. )
					.Codigo = nvl( c_CLIENTERECOMENDANTE.Codigo, [] )
					.Vendedor_PK =  nvl( c_CLIENTERECOMENDANTE.Vendedor, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Cuitpais = nvl( c_CLIENTERECOMENDANTE.Cuitpais, [] )
					.Tipodocumento = nvl( c_CLIENTERECOMENDANTE.Tipodocumento, [] )
					.Calle = nvl( c_CLIENTERECOMENDANTE.Calle, [] )
					.Movil = nvl( c_CLIENTERECOMENDANTE.Movil, [] )
					.Clasificacionsecundaria = nvl( c_CLIENTERECOMENDANTE.Clasificacionsecundaria, [] )
					.Situacionfiscal_PK =  nvl( c_CLIENTERECOMENDANTE.Situacionfiscal, 0 )
					.Transportista_PK =  nvl( c_CLIENTERECOMENDANTE.Transportista, [] )
					.Clasificacion_PK =  nvl( c_CLIENTERECOMENDANTE.Clasificacion, [] )
					.Contacto.Limpiar()
					.Contacto.SetearEsNavegacion( .lProcesando )
					.Contacto.Cargar()
					.Codnombrefantasia_PK =  nvl( c_CLIENTERECOMENDANTE.Codnombrefantasia, [] )
					.Nrodocumento = nvl( c_CLIENTERECOMENDANTE.Nrodocumento, [] )
					.Cfi = nvl( c_CLIENTERECOMENDANTE.Cfi, 0 )
					.Numero = nvl( c_CLIENTERECOMENDANTE.Numero, 0 )
					.Fax = nvl( c_CLIENTERECOMENDANTE.Fax, [] )
					.Listadeprecio_PK =  nvl( c_CLIENTERECOMENDANTE.Listadeprecio, [] )
					.Tipocli_PK =  nvl( c_CLIENTERECOMENDANTE.Tipocli, [] )
					.Email = nvl( c_CLIENTERECOMENDANTE.Email, [] )
					.Piso = nvl( c_CLIENTERECOMENDANTE.Piso, [] )
					.Credito = nvl( c_CLIENTERECOMENDANTE.Credito, 0 )
					.Primernombre = nvl( c_CLIENTERECOMENDANTE.Primernombre, [] )
					.Categcli_PK =  nvl( c_CLIENTERECOMENDANTE.Categcli, [] )
					.Descuentopreferente_PK =  nvl( c_CLIENTERECOMENDANTE.Descuentopreferente, [] )
					.Fechanacimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTERECOMENDANTE.Fechanacimiento, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_CLIENTERECOMENDANTE.Cuit, [] )
					.Paginaweb = nvl( c_CLIENTERECOMENDANTE.Paginaweb, [] )
					.Departamento = nvl( c_CLIENTERECOMENDANTE.Departamento, [] )
					.Topectacte = nvl( c_CLIENTERECOMENDANTE.Topectacte, 0 )
					.Dolaresacumulados = nvl( c_CLIENTERECOMENDANTE.Dolaresacumulados, 0 )
					.Segundonombre = nvl( c_CLIENTERECOMENDANTE.Segundonombre, [] )
					.Sexo = nvl( c_CLIENTERECOMENDANTE.Sexo, [] )
					.Topefacturacion = nvl( c_CLIENTERECOMENDANTE.Topefacturacion, 0 )
					.Localidad = nvl( c_CLIENTERECOMENDANTE.Localidad, [] )
					.Apellido = nvl( c_CLIENTERECOMENDANTE.Apellido, [] )
					.Estadocivil = nvl( c_CLIENTERECOMENDANTE.Estadocivil, [] )
					.Condiciondepago_PK =  nvl( c_CLIENTERECOMENDANTE.Condiciondepago, [] )
					.Codigopostal = nvl( c_CLIENTERECOMENDANTE.Codigopostal, [] )
					.Hijos = nvl( c_CLIENTERECOMENDANTE.Hijos, 0 )
					.Nombre = nvl( c_CLIENTERECOMENDANTE.Nombre, [] )
					.Rut = nvl( c_CLIENTERECOMENDANTE.Rut, [] )
					.Provincia_PK =  nvl( c_CLIENTERECOMENDANTE.Provincia, [] )
					.Pais_PK =  nvl( c_CLIENTERECOMENDANTE.Pais, [] )
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
		
		loDetalle = this.oEntidad.Contacto
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
		return c_CLIENTERECOMENDANTE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CLI' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CLCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CLCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CLCOD from (
							select * 
								from ZooLogic.CLI 
								Where   CLI.CLCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CLI", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CLCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Cd1" as "Fechaultimamodificacion", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Haltafw" as "Horaaltafw", "Nomrecom" as "Nombrerecomendante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Globalid" as "Idglobal", "Codrecom" as "Codrecomendante", "Umodifw" as "Usuariomodificacionfw", "Cltlf" as "Telefono", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Clprov" as "Jurisdiccion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Clpin" as "Pin", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clvend" as "Vendedor", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Cltipodoc" as "Tipodocumento", "Clcalle" as "Calle", "Clmovil" as "Movil", "Climpd" as "Clasificacionsecundaria", "Cliva" as "Situacionfiscal", "Cltrans" as "Transportista", "Clclas" as "Clasificacion", "Clcodfant" as "Codnombrefantasia", "Clnrodoc" as "Nrodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clfax" as "Fax", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Clemail" as "Email", "Clpiso" as "Piso", "Cnx1" as "Credito", "Clprinom" as "Primernombre", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clcuit" as "Cuit", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Cltopeccte" as "Topectacte", "Clacum" as "Dolaresacumulados", "Clsegnom" as "Segundonombre", "Sexo" as "Sexo", "Cltope" as "Topefacturacion", "Clloc" as "Localidad", "Clapell" as "Apellido", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clnom" as "Nombre", "Rut" as "Rut", "Clprv" as "Provincia", "Clpais" as "Pais"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CLI 
								Where   CLI.CLCOD != ''
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
	Tabla = 'CLI'
	Filtro = " CLI.CLCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CLI.CLCOD != ''"
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
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FECHAALTAFW                             " tabla="CLI            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FECHATRANSFERENCIA                      " tabla="CLI            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FECHAIMPO                               " tabla="CLI            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FECHAMODIFICACIONFW                     " tabla="CLI            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FECHAEXPO                               " tabla="CLI            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FECHAULTIMAMODIFICACION                 " tabla="CLI            " campo="CD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima Modificación                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CLASIFICACION2                          " tabla="CLI            " campo="CLSER     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Clasificación                                                                                                                                                   " dominio="CLASIFICACION                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FECHADEALTA                             " tabla="CLI            " campo="CLFING    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="46" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="HORAALTAFW                              " tabla="CLI            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="NOMBRERECOMENDANTE                      " tabla="CLI            " campo="NOMRECOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Nombre recomendante                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="HORAMODIFICACIONFW                      " tabla="CLI            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="HORAIMPO                                " tabla="CLI            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="SERIEALTAFW                             " tabla="CLI            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="IDGLOBAL                                " tabla="CLI            " campo="GLOBALID  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id de centralización en zNube                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CODRECOMENDANTE                         " tabla="CLI            " campo="CODRECOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cód. recomendante                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="USUARIOMODIFICACIONFW                   " tabla="CLI            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="TELEFONO                                " tabla="CLI            " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="ESTADOTRANSFERENCIA                     " tabla="CLI            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="VERSIONMODIFICACIONFW                   " tabla="CLI            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="ZADSFW                                  " tabla="CLI            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="VERSIONALTAFW                           " tabla="CLI            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="JURISDICCION                            " tabla="CLI            " campo="CLPROV    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Jurisdicción                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="USUARIOALTAFW                           " tabla="CLI            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="SERIEMODIFICACIONFW                     " tabla="CLI            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="PIN                                     " tabla="CLI            " campo="CLPIN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="HORAEXPO                                " tabla="CLI            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CLI            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="BASEDEDATOSALTAFW                       " tabla="CLI            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="TIPOINTERNO                             " tabla="CLI            " campo="CLTPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="IDCENTRALIZADOR                         " tabla="CLI            " campo="CENTID    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Id de centralización                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="INACTIVOFW                              " tabla="CLI            " campo="INACTIVOFW" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CODIGO                                  " tabla="CLI            " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="VENDEDOR                                " tabla="CLI            " campo="CLVEND    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="OBSERVACION                             " tabla="CLI            " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CUITPAIS                                " tabla="CLI            " campo="PCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="CUIT país                                                                                                                                                       " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="TIPODOCUMENTO                           " tabla="CLI            " campo="CLTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="=&quot;05&quot;                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="406" etiqueta="Tipo documento                                                                                                                                                  " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CALLE                                   " tabla="CLI            " campo="CLCALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="MOVIL                                   " tabla="CLI            " campo="CLMOVIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Teléfono móvil                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CLASIFICACIONSECUNDARIA                 " tabla="CLI            " campo="CLIMPD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Clasificación secundaria                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="SITUACIONFISCAL                         " tabla="CLI            " campo="CLIVA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="408" etiqueta="Situación fiscal                                                                                                                                                " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="TRANSPORTISTA                           " tabla="CLI            " campo="CLTRANS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Transportista                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CLASIFICACION                           " tabla="CLI            " campo="CLCLAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="48" etiqueta="Clasificación cliente                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CONTACTO                                " tabla="CONTACTODET    " campo="CONCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Contactos                                                                                                                                                       " dominio="DETALLEITEMCONTACTO           " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CODNOMBREFANTASIA                       " tabla="CLI            " campo="CLCODFANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMBREDEFANTASIA                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="54" etiqueta="Nombre de fantasía                                                                                                                                              " dominio="CODIGOSINMUESTRARELACION      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="NRODOCUMENTO                            " tabla="CLI            " campo="CLNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="50" etiqueta="Número documento                                                                                                                                                " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CFI                                     " tabla="CLI            " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente Frecuente Importante                                                                                                                                    " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="NUMERO                                  " tabla="CLI            " campo="CLNRO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FAX                                     " tabla="CLI            " campo="CLFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="SITFISCALURUGUAY                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="2                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="412" etiqueta="Situación del cliente                                                                                                                                           " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="LISTADEPRECIO                           " tabla="CLI            " campo="CLLISPREC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="36" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="TIPOCLI                                 " tabla="CLI            " campo="CLTIPOCLI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOCLIENTE                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="56" etiqueta="Tipo                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="EMAIL                                   " tabla="CLI            " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Email                                                                                                                                                           " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="PISO                                    " tabla="CLI            " campo="CLPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CREDITO                                 " tabla="CLI            " campo="CNX1      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Crédito                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="PRIMERNOMBRE                            " tabla="CLI            " campo="CLPRINOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Primer nombre                                                                                                                                                   " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CATEGCLI                                " tabla="CLI            " campo="CLCATEGCLI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIACLIENTE                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="58" etiqueta="Categoría                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="DESCUENTOPREFERENTE                     " tabla="CLI            " campo="CLCO_DTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESCUENTO                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="38" etiqueta="Descuento                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="FECHANACIMIENTO                         " tabla="CLI            " campo="CLFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="44" etiqueta="Fecha de nacimiento                                                                                                                                             " dominio="FECHALARGACALENDARIO          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CUIT                                    " tabla="CLI            " campo="CLCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="CUIT                                                                                                                                                            " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="PAGINAWEB                               " tabla="CLI            " campo="CLPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Sitio web                                                                                                                                                       " dominio="WEB                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="DEPARTAMENTO                            " tabla="CLI            " campo="CLDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="TOPECTACTE                              " tabla="CLI            " campo="CLTOPECCTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="40" etiqueta="Límite de crédito                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="DOLARESACUMULADOS                       " tabla="CLI            " campo="CLACUM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="U$S acumulados                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="SEGUNDONOMBRE                           " tabla="CLI            " campo="CLSEGNOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Segundo nombre                                                                                                                                                  " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="SEXO                                    " tabla="CLI            " campo="SEXO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Sexo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="TOPEFACTURACION                         " tabla="CLI            " campo="CLTOPE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tope facturación                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="LOCALIDAD                               " tabla="CLI            " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Localidad                                                                                                                                                       " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="APELLIDO                                " tabla="CLI            " campo="CLAPELL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Apellido                                                                                                                                                        " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="ESTADOCIVIL                             " tabla="CLI            " campo="ESTADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Estado civil                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CONDICIONDEPAGO                         " tabla="CLI            " campo="CLCONDPAG " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="CODIGOPOSTAL                            " tabla="CLI            " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Código postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="HIJOS                                   " tabla="CLI            " campo="HIJOS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Cantidad de hijos                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Denominación o razón social                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="RUT                                     " tabla="CLI            " campo="RUT       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="R.U.T.                                                                                                                                                          " dominio="RUT                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999999-X              " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="PROVINCIA                               " tabla="CLI            " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTERECOMENDANTE                     " atributo="PAIS                                    " tabla="CLI            " campo="CLPAIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="33" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On CLI.CLVEND = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SITUACIONFISCAL                         " atributo="DESCRIPCION                             " tabla="SITFISCAL      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Sit.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SITFISCAL On CLI.CLIVA = SITFISCAL.Codigo And  SITFISCAL.CODIGO != 0                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="35" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On CLI.CLTRANS = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="49" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On CLI.CLCLAS = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="CODIGO                                  " tabla="NOMFANT        " campo="NFCOD     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="55" etiqueta="Detalle Nom.                                                                                                                                                    " dominio="CODIGOSINMUESTRARELACION      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NOMFANT On CLI.CLCODFANT = NOMFANT.NFCOD And  NOMFANT.NFCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="37" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On CLI.CLLISPREC = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOCLIENTE                             " atributo="DESCRIPCION                             " tabla="TIPOCLI        " campo="TCDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="57" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOCLI On CLI.CLTIPOCLI = TIPOCLI.TCCOD And  TIPOCLI.TCCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIACLIENTE                        " atributo="DESCRIPCION                             " tabla="CATCLI         " campo="CGDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="59" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATCLI On CLI.CLCATEGCLI = CATCLI.CGCod And  CATCLI.CGCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCION                             " tabla="DESCUENTOS     " campo="DES       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="39" etiqueta="Detalle Des.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESCUENTOS On CLI.CLCO_DTO = DESCUENTOS.codigo And  DESCUENTOS.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="419" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On CLI.CLCONDPAG = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="19" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On CLI.CLPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On CLI.CLPAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMCONTACTO                            " atributo="NOMBRE                                  " tabla="CONTACTODET    " campo="CONNOM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleContactos, Nombre                                                                                                                                        " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONTACTODET On CLI.CLCOD = CONTACTODET.Concod And  CLI.CLCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMCONTACTO                            " atributo="TELEFONOS                               " tabla="CONTACTODET    " campo="CONTEL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleContactos, Teléfonos                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONTACTODET On CLI.CLCOD = CONTACTODET.Concod And  CLI.CLCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMCONTACTO                            " atributo="EMAIL                                   " tabla="CONTACTODET    " campo="CONMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleContactos, Email                                                                                                                                         " dominio="MAIL                          " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONTACTODET On CLI.CLCOD = CONTACTODET.Concod And  CLI.CLCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMCONTACTO                            " atributo="NOTAS                                   " tabla="CONTACTODET    " campo="CONNOT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleContactos, Notas                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONTACTODET On CLI.CLCOD = CONTACTODET.Concod And  CLI.CLCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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