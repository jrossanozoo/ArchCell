
define class Din_EntidadCLIENTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CLIENTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CLIPK'
	cTablaPrincipal = 'CLI'
	cCampoCodigoWH = 'CLCOD'
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
			local  lxCliFecimpo, lxCliFectrans, lxCliFmodifw, lxCliCd1, lxCliFecexpo, lxCliFaltafw, lxCliClser, lxCliClfing, lxCliZadsfw, lxCliEsttrans, lxCliBdaltafw, lxCliGlobalid, lxCliDescfw, lxCliNomrecom, lxCliCodrecom, lxCliBdmodifw, lxCliVmodifw, lxCliSaltafw, lxCliHmodifw, lxCliSmodifw, lxCliClprov, lxCliHoraimpo, lxCliHoraexpo, lxCliValtafw, lxCliUaltafw, lxCliHaltafw, lxCliUmodifw, lxCliClpin, lxCliTimestamp, lxCliCentid, lxCliCltpo, lxCliInactivofw, lxCliCimagen, lxCliClvend, lxCliClcod, lxCliClobs, lxCliPcuit, lxCliClperibru, lxCliClcalle, lxCliClimpd, lxCliCltlf, lxCliCliva, lxCliClclas, lxCliCltrans, lxCliClcodfant, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliCltipodoc, lxCliClcfi, lxCliClnro, lxCliClmovil, lxCliCllisprec, lxCliCltipocli, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClcuit, lxCliClnrodoc, lxCliClpiso, lxCliClfax, lxCliCnx1, lxCliSexo, lxCliClsitgan, lxCliRut, lxCliClcategcli, lxCliClpertiva, lxCliClco_dto, lxCliClfecha, lxCliClpageweb, lxCliCldepto, lxCliClacum, lxCliCltopeccte, lxCliClsiprib, lxCliClpergan, lxCliClprinom, lxCliCltope, lxCliClsujvinc, lxCliClloc, lxCliEstado, lxCliClcondpag, lxCliClsegnom, lxCliPorcentc, lxCliClcp, lxCliHijos, lxCliClapell, lxCliAplicatc, lxCliClprv, lxCliClnom, lxCliClpais, lxCliClemail
				lxCliFecimpo =  .Fechaimpo			lxCliFectrans =  .Fechatransferencia			lxCliFmodifw =  .Fechamodificacionfw			lxCliCd1 =  .Fechaultimamodificacion			lxCliFecexpo =  .Fechaexpo			lxCliFaltafw =  .Fechaaltafw			lxCliClser =  .Clasificacion2			lxCliClfing =  .Fechadealta			lxCliZadsfw =  .Zadsfw			lxCliEsttrans =  .Estadotransferencia			lxCliBdaltafw =  .Basededatosaltafw			lxCliGlobalid =  .Idglobal			lxCliDescfw =  .Descripcionfw			lxCliNomrecom =  .Nombrerecomendante			lxCliCodrecom =  .Codrecomendante			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliVmodifw =  .Versionmodificacionfw			lxCliSaltafw =  .Seriealtafw			lxCliHmodifw =  .Horamodificacionfw			lxCliSmodifw =  .Seriemodificacionfw			lxCliClprov =  .Jurisdiccion			lxCliHoraimpo =  .Horaimpo			lxCliHoraexpo =  .Horaexpo			lxCliValtafw =  .Versionaltafw			lxCliUaltafw =  .Usuarioaltafw			lxCliHaltafw =  .Horaaltafw			lxCliUmodifw =  .Usuariomodificacionfw			lxCliClpin =  .Pin			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliCentid =  .Idcentralizador			lxCliCltpo =  .Tipointerno			lxCliInactivofw =  .Inactivofw			lxCliCimagen =  .Imagen			lxCliClvend =  upper( .Vendedor_PK ) 			lxCliClcod =  .Codigo			lxCliClobs =  .Observacion			lxCliPcuit =  .Cuitpais			lxCliClperibru =  .Percepcioningresosbrutos			lxCliClcalle =  .Calle			lxCliClimpd =  .Clasificacionsecundaria			lxCliCltlf =  .Telefono			lxCliCliva =  .Situacionfiscal_PK 			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliExpergan =  .Excluidopercepcionganancias			lxCliExperiva =  .Excluidopercepcioniva			lxCliCltipconv =  .Tipoconvenio			lxCliCltipodoc =  .Tipodocumento			lxCliClcfi =  .Cfi			lxCliClnro =  .Numero			lxCliClmovil =  .Movil			lxCliCllisprec =  upper( .ListaDePrecio_PK ) 			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliVhastagan =  .Vigenciahastagan			lxCliVhastaiva =  .Vigenciahastaiva			lxCliClnroiibb =  .Nroiibb			lxCliClcuit =  .Cuit			lxCliClnrodoc =  .Nrodocumento			lxCliClpiso =  .Piso			lxCliClfax =  .Fax			lxCliCnx1 =  .Credito			lxCliSexo =  .Sexo			lxCliClsitgan =  .Situacionganancias			lxCliRut =  .Rut			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClpertiva =  upper( .PercepcionIva_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliClpageweb =  .Paginaweb			lxCliCldepto =  .Departamento			lxCliClacum =  .Dolaresacumulados			lxCliCltopeccte =  .Topectacte			lxCliClsiprib =  upper( .CodigoSiprib_PK ) 			lxCliClpergan =  upper( .PercepcionGanancias_PK ) 			lxCliClprinom =  .Primernombre			lxCliCltope =  .Topefacturacion			lxCliClsujvinc =  .Sujetovinculado			lxCliClloc =  .Localidad			lxCliEstado =  .Estadocivil			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClsegnom =  .Segundonombre			lxCliPorcentc =  .Tasaceroporcen			lxCliClcp =  .Codigopostal			lxCliHijos =  .Hijos			lxCliClapell =  .Apellido			lxCliAplicatc =  .Tasaceroaplica			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClnom =  .Nombre			lxCliClpais =  upper( .Pais_PK ) 			lxCliClemail =  .Email
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
				insert into ZooLogic.CLI ( "Fecimpo","Fectrans","Fmodifw","Cd1","Fecexpo","Faltafw","Clser","Clfing","Zadsfw","Esttrans","Bdaltafw","Globalid","Descfw","Nomrecom","Codrecom","Bdmodifw","Vmodifw","Saltafw","Hmodifw","Smodifw","Clprov","Horaimpo","Horaexpo","Valtafw","Ualtafw","Haltafw","Umodifw","Clpin","Timestamp","Centid","Cltpo","Inactivofw","Cimagen","Clvend","Clcod","Clobs","Pcuit","Clperibru","Clcalle","Climpd","Cltlf","Cliva","Clclas","Cltrans","Clcodfant","Expergan","Experiva","Cltipconv","Cltipodoc","Clcfi","Clnro","Clmovil","Cllisprec","Cltipocli","Vhastagan","Vhastaiva","Clnroiibb","Clcuit","Clnrodoc","Clpiso","Clfax","Cnx1","Sexo","Clsitgan","Rut","Clcategcli","Clpertiva","Clco_dto","Clfecha","Clpageweb","Cldepto","Clacum","Cltopeccte","Clsiprib","Clpergan","Clprinom","Cltope","Clsujvinc","Clloc","Estado","Clcondpag","Clsegnom","Porcentc","Clcp","Hijos","Clapell","Aplicatc","Clprv","Clnom","Clpais","Clemail" ) values ( <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'" >>, <<lxCliClser >>, <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliNomrecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCodrecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'" >>, <<lxCliTimestamp >>, <<lxCliCentid >>, <<lxCliCltpo >>, <<iif( lxCliInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClvend ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClperibru ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'" >>, <<lxCliCliva >>, <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'" >>, <<iif( lxCliExpergan, 1, 0 ) >>, <<iif( lxCliExperiva, 1, 0 ) >>, <<lxCliCltipconv >>, <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'" >>, <<lxCliClcfi >>, <<lxCliClnro >>, <<"'" + this.FormatearTextoSql( lxCliClmovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCllisprec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliVhastagan ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliVhastaiva ) + "'" >>, <<lxCliClnroiibb >>, <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'" >>, <<lxCliCnx1 >>, <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'" >>, <<lxCliClsitgan >>, <<"'" + this.FormatearTextoSql( lxCliRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpertiva ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'" >>, <<lxCliClacum >>, <<lxCliCltopeccte >>, <<"'" + this.FormatearTextoSql( lxCliClsiprib ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpergan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprinom ) + "'" >>, <<lxCliCltope >>, <<iif( lxCliClsujvinc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClsegnom ) + "'" >>, <<lxCliPorcentc >>, <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'" >>, <<lxCliHijos >>, <<"'" + this.FormatearTextoSql( lxCliClapell ) + "'" >>, <<iif( lxCliAplicatc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OtrasDirecciones
				if this.oEntidad.OtrasDirecciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCalle = loItem.Calle
					lxNumero = loItem.Numero
					lxPiso = loItem.Piso
					lxDepartamento = loItem.Departamento
					lxLocalidad = loItem.Localidad
					lxCodigopostal = loItem.Codigopostal
					lxProvincia_PK = loItem.Provincia_PK
					lxProvinciadetalle = loItem.Provinciadetalle
					lxPais_PK = loItem.Pais_PK
					lxPaisdetalle = loItem.Paisdetalle
					lxTelefono = loItem.Telefono
					lxTipodireccion_PK = loItem.Tipodireccion_PK
					lxNotas = loItem.Notas
					lxPreferente = loItem.Preferente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CliOtrasDir("NROITEM","ODCOD","ODCalle","ODNro","ODPiso","ODDepto","ODLoc","ODCP","ODPrv","ODPrvNom","ODPais","ODPAISNom","ODTel","ODTipoDir","ODNotas","ODPref" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCalle ) + "'">>, <<lxNumero>>, <<"'" + this.FormatearTextoSql( lxPiso ) + "'">>, <<"'" + this.FormatearTextoSql( lxDepartamento ) + "'">>, <<"'" + this.FormatearTextoSql( lxLocalidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigopostal ) + "'">>, <<"'" + this.FormatearTextoSql( lxProvincia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProvinciadetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPais_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPaisdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefono ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodireccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">>, <<iif( lxPreferente, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ExcluidoOtraPercep
				if this.oEntidad.ExcluidoOtraPercep.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigo_PK = loItem.Codigo_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PerExcluido("NROITEM","Cod","Codigo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigo_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Percepciones
				if this.oEntidad.Percepciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigopadroniibb = loItem.Codigopadroniibb
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxJurisdicciondetalle = loItem.Jurisdicciondetalle
					lxResolucion = loItem.Resolucion
					lxPorcentaje = loItem.Porcentaje
					lxFechaexpiracion = loItem.Fechaexpiracion
					lxExcluido = loItem.Excluido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PerCliDet("NROITEM","Cod","CODIGO","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigopadroniibb ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxPorcentaje>>, <<"'" + this.ConvertirDateSql( lxFechaexpiracion ) + "'">>, <<iif( lxExcluido, 1, 0 )>> ) 
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
		this.oEntidad.Timestamp = lxCliTimestamp
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
			local  lxCliFecimpo, lxCliFectrans, lxCliFmodifw, lxCliCd1, lxCliFecexpo, lxCliFaltafw, lxCliClser, lxCliClfing, lxCliZadsfw, lxCliEsttrans, lxCliBdaltafw, lxCliGlobalid, lxCliDescfw, lxCliNomrecom, lxCliCodrecom, lxCliBdmodifw, lxCliVmodifw, lxCliSaltafw, lxCliHmodifw, lxCliSmodifw, lxCliClprov, lxCliHoraimpo, lxCliHoraexpo, lxCliValtafw, lxCliUaltafw, lxCliHaltafw, lxCliUmodifw, lxCliClpin, lxCliTimestamp, lxCliCentid, lxCliCltpo, lxCliInactivofw, lxCliCimagen, lxCliClvend, lxCliClcod, lxCliClobs, lxCliPcuit, lxCliClperibru, lxCliClcalle, lxCliClimpd, lxCliCltlf, lxCliCliva, lxCliClclas, lxCliCltrans, lxCliClcodfant, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliCltipodoc, lxCliClcfi, lxCliClnro, lxCliClmovil, lxCliCllisprec, lxCliCltipocli, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClcuit, lxCliClnrodoc, lxCliClpiso, lxCliClfax, lxCliCnx1, lxCliSexo, lxCliClsitgan, lxCliRut, lxCliClcategcli, lxCliClpertiva, lxCliClco_dto, lxCliClfecha, lxCliClpageweb, lxCliCldepto, lxCliClacum, lxCliCltopeccte, lxCliClsiprib, lxCliClpergan, lxCliClprinom, lxCliCltope, lxCliClsujvinc, lxCliClloc, lxCliEstado, lxCliClcondpag, lxCliClsegnom, lxCliPorcentc, lxCliClcp, lxCliHijos, lxCliClapell, lxCliAplicatc, lxCliClprv, lxCliClnom, lxCliClpais, lxCliClemail
				lxCliFecimpo =  .Fechaimpo			lxCliFectrans =  .Fechatransferencia			lxCliFmodifw =  .Fechamodificacionfw			lxCliCd1 =  .Fechaultimamodificacion			lxCliFecexpo =  .Fechaexpo			lxCliFaltafw =  .Fechaaltafw			lxCliClser =  .Clasificacion2			lxCliClfing =  .Fechadealta			lxCliZadsfw =  .Zadsfw			lxCliEsttrans =  .Estadotransferencia			lxCliBdaltafw =  .Basededatosaltafw			lxCliGlobalid =  .Idglobal			lxCliDescfw =  .Descripcionfw			lxCliNomrecom =  .Nombrerecomendante			lxCliCodrecom =  .Codrecomendante			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliVmodifw =  .Versionmodificacionfw			lxCliSaltafw =  .Seriealtafw			lxCliHmodifw =  .Horamodificacionfw			lxCliSmodifw =  .Seriemodificacionfw			lxCliClprov =  .Jurisdiccion			lxCliHoraimpo =  .Horaimpo			lxCliHoraexpo =  .Horaexpo			lxCliValtafw =  .Versionaltafw			lxCliUaltafw =  .Usuarioaltafw			lxCliHaltafw =  .Horaaltafw			lxCliUmodifw =  .Usuariomodificacionfw			lxCliClpin =  .Pin			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliCentid =  .Idcentralizador			lxCliCltpo =  .Tipointerno			lxCliInactivofw =  .Inactivofw			lxCliCimagen =  .Imagen			lxCliClvend =  upper( .Vendedor_PK ) 			lxCliClcod =  .Codigo			lxCliClobs =  .Observacion			lxCliPcuit =  .Cuitpais			lxCliClperibru =  .Percepcioningresosbrutos			lxCliClcalle =  .Calle			lxCliClimpd =  .Clasificacionsecundaria			lxCliCltlf =  .Telefono			lxCliCliva =  .Situacionfiscal_PK 			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliExpergan =  .Excluidopercepcionganancias			lxCliExperiva =  .Excluidopercepcioniva			lxCliCltipconv =  .Tipoconvenio			lxCliCltipodoc =  .Tipodocumento			lxCliClcfi =  .Cfi			lxCliClnro =  .Numero			lxCliClmovil =  .Movil			lxCliCllisprec =  upper( .ListaDePrecio_PK ) 			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliVhastagan =  .Vigenciahastagan			lxCliVhastaiva =  .Vigenciahastaiva			lxCliClnroiibb =  .Nroiibb			lxCliClcuit =  .Cuit			lxCliClnrodoc =  .Nrodocumento			lxCliClpiso =  .Piso			lxCliClfax =  .Fax			lxCliCnx1 =  .Credito			lxCliSexo =  .Sexo			lxCliClsitgan =  .Situacionganancias			lxCliRut =  .Rut			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClpertiva =  upper( .PercepcionIva_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliClpageweb =  .Paginaweb			lxCliCldepto =  .Departamento			lxCliClacum =  .Dolaresacumulados			lxCliCltopeccte =  .Topectacte			lxCliClsiprib =  upper( .CodigoSiprib_PK ) 			lxCliClpergan =  upper( .PercepcionGanancias_PK ) 			lxCliClprinom =  .Primernombre			lxCliCltope =  .Topefacturacion			lxCliClsujvinc =  .Sujetovinculado			lxCliClloc =  .Localidad			lxCliEstado =  .Estadocivil			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClsegnom =  .Segundonombre			lxCliPorcentc =  .Tasaceroporcen			lxCliClcp =  .Codigopostal			lxCliHijos =  .Hijos			lxCliClapell =  .Apellido			lxCliAplicatc =  .Tasaceroaplica			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClnom =  .Nombre			lxCliClpais =  upper( .Pais_PK ) 			lxCliClemail =  .Email
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.INACTIVOFW != .oEntidad.INACTIVOFW or  .oEntidad.oAtributosAuditoria.SituacionFiscal != .oEntidad.SituacionFiscal_Pk or  .oEntidad.oAtributosAuditoria.Clasificacion != .oEntidad.Clasificacion_Pk or  .oEntidad.oAtributosAuditoria.TipoConvenio != .oEntidad.TipoConvenio or  .oEntidad.oAtributosAuditoria.ListaDePrecio != .oEntidad.ListaDePrecio_Pk or  .oEntidad.oAtributosAuditoria.NroIIBB != .oEntidad.NroIIBB or  .oEntidad.oAtributosAuditoria.CUIT != .oEntidad.CUIT or  .oEntidad.oAtributosAuditoria.RUT != .oEntidad.RUT or  .oEntidad.oAtributosAuditoria.TopeCtaCte != .oEntidad.TopeCtaCte )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CLI set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'">>,"Cd1" = <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'">>,"Clser" = <<lxCliClser>>,"Clfing" = <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'">>,"Globalid" = <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCliDescfw ) + "'">>,"Nomrecom" = <<"'" + this.FormatearTextoSql( lxCliNomrecom ) + "'">>,"Codrecom" = <<"'" + this.FormatearTextoSql( lxCliCodrecom ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'">>,"Clprov" = <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'">>,"Clpin" = <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'">>,"Timestamp" = <<lxCliTimestamp>>,"Centid" = <<lxCliCentid>>,"Cltpo" = <<lxCliCltpo>>,"Inactivofw" = <<iif( lxCliInactivofw, 1, 0 )>>,"Cimagen" = <<"'" + this.FormatearTextoSql( lxCliCimagen ) + "'">>,"Clvend" = <<"'" + this.FormatearTextoSql( lxCliClvend ) + "'">>,"Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'">>,"Pcuit" = <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'">>,"Clperibru" = <<"'" + this.FormatearTextoSql( lxCliClperibru ) + "'">>,"Clcalle" = <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'">>,"Climpd" = <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'">>,"Cliva" = <<lxCliCliva>>,"Clclas" = <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'">>,"Cltrans" = <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'">>,"Clcodfant" = <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'">>,"Expergan" = <<iif( lxCliExpergan, 1, 0 )>>,"Experiva" = <<iif( lxCliExperiva, 1, 0 )>>,"Cltipconv" = <<lxCliCltipconv>>,"Cltipodoc" = <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'">>,"Clcfi" = <<lxCliClcfi>>,"Clnro" = <<lxCliClnro>>,"Clmovil" = <<"'" + this.FormatearTextoSql( lxCliClmovil ) + "'">>,"Cllisprec" = <<"'" + this.FormatearTextoSql( lxCliCllisprec ) + "'">>,"Cltipocli" = <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'">>,"Vhastagan" = <<"'" + this.ConvertirDateSql( lxCliVhastagan ) + "'">>,"Vhastaiva" = <<"'" + this.ConvertirDateSql( lxCliVhastaiva ) + "'">>,"Clnroiibb" = <<lxCliClnroiibb>>,"Clcuit" = <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'">>,"Clnrodoc" = <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'">>,"Clpiso" = <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'">>,"Clfax" = <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'">>,"Cnx1" = <<lxCliCnx1>>,"Sexo" = <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'">>,"Clsitgan" = <<lxCliClsitgan>>,"Rut" = <<"'" + this.FormatearTextoSql( lxCliRut ) + "'">>,"Clcategcli" = <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'">>,"Clpertiva" = <<"'" + this.FormatearTextoSql( lxCliClpertiva ) + "'">>,"Clco_dto" = <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'">>,"Clfecha" = <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'">>,"Clpageweb" = <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'">>,"Cldepto" = <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'">>,"Clacum" = <<lxCliClacum>>,"Cltopeccte" = <<lxCliCltopeccte>>,"Clsiprib" = <<"'" + this.FormatearTextoSql( lxCliClsiprib ) + "'">>,"Clpergan" = <<"'" + this.FormatearTextoSql( lxCliClpergan ) + "'">>,"Clprinom" = <<"'" + this.FormatearTextoSql( lxCliClprinom ) + "'">>,"Cltope" = <<lxCliCltope>>,"Clsujvinc" = <<iif( lxCliClsujvinc, 1, 0 )>>,"Clloc" = <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'">>,"Estado" = <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'">>,"Clcondpag" = <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'">>,"Clsegnom" = <<"'" + this.FormatearTextoSql( lxCliClsegnom ) + "'">>,"Porcentc" = <<lxCliPorcentc>>,"Clcp" = <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'">>,"Hijos" = <<lxCliHijos>>,"Clapell" = <<"'" + this.FormatearTextoSql( lxCliClapell ) + "'">>,"Aplicatc" = <<iif( lxCliAplicatc, 1, 0 )>>,"Clprv" = <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'">>,"Clnom" = <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'">>,"Clpais" = <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'">>,"Clemail" = <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'">> where "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">> and  CLI.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CliOtrasDir where "ODCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PerExcluido where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CONTACTODET where "CONCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PerCliDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OtrasDirecciones
				if this.oEntidad.OtrasDirecciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCalle = loItem.Calle
					lxNumero = loItem.Numero
					lxPiso = loItem.Piso
					lxDepartamento = loItem.Departamento
					lxLocalidad = loItem.Localidad
					lxCodigopostal = loItem.Codigopostal
					lxProvincia_PK = loItem.Provincia_PK
					lxProvinciadetalle = loItem.Provinciadetalle
					lxPais_PK = loItem.Pais_PK
					lxPaisdetalle = loItem.Paisdetalle
					lxTelefono = loItem.Telefono
					lxTipodireccion_PK = loItem.Tipodireccion_PK
					lxNotas = loItem.Notas
					lxPreferente = loItem.Preferente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CliOtrasDir("NROITEM","ODCOD","ODCalle","ODNro","ODPiso","ODDepto","ODLoc","ODCP","ODPrv","ODPrvNom","ODPais","ODPAISNom","ODTel","ODTipoDir","ODNotas","ODPref" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCalle ) + "'">>, <<lxNumero>>, <<"'" + this.FormatearTextoSql( lxPiso ) + "'">>, <<"'" + this.FormatearTextoSql( lxDepartamento ) + "'">>, <<"'" + this.FormatearTextoSql( lxLocalidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigopostal ) + "'">>, <<"'" + this.FormatearTextoSql( lxProvincia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProvinciadetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPais_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPaisdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefono ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodireccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">>, <<iif( lxPreferente, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ExcluidoOtraPercep
				if this.oEntidad.ExcluidoOtraPercep.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigo_PK = loItem.Codigo_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PerExcluido("NROITEM","Cod","Codigo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigo_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Percepciones
				if this.oEntidad.Percepciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigopadroniibb = loItem.Codigopadroniibb
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxJurisdicciondetalle = loItem.Jurisdicciondetalle
					lxResolucion = loItem.Resolucion
					lxPorcentaje = loItem.Porcentaje
					lxFechaexpiracion = loItem.Fechaexpiracion
					lxExcluido = loItem.Excluido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PerCliDet("NROITEM","Cod","CODIGO","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigopadroniibb ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxPorcentaje>>, <<"'" + this.ConvertirDateSql( lxFechaexpiracion ) + "'">>, <<iif( lxExcluido, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
			dodefault()
			local lxCodigo, lxClasificacion
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			lxClasificacion = this.oEntidad.Clasificacion_pk
			this.oSP.ActualizarClasificacionLimiteConsumo(lxCodigo, lxClasificacion)
			local lxCodigo, lxClasificacion
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			lxClasificacion = this.oEntidad.Clasificacion_pk
			this.oSP.ActualizarClasificacionConsumoCliente(lxCodigo, lxClasificacion)
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
		this.oEntidad.Timestamp = lxCliTimestamp
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
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Globalid" as "Idglobal", "Descfw" as "Descripcionfw", "Nomrecom" as "Nombrerecomendante", "Codrecom" as "Codrecomendante", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Clprov" as "Jurisdiccion", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Clpin" as "Pin", "Timestamp" as "Timestamp", "Centid" as "Idcentralizador", "Cltpo" as "Tipointerno", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clvend" as "Vendedor", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Clperibru" as "Percepcioningresosbrutos", "Clcalle" as "Calle", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Clclas" as "Clasificacion", "Cltrans" as "Transportista", "Clcodfant" as "Codnombrefantasia", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clmovil" as "Movil", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clcuit" as "Cuit", "Clnrodoc" as "Nrodocumento", "Clpiso" as "Piso", "Clfax" as "Fax", "Cnx1" as "Credito", "Sexo" as "Sexo", "Clsitgan" as "Situacionganancias", "Rut" as "Rut", "Clcategcli" as "Categcli", "Clpertiva" as "Percepcioniva", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Clacum" as "Dolaresacumulados", "Cltopeccte" as "Topectacte", "Clsiprib" as "Codigosiprib", "Clpergan" as "Percepcionganancias", "Clprinom" as "Primernombre", "Cltope" as "Topefacturacion", "Clsujvinc" as "Sujetovinculado", "Clloc" as "Localidad", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clsegnom" as "Segundonombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clapell" as "Apellido", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Clnom" as "Nombre", "Clpais" as "Pais", "Clemail" as "Email" from ZooLogic.CLI where "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">> and  CLI.CLCOD != ''
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )

			if reccount( 'c_CLIENTE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Odcod" as "Codigo", "Odcalle" as "Calle", "Odnro" as "Numero", "Odpiso" as "Piso", "Oddepto" as "Departamento", "Odloc" as "Localidad", "Odcp" as "Codigopostal", "Odprv" as "Provincia", "Odprvnom" as "Provinciadetalle", "Odpais" as "Pais", "Odpaisnom" as "Paisdetalle", "Odtel" as "Telefono", "Odtipodir" as "Tipodireccion", "Odnotas" as "Notas", "Odpref" as "Preferente" from ZooLogic.CliOtrasDir where ODCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OtrasDirecciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OtrasDirecciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OtrasDirecciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigocliente", "Codigo" as "Codigo" from ZooLogic.PerExcluido where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ExcluidoOtraPercep')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ExcluidoOtraPercep', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ExcluidoOtraPercep
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Codigo" as "Codigopadroniibb", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido" from ZooLogic.PerCliDet where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Percepciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Percepciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Percepciones
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Globalid" as "Idglobal", "Descfw" as "Descripcionfw", "Nomrecom" as "Nombrerecomendante", "Codrecom" as "Codrecomendante", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Clprov" as "Jurisdiccion", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Clpin" as "Pin", "Timestamp" as "Timestamp", "Centid" as "Idcentralizador", "Cltpo" as "Tipointerno", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clvend" as "Vendedor", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Clperibru" as "Percepcioningresosbrutos", "Clcalle" as "Calle", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Clclas" as "Clasificacion", "Cltrans" as "Transportista", "Clcodfant" as "Codnombrefantasia", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clmovil" as "Movil", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clcuit" as "Cuit", "Clnrodoc" as "Nrodocumento", "Clpiso" as "Piso", "Clfax" as "Fax", "Cnx1" as "Credito", "Sexo" as "Sexo", "Clsitgan" as "Situacionganancias", "Rut" as "Rut", "Clcategcli" as "Categcli", "Clpertiva" as "Percepcioniva", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Clacum" as "Dolaresacumulados", "Cltopeccte" as "Topectacte", "Clsiprib" as "Codigosiprib", "Clpergan" as "Percepcionganancias", "Clprinom" as "Primernombre", "Cltope" as "Topefacturacion", "Clsujvinc" as "Sujetovinculado", "Clloc" as "Localidad", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clsegnom" as "Segundonombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clapell" as "Apellido", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Clnom" as "Nombre", "Clpais" as "Pais", "Clemail" as "Email" from ZooLogic.CLI where  CLI.CLCOD != '' order by CLCOD
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Odcod" as "Codigo", "Odcalle" as "Calle", "Odnro" as "Numero", "Odpiso" as "Piso", "Oddepto" as "Departamento", "Odloc" as "Localidad", "Odcp" as "Codigopostal", "Odprv" as "Provincia", "Odprvnom" as "Provinciadetalle", "Odpais" as "Pais", "Odpaisnom" as "Paisdetalle", "Odtel" as "Telefono", "Odtipodir" as "Tipodireccion", "Odnotas" as "Notas", "Odpref" as "Preferente" from ZooLogic.CliOtrasDir where ODCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OtrasDirecciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OtrasDirecciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OtrasDirecciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigocliente", "Codigo" as "Codigo" from ZooLogic.PerExcluido where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ExcluidoOtraPercep')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ExcluidoOtraPercep', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ExcluidoOtraPercep
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Codigo" as "Codigopadroniibb", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido" from ZooLogic.PerCliDet where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Percepciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Percepciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Percepciones
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Globalid" as "Idglobal", "Descfw" as "Descripcionfw", "Nomrecom" as "Nombrerecomendante", "Codrecom" as "Codrecomendante", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Clprov" as "Jurisdiccion", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Clpin" as "Pin", "Timestamp" as "Timestamp", "Centid" as "Idcentralizador", "Cltpo" as "Tipointerno", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clvend" as "Vendedor", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Clperibru" as "Percepcioningresosbrutos", "Clcalle" as "Calle", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Clclas" as "Clasificacion", "Cltrans" as "Transportista", "Clcodfant" as "Codnombrefantasia", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clmovil" as "Movil", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clcuit" as "Cuit", "Clnrodoc" as "Nrodocumento", "Clpiso" as "Piso", "Clfax" as "Fax", "Cnx1" as "Credito", "Sexo" as "Sexo", "Clsitgan" as "Situacionganancias", "Rut" as "Rut", "Clcategcli" as "Categcli", "Clpertiva" as "Percepcioniva", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Clacum" as "Dolaresacumulados", "Cltopeccte" as "Topectacte", "Clsiprib" as "Codigosiprib", "Clpergan" as "Percepcionganancias", "Clprinom" as "Primernombre", "Cltope" as "Topefacturacion", "Clsujvinc" as "Sujetovinculado", "Clloc" as "Localidad", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clsegnom" as "Segundonombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clapell" as "Apellido", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Clnom" as "Nombre", "Clpais" as "Pais", "Clemail" as "Email" from ZooLogic.CLI where  funciones.padr( CLCOD, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CLI.CLCOD != '' order by CLCOD
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Odcod" as "Codigo", "Odcalle" as "Calle", "Odnro" as "Numero", "Odpiso" as "Piso", "Oddepto" as "Departamento", "Odloc" as "Localidad", "Odcp" as "Codigopostal", "Odprv" as "Provincia", "Odprvnom" as "Provinciadetalle", "Odpais" as "Pais", "Odpaisnom" as "Paisdetalle", "Odtel" as "Telefono", "Odtipodir" as "Tipodireccion", "Odnotas" as "Notas", "Odpref" as "Preferente" from ZooLogic.CliOtrasDir where ODCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OtrasDirecciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OtrasDirecciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OtrasDirecciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigocliente", "Codigo" as "Codigo" from ZooLogic.PerExcluido where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ExcluidoOtraPercep')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ExcluidoOtraPercep', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ExcluidoOtraPercep
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Codigo" as "Codigopadroniibb", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido" from ZooLogic.PerCliDet where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Percepciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Percepciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Percepciones
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Globalid" as "Idglobal", "Descfw" as "Descripcionfw", "Nomrecom" as "Nombrerecomendante", "Codrecom" as "Codrecomendante", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Clprov" as "Jurisdiccion", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Clpin" as "Pin", "Timestamp" as "Timestamp", "Centid" as "Idcentralizador", "Cltpo" as "Tipointerno", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clvend" as "Vendedor", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Clperibru" as "Percepcioningresosbrutos", "Clcalle" as "Calle", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Clclas" as "Clasificacion", "Cltrans" as "Transportista", "Clcodfant" as "Codnombrefantasia", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clmovil" as "Movil", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clcuit" as "Cuit", "Clnrodoc" as "Nrodocumento", "Clpiso" as "Piso", "Clfax" as "Fax", "Cnx1" as "Credito", "Sexo" as "Sexo", "Clsitgan" as "Situacionganancias", "Rut" as "Rut", "Clcategcli" as "Categcli", "Clpertiva" as "Percepcioniva", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Clacum" as "Dolaresacumulados", "Cltopeccte" as "Topectacte", "Clsiprib" as "Codigosiprib", "Clpergan" as "Percepcionganancias", "Clprinom" as "Primernombre", "Cltope" as "Topefacturacion", "Clsujvinc" as "Sujetovinculado", "Clloc" as "Localidad", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clsegnom" as "Segundonombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clapell" as "Apellido", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Clnom" as "Nombre", "Clpais" as "Pais", "Clemail" as "Email" from ZooLogic.CLI where  funciones.padr( CLCOD, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CLI.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Odcod" as "Codigo", "Odcalle" as "Calle", "Odnro" as "Numero", "Odpiso" as "Piso", "Oddepto" as "Departamento", "Odloc" as "Localidad", "Odcp" as "Codigopostal", "Odprv" as "Provincia", "Odprvnom" as "Provinciadetalle", "Odpais" as "Pais", "Odpaisnom" as "Paisdetalle", "Odtel" as "Telefono", "Odtipodir" as "Tipodireccion", "Odnotas" as "Notas", "Odpref" as "Preferente" from ZooLogic.CliOtrasDir where ODCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OtrasDirecciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OtrasDirecciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OtrasDirecciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigocliente", "Codigo" as "Codigo" from ZooLogic.PerExcluido where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ExcluidoOtraPercep')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ExcluidoOtraPercep', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ExcluidoOtraPercep
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Codigo" as "Codigopadroniibb", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido" from ZooLogic.PerCliDet where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Percepciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Percepciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Percepciones
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Globalid" as "Idglobal", "Descfw" as "Descripcionfw", "Nomrecom" as "Nombrerecomendante", "Codrecom" as "Codrecomendante", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Clprov" as "Jurisdiccion", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Clpin" as "Pin", "Timestamp" as "Timestamp", "Centid" as "Idcentralizador", "Cltpo" as "Tipointerno", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clvend" as "Vendedor", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Clperibru" as "Percepcioningresosbrutos", "Clcalle" as "Calle", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Clclas" as "Clasificacion", "Cltrans" as "Transportista", "Clcodfant" as "Codnombrefantasia", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clmovil" as "Movil", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clcuit" as "Cuit", "Clnrodoc" as "Nrodocumento", "Clpiso" as "Piso", "Clfax" as "Fax", "Cnx1" as "Credito", "Sexo" as "Sexo", "Clsitgan" as "Situacionganancias", "Rut" as "Rut", "Clcategcli" as "Categcli", "Clpertiva" as "Percepcioniva", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Clacum" as "Dolaresacumulados", "Cltopeccte" as "Topectacte", "Clsiprib" as "Codigosiprib", "Clpergan" as "Percepcionganancias", "Clprinom" as "Primernombre", "Cltope" as "Topefacturacion", "Clsujvinc" as "Sujetovinculado", "Clloc" as "Localidad", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clsegnom" as "Segundonombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clapell" as "Apellido", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Clnom" as "Nombre", "Clpais" as "Pais", "Clemail" as "Email" from ZooLogic.CLI where  CLI.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Odcod" as "Codigo", "Odcalle" as "Calle", "Odnro" as "Numero", "Odpiso" as "Piso", "Oddepto" as "Departamento", "Odloc" as "Localidad", "Odcp" as "Codigopostal", "Odprv" as "Provincia", "Odprvnom" as "Provinciadetalle", "Odpais" as "Pais", "Odpaisnom" as "Paisdetalle", "Odtel" as "Telefono", "Odtipodir" as "Tipodireccion", "Odnotas" as "Notas", "Odpref" as "Preferente" from ZooLogic.CliOtrasDir where ODCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OtrasDirecciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OtrasDirecciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OtrasDirecciones
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigocliente", "Codigo" as "Codigo" from ZooLogic.PerExcluido where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ExcluidoOtraPercep')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ExcluidoOtraPercep', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ExcluidoOtraPercep
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Codigo" as "Codigopadroniibb", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido" from ZooLogic.PerCliDet where Cod = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Percepciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Percepciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Percepciones
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Cd1,Fecexpo,Faltafw,Clser,Clfing,Zadsfw,Esttrans,Bdaltafw,Globalid," + ;
"Descfw,Nomrecom,Codrecom,Bdmodifw,Vmodifw,Saltafw,Hmodifw,Smodifw,Clprov,Horaimpo,Horaexpo,Valtafw,U" + ;
"altafw,Haltafw,Umodifw,Clpin,Timestamp,Centid,Cltpo,Inactivofw,Cimagen,Clvend,Clcod,Clobs,Pcuit,Clpe" + ;
"ribru,Clcalle,Climpd,Cltlf,Cliva,Clclas,Cltrans,Clcodfant,Expergan,Experiva,Cltipconv,Cltipodoc,Clcf" + ;
"i,Clnro,Clmovil,Cllisprec,Cltipocli,Vhastagan,Vhastaiva,Clnroiibb,Clcuit,Clnrodoc,Clpiso,Clfax,Cnx1," + ;
"Sexo,Clsitgan,Rut,Clcategcli,Clpertiva,Clco_dto,Clfecha,Clpageweb,Cldepto,Clacum,Cltopeccte,Clsiprib" + ;
",Clpergan,Clprinom,Cltope,Clsujvinc,Clloc,Estado,Clcondpag,Clsegnom,Porcentc,Clcp,Hijos,Clapell,Apli" + ;
"catc,Clprv,Clnom,Clpais,Clemail" + ;
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
			local  lxCliFecimpo, lxCliFectrans, lxCliFmodifw, lxCliCd1, lxCliFecexpo, lxCliFaltafw, lxCliClser, lxCliClfing, lxCliZadsfw, lxCliEsttrans, lxCliBdaltafw, lxCliGlobalid, lxCliDescfw, lxCliNomrecom, lxCliCodrecom, lxCliBdmodifw, lxCliVmodifw, lxCliSaltafw, lxCliHmodifw, lxCliSmodifw, lxCliClprov, lxCliHoraimpo, lxCliHoraexpo, lxCliValtafw, lxCliUaltafw, lxCliHaltafw, lxCliUmodifw, lxCliClpin, lxCliTimestamp, lxCliCentid, lxCliCltpo, lxCliInactivofw, lxCliCimagen, lxCliClvend, lxCliClcod, lxCliClobs, lxCliPcuit, lxCliClperibru, lxCliClcalle, lxCliClimpd, lxCliCltlf, lxCliCliva, lxCliClclas, lxCliCltrans, lxCliClcodfant, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliCltipodoc, lxCliClcfi, lxCliClnro, lxCliClmovil, lxCliCllisprec, lxCliCltipocli, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClcuit, lxCliClnrodoc, lxCliClpiso, lxCliClfax, lxCliCnx1, lxCliSexo, lxCliClsitgan, lxCliRut, lxCliClcategcli, lxCliClpertiva, lxCliClco_dto, lxCliClfecha, lxCliClpageweb, lxCliCldepto, lxCliClacum, lxCliCltopeccte, lxCliClsiprib, lxCliClpergan, lxCliClprinom, lxCliCltope, lxCliClsujvinc, lxCliClloc, lxCliEstado, lxCliClcondpag, lxCliClsegnom, lxCliPorcentc, lxCliClcp, lxCliHijos, lxCliClapell, lxCliAplicatc, lxCliClprv, lxCliClnom, lxCliClpais, lxCliClemail
				lxCliFecimpo = ctod( '  /  /    ' )			lxCliFectrans = ctod( '  /  /    ' )			lxCliFmodifw = ctod( '  /  /    ' )			lxCliCd1 = ctod( '  /  /    ' )			lxCliFecexpo = ctod( '  /  /    ' )			lxCliFaltafw = ctod( '  /  /    ' )			lxCliClser = 0			lxCliClfing = ctod( '  /  /    ' )			lxCliZadsfw = []			lxCliEsttrans = []			lxCliBdaltafw = []			lxCliGlobalid = []			lxCliDescfw = []			lxCliNomrecom = []			lxCliCodrecom = []			lxCliBdmodifw = []			lxCliVmodifw = []			lxCliSaltafw = []			lxCliHmodifw = []			lxCliSmodifw = []			lxCliClprov = []			lxCliHoraimpo = []			lxCliHoraexpo = []			lxCliValtafw = []			lxCliUaltafw = []			lxCliHaltafw = []			lxCliUmodifw = []			lxCliClpin = []			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliCentid = 0			lxCliCltpo = 0			lxCliInactivofw = .F.			lxCliCimagen = []			lxCliClvend = []			lxCliClcod = []			lxCliClobs = []			lxCliPcuit = []			lxCliClperibru = []			lxCliClcalle = []			lxCliClimpd = []			lxCliCltlf = []			lxCliCliva = 0			lxCliClclas = []			lxCliCltrans = []			lxCliClcodfant = []			lxCliExpergan = .F.			lxCliExperiva = .F.			lxCliCltipconv = 0			lxCliCltipodoc = []			lxCliClcfi = 0			lxCliClnro = 0			lxCliClmovil = []			lxCliCllisprec = []			lxCliCltipocli = []			lxCliVhastagan = ctod( '  /  /    ' )			lxCliVhastaiva = ctod( '  /  /    ' )			lxCliClnroiibb = 0			lxCliClcuit = []			lxCliClnrodoc = []			lxCliClpiso = []			lxCliClfax = []			lxCliCnx1 = 0			lxCliSexo = []			lxCliClsitgan = 0			lxCliRut = []			lxCliClcategcli = []			lxCliClpertiva = []			lxCliClco_dto = []			lxCliClfecha = ctod( '  /  /    ' )			lxCliClpageweb = []			lxCliCldepto = []			lxCliClacum = 0			lxCliCltopeccte = 0			lxCliClsiprib = []			lxCliClpergan = []			lxCliClprinom = []			lxCliCltope = 0			lxCliClsujvinc = .F.			lxCliClloc = []			lxCliEstado = []			lxCliClcondpag = []			lxCliClsegnom = []			lxCliPorcentc = 0			lxCliClcp = []			lxCliHijos = 0			lxCliClapell = []			lxCliAplicatc = .F.			lxCliClprv = []			lxCliClnom = []			lxCliClpais = []			lxCliClemail = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CliOtrasDir where "ODCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PerExcluido where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CONTACTODET where "CONCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PerCliDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CLI where "CLCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Globalid" as "Idglobal", "Descfw" as "Descripcionfw", "Nomrecom" as "Nombrerecomendante", "Codrecom" as "Codrecomendante", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Clprov" as "Jurisdiccion", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Clpin" as "Pin", "Timestamp" as "Timestamp", "Centid" as "Idcentralizador", "Cltpo" as "Tipointerno", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clvend" as "Vendedor", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Clperibru" as "Percepcioningresosbrutos", "Clcalle" as "Calle", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Clclas" as "Clasificacion", "Cltrans" as "Transportista", "Clcodfant" as "Codnombrefantasia", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clmovil" as "Movil", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clcuit" as "Cuit", "Clnrodoc" as "Nrodocumento", "Clpiso" as "Piso", "Clfax" as "Fax", "Cnx1" as "Credito", "Sexo" as "Sexo", "Clsitgan" as "Situacionganancias", "Rut" as "Rut", "Clcategcli" as "Categcli", "Clpertiva" as "Percepcioniva", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Clacum" as "Dolaresacumulados", "Cltopeccte" as "Topectacte", "Clsiprib" as "Codigosiprib", "Clpergan" as "Percepcionganancias", "Clprinom" as "Primernombre", "Cltope" as "Topefacturacion", "Clsujvinc" as "Sujetovinculado", "Clloc" as "Localidad", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clsegnom" as "Segundonombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clapell" as "Apellido", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Clnom" as "Nombre", "Clpais" as "Pais", "Clemail" as "Email"
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
	Function ObtenerDatosDetalleOtrasDirecciones( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CLIOTRASDIR.ODCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Odcod" as "Codigo", "Odcalle" as "Calle", "Odnro" as "Numero", "Odpiso" as "Piso", "Oddepto" as "Departamento", "Odloc" as "Localidad", "Odcp" as "Codigopostal", "Odprv" as "Provincia", "Odprvnom" as "Provinciadetalle", "Odpais" as "Pais", "Odpaisnom" as "Paisdetalle", "Odtel" as "Telefono", "Odtipodir" as "Tipodireccion", "Odnotas" as "Notas", "Odpref" as "Preferente"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOtrasDirecciones( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CliOtrasDir', 'OtrasDirecciones', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOtrasDirecciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOtrasDirecciones( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleExcluidoOtraPercep( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PEREXCLUIDO.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Cod" as "Codigocliente", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleExcluidoOtraPercep( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PerExcluido', 'ExcluidoOtraPercep', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleExcluidoOtraPercep( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleExcluidoOtraPercep( lcAtributo )
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
	Function ObtenerDatosDetallePercepciones( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PERCLIDET.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Cod" as "Codigo", "Codigo" as "Codigopadroniibb", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallePercepciones( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PerCliDet', 'Percepciones', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallePercepciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallePercepciones( lcAtributo )
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
				Case lcAtributo == 'FECHAULTIMAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CD1 AS FECHAULTIMAMODIFICACION'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'CLASIFICACION2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSER AS CLASIFICACION2'
				Case lcAtributo == 'FECHADEALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFING AS FECHADEALTA'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'IDGLOBAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GLOBALID AS IDGLOBAL'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'NOMBRERECOMENDANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMRECOM AS NOMBRERECOMENDANTE'
				Case lcAtributo == 'CODRECOMENDANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODRECOM AS CODRECOMENDANTE'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPROV AS JURISDICCION'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'PIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPIN AS PIN'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'IDCENTRALIZADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTID AS IDCENTRALIZADOR'
				Case lcAtributo == 'TIPOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTPO AS TIPOINTERNO'
				Case lcAtributo == 'INACTIVOFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INACTIVOFW AS INACTIVOFW'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIMAGEN AS IMAGEN'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVEND AS VENDEDOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'CUITPAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUIT AS CUITPAIS'
				Case lcAtributo == 'PERCEPCIONINGRESOSBRUTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPERIBRU AS PERCEPCIONINGRESOSBRUTOS'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCALLE AS CALLE'
				Case lcAtributo == 'CLASIFICACIONSECUNDARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIMPD AS CLASIFICACIONSECUNDARIA'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIVA AS SITUACIONFISCAL'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCLAS AS CLASIFICACION'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTRANS AS TRANSPORTISTA'
				Case lcAtributo == 'CODNOMBREFANTASIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCODFANT AS CODNOMBREFANTASIA'
				Case lcAtributo == 'EXCLUIDOPERCEPCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPERGAN AS EXCLUIDOPERCEPCIONGANANCIAS'
				Case lcAtributo == 'EXCLUIDOPERCEPCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPERIVA AS EXCLUIDOPERCEPCIONIVA'
				Case lcAtributo == 'TIPOCONVENIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPCONV AS TIPOCONVENIO'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'CFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS CFI'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRO AS NUMERO'
				Case lcAtributo == 'MOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMOVIL AS MOVIL'
				Case lcAtributo == 'LISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLISPREC AS LISTADEPRECIO'
				Case lcAtributo == 'TIPOCLI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPOCLI AS TIPOCLI'
				Case lcAtributo == 'VIGENCIAHASTAGAN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VHASTAGAN AS VIGENCIAHASTAGAN'
				Case lcAtributo == 'VIGENCIAHASTAIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VHASTAIVA AS VIGENCIAHASTAIVA'
				Case lcAtributo == 'NROIIBB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNROIIBB AS NROIIBB'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCUIT AS CUIT'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPISO AS PISO'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFAX AS FAX'
				Case lcAtributo == 'CREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNX1 AS CREDITO'
				Case lcAtributo == 'SEXO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEXO AS SEXO'
				Case lcAtributo == 'SITUACIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSITGAN AS SITUACIONGANANCIAS'
				Case lcAtributo == 'RUT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUT AS RUT'
				Case lcAtributo == 'CATEGCLI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCATEGCLI AS CATEGCLI'
				Case lcAtributo == 'PERCEPCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPERTIVA AS PERCEPCIONIVA'
				Case lcAtributo == 'DESCUENTOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCO_DTO AS DESCUENTOPREFERENTE'
				Case lcAtributo == 'FECHANACIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFECHA AS FECHANACIMIENTO'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'DOLARESACUMULADOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLACUM AS DOLARESACUMULADOS'
				Case lcAtributo == 'TOPECTACTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTOPECCTE AS TOPECTACTE'
				Case lcAtributo == 'CODIGOSIPRIB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSIPRIB AS CODIGOSIPRIB'
				Case lcAtributo == 'PERCEPCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPERGAN AS PERCEPCIONGANANCIAS'
				Case lcAtributo == 'PRIMERNOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRINOM AS PRIMERNOMBRE'
				Case lcAtributo == 'TOPEFACTURACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTOPE AS TOPEFACTURACION'
				Case lcAtributo == 'SUJETOVINCULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSUJVINC AS SUJETOVINCULADO'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'ESTADOCIVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADOCIVIL'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCONDPAG AS CONDICIONDEPAGO'
				Case lcAtributo == 'SEGUNDONOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSEGNOM AS SEGUNDONOMBRE'
				Case lcAtributo == 'TASACEROPORCEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENTC AS TASACEROPORCEN'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'HIJOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HIJOS AS HIJOS'
				Case lcAtributo == 'APELLIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAPELL AS APELLIDO'
				Case lcAtributo == 'TASACEROAPLICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APLICATC AS TASACEROAPLICA'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAIS AS PAIS'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOtrasDirecciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODCOD AS CODIGO'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODCALLE AS CALLE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODNRO AS NUMERO'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODPISO AS PISO'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODLOC AS LOCALIDAD'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODPRV AS PROVINCIA'
				Case lcAtributo == 'PROVINCIADETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODPRVNOM AS PROVINCIADETALLE'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODPAIS AS PAIS'
				Case lcAtributo == 'PAISDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODPAISNOM AS PAISDETALLE'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODTEL AS TELEFONO'
				Case lcAtributo == 'TIPODIRECCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODTIPODIR AS TIPODIRECCION'
				Case lcAtributo == 'NOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODNOTAS AS NOTAS'
				Case lcAtributo == 'PREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ODPREF AS PREFERENTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleExcluidoOtraPercep( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGOCLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGOCLIENTE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
	Function ObtenerCamposSelectDetallePercepciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGO'
				Case lcAtributo == 'CODIGOPADRONIIBB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGOPADRONIIBB'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURISDICCI AS JURISDICCION'
				Case lcAtributo == 'JURISDICCIONDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESJUR AS JURISDICCIONDETALLE'
				Case lcAtributo == 'RESOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESOL AS RESOLUCION'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'FECHAEXPIRACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXP AS FECHAEXPIRACION'
				Case lcAtributo == 'EXCLUIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXCLUIDO AS EXCLUIDO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTIMAMODIFICACION'
				lcCampo = 'CD1'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION2'
				lcCampo = 'CLSER'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADEALTA'
				lcCampo = 'CLFING'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'IDGLOBAL'
				lcCampo = 'GLOBALID'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRERECOMENDANTE'
				lcCampo = 'NOMRECOM'
			Case upper( alltrim( tcAtributo ) ) == 'CODRECOMENDANTE'
				lcCampo = 'CODRECOM'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'CLPROV'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'PIN'
				lcCampo = 'CLPIN'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'IDCENTRALIZADOR'
				lcCampo = 'CENTID'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO'
				lcCampo = 'CLTPO'
			Case upper( alltrim( tcAtributo ) ) == 'INACTIVOFW'
				lcCampo = 'INACTIVOFW'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'CIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'CLVEND'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CUITPAIS'
				lcCampo = 'PCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONINGRESOSBRUTOS'
				lcCampo = 'CLPERIBRU'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'CLCALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACIONSECUNDARIA'
				lcCampo = 'CLIMPD'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'CLIVA'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLCLAS'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'CLTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODNOMBREFANTASIA'
				lcCampo = 'CLCODFANT'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDOPERCEPCIONGANANCIAS'
				lcCampo = 'EXPERGAN'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDOPERCEPCIONIVA'
				lcCampo = 'EXPERIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCONVENIO'
				lcCampo = 'CLTIPCONV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'CLTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CFI'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CLNRO'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIL'
				lcCampo = 'CLMOVIL'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIO'
				lcCampo = 'CLLISPREC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCLI'
				lcCampo = 'CLTIPOCLI'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTAGAN'
				lcCampo = 'VHASTAGAN'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTAIVA'
				lcCampo = 'VHASTAIVA'
			Case upper( alltrim( tcAtributo ) ) == 'NROIIBB'
				lcCampo = 'CLNROIIBB'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CLCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CLNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'CLPISO'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'CLFAX'
			Case upper( alltrim( tcAtributo ) ) == 'CREDITO'
				lcCampo = 'CNX1'
			Case upper( alltrim( tcAtributo ) ) == 'SEXO'
				lcCampo = 'SEXO'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONGANANCIAS'
				lcCampo = 'CLSITGAN'
			Case upper( alltrim( tcAtributo ) ) == 'RUT'
				lcCampo = 'RUT'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGCLI'
				lcCampo = 'CLCATEGCLI'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVA'
				lcCampo = 'CLPERTIVA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPREFERENTE'
				lcCampo = 'CLCO_DTO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANACIMIENTO'
				lcCampo = 'CLFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'CLPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'CLDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'DOLARESACUMULADOS'
				lcCampo = 'CLACUM'
			Case upper( alltrim( tcAtributo ) ) == 'TOPECTACTE'
				lcCampo = 'CLTOPECCTE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOSIPRIB'
				lcCampo = 'CLSIPRIB'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONGANANCIAS'
				lcCampo = 'CLPERGAN'
			Case upper( alltrim( tcAtributo ) ) == 'PRIMERNOMBRE'
				lcCampo = 'CLPRINOM'
			Case upper( alltrim( tcAtributo ) ) == 'TOPEFACTURACION'
				lcCampo = 'CLTOPE'
			Case upper( alltrim( tcAtributo ) ) == 'SUJETOVINCULADO'
				lcCampo = 'CLSUJVINC'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOCIVIL'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CLCONDPAG'
			Case upper( alltrim( tcAtributo ) ) == 'SEGUNDONOMBRE'
				lcCampo = 'CLSEGNOM'
			Case upper( alltrim( tcAtributo ) ) == 'TASACEROPORCEN'
				lcCampo = 'PORCENTC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'HIJOS'
				lcCampo = 'HIJOS'
			Case upper( alltrim( tcAtributo ) ) == 'APELLIDO'
				lcCampo = 'CLAPELL'
			Case upper( alltrim( tcAtributo ) ) == 'TASACEROAPLICA'
				lcCampo = 'APLICATC'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'CLPAIS'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOtrasDirecciones( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ODCOD'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'ODCALLE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'ODNRO'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'ODPISO'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'ODDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'ODLOC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'ODCP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'ODPRV'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIADETALLE'
				lcCampo = 'ODPRVNOM'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'ODPAIS'
			Case upper( alltrim( tcAtributo ) ) == 'PAISDETALLE'
				lcCampo = 'ODPAISNOM'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'ODTEL'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODIRECCION'
				lcCampo = 'ODTIPODIR'
			Case upper( alltrim( tcAtributo ) ) == 'NOTAS'
				lcCampo = 'ODNOTAS'
			Case upper( alltrim( tcAtributo ) ) == 'PREFERENTE'
				lcCampo = 'ODPREF'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleExcluidoOtraPercep( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCLIENTE'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
	Function ObtenerCampoDetallePercepciones( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPADRONIIBB'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'JURISDICCI'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCIONDETALLE'
				lcCampo = 'DESJUR'
			Case upper( alltrim( tcAtributo ) ) == 'RESOLUCION'
				lcCampo = 'RESOL'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPIRACION'
				lcCampo = 'FECEXP'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDO'
				lcCampo = 'EXCLUIDO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'OTRASDIRECCIONES'
			lcRetorno = 'CLIOTRASDIR'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'EXCLUIDOOTRAPERCEP'
			lcRetorno = 'PEREXCLUIDO'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'CONTACTO'
			lcRetorno = 'CONTACTODET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'PERCEPCIONES'
			lcRetorno = 'PERCLIDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCliFecimpo, lxCliFectrans, lxCliFmodifw, lxCliCd1, lxCliFecexpo, lxCliFaltafw, lxCliClser, lxCliClfing, lxCliZadsfw, lxCliEsttrans, lxCliBdaltafw, lxCliGlobalid, lxCliDescfw, lxCliNomrecom, lxCliCodrecom, lxCliBdmodifw, lxCliVmodifw, lxCliSaltafw, lxCliHmodifw, lxCliSmodifw, lxCliClprov, lxCliHoraimpo, lxCliHoraexpo, lxCliValtafw, lxCliUaltafw, lxCliHaltafw, lxCliUmodifw, lxCliClpin, lxCliTimestamp, lxCliCentid, lxCliCltpo, lxCliInactivofw, lxCliCimagen, lxCliClvend, lxCliClcod, lxCliClobs, lxCliPcuit, lxCliClperibru, lxCliClcalle, lxCliClimpd, lxCliCltlf, lxCliCliva, lxCliClclas, lxCliCltrans, lxCliClcodfant, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliCltipodoc, lxCliClcfi, lxCliClnro, lxCliClmovil, lxCliCllisprec, lxCliCltipocli, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClcuit, lxCliClnrodoc, lxCliClpiso, lxCliClfax, lxCliCnx1, lxCliSexo, lxCliClsitgan, lxCliRut, lxCliClcategcli, lxCliClpertiva, lxCliClco_dto, lxCliClfecha, lxCliClpageweb, lxCliCldepto, lxCliClacum, lxCliCltopeccte, lxCliClsiprib, lxCliClpergan, lxCliClprinom, lxCliCltope, lxCliClsujvinc, lxCliClloc, lxCliEstado, lxCliClcondpag, lxCliClsegnom, lxCliPorcentc, lxCliClcp, lxCliHijos, lxCliClapell, lxCliAplicatc, lxCliClprv, lxCliClnom, lxCliClpais, lxCliClemail
				lxCliFecimpo =  .Fechaimpo			lxCliFectrans =  .Fechatransferencia			lxCliFmodifw =  .Fechamodificacionfw			lxCliCd1 =  .Fechaultimamodificacion			lxCliFecexpo =  .Fechaexpo			lxCliFaltafw =  .Fechaaltafw			lxCliClser =  .Clasificacion2			lxCliClfing =  .Fechadealta			lxCliZadsfw =  .Zadsfw			lxCliEsttrans =  .Estadotransferencia			lxCliBdaltafw =  .Basededatosaltafw			lxCliGlobalid =  .Idglobal			lxCliDescfw =  .Descripcionfw			lxCliNomrecom =  .Nombrerecomendante			lxCliCodrecom =  .Codrecomendante			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliVmodifw =  .Versionmodificacionfw			lxCliSaltafw =  .Seriealtafw			lxCliHmodifw =  .Horamodificacionfw			lxCliSmodifw =  .Seriemodificacionfw			lxCliClprov =  .Jurisdiccion			lxCliHoraimpo =  .Horaimpo			lxCliHoraexpo =  .Horaexpo			lxCliValtafw =  .Versionaltafw			lxCliUaltafw =  .Usuarioaltafw			lxCliHaltafw =  .Horaaltafw			lxCliUmodifw =  .Usuariomodificacionfw			lxCliClpin =  .Pin			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliCentid =  .Idcentralizador			lxCliCltpo =  .Tipointerno			lxCliInactivofw =  .Inactivofw			lxCliCimagen =  .Imagen			lxCliClvend =  upper( .Vendedor_PK ) 			lxCliClcod =  .Codigo			lxCliClobs =  .Observacion			lxCliPcuit =  .Cuitpais			lxCliClperibru =  .Percepcioningresosbrutos			lxCliClcalle =  .Calle			lxCliClimpd =  .Clasificacionsecundaria			lxCliCltlf =  .Telefono			lxCliCliva =  .Situacionfiscal_PK 			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliExpergan =  .Excluidopercepcionganancias			lxCliExperiva =  .Excluidopercepcioniva			lxCliCltipconv =  .Tipoconvenio			lxCliCltipodoc =  .Tipodocumento			lxCliClcfi =  .Cfi			lxCliClnro =  .Numero			lxCliClmovil =  .Movil			lxCliCllisprec =  upper( .ListaDePrecio_PK ) 			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliVhastagan =  .Vigenciahastagan			lxCliVhastaiva =  .Vigenciahastaiva			lxCliClnroiibb =  .Nroiibb			lxCliClcuit =  .Cuit			lxCliClnrodoc =  .Nrodocumento			lxCliClpiso =  .Piso			lxCliClfax =  .Fax			lxCliCnx1 =  .Credito			lxCliSexo =  .Sexo			lxCliClsitgan =  .Situacionganancias			lxCliRut =  .Rut			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClpertiva =  upper( .PercepcionIva_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliClpageweb =  .Paginaweb			lxCliCldepto =  .Departamento			lxCliClacum =  .Dolaresacumulados			lxCliCltopeccte =  .Topectacte			lxCliClsiprib =  upper( .CodigoSiprib_PK ) 			lxCliClpergan =  upper( .PercepcionGanancias_PK ) 			lxCliClprinom =  .Primernombre			lxCliCltope =  .Topefacturacion			lxCliClsujvinc =  .Sujetovinculado			lxCliClloc =  .Localidad			lxCliEstado =  .Estadocivil			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClsegnom =  .Segundonombre			lxCliPorcentc =  .Tasaceroporcen			lxCliClcp =  .Codigopostal			lxCliHijos =  .Hijos			lxCliClapell =  .Apellido			lxCliAplicatc =  .Tasaceroaplica			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClnom =  .Nombre			lxCliClpais =  upper( .Pais_PK ) 			lxCliClemail =  .Email
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CLI ( "Fecimpo","Fectrans","Fmodifw","Cd1","Fecexpo","Faltafw","Clser","Clfing","Zadsfw","Esttrans","Bdaltafw","Globalid","Descfw","Nomrecom","Codrecom","Bdmodifw","Vmodifw","Saltafw","Hmodifw","Smodifw","Clprov","Horaimpo","Horaexpo","Valtafw","Ualtafw","Haltafw","Umodifw","Clpin","Timestamp","Centid","Cltpo","Inactivofw","Cimagen","Clvend","Clcod","Clobs","Pcuit","Clperibru","Clcalle","Climpd","Cltlf","Cliva","Clclas","Cltrans","Clcodfant","Expergan","Experiva","Cltipconv","Cltipodoc","Clcfi","Clnro","Clmovil","Cllisprec","Cltipocli","Vhastagan","Vhastaiva","Clnroiibb","Clcuit","Clnrodoc","Clpiso","Clfax","Cnx1","Sexo","Clsitgan","Rut","Clcategcli","Clpertiva","Clco_dto","Clfecha","Clpageweb","Cldepto","Clacum","Cltopeccte","Clsiprib","Clpergan","Clprinom","Cltope","Clsujvinc","Clloc","Estado","Clcondpag","Clsegnom","Porcentc","Clcp","Hijos","Clapell","Aplicatc","Clprv","Clnom","Clpais","Clemail" ) values ( <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'" >>, <<lxCliClser >>, <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliNomrecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCodrecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'" >>, <<lxCliTimestamp >>, <<lxCliCentid >>, <<lxCliCltpo >>, <<iif( lxCliInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClvend ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClperibru ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'" >>, <<lxCliCliva >>, <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'" >>, <<iif( lxCliExpergan, 1, 0 ) >>, <<iif( lxCliExperiva, 1, 0 ) >>, <<lxCliCltipconv >>, <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'" >>, <<lxCliClcfi >>, <<lxCliClnro >>, <<"'" + this.FormatearTextoSql( lxCliClmovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCllisprec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliVhastagan ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliVhastaiva ) + "'" >>, <<lxCliClnroiibb >>, <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'" >>, <<lxCliCnx1 >>, <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'" >>, <<lxCliClsitgan >>, <<"'" + this.FormatearTextoSql( lxCliRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpertiva ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'" >>, <<lxCliClacum >>, <<lxCliCltopeccte >>, <<"'" + this.FormatearTextoSql( lxCliClsiprib ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpergan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprinom ) + "'" >>, <<lxCliCltope >>, <<iif( lxCliClsujvinc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClsegnom ) + "'" >>, <<lxCliPorcentc >>, <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'" >>, <<lxCliHijos >>, <<"'" + this.FormatearTextoSql( lxCliClapell ) + "'" >>, <<iif( lxCliAplicatc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CLI' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OtrasDirecciones
				if this.oEntidad.OtrasDirecciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCalle = loItem.Calle
					lxNumero = loItem.Numero
					lxPiso = loItem.Piso
					lxDepartamento = loItem.Departamento
					lxLocalidad = loItem.Localidad
					lxCodigopostal = loItem.Codigopostal
					lxProvincia_PK = loItem.Provincia_PK
					lxProvinciadetalle = loItem.Provinciadetalle
					lxPais_PK = loItem.Pais_PK
					lxPaisdetalle = loItem.Paisdetalle
					lxTelefono = loItem.Telefono
					lxTipodireccion_PK = loItem.Tipodireccion_PK
					lxNotas = loItem.Notas
					lxPreferente = loItem.Preferente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CliOtrasDir("NROITEM","ODCOD","ODCalle","ODNro","ODPiso","ODDepto","ODLoc","ODCP","ODPrv","ODPrvNom","ODPais","ODPAISNom","ODTel","ODTipoDir","ODNotas","ODPref" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCalle ) + "'">>, <<lxNumero>>, <<"'" + this.FormatearTextoSql( lxPiso ) + "'">>, <<"'" + this.FormatearTextoSql( lxDepartamento ) + "'">>, <<"'" + this.FormatearTextoSql( lxLocalidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigopostal ) + "'">>, <<"'" + this.FormatearTextoSql( lxProvincia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProvinciadetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPais_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPaisdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefono ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodireccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">>, <<iif( lxPreferente, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ExcluidoOtraPercep
				if this.oEntidad.ExcluidoOtraPercep.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigo_PK = loItem.Codigo_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PerExcluido("NROITEM","Cod","Codigo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigo_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Percepciones
				if this.oEntidad.Percepciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigopadroniibb = loItem.Codigopadroniibb
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxJurisdicciondetalle = loItem.Jurisdicciondetalle
					lxResolucion = loItem.Resolucion
					lxPorcentaje = loItem.Porcentaje
					lxFechaexpiracion = loItem.Fechaexpiracion
					lxExcluido = loItem.Excluido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PerCliDet("NROITEM","Cod","CODIGO","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigopadroniibb ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxPorcentaje>>, <<"'" + this.ConvertirDateSql( lxFechaexpiracion ) + "'">>, <<iif( lxExcluido, 1, 0 )>> ) 
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
			local  lxCliFecimpo, lxCliFectrans, lxCliFmodifw, lxCliCd1, lxCliFecexpo, lxCliFaltafw, lxCliClser, lxCliClfing, lxCliZadsfw, lxCliEsttrans, lxCliBdaltafw, lxCliGlobalid, lxCliDescfw, lxCliNomrecom, lxCliCodrecom, lxCliBdmodifw, lxCliVmodifw, lxCliSaltafw, lxCliHmodifw, lxCliSmodifw, lxCliClprov, lxCliHoraimpo, lxCliHoraexpo, lxCliValtafw, lxCliUaltafw, lxCliHaltafw, lxCliUmodifw, lxCliClpin, lxCliTimestamp, lxCliCentid, lxCliCltpo, lxCliInactivofw, lxCliCimagen, lxCliClvend, lxCliClcod, lxCliClobs, lxCliPcuit, lxCliClperibru, lxCliClcalle, lxCliClimpd, lxCliCltlf, lxCliCliva, lxCliClclas, lxCliCltrans, lxCliClcodfant, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliCltipodoc, lxCliClcfi, lxCliClnro, lxCliClmovil, lxCliCllisprec, lxCliCltipocli, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClcuit, lxCliClnrodoc, lxCliClpiso, lxCliClfax, lxCliCnx1, lxCliSexo, lxCliClsitgan, lxCliRut, lxCliClcategcli, lxCliClpertiva, lxCliClco_dto, lxCliClfecha, lxCliClpageweb, lxCliCldepto, lxCliClacum, lxCliCltopeccte, lxCliClsiprib, lxCliClpergan, lxCliClprinom, lxCliCltope, lxCliClsujvinc, lxCliClloc, lxCliEstado, lxCliClcondpag, lxCliClsegnom, lxCliPorcentc, lxCliClcp, lxCliHijos, lxCliClapell, lxCliAplicatc, lxCliClprv, lxCliClnom, lxCliClpais, lxCliClemail
				lxCliFecimpo =  .Fechaimpo			lxCliFectrans =  .Fechatransferencia			lxCliFmodifw =  .Fechamodificacionfw			lxCliCd1 =  .Fechaultimamodificacion			lxCliFecexpo =  .Fechaexpo			lxCliFaltafw =  .Fechaaltafw			lxCliClser =  .Clasificacion2			lxCliClfing =  .Fechadealta			lxCliZadsfw =  .Zadsfw			lxCliEsttrans =  .Estadotransferencia			lxCliBdaltafw =  .Basededatosaltafw			lxCliGlobalid =  .Idglobal			lxCliDescfw =  .Descripcionfw			lxCliNomrecom =  .Nombrerecomendante			lxCliCodrecom =  .Codrecomendante			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliVmodifw =  .Versionmodificacionfw			lxCliSaltafw =  .Seriealtafw			lxCliHmodifw =  .Horamodificacionfw			lxCliSmodifw =  .Seriemodificacionfw			lxCliClprov =  .Jurisdiccion			lxCliHoraimpo =  .Horaimpo			lxCliHoraexpo =  .Horaexpo			lxCliValtafw =  .Versionaltafw			lxCliUaltafw =  .Usuarioaltafw			lxCliHaltafw =  .Horaaltafw			lxCliUmodifw =  .Usuariomodificacionfw			lxCliClpin =  .Pin			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliCentid =  .Idcentralizador			lxCliCltpo =  .Tipointerno			lxCliInactivofw =  .Inactivofw			lxCliCimagen =  .Imagen			lxCliClvend =  upper( .Vendedor_PK ) 			lxCliClcod =  .Codigo			lxCliClobs =  .Observacion			lxCliPcuit =  .Cuitpais			lxCliClperibru =  .Percepcioningresosbrutos			lxCliClcalle =  .Calle			lxCliClimpd =  .Clasificacionsecundaria			lxCliCltlf =  .Telefono			lxCliCliva =  .Situacionfiscal_PK 			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliExpergan =  .Excluidopercepcionganancias			lxCliExperiva =  .Excluidopercepcioniva			lxCliCltipconv =  .Tipoconvenio			lxCliCltipodoc =  .Tipodocumento			lxCliClcfi =  .Cfi			lxCliClnro =  .Numero			lxCliClmovil =  .Movil			lxCliCllisprec =  upper( .ListaDePrecio_PK ) 			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliVhastagan =  .Vigenciahastagan			lxCliVhastaiva =  .Vigenciahastaiva			lxCliClnroiibb =  .Nroiibb			lxCliClcuit =  .Cuit			lxCliClnrodoc =  .Nrodocumento			lxCliClpiso =  .Piso			lxCliClfax =  .Fax			lxCliCnx1 =  .Credito			lxCliSexo =  .Sexo			lxCliClsitgan =  .Situacionganancias			lxCliRut =  .Rut			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClpertiva =  upper( .PercepcionIva_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliClpageweb =  .Paginaweb			lxCliCldepto =  .Departamento			lxCliClacum =  .Dolaresacumulados			lxCliCltopeccte =  .Topectacte			lxCliClsiprib =  upper( .CodigoSiprib_PK ) 			lxCliClpergan =  upper( .PercepcionGanancias_PK ) 			lxCliClprinom =  .Primernombre			lxCliCltope =  .Topefacturacion			lxCliClsujvinc =  .Sujetovinculado			lxCliClloc =  .Localidad			lxCliEstado =  .Estadocivil			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClsegnom =  .Segundonombre			lxCliPorcentc =  .Tasaceroporcen			lxCliClcp =  .Codigopostal			lxCliHijos =  .Hijos			lxCliClapell =  .Apellido			lxCliAplicatc =  .Tasaceroaplica			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClnom =  .Nombre			lxCliClpais =  upper( .Pais_PK ) 			lxCliClemail =  .Email
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.INACTIVOFW != .oEntidad.INACTIVOFW or  .oEntidad.oAtributosAuditoria.SituacionFiscal != .oEntidad.SituacionFiscal_Pk or  .oEntidad.oAtributosAuditoria.Clasificacion != .oEntidad.Clasificacion_Pk or  .oEntidad.oAtributosAuditoria.TipoConvenio != .oEntidad.TipoConvenio or  .oEntidad.oAtributosAuditoria.ListaDePrecio != .oEntidad.ListaDePrecio_Pk or  .oEntidad.oAtributosAuditoria.NroIIBB != .oEntidad.NroIIBB or  .oEntidad.oAtributosAuditoria.CUIT != .oEntidad.CUIT or  .oEntidad.oAtributosAuditoria.RUT != .oEntidad.RUT or  .oEntidad.oAtributosAuditoria.TopeCtaCte != .oEntidad.TopeCtaCte )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  CLI.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CLI set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'">>, "Cd1" = <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'">>, "Clser" = <<lxCliClser>>, "Clfing" = <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'">>, "Globalid" = <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCliDescfw ) + "'">>, "Nomrecom" = <<"'" + this.FormatearTextoSql( lxCliNomrecom ) + "'">>, "Codrecom" = <<"'" + this.FormatearTextoSql( lxCliCodrecom ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'">>, "Clprov" = <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'">>, "Clpin" = <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'">>, "Timestamp" = <<lxCliTimestamp>>, "Centid" = <<lxCliCentid>>, "Cltpo" = <<lxCliCltpo>>, "Inactivofw" = <<iif( lxCliInactivofw, 1, 0 )>>, "Cimagen" = <<"'" + this.FormatearTextoSql( lxCliCimagen ) + "'">>, "Clvend" = <<"'" + this.FormatearTextoSql( lxCliClvend ) + "'">>, "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'">>, "Pcuit" = <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'">>, "Clperibru" = <<"'" + this.FormatearTextoSql( lxCliClperibru ) + "'">>, "Clcalle" = <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'">>, "Climpd" = <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'">>, "Cliva" = <<lxCliCliva>>, "Clclas" = <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'">>, "Cltrans" = <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'">>, "Clcodfant" = <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'">>, "Expergan" = <<iif( lxCliExpergan, 1, 0 )>>, "Experiva" = <<iif( lxCliExperiva, 1, 0 )>>, "Cltipconv" = <<lxCliCltipconv>>, "Cltipodoc" = <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'">>, "Clcfi" = <<lxCliClcfi>>, "Clnro" = <<lxCliClnro>>, "Clmovil" = <<"'" + this.FormatearTextoSql( lxCliClmovil ) + "'">>, "Cllisprec" = <<"'" + this.FormatearTextoSql( lxCliCllisprec ) + "'">>, "Cltipocli" = <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'">>, "Vhastagan" = <<"'" + this.ConvertirDateSql( lxCliVhastagan ) + "'">>, "Vhastaiva" = <<"'" + this.ConvertirDateSql( lxCliVhastaiva ) + "'">>, "Clnroiibb" = <<lxCliClnroiibb>>, "Clcuit" = <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'">>, "Clnrodoc" = <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'">>, "Clpiso" = <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'">>, "Clfax" = <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'">>, "Cnx1" = <<lxCliCnx1>>, "Sexo" = <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'">>, "Clsitgan" = <<lxCliClsitgan>>, "Rut" = <<"'" + this.FormatearTextoSql( lxCliRut ) + "'">>, "Clcategcli" = <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'">>, "Clpertiva" = <<"'" + this.FormatearTextoSql( lxCliClpertiva ) + "'">>, "Clco_dto" = <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'">>, "Clfecha" = <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'">>, "Clpageweb" = <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'">>, "Cldepto" = <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'">>, "Clacum" = <<lxCliClacum>>, "Cltopeccte" = <<lxCliCltopeccte>>, "Clsiprib" = <<"'" + this.FormatearTextoSql( lxCliClsiprib ) + "'">>, "Clpergan" = <<"'" + this.FormatearTextoSql( lxCliClpergan ) + "'">>, "Clprinom" = <<"'" + this.FormatearTextoSql( lxCliClprinom ) + "'">>, "Cltope" = <<lxCliCltope>>, "Clsujvinc" = <<iif( lxCliClsujvinc, 1, 0 )>>, "Clloc" = <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'">>, "Estado" = <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'">>, "Clcondpag" = <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'">>, "Clsegnom" = <<"'" + this.FormatearTextoSql( lxCliClsegnom ) + "'">>, "Porcentc" = <<lxCliPorcentc>>, "Clcp" = <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'">>, "Hijos" = <<lxCliHijos>>, "Clapell" = <<"'" + this.FormatearTextoSql( lxCliClapell ) + "'">>, "Aplicatc" = <<iif( lxCliAplicatc, 1, 0 )>>, "Clprv" = <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'">>, "Clnom" = <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'">>, "Clpais" = <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'">>, "Clemail" = <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CLI' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
			loColeccion.Agregar([delete from ZooLogic.CliOtrasDir where "ODCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PerExcluido where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CONTACTODET where "CONCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PerCliDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OtrasDirecciones
				if this.oEntidad.OtrasDirecciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCalle = loItem.Calle
					lxNumero = loItem.Numero
					lxPiso = loItem.Piso
					lxDepartamento = loItem.Departamento
					lxLocalidad = loItem.Localidad
					lxCodigopostal = loItem.Codigopostal
					lxProvincia_PK = loItem.Provincia_PK
					lxProvinciadetalle = loItem.Provinciadetalle
					lxPais_PK = loItem.Pais_PK
					lxPaisdetalle = loItem.Paisdetalle
					lxTelefono = loItem.Telefono
					lxTipodireccion_PK = loItem.Tipodireccion_PK
					lxNotas = loItem.Notas
					lxPreferente = loItem.Preferente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CliOtrasDir("NROITEM","ODCOD","ODCalle","ODNro","ODPiso","ODDepto","ODLoc","ODCP","ODPrv","ODPrvNom","ODPais","ODPAISNom","ODTel","ODTipoDir","ODNotas","ODPref" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCalle ) + "'">>, <<lxNumero>>, <<"'" + this.FormatearTextoSql( lxPiso ) + "'">>, <<"'" + this.FormatearTextoSql( lxDepartamento ) + "'">>, <<"'" + this.FormatearTextoSql( lxLocalidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigopostal ) + "'">>, <<"'" + this.FormatearTextoSql( lxProvincia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProvinciadetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPais_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPaisdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefono ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodireccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">>, <<iif( lxPreferente, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ExcluidoOtraPercep
				if this.oEntidad.ExcluidoOtraPercep.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigo_PK = loItem.Codigo_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PerExcluido("NROITEM","Cod","Codigo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigo_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Percepciones
				if this.oEntidad.Percepciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigopadroniibb = loItem.Codigopadroniibb
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxJurisdicciondetalle = loItem.Jurisdicciondetalle
					lxResolucion = loItem.Resolucion
					lxPorcentaje = loItem.Porcentaje
					lxFechaexpiracion = loItem.Fechaexpiracion
					lxExcluido = loItem.Excluido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PerCliDet("NROITEM","Cod","CODIGO","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigopadroniibb ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxPorcentaje>>, <<"'" + this.ConvertirDateSql( lxFechaexpiracion ) + "'">>, <<iif( lxExcluido, 1, 0 )>> ) 
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
			loColeccion.Agregar([delete from ZooLogic.CliOtrasDir where "ODCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PerExcluido where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CONTACTODET where "CONCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PerCliDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CLI' 
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
		
			.oCompDatosadicionalessiprib.lNuevo = .EsNuevo()
			.oCompDatosadicionalessiprib.lEdicion = .EsEdicion()
			.oCompDatosadicionalessiprib.lEliminar = .lEliminar
			.oCompDatosadicionalessiprib.lAnular = .lAnular
			loColSentencias = .oCompDatosadicionalessiprib.grabar()
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
			lcRetorno = [update ZooLogic.CLI set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CLCOD = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  CLI.CLCOD != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCLIInactivoFW as variant, lxCLICLIVA as variant, lxCLICLCLAS as variant, lxCLICLTIPCONV as variant, lxCLICLLisPrec as variant, lxCLICLNROIIBB as variant, lxCLICLCUIT as variant, lxCLIRUT as variant, lxCLICLTOPECCTE as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CLI Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					local llInsertarAuditoria as boolean
					llInsertarAuditoria = (  iif( isnull( curSeek.InactivoFW != &lcCursor..InactivoFW ), .F., curSeek.InactivoFW != &lcCursor..InactivoFW ) or  iif( isnull( curSeek.CLIVA != &lcCursor..CLIVA ), .F., curSeek.CLIVA != &lcCursor..CLIVA ) or  iif( isnull( curSeek.CLCLAS != &lcCursor..CLCLAS ), .F., curSeek.CLCLAS != &lcCursor..CLCLAS ) or  iif( isnull( curSeek.CLTIPCONV != &lcCursor..CLTIPCONV ), .F., curSeek.CLTIPCONV != &lcCursor..CLTIPCONV ) or  iif( isnull( curSeek.CLLisPrec != &lcCursor..CLLisPrec ), .F., curSeek.CLLisPrec != &lcCursor..CLLisPrec ) or  iif( isnull( curSeek.CLNROIIBB != &lcCursor..CLNROIIBB ), .F., curSeek.CLNROIIBB != &lcCursor..CLNROIIBB ) or  iif( isnull( curSeek.CLCUIT != &lcCursor..CLCUIT ), .F., curSeek.CLCUIT != &lcCursor..CLCUIT ) or  iif( isnull( curSeek.RUT != &lcCursor..RUT ), .F., curSeek.RUT != &lcCursor..RUT ) or  iif( isnull( curSeek.CLTOPECCTE != &lcCursor..CLTOPECCTE ), .F., curSeek.CLTOPECCTE != &lcCursor..CLTOPECCTE ) )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					if this.oentidad.lActualizarSoloEquivalenciasDeLince
						local lcCadena as String, lnPos as integer
						lnPos = recno(lcCursor)
						afields( laEst, lcCursor )
						lcCadena = [Replace in &lcCursor ]
						if empty( this.oEntidad.CamposEquivalenciaLince )
							this.oEntidad.CamposEquivalenciaLince = this.oEntidad.ObtenerCamposSegunEquivalencia(@laEst)
						endif 
						lcCadena = lcCadena + this.oEntidad.CamposEquivalenciaLince
						lcCadena = lcCadena + [ for CLCOD= curseek.CLCOD]
						&lcCadena.
						select( lcCursor )
						go lnPos
					endif
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CLI set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, CD1 = ] + "'" + this.ConvertirDateSql( &lcCursor..CD1 ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, CLSER = ] + transform( &lcCursor..CLSER )+ [, CLFING = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, globalid = ] + "'" + this.FormatearTextoSql( &lcCursor..globalid ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, NOMRECOM = ] + "'" + this.FormatearTextoSql( &lcCursor..NOMRECOM ) + "'"+ [, CODRECOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CODRECOM ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, CLPROV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPROV ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, CLPIN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPIN ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, centid = ] + transform( &lcCursor..centid )+ [, CLTPO = ] + transform( &lcCursor..CLTPO )+ [, InactivoFW = ] + Transform( iif( &lcCursor..InactivoFW, 1, 0 ))+ [, CIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'"+ [, CLVend = ] + "'" + this.FormatearTextoSql( &lcCursor..CLVend ) + "'"+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, PCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUIT ) + "'"+ [, CLPERIBRU = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPERIBRU ) + "'"+ [, CLCalle = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCalle ) + "'"+ [, CLIMPD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, CLIVA = ] + transform( &lcCursor..CLIVA )+ [, CLCLAS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'"+ [, CLTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTRANS ) + "'"+ [, CLCODFANT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANT ) + "'"+ [, EXPERGAN = ] + Transform( iif( &lcCursor..EXPERGAN, 1, 0 ))+ [, EXPERIVA = ] + Transform( iif( &lcCursor..EXPERIVA, 1, 0 ))+ [, CLTIPCONV = ] + transform( &lcCursor..CLTIPCONV )+ [, CLTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, CLNro = ] + transform( &lcCursor..CLNro )+ [, CLMovil = ] + "'" + this.FormatearTextoSql( &lcCursor..CLMovil ) + "'"+ [, CLLisPrec = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLisPrec ) + "'"+ [, CLTipoCli = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCli ) + "'"+ [, VHastaGan = ] + "'" + this.ConvertirDateSql( &lcCursor..VHastaGan ) + "'"+ [, VHastaIva = ] + "'" + this.ConvertirDateSql( &lcCursor..VHastaIva ) + "'"+ [, CLNROIIBB = ] + transform( &lcCursor..CLNROIIBB )+ [, CLCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"+ [, CLNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'"+ [, ClPiso = ] + "'" + this.FormatearTextoSql( &lcCursor..ClPiso ) + "'"+ [, CLFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"+ [, CNX1 = ] + transform( &lcCursor..CNX1 )+ [, Sexo = ] + "'" + this.FormatearTextoSql( &lcCursor..Sexo ) + "'"+ [, CLSITGAN = ] + transform( &lcCursor..CLSITGAN )+ [, RUT = ] + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'"+ [, CLCategCli = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCategCli ) + "'"+ [, CLPERTIVA = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPERTIVA ) + "'"+ [, CLCO_DTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCO_DTO ) + "'"+ [, CLFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'"+ [, CLPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'"+ [, CLDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'"+ [, CLACUM = ] + transform( &lcCursor..CLACUM )+ [, CLTOPECCTE = ] + transform( &lcCursor..CLTOPECCTE )+ [, CLSIPRIB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLSIPRIB ) + "'"+ [, CLPERGAN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPERGAN ) + "'"+ [, CLPRINOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRINOM ) + "'"+ [, CLTOPE = ] + transform( &lcCursor..CLTOPE )+ [, CLSujVinc = ] + Transform( iif( &lcCursor..CLSujVinc, 1, 0 ))+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, Estado = ] + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"+ [, CLCONDPAG = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'"+ [, CLSEGNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLSEGNOM ) + "'"+ [, PorcenTC = ] + transform( &lcCursor..PorcenTC )+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, Hijos = ] + transform( &lcCursor..Hijos )+ [, CLAPELL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLAPELL ) + "'"+ [, AplicaTC = ] + Transform( iif( &lcCursor..AplicaTC, 1, 0 ))+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, CLPAIS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAIS ) + "'"+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'" + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					lcCampo = lcCursor + '.' + this.cCampoCodigoWH
					this.AgregarMensajeWebHook( 'MODIFICAR', &lcCampo )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					if llInsertarAuditoria
						lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
						this.oConexion.EjecutarSql( lcSentencia )
					EndIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, CD1, FECEXPO, FALTAFW, CLSER, CLFING, ZADSFW, ESTTRANS, BDALTAFW, globalid, DescFW, NOMRECOM, CODRECOM, BDMODIFW, VMODIFW, SALTAFW, HMODIFW, SMODIFW, CLPROV, HORAIMPO, HORAEXPO, VALTAFW, UALTAFW, HALTAFW, UMODIFW, CLPIN, TIMESTAMP, centid, CLTPO, InactivoFW, CIMAGEN, CLVend, CLCOD, CLOBS, PCUIT, CLPERIBRU, CLCalle, CLIMPD, CLTLF, CLIVA, CLCLAS, CLTRANS, CLCODFANT, EXPERGAN, EXPERIVA, CLTIPCONV, CLTIPODOC, CLCFI, CLNro, CLMovil, CLLisPrec, CLTipoCli, VHastaGan, VHastaIva, CLNROIIBB, CLCUIT, CLNRODOC, ClPiso, CLFAX, CNX1, Sexo, CLSITGAN, RUT, CLCategCli, CLPERTIVA, CLCO_DTO, CLFECHA, CLPAGEWEB, CLDEPTO, CLACUM, CLTOPECCTE, CLSIPRIB, CLPERGAN, CLPRINOM, CLTOPE, CLSujVinc, CLLOC, Estado, CLCONDPAG, CLSEGNOM, PorcenTC, CLCP, Hijos, CLAPELL, AplicaTC, CLPRV, CLNOM, CLPAIS, CLEMAIL
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CD1 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + transform( &lcCursor..CLSER )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..globalid ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NOMRECOM ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODRECOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPROV ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPIN ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..centid ) + ',' + transform( &lcCursor..CLTPO ) + ',' + Transform( iif( &lcCursor..InactivoFW, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLVend ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUIT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPERIBRU ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCalle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + transform( &lcCursor..CLIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANT ) + "'" + ',' + Transform( iif( &lcCursor..EXPERGAN, 1, 0 )) + ',' + Transform( iif( &lcCursor..EXPERIVA, 1, 0 )) + ',' + transform( &lcCursor..CLTIPCONV ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'" + ',' + transform( &lcCursor..CLCFI ) + ',' + transform( &lcCursor..CLNro )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLMovil ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLisPrec ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCli ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..VHastaGan ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..VHastaIva ) + "'" + ',' + transform( &lcCursor..CLNROIIBB ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClPiso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'" + ',' + transform( &lcCursor..CNX1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Sexo ) + "'" + ',' + transform( &lcCursor..CLSITGAN ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCategCli ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPERTIVA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCO_DTO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'" + ',' + transform( &lcCursor..CLACUM ) + ',' + transform( &lcCursor..CLTOPECCTE )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLSIPRIB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPERGAN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRINOM ) + "'" + ',' + transform( &lcCursor..CLTOPE ) + ',' + Transform( iif( &lcCursor..CLSujVinc, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLSEGNOM ) + "'" + ',' + transform( &lcCursor..PorcenTC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'" + ',' + transform( &lcCursor..Hijos ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLAPELL ) + "'" + ',' + Transform( iif( &lcCursor..AplicaTC, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAIS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CLI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
				this.oConexion.EjecutarSql( lcSentencia )
				lcCampo = lcCursor + '.' + this.cCampoCodigoWH
				this.AgregarMensajeWebHook( 'INGRESAR', &lcCampo )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTE'
		if This.ActualizaEnRecepcion()
			if !This.oEntidad.lActualizarSoloEquivalenciasDeLince
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
					this.oConexion.EjecutarSql( [Delete From ZooLogic.CliOtrasDir Where ODCOD] + lcIn  )
					this.oConexion.EjecutarSql( [Delete From ZooLogic.PerExcluido Where Cod] + lcIn  )
					this.oConexion.EjecutarSql( [Delete From ZooLogic.CONTACTODET Where CONCOD] + lcIn  )
					this.oConexion.EjecutarSql( [Delete From ZooLogic.PerCliDet Where Cod] + lcIn  )
					endfor
					if llEjecutaEnTransaccion
						this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
					endif
				EndIf
			endif
			lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMOTRASDIRECCIONES'
			Select * From &lcDetalle into cursor cDetallesExistentes ;
				where ODCOD in ( select CLCOD from &lcCursor )
			select cDetallesExistentes
			Scan All
				Text to lcCamposInsert noShow
					"NROITEM","ODCOD","ODCalle","ODNro","ODPiso","ODDepto","ODLoc","ODCP","ODPrv","ODPrvNom","ODPais","ODPAISNom","ODTel","ODTipoDir","ODNotas","ODPref"
				endText
				this.oConexion.EjecutarSql( [Insert into ZooLogic.CliOtrasDir ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODCOD      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODCalle    ) + "'" + ',' + transform( cDetallesExistentes.ODNro      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODPiso     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODDepto    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODLoc      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODCP       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODPrv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODPrvNom   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODPais     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODPAISNom  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODTel      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODTipoDir  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ODNotas    ) + "'" + ',' + Transform( iif( cDetallesExistentes.ODPref    , 1, 0 )) + ' )'  )
				select cDetallesExistentes
			EndScan
			Use in select( 'cDetallesExistentes' )
			lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMEXCLUIDOOTRAPERCEP'
			Select * From &lcDetalle into cursor cDetallesExistentes ;
				where Cod in ( select CLCOD from &lcCursor )
			select cDetallesExistentes
			Scan All
				Text to lcCamposInsert noShow
					"NROITEM","Cod","Codigo"
				endText
				this.oConexion.EjecutarSql( [Insert into ZooLogic.PerExcluido ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cod        ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
				select cDetallesExistentes
			EndScan
			Use in select( 'cDetallesExistentes' )
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
			lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPERCEPCIONES'
			Select * From &lcDetalle into cursor cDetallesExistentes ;
				where Cod in ( select CLCOD from &lcCursor )
			select cDetallesExistentes
			Scan All
				Text to lcCamposInsert noShow
					"NROITEM","Cod","CODIGO","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido"
				endText
				this.oConexion.EjecutarSql( [Insert into ZooLogic.PerCliDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cod        ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.jurisdicci ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DesJur     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Resol      ) + "'" + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FecExp     ) + "'" + ',' + Transform( iif( cDetallesExistentes.Excluido  , 1, 0 )) + ' )'  )
				select cDetallesExistentes
			EndScan
			Use in select( 'cDetallesExistentes' )
			Use in select( 'cExistentes' )
		endif
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
	protected Function AgregarMensajeWebHook( tcEvento as String, tcCodigo as String ) As Void

		if ( alltrim( tcEvento ) = 'MODIFICAR' and this.oEntidad.lWHModificar ) or ( alltrim( tcEvento ) = 'INGRESAR' and this.oEntidad.lWHIngresar )
			goServicios.WebHook.AgregarMensajeALaCola( tcEvento, tcCodigo, this.oEntidad.cNombre )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function EnviarColaWebHook() As Void
		goServicios.WebHook.EnviarColaDeMensajes( this.oEntidad.cNombre )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CLIENTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CLIENTE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CLIENTE_CLOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMOTRASDIRECCIONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMEXCLUIDOOTRAPERCEP'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCONTACTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPERCEPCIONES'
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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CLIENTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CLCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CLIENTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTE'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  CD1       
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  CLFING    
		* Validar ANTERIORES A 1/1/1753  VHastaGan 
		* Validar ANTERIORES A 1/1/1753  VHastaIva 
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
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"cd1" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"clser" numeric( 1, 0 )  null, 
"clfing" datetime  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"globalid" char( 38 )  null, 
"descfw" char( 200 )  null, 
"nomrecom" char( 60 )  null, 
"codrecom" char( 10 )  null, 
"bdmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"clprov" char( 2 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"clpin" char( 60 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"centid" numeric( 10, 0 )  null, 
"cltpo" numeric( 1, 0 )  null, 
"inactivofw" bit  null, 
"cimagen" char( 180 )  null, 
"clvend" char( 10 )  null, 
"clcod" char( 10 )  null, 
"clobs" varchar(max)  null, 
"pcuit" char( 20 )  null, 
"clperibru" char( 1 )  null, 
"clcalle" char( 250 )  null, 
"climpd" char( 8 )  null, 
"cltlf" char( 30 )  null, 
"cliva" numeric( 2, 0 )  null, 
"clclas" char( 10 )  null, 
"cltrans" char( 15 )  null, 
"clcodfant" char( 50 )  null, 
"expergan" bit  null, 
"experiva" bit  null, 
"cltipconv" numeric( 1, 0 )  null, 
"cltipodoc" char( 2 )  null, 
"clcfi" numeric( 1, 0 )  null, 
"clnro" numeric( 5, 0 )  null, 
"clmovil" char( 30 )  null, 
"cllisprec" char( 6 )  null, 
"cltipocli" char( 10 )  null, 
"vhastagan" datetime  null, 
"vhastaiva" datetime  null, 
"clnroiibb" numeric( 11, 0 )  null, 
"clcuit" char( 15 )  null, 
"clnrodoc" char( 10 )  null, 
"clpiso" char( 3 )  null, 
"clfax" char( 20 )  null, 
"cnx1" numeric( 15, 2 )  null, 
"sexo" char( 10 )  null, 
"clsitgan" numeric( 1, 0 )  null, 
"rut" char( 12 )  null, 
"clcategcli" char( 10 )  null, 
"clpertiva" char( 10 )  null, 
"clco_dto" char( 10 )  null, 
"clfecha" datetime  null, 
"clpageweb" char( 60 )  null, 
"cldepto" char( 3 )  null, 
"clacum" numeric( 15, 2 )  null, 
"cltopeccte" numeric( 15, 2 )  null, 
"clsiprib" char( 20 )  null, 
"clpergan" char( 10 )  null, 
"clprinom" char( 60 )  null, 
"cltope" numeric( 15, 2 )  null, 
"clsujvinc" bit  null, 
"clloc" char( 70 )  null, 
"estado" char( 13 )  null, 
"clcondpag" char( 5 )  null, 
"clsegnom" char( 60 )  null, 
"porcentc" numeric( 6, 2 )  null, 
"clcp" char( 8 )  null, 
"hijos" numeric( 2, 0 )  null, 
"clapell" char( 60 )  null, 
"aplicatc" bit  null, 
"clprv" char( 2 )  null, 
"clnom" char( 185 )  null, 
"clpais" char( 3 )  null, 
"clemail" char( 250 )  null )
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTE'
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
			.AgregarMapeo('cd1','cd1')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('clser','clser')
			.AgregarMapeo('clfing','clfing')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('globalid','globalid')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('nomrecom','nomrecom')
			.AgregarMapeo('codrecom','codrecom')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('clprov','clprov')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('clpin','clpin')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('centid','centid')
			.AgregarMapeo('cltpo','cltpo')
			.AgregarMapeo('inactivofw','inactivofw')
			.AgregarMapeo('cimagen','cimagen')
			.AgregarMapeo('clvend','clvend')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('pcuit','pcuit')
			.AgregarMapeo('clperibru','clperibru')
			.AgregarMapeo('clcalle','clcalle')
			.AgregarMapeo('climpd','climpd')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('cliva','cliva')
			.AgregarMapeo('clclas','clclas')
			.AgregarMapeo('cltrans','cltrans')
			.AgregarMapeo('clcodfant','clcodfant')
			.AgregarMapeo('expergan','expergan')
			.AgregarMapeo('experiva','experiva')
			.AgregarMapeo('cltipconv','cltipconv')
			.AgregarMapeo('cltipodoc','cltipodoc')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('clnro','clnro')
			.AgregarMapeo('clmovil','clmovil')
			.AgregarMapeo('cllisprec','cllisprec')
			.AgregarMapeo('cltipocli','cltipocli')
			.AgregarMapeo('vhastagan','vhastagan')
			.AgregarMapeo('vhastaiva','vhastaiva')
			.AgregarMapeo('clnroiibb','clnroiibb')
			.AgregarMapeo('clcuit','clcuit')
			.AgregarMapeo('clnrodoc','clnrodoc')
			.AgregarMapeo('clpiso','clpiso')
			.AgregarMapeo('clfax','clfax')
			.AgregarMapeo('cnx1','cnx1')
			.AgregarMapeo('sexo','sexo')
			.AgregarMapeo('clsitgan','clsitgan')
			.AgregarMapeo('rut','rut')
			.AgregarMapeo('clcategcli','clcategcli')
			.AgregarMapeo('clpertiva','clpertiva')
			.AgregarMapeo('clco_dto','clco_dto')
			.AgregarMapeo('clfecha','clfecha')
			.AgregarMapeo('clpageweb','clpageweb')
			.AgregarMapeo('cldepto','cldepto')
			.AgregarMapeo('clacum','clacum')
			.AgregarMapeo('cltopeccte','cltopeccte')
			.AgregarMapeo('clsiprib','clsiprib')
			.AgregarMapeo('clpergan','clpergan')
			.AgregarMapeo('clprinom','clprinom')
			.AgregarMapeo('cltope','cltope')
			.AgregarMapeo('clsujvinc','clsujvinc')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('estado','estado')
			.AgregarMapeo('clcondpag','clcondpag')
			.AgregarMapeo('clsegnom','clsegnom')
			.AgregarMapeo('porcentc','porcentc')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('hijos','hijos')
			.AgregarMapeo('clapell','clapell')
			.AgregarMapeo('aplicatc','aplicatc')
			.AgregarMapeo('clprv','clprv')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('clpais','clpais')
			.AgregarMapeo('clemail','clemail')
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
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				insert into ZooLogic.ADT_CLI ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Cliva","Clclas","Cltipconv","Cllisprec","Clnroiibb","Clcuit","Rut","Cltopeccte" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Clcod,Isnull( d.Inactivofw,t.Inactivofw),Isnull( d.Cliva,t.Cliva),Isnull( d.Clclas,t.Clclas),Isnull( d.Cltipconv,t.Cltipconv),Isnull( d.Cllisprec,t.Cllisprec),Isnull( d.Clnroiibb,t.Clnroiibb),Isnull( d.Clcuit,t.Clcuit),Isnull( d.Rut,t.Rut),Isnull( d.Cltopeccte,t.Cltopeccte)
						from ZooLogic.CLI t inner join deleted d 
							 on t.CLCOD = d.CLCOD
					where ( d.InactivoFW is not null and d.InactivoFW <> t.InactivoFW ) or ( d.CLIVA is not null and d.CLIVA <> t.CLIVA ) or ( d.CLCLAS is not null and d.CLCLAS <> t.CLCLAS ) or ( d.CLTIPCONV is not null and d.CLTIPCONV <> t.CLTIPCONV ) or ( d.CLLisPrec is not null and d.CLLisPrec <> t.CLLisPrec ) or ( d.CLNROIIBB is not null and d.CLNROIIBB <> t.CLNROIIBB ) or ( d.CLCUIT is not null and d.CLCUIT <> t.CLCUIT ) or ( d.RUT is not null and d.RUT <> t.RUT ) or ( d.CLTOPECCTE is not null and d.CLTOPECCTE <> t.CLTOPECCTE )
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.CD1 = isnull( d.CD1, t.CD1 ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.CLSER = isnull( d.CLSER, t.CLSER ),t.CLFING = isnull( d.CLFING, t.CLFING ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.GLOBALID = isnull( d.GLOBALID, t.GLOBALID ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.NOMRECOM = isnull( d.NOMRECOM, t.NOMRECOM ),t.CODRECOM = isnull( d.CODRECOM, t.CODRECOM ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.CLPROV = isnull( d.CLPROV, t.CLPROV ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.CLPIN = isnull( d.CLPIN, t.CLPIN ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CENTID = isnull( d.CENTID, t.CENTID ),t.CLTPO = isnull( d.CLTPO, t.CLTPO ),t.INACTIVOFW = isnull( d.INACTIVOFW, t.INACTIVOFW ),t.CIMAGEN = isnull( d.CIMAGEN, t.CIMAGEN ),t.CLVEND = isnull( d.CLVEND, t.CLVEND ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.PCUIT = isnull( d.PCUIT, t.PCUIT ),t.CLPERIBRU = isnull( d.CLPERIBRU, t.CLPERIBRU ),t.CLCALLE = isnull( d.CLCALLE, t.CLCALLE ),t.CLIMPD = isnull( d.CLIMPD, t.CLIMPD ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.CLIVA = isnull( d.CLIVA, t.CLIVA ),t.CLCLAS = isnull( d.CLCLAS, t.CLCLAS ),t.CLTRANS = isnull( d.CLTRANS, t.CLTRANS ),t.CLCODFANT = isnull( d.CLCODFANT, t.CLCODFANT ),t.EXPERGAN = isnull( d.EXPERGAN, t.EXPERGAN ),t.EXPERIVA = isnull( d.EXPERIVA, t.EXPERIVA ),t.CLTIPCONV = isnull( d.CLTIPCONV, t.CLTIPCONV ),t.CLTIPODOC = isnull( d.CLTIPODOC, t.CLTIPODOC ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.CLNRO = isnull( d.CLNRO, t.CLNRO ),t.CLMOVIL = isnull( d.CLMOVIL, t.CLMOVIL ),t.CLLISPREC = isnull( d.CLLISPREC, t.CLLISPREC ),t.CLTIPOCLI = isnull( d.CLTIPOCLI, t.CLTIPOCLI ),t.VHASTAGAN = isnull( d.VHASTAGAN, t.VHASTAGAN ),t.VHASTAIVA = isnull( d.VHASTAIVA, t.VHASTAIVA ),t.CLNROIIBB = isnull( d.CLNROIIBB, t.CLNROIIBB ),t.CLCUIT = isnull( d.CLCUIT, t.CLCUIT ),t.CLNRODOC = isnull( d.CLNRODOC, t.CLNRODOC ),t.CLPISO = isnull( d.CLPISO, t.CLPISO ),t.CLFAX = isnull( d.CLFAX, t.CLFAX ),t.CNX1 = isnull( d.CNX1, t.CNX1 ),t.SEXO = isnull( d.SEXO, t.SEXO ),t.CLSITGAN = isnull( d.CLSITGAN, t.CLSITGAN ),t.RUT = isnull( d.RUT, t.RUT ),t.CLCATEGCLI = isnull( d.CLCATEGCLI, t.CLCATEGCLI ),t.CLPERTIVA = isnull( d.CLPERTIVA, t.CLPERTIVA ),t.CLCO_DTO = isnull( d.CLCO_DTO, t.CLCO_DTO ),t.CLFECHA = isnull( d.CLFECHA, t.CLFECHA ),t.CLPAGEWEB = isnull( d.CLPAGEWEB, t.CLPAGEWEB ),t.CLDEPTO = isnull( d.CLDEPTO, t.CLDEPTO ),t.CLACUM = isnull( d.CLACUM, t.CLACUM ),t.CLTOPECCTE = isnull( d.CLTOPECCTE, t.CLTOPECCTE ),t.CLSIPRIB = isnull( d.CLSIPRIB, t.CLSIPRIB ),t.CLPERGAN = isnull( d.CLPERGAN, t.CLPERGAN ),t.CLPRINOM = isnull( d.CLPRINOM, t.CLPRINOM ),t.CLTOPE = isnull( d.CLTOPE, t.CLTOPE ),t.CLSUJVINC = isnull( d.CLSUJVINC, t.CLSUJVINC ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.ESTADO = isnull( d.ESTADO, t.ESTADO ),t.CLCONDPAG = isnull( d.CLCONDPAG, t.CLCONDPAG ),t.CLSEGNOM = isnull( d.CLSEGNOM, t.CLSEGNOM ),t.PORCENTC = isnull( d.PORCENTC, t.PORCENTC ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.HIJOS = isnull( d.HIJOS, t.HIJOS ),t.CLAPELL = isnull( d.CLAPELL, t.CLAPELL ),t.APLICATC = isnull( d.APLICATC, t.APLICATC ),t.CLPRV = isnull( d.CLPRV, t.CLPRV ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.CLPAIS = isnull( d.CLPAIS, t.CLPAIS ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL )
					from ZooLogic.CLI t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.ADT_CLI ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Cliva","Clclas","Cltipconv","Cllisprec","Clnroiibb","Clcuit","Rut","Cltopeccte" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Clcod,isnull( d.INACTIVOFW,0),isnull( d.CLIVA,0),isnull( d.CLCLAS,''),isnull( d.CLTIPCONV,0),isnull( d.CLLISPREC,''),isnull( d.CLNROIIBB,0),isnull( d.CLCUIT,''),isnull( d.RUT,''),isnull( d.CLTOPECCTE,0)
						From deleted d left join ZooLogic.CLI pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				insert into ZooLogic.CLI(Fecimpo,Fectrans,Fmodifw,Cd1,Fecexpo,Faltafw,Clser,Clfing,Zadsfw,Esttrans,Bdaltafw,Globalid,Descfw,Nomrecom,Codrecom,Bdmodifw,Vmodifw,Saltafw,Hmodifw,Smodifw,Clprov,Horaimpo,Horaexpo,Valtafw,Ualtafw,Haltafw,Umodifw,Clpin,Timestamp,Centid,Cltpo,Inactivofw,Cimagen,Clvend,Clcod,Clobs,Pcuit,Clperibru,Clcalle,Climpd,Cltlf,Cliva,Clclas,Cltrans,Clcodfant,Expergan,Experiva,Cltipconv,Cltipodoc,Clcfi,Clnro,Clmovil,Cllisprec,Cltipocli,Vhastagan,Vhastaiva,Clnroiibb,Clcuit,Clnrodoc,Clpiso,Clfax,Cnx1,Sexo,Clsitgan,Rut,Clcategcli,Clpertiva,Clco_dto,Clfecha,Clpageweb,Cldepto,Clacum,Cltopeccte,Clsiprib,Clpergan,Clprinom,Cltope,Clsujvinc,Clloc,Estado,Clcondpag,Clsegnom,Porcentc,Clcp,Hijos,Clapell,Aplicatc,Clprv,Clnom,Clpais,Clemail)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.CD1,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.CLSER,0),isnull( d.CLFING,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.GLOBALID,''),isnull( d.DESCFW,''),isnull( d.NOMRECOM,''),isnull( d.CODRECOM,''),isnull( d.BDMODIFW,''),isnull( d.VMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.CLPROV,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.UMODIFW,''),isnull( d.CLPIN,''),isnull( d.TIMESTAMP,0),isnull( d.CENTID,0),isnull( d.CLTPO,0),isnull( d.INACTIVOFW,0),isnull( d.CIMAGEN,''),isnull( d.CLVEND,''),isnull( d.CLCOD,''),isnull( d.CLOBS,''),isnull( d.PCUIT,''),isnull( d.CLPERIBRU,''),isnull( d.CLCALLE,''),isnull( d.CLIMPD,''),isnull( d.CLTLF,''),isnull( d.CLIVA,0),isnull( d.CLCLAS,''),isnull( d.CLTRANS,''),isnull( d.CLCODFANT,''),isnull( d.EXPERGAN,0),isnull( d.EXPERIVA,0),isnull( d.CLTIPCONV,0),isnull( d.CLTIPODOC,''),isnull( d.CLCFI,0),isnull( d.CLNRO,0),isnull( d.CLMOVIL,''),isnull( d.CLLISPREC,''),isnull( d.CLTIPOCLI,''),isnull( d.VHASTAGAN,''),isnull( d.VHASTAIVA,''),isnull( d.CLNROIIBB,0),isnull( d.CLCUIT,''),isnull( d.CLNRODOC,''),isnull( d.CLPISO,''),isnull( d.CLFAX,''),isnull( d.CNX1,0),isnull( d.SEXO,''),isnull( d.CLSITGAN,0),isnull( d.RUT,''),isnull( d.CLCATEGCLI,''),isnull( d.CLPERTIVA,''),isnull( d.CLCO_DTO,''),isnull( d.CLFECHA,''),isnull( d.CLPAGEWEB,''),isnull( d.CLDEPTO,''),isnull( d.CLACUM,0),isnull( d.CLTOPECCTE,0),isnull( d.CLSIPRIB,''),isnull( d.CLPERGAN,''),isnull( d.CLPRINOM,''),isnull( d.CLTOPE,0),isnull( d.CLSUJVINC,0),isnull( d.CLLOC,''),isnull( d.ESTADO,''),isnull( d.CLCONDPAG,''),isnull( d.CLSEGNOM,''),isnull( d.PORCENTC,0),isnull( d.CLCP,''),isnull( d.HIJOS,0),isnull( d.CLAPELL,''),isnull( d.APLICATC,0),isnull( d.CLPRV,''),isnull( d.CLNOM,''),isnull( d.CLPAIS,''),isnull( d.CLEMAIL,'')
						From deleted d left join ZooLogic.CLI pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CliOtrasDir( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CLI_CliOtrasDir
ON ZooLogic.TablaTrabajo_CLI_CliOtrasDir
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.ODCOD = isnull( d.ODCOD, t.ODCOD ),
t.ODCALLE = isnull( d.ODCALLE, t.ODCALLE ),
t.ODNRO = isnull( d.ODNRO, t.ODNRO ),
t.ODPISO = isnull( d.ODPISO, t.ODPISO ),
t.ODDEPTO = isnull( d.ODDEPTO, t.ODDEPTO ),
t.ODLOC = isnull( d.ODLOC, t.ODLOC ),
t.ODCP = isnull( d.ODCP, t.ODCP ),
t.ODPRV = isnull( d.ODPRV, t.ODPRV ),
t.ODPRVNOM = isnull( d.ODPRVNOM, t.ODPRVNOM ),
t.ODPAIS = isnull( d.ODPAIS, t.ODPAIS ),
t.ODPAISNOM = isnull( d.ODPAISNOM, t.ODPAISNOM ),
t.ODTEL = isnull( d.ODTEL, t.ODTEL ),
t.ODTIPODIR = isnull( d.ODTIPODIR, t.ODTIPODIR ),
t.ODNOTAS = isnull( d.ODNOTAS, t.ODNOTAS ),
t.ODPREF = isnull( d.ODPREF, t.ODPREF )
from ZooLogic.CliOtrasDir t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CliOtrasDir
( 
"NROITEM",
"ODCOD",
"ODCALLE",
"ODNRO",
"ODPISO",
"ODDEPTO",
"ODLOC",
"ODCP",
"ODPRV",
"ODPRVNOM",
"ODPAIS",
"ODPAISNOM",
"ODTEL",
"ODTIPODIR",
"ODNOTAS",
"ODPREF"
 )
Select 
d.NROITEM,
d.ODCOD,
d.ODCALLE,
d.ODNRO,
d.ODPISO,
d.ODDEPTO,
d.ODLOC,
d.ODCP,
d.ODPRV,
d.ODPRVNOM,
d.ODPAIS,
d.ODPAISNOM,
d.ODTEL,
d.ODTIPODIR,
d.ODNOTAS,
d.ODPREF
From deleted d left join ZooLogic.CliOtrasDir pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_PerExcluido( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CLI_PerExcluido
ON ZooLogic.TablaTrabajo_CLI_PerExcluido
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COD = isnull( d.COD, t.COD ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO )
from ZooLogic.PerExcluido t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PerExcluido
( 
"NROITEM",
"COD",
"CODIGO"
 )
Select 
d.NROITEM,
d.COD,
d.CODIGO
From deleted d left join ZooLogic.PerExcluido pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
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
	function ObtenerTriggerDeleteImportacion_PerCliDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CLI_PerCliDet
ON ZooLogic.TablaTrabajo_CLI_PerCliDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COD = isnull( d.COD, t.COD ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.JURISDICCI = isnull( d.JURISDICCI, t.JURISDICCI ),
t.DESJUR = isnull( d.DESJUR, t.DESJUR ),
t.RESOL = isnull( d.RESOL, t.RESOL ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.FECEXP = isnull( d.FECEXP, t.FECEXP ),
t.EXCLUIDO = isnull( d.EXCLUIDO, t.EXCLUIDO )
from ZooLogic.PerCliDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PerCliDet
( 
"NROITEM",
"COD",
"CODIGO",
"JURISDICCI",
"DESJUR",
"RESOL",
"PORCEN",
"FECEXP",
"EXCLUIDO"
 )
Select 
d.NROITEM,
d.COD,
d.CODIGO,
d.JURISDICCI,
d.DESJUR,
d.RESOL,
d.PORCEN,
d.FECEXP,
d.EXCLUIDO
From deleted d left join ZooLogic.PerCliDet pk 
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
			if reccount( 'c_CLIENTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaultimamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechaultimamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Clasificacion2 = nvl( c_CLIENTE.Clasificacion2, 0 )
					.Fechadealta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechadealta, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_CLIENTE.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_CLIENTE.Basededatosaltafw, [] )
					.Idglobal = nvl( c_CLIENTE.Idglobal, [] )
					.Descripcionfw = nvl( c_CLIENTE.Descripcionfw, [] )
					.Nombrerecomendante = nvl( c_CLIENTE.Nombrerecomendante, [] )
					.Codrecomendante = nvl( c_CLIENTE.Codrecomendante, [] )
					.Basededatosmodificacionfw = nvl( c_CLIENTE.Basededatosmodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CLIENTE.Versionmodificacionfw, [] )
					.Seriealtafw = nvl( c_CLIENTE.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_CLIENTE.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CLIENTE.Seriemodificacionfw, [] )
					.Jurisdiccion = nvl( c_CLIENTE.Jurisdiccion, [] )
					.Horaimpo = nvl( c_CLIENTE.Horaimpo, [] )
					.Horaexpo = nvl( c_CLIENTE.Horaexpo, [] )
					.Versionaltafw = nvl( c_CLIENTE.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_CLIENTE.Usuarioaltafw, [] )
					.Horaaltafw = nvl( c_CLIENTE.Horaaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CLIENTE.Usuariomodificacionfw, [] )
					.Pin = nvl( c_CLIENTE.Pin, [] )
					.Timestamp = nvl( c_CLIENTE.Timestamp, 0 )
					.Idcentralizador = nvl( c_CLIENTE.Idcentralizador, 0 )
					.Tipointerno = nvl( c_CLIENTE.Tipointerno, 0 )
					.Inactivofw = nvl( c_CLIENTE.Inactivofw, .F. )
					.Imagen = nvl( c_CLIENTE.Imagen, [] )
					.Vendedor_PK =  nvl( c_CLIENTE.Vendedor, [] )
					.Codigo = nvl( c_CLIENTE.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Cuitpais = nvl( c_CLIENTE.Cuitpais, [] )
					.Percepcioningresosbrutos = nvl( c_CLIENTE.Percepcioningresosbrutos, [] )
					.Calle = nvl( c_CLIENTE.Calle, [] )
					.Clasificacionsecundaria = nvl( c_CLIENTE.Clasificacionsecundaria, [] )
					.Telefono = nvl( c_CLIENTE.Telefono, [] )
					.Situacionfiscal_PK =  nvl( c_CLIENTE.Situacionfiscal, 0 )
					.Clasificacion_PK =  nvl( c_CLIENTE.Clasificacion, [] )
					.Transportista_PK =  nvl( c_CLIENTE.Transportista, [] )
					.Otrasdirecciones.Limpiar()
					.Otrasdirecciones.SetearEsNavegacion( .lProcesando )
					.Otrasdirecciones.Cargar()
					.Codnombrefantasia_PK =  nvl( c_CLIENTE.Codnombrefantasia, [] )
					.Excluidopercepcionganancias = nvl( c_CLIENTE.Excluidopercepcionganancias, .F. )
					.Excluidopercepcioniva = nvl( c_CLIENTE.Excluidopercepcioniva, .F. )
					.Tipoconvenio = nvl( c_CLIENTE.Tipoconvenio, 0 )
					.Tipodocumento = nvl( c_CLIENTE.Tipodocumento, [] )
					.Excluidootrapercep.Limpiar()
					.Excluidootrapercep.SetearEsNavegacion( .lProcesando )
					.Excluidootrapercep.Cargar()
					.Cfi = nvl( c_CLIENTE.Cfi, 0 )
					.Numero = nvl( c_CLIENTE.Numero, 0 )
					.Movil = nvl( c_CLIENTE.Movil, [] )
					.Listadeprecio_PK =  nvl( c_CLIENTE.Listadeprecio, [] )
					.Tipocli_PK =  nvl( c_CLIENTE.Tipocli, [] )
					.Contacto.Limpiar()
					.Contacto.SetearEsNavegacion( .lProcesando )
					.Contacto.Cargar()
					.Vigenciahastagan = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Vigenciahastagan, ctod( '  /  /    ' ) ) )
					.Vigenciahastaiva = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Vigenciahastaiva, ctod( '  /  /    ' ) ) )
					.Nroiibb = nvl( c_CLIENTE.Nroiibb, 0 )
					.Cuit = nvl( c_CLIENTE.Cuit, [] )
					.Nrodocumento = nvl( c_CLIENTE.Nrodocumento, [] )
					.Piso = nvl( c_CLIENTE.Piso, [] )
					.Fax = nvl( c_CLIENTE.Fax, [] )
					.Credito = nvl( c_CLIENTE.Credito, 0 )
					.Percepciones.Limpiar()
					.Percepciones.SetearEsNavegacion( .lProcesando )
					.Percepciones.Cargar()
					.Sexo = nvl( c_CLIENTE.Sexo, [] )
					.Situacionganancias = nvl( c_CLIENTE.Situacionganancias, 0 )
					.Rut = nvl( c_CLIENTE.Rut, [] )
					.Categcli_PK =  nvl( c_CLIENTE.Categcli, [] )
					.Percepcioniva_PK =  nvl( c_CLIENTE.Percepcioniva, [] )
					.Descuentopreferente_PK =  nvl( c_CLIENTE.Descuentopreferente, [] )
					.Fechanacimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechanacimiento, ctod( '  /  /    ' ) ) )
					.Paginaweb = nvl( c_CLIENTE.Paginaweb, [] )
					.Departamento = nvl( c_CLIENTE.Departamento, [] )
					.Dolaresacumulados = nvl( c_CLIENTE.Dolaresacumulados, 0 )
					.Topectacte = nvl( c_CLIENTE.Topectacte, 0 )
					.Codigosiprib_PK =  nvl( c_CLIENTE.Codigosiprib, [] )
					.Percepcionganancias_PK =  nvl( c_CLIENTE.Percepcionganancias, [] )
					.Primernombre = nvl( c_CLIENTE.Primernombre, [] )
					.Topefacturacion = nvl( c_CLIENTE.Topefacturacion, 0 )
					.Sujetovinculado = nvl( c_CLIENTE.Sujetovinculado, .F. )
					.Localidad = nvl( c_CLIENTE.Localidad, [] )
					.Estadocivil = nvl( c_CLIENTE.Estadocivil, [] )
					.Condiciondepago_PK =  nvl( c_CLIENTE.Condiciondepago, [] )
					.Segundonombre = nvl( c_CLIENTE.Segundonombre, [] )
					.Tasaceroporcen = nvl( c_CLIENTE.Tasaceroporcen, 0 )
					.Codigopostal = nvl( c_CLIENTE.Codigopostal, [] )
					.Hijos = nvl( c_CLIENTE.Hijos, 0 )
					.Apellido = nvl( c_CLIENTE.Apellido, [] )
					.Tasaceroaplica = nvl( c_CLIENTE.Tasaceroaplica, .F. )
					.Provincia_PK =  nvl( c_CLIENTE.Provincia, [] )
					.Nombre = nvl( c_CLIENTE.Nombre, [] )
					.Pais_PK =  nvl( c_CLIENTE.Pais, [] )
					.Email = nvl( c_CLIENTE.Email, [] )
					Select c_CLIENTE
					scatter name This.oEntidad.oAtributosAuditoria
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
	*-----------------------------------------------------------------------------------------
	function ObtenerSentenciasInsertAuditoria( tcCursor as string ) as String
		if empty( tcCursor )
			local lcDescripcionFW as string
			lcDescripcionFW = this.oEntidad.DescripcionFW
		else
			local lcDescripcionFW as string
			lcDescripcionFW = &tcCursor..DescFW
		endif
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string;
		, lcCabecera10 as string
		lcCabecera1 = "'" + this.FormatearTextoSql( goLibrerias.ObtenerGuidPk() ) + "'"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( lcDescripcionFW ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera9 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera10 = iif( .F., 1, 0 )
		
		local lxValorClavePrimaria as variant
		if empty( tcCursor )
			lxValorClavePrimaria = this.oEntidad.CODIGO
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string, lcEntidad8 as string, lcEntidad9 as string, lcEntidad10 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = iif( this.oEntidad.Inactivofw, 1, 0 )
			lcEntidad3 = transform( this.oEntidad.Situacionfiscal_pk )
			lcEntidad4 = "'" + this.FormatearTextoSql( this.oEntidad.Clasificacion_pk ) + "'"
			lcEntidad5 = transform( this.oEntidad.Tipoconvenio )
			lcEntidad6 = "'" + this.FormatearTextoSql( this.oEntidad.Listadeprecio_pk ) + "'"
			lcEntidad7 = transform( this.oEntidad.Nroiibb )
			lcEntidad8 = "'" + this.FormatearTextoSql( this.oEntidad.Cuit ) + "'"
			lcEntidad9 = "'" + this.FormatearTextoSql( this.oEntidad.Rut ) + "'"
			lcEntidad10 = transform( this.oEntidad.Topectacte )
			
		else
			lxValorClavePrimaria = &tcCursor..CLCOD
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string, lcEntidad8 as string, lcEntidad9 as string, lcEntidad10 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = iif( &tcCursor..Inactivofw, 1, 0 )
			lcEntidad3 = transform( &tcCursor..Cliva )
			lcEntidad4 = "'" + this.FormatearTextoSql( &tcCursor..Clclas ) + "'"
			lcEntidad5 = transform( &tcCursor..Cltipconv )
			lcEntidad6 = "'" + this.FormatearTextoSql( &tcCursor..Cllisprec ) + "'"
			lcEntidad7 = transform( &tcCursor..Clnroiibb )
			lcEntidad8 = "'" + this.FormatearTextoSql( &tcCursor..Clcuit ) + "'"
			lcEntidad9 = "'" + this.FormatearTextoSql( &tcCursor..Rut ) + "'"
			lcEntidad10 = transform( &tcCursor..Cltopeccte )
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_CLI ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Cliva","Clclas","Cltipconv","Cllisprec","Clnroiibb","Clcuit","Rut","Cltopeccte" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>>, <<lcEntidad4>>, <<lcEntidad5>>, <<lcEntidad6>>, <<lcEntidad7>>, <<lcEntidad8>>, <<lcEntidad9>>, <<lcEntidad10>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.OtrasDirecciones
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

		loDetalle = this.oEntidad.ExcluidoOtraPercep
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

		loDetalle = this.oEntidad.Percepciones
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
		return c_CLIENTE.&lcAtributo
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Clser" as "Clasificacion2", "Clfing" as "Fechadealta", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Globalid" as "Idglobal", "Descfw" as "Descripcionfw", "Nomrecom" as "Nombrerecomendante", "Codrecom" as "Codrecomendante", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Clprov" as "Jurisdiccion", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Clpin" as "Pin", "Timestamp" as "Timestamp", "Centid" as "Idcentralizador", "Cltpo" as "Tipointerno", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clvend" as "Vendedor", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcuit" as "Cuitpais", "Clperibru" as "Percepcioningresosbrutos", "Clcalle" as "Calle", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Clclas" as "Clasificacion", "Cltrans" as "Transportista", "Clcodfant" as "Codnombrefantasia", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Clcfi" as "Cfi", "Clnro" as "Numero", "Clmovil" as "Movil", "Cllisprec" as "Listadeprecio", "Cltipocli" as "Tipocli", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clcuit" as "Cuit", "Clnrodoc" as "Nrodocumento", "Clpiso" as "Piso", "Clfax" as "Fax", "Cnx1" as "Credito", "Sexo" as "Sexo", "Clsitgan" as "Situacionganancias", "Rut" as "Rut", "Clcategcli" as "Categcli", "Clpertiva" as "Percepcioniva", "Clco_dto" as "Descuentopreferente", "Clfecha" as "Fechanacimiento", "Clpageweb" as "Paginaweb", "Cldepto" as "Departamento", "Clacum" as "Dolaresacumulados", "Cltopeccte" as "Topectacte", "Clsiprib" as "Codigosiprib", "Clpergan" as "Percepcionganancias", "Clprinom" as "Primernombre", "Cltope" as "Topefacturacion", "Clsujvinc" as "Sujetovinculado", "Clloc" as "Localidad", "Estado" as "Estadocivil", "Clcondpag" as "Condiciondepago", "Clsegnom" as "Segundonombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Hijos" as "Hijos", "Clapell" as "Apellido", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Clnom" as "Nombre", "Clpais" as "Pais", "Clemail" as "Email"
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
	FiltroSubEntidad = ' ( CLI.InactivoFW = 0)'

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
	<row entidad="CLIENTE                                 " atributo="FECHAIMPO                               " tabla="CLI            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHATRANSFERENCIA                      " tabla="CLI            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHAMODIFICACIONFW                     " tabla="CLI            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHAULTIMAMODIFICACION                 " tabla="CLI            " campo="CD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima Modificación                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHAEXPO                               " tabla="CLI            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHAALTAFW                             " tabla="CLI            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CLASIFICACION2                          " tabla="CLI            " campo="CLSER     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Clasificación                                                                                                                                                   " dominio="CLASIFICACION                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHADEALTA                             " tabla="CLI            " campo="CLFING    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="46" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="ZADSFW                                  " tabla="CLI            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="ESTADOTRANSFERENCIA                     " tabla="CLI            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="BASEDEDATOSALTAFW                       " tabla="CLI            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="IDGLOBAL                                " tabla="CLI            " campo="GLOBALID  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Id local de centralización                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="DESCRIPCIONFW                           " tabla="CLI            " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRERECOMENDANTE                      " tabla="CLI            " campo="NOMRECOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Nombre recomendante                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODRECOMENDANTE                         " tabla="CLI            " campo="CODRECOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cód. recomendante                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CLI            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VERSIONMODIFICACIONFW                   " tabla="CLI            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SERIEALTAFW                             " tabla="CLI            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HORAMODIFICACIONFW                      " tabla="CLI            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SERIEMODIFICACIONFW                     " tabla="CLI            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="JURISDICCION                            " tabla="CLI            " campo="CLPROV    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Jurisdicción                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HORAIMPO                                " tabla="CLI            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HORAEXPO                                " tabla="CLI            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VERSIONALTAFW                           " tabla="CLI            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="USUARIOALTAFW                           " tabla="CLI            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HORAALTAFW                              " tabla="CLI            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="USUARIOMODIFICACIONFW                   " tabla="CLI            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PIN                                     " tabla="CLI            " campo="CLPIN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIMESTAMP                               " tabla="CLI            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="IDCENTRALIZADOR                         " tabla="CLI            " campo="CENTID    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id global de centralización                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIPOINTERNO                             " tabla="CLI            " campo="CLTPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="INACTIVOFW                              " tabla="CLI            " campo="INACTIVOFW" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Inactivo                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="IMAGEN                                  " tabla="CLI            " campo="CIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="42" etiqueta="Imagen                                                                                                                                                          " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VENDEDOR                                " tabla="CLI            " campo="CLVEND    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODIGO                                  " tabla="CLI            " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="OBSERVACION                             " tabla="CLI            " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CUITPAIS                                " tabla="CLI            " campo="PCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="CUIT país                                                                                                                                                       " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PERCEPCIONINGRESOSBRUTOS                " tabla="CLI            " campo="CLPERIBRU " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Percepción de ingresos brutos                                                                                                                                   " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CALLE                                   " tabla="CLI            " campo="CLCALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CLASIFICACIONSECUNDARIA                 " tabla="CLI            " campo="CLIMPD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Clasificación secundaria                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TELEFONO                                " tabla="CLI            " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SITUACIONFISCAL                         " tabla="CLI            " campo="CLIVA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="406" etiqueta="Situación fiscal                                                                                                                                                " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="RECOMENDADOPOR                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTERECOMENDANTE                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Recomendado por                                                                                                                                                 " dominio="CODIGOSINALTA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CLASIFICACION                           " tabla="CLI            " campo="CLCLAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="48" etiqueta="Clasificación cliente                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TRANSPORTISTA                           " tabla="CLI            " campo="CLTRANS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Transportista                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="OTRASDIRECCIONES                        " tabla="CLIOTRASDIR    " campo="ODCOD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Otras direcciones                                                                                                                                               " dominio="DETALLEITEMOTRASDIRECCIONES   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODNOMBREFANTASIA                       " tabla="CLI            " campo="CLCODFANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMBREDEFANTASIA                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="54" etiqueta="Nombre de fantasía                                                                                                                                              " dominio="CODIGOSINMUESTRARELACION      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="EXCLUIDOPERCEPCIONGANANCIAS             " tabla="CLI            " campo="EXPERGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Percepciones Ganancias                                                                                                                                          " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="EXCLUIDOPERCEPCIONIVA                   " tabla="CLI            " campo="EXPERIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Percepciones IVA                                                                                                                                                " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIPOCONVENIO                            " tabla="CLI            " campo="CLTIPCONV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Convenio                                                                                                                                                        " dominio="CONVENIOCONNUMERO             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIPODOCUMENTO                           " tabla="CLI            " campo="CLTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="=iif(goParametros.Nucleo.DatosGenerales.Pais=3,&quot;03&quot;,&quot;05&quot;)                                                                                                                                                                                                     " obligatorio="false" admitebusqueda="418" etiqueta="Tipo documento                                                                                                                                                  " dominio="DOCUMENTOCLIENTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="EXCLUIDOOTRAPERCEP                      " tabla="PEREXCLUIDO    " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Impuestos excluidos                                                                                                                                             " dominio="DETALLEITEMEXCLUIDOOTRAPERCEP " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CFI                                     " tabla="CLI            " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente Frecuente Importante                                                                                                                                    " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NUMERO                                  " tabla="CLI            " campo="CLNRO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="MOVIL                                   " tabla="CLI            " campo="CLMOVIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Teléfono móvil                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SITFISCALURUGUAY                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="2                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="422" etiqueta="Situación del cliente                                                                                                                                           " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="LISTADEPRECIO                           " tabla="CLI            " campo="CLLISPREC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="36" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIPOCLI                                 " tabla="CLI            " campo="CLTIPOCLI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOCLIENTE                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="56" etiqueta="Tipo                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CONTACTO                                " tabla="CONTACTODET    " campo="CONCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Contactos                                                                                                                                                       " dominio="DETALLEITEMCONTACTO           " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="12" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VIGENCIAHASTAGAN                        " tabla="CLI            " campo="VHASTAGAN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia Fecha de Ganancia                                                                                                                                      " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VIGENCIAHASTAIVA                        " tabla="CLI            " campo="VHASTAIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia Fecha de Iva                                                                                                                                           " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NROIIBB                                 " tabla="CLI            " campo="CLNROIIBB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Número Ingresos Brutos                                                                                                                                          " dominio="CONVENIOCONNUMERO             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CUIT                                    " tabla="CLI            " campo="CLCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="CUIT                                                                                                                                                            " dominio="CUITBUSQUEDA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NRODOCUMENTO                            " tabla="CLI            " campo="CLNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="50" etiqueta="Número documento                                                                                                                                                " dominio="DOCUMENTOCLIENTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PISO                                    " tabla="CLI            " campo="CLPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FAX                                     " tabla="CLI            " campo="CLFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CREDITO                                 " tabla="CLI            " campo="CNX1      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Crédito                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PERCEPCIONES                            " tabla="PERCLIDET      " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Percepciones                                                                                                                                                    " dominio="DETALLEITEMPERCEPCIONES       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SEXO                                    " tabla="CLI            " campo="SEXO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Sexo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SITUACIONGANANCIAS                      " tabla="CLI            " campo="CLSITGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Situación                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="RUT                                     " tabla="CLI            " campo="RUT       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="R.U.T.                                                                                                                                                          " dominio="RUT                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999999-X              " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CATEGCLI                                " tabla="CLI            " campo="CLCATEGCLI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIACLIENTE                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="58" etiqueta="Categoría                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PERCEPCIONIVA                           " tabla="CLI            " campo="CLPERTIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Código percepciones IVA                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="DESCUENTOPREFERENTE                     " tabla="CLI            " campo="CLCO_DTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESCUENTO                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="38" etiqueta="Descuento                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHANACIMIENTO                         " tabla="CLI            " campo="CLFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="44" etiqueta="Fecha de nacimiento                                                                                                                                             " dominio="FECHALARGACALENDARIO          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PAGINAWEB                               " tabla="CLI            " campo="CLPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Sitio web                                                                                                                                                       " dominio="WEB                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="DEPARTAMENTO                            " tabla="CLI            " campo="CLDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="DOLARESACUMULADOS                       " tabla="CLI            " campo="CLACUM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="U$S acumulados                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TOPECTACTE                              " tabla="CLI            " campo="CLTOPECCTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="40" etiqueta="Límite de crédito                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODIGOSIPRIB                            " tabla="CLI            " campo="CLSIPRIB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DATOSADICIONALESSIPRIB                  " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="IIBB Santa Fe SIPRIB                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PERCEPCIONGANANCIAS                     " tabla="CLI            " campo="CLPERGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Código percepciones Ganancias                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PRIMERNOMBRE                            " tabla="CLI            " campo="CLPRINOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Primer nombre                                                                                                                                                   " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TOPEFACTURACION                         " tabla="CLI            " campo="CLTOPE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tope facturación                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SUJETOVINCULADO                         " tabla="CLI            " campo="CLSUJVINC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Sujeto vinculado                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="LOCALIDAD                               " tabla="CLI            " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Localidad                                                                                                                                                       " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="ESTADOCIVIL                             " tabla="CLI            " campo="ESTADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Estado civil                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CONDICIONDEPAGO                         " tabla="CLI            " campo="CLCONDPAG " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SEGUNDONOMBRE                           " tabla="CLI            " campo="CLSEGNOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Segundo nombre                                                                                                                                                  " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TASACEROPORCEN                          " tabla="CLI            " campo="PORCENTC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="IIBB Mendoza con certificado tasa cero                                                                                                                          " dominio="NUMERICOCHECK                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODIGOPOSTAL                            " tabla="CLI            " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Código postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HIJOS                                   " tabla="CLI            " campo="HIJOS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Cantidad de hijos                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="APELLIDO                                " tabla="CLI            " campo="CLAPELL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Apellido                                                                                                                                                        " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TASACEROAPLICA                          " tabla="CLI            " campo="APLICATC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Aplica                                                                                                                                                          " dominio="NUMERICOCHECK                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PROVINCIA                               " tabla="CLI            " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Denominación o razón social                                                                                                                                     " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PAIS                                    " tabla="CLI            " campo="CLPAIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="EMAIL                                   " tabla="CLI            " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Email                                                                                                                                                           " dominio="MAILCLIENTE                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="33" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On CLI.CLVEND = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SITUACIONFISCAL                         " atributo="DESCRIPCION                             " tabla="SITFISCAL      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Sit.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SITFISCAL On CLI.CLIVA = SITFISCAL.Codigo And  SITFISCAL.CODIGO != 0                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="49" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On CLI.CLCLAS = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="35" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On CLI.CLTRANS = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="CODIGO                                  " tabla="NOMFANT        " campo="NFCOD     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="55" etiqueta="Detalle Nom.                                                                                                                                                    " dominio="CODIGOSINMUESTRARELACION      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NOMFANT On CLI.CLCODFANT = NOMFANT.NFCOD And  NOMFANT.NFCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="37" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On CLI.CLLISPREC = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOCLIENTE                             " atributo="DESCRIPCION                             " tabla="TIPOCLI        " campo="TCDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="57" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOCLI On CLI.CLTIPOCLI = TIPOCLI.TCCOD And  TIPOCLI.TCCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIACLIENTE                        " atributo="DESCRIPCION                             " tabla="CATCLI         " campo="CGDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="59" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATCLI On CLI.CLCATEGCLI = CATCLI.CGCod And  CATCLI.CGCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On CLI.CLPERTIVA = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCION                             " tabla="DESCUENTOS     " campo="DES       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="39" etiqueta="Detalle Des.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESCUENTOS On CLI.CLCO_DTO = DESCUENTOS.codigo And  DESCUENTOS.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="DESCRIPCION                             " tabla="SIPRIBDATADIC  " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="Código SIPRIB                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="437" etiqueta="Detalle IIB.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SIPRIBDATADIC On CLI.CLSIPRIB = SIPRIBDATADIC.Codigo And  SIPRIBDATADIC.CODIGO != ''                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="439" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On CLI.CLPERGAN = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="445" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On CLI.CLCONDPAG = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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