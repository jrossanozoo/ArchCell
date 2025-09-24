
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
	cTagClavePk = '_008PK'
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
			local  lxCliFecexpo, lxCliFecimpo, lxCliFaltafw, lxCliFmodifw, lxCliCd1, lxCliClfing, lxCliFectrans, lxCliClser, lxCliClretivav, lxCliClcalle, lxCliCltpo, lxCliCentid, lxCliTimestamp, lxCliUaltafw, lxCliSaltafw, lxCliEsttrans, lxCliHoraexpo, lxCliHaltafw, lxCliBdmodifw, lxCliHmodifw, lxCliBdaltafw, lxCliPrinom, lxCliSmodifw, lxCliApellido, lxCliGlobalid, lxCliClprov, lxCliVmodifw, lxCliClpin, lxCliValtafw, lxCliZadsfw, lxCliUmodifw, lxCliHoraimpo, lxCliCimagen, lxCliCc051, lxCliClcod, lxCliCltrans, lxCliClobs, lxCliClretganv, lxCliClnro, lxCliClloc, lxCliCliva, lxCliCc601, lxCliClimpd, lxCliCltlf, lxCliClclas, lxCliVende, lxCliClcodfant, lxCliClfecha, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliClcuit, lxCliCltipodoc, lxCliClt_dir, lxCliClcfi, lxCliClretibrv, lxCliClpiso, lxCliClsujvinc, lxCliCltmovil, lxCliClcp, lxCliClsitgan, lxCliCltipocli, lxCliCllistpre, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClnom, lxCliClnrodoc, lxCliClt_cuit, lxCliClretsegv, lxCliCldepto, lxCliCnx1, lxCliClfax, lxCliSexo, lxCliEstado, lxCliClprv, lxCliClcategcli, lxCliClco_dto, lxCliClpertiva, lxCliClpergan, lxCliClpageweb, lxCliClperibru, lxCliHijos, lxCliClacum, lxCliClentr, lxCliClvcod, lxCliClpais, lxCliClsiprib, lxCliClmsn, lxCliCltopeccte, lxCliCltope, lxCliPorcentc, lxCliAplicatc, lxCliClcondpag, lxCliClemail, lxCliRut, lxCliPcuit
				lxCliFecexpo =  .Fechaexpo			lxCliFecimpo =  .Fechaimpo			lxCliFaltafw =  .Fechaaltafw			lxCliFmodifw =  .Fechamodificacionfw			lxCliCd1 =  .Fechaultimamodificacion			lxCliClfing =  .Fechadealta			lxCliFectrans =  .Fechatransferencia			lxCliClser =  .Clasificacion2			lxCliClretivav =  .Retencioniva			lxCliClcalle =  .Calle			lxCliCltpo =  .Tipointerno			lxCliCentid =  .Idcentralizador			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliUaltafw =  .Usuarioaltafw			lxCliSaltafw =  .Seriealtafw			lxCliEsttrans =  .Estadotransferencia			lxCliHoraexpo =  .Horaexpo			lxCliHaltafw =  .Horaaltafw			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliHmodifw =  .Horamodificacionfw			lxCliBdaltafw =  .Basededatosaltafw			lxCliPrinom =  .Primernombre			lxCliSmodifw =  .Seriemodificacionfw			lxCliApellido =  .Apellido			lxCliGlobalid =  .Idglobal			lxCliClprov =  .Jurisdiccion			lxCliVmodifw =  .Versionmodificacionfw			lxCliClpin =  .Pin			lxCliValtafw =  .Versionaltafw			lxCliZadsfw =  .Zadsfw			lxCliUmodifw =  .Usuariomodificacionfw			lxCliHoraimpo =  .Horaimpo			lxCliCimagen =  .Imagen			lxCliCc051 =  upper( .Corredor_PK ) 			lxCliClcod =  .Codigo			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClobs =  .Observacion			lxCliClretganv =  .Retencionganancias			lxCliClnro =  .Numero			lxCliClloc =  .Localidad			lxCliCliva =  .Situacionfiscal_PK 			lxCliCc601 =  .Transporte			lxCliClimpd =  .Clasificacionsecundaria			lxCliCltlf =  .Telefono			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliVende =  upper( .Vendedor_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliExpergan =  .Excluidopercepcionganancias			lxCliExperiva =  .Excluidopercepcioniva			lxCliCltipconv =  .Tipoconvenio			lxCliClcuit =  .Cuit			lxCliCltipodoc =  .Tipodocumento			lxCliClt_dir =  .Direcciontransporte			lxCliClcfi =  .Cfi			lxCliClretibrv =  .Retencioningresosbrutos			lxCliClpiso =  .Piso			lxCliClsujvinc =  .Sujetovinculado			lxCliCltmovil =  .Movil			lxCliClcp =  .Codigopostal			lxCliClsitgan =  .Situacionganancias			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliCllistpre =  upper( .ListaDePrecio_PK ) 			lxCliVhastagan =  .Vigenciahastagan			lxCliVhastaiva =  .Vigenciahastaiva			lxCliClnroiibb =  .Nroiibb			lxCliClnom =  .Nombre			lxCliClnrodoc =  .Nrodocumento			lxCliClt_cuit =  .Cuittransporte			lxCliClretsegv =  .Retencionseguridadsocial			lxCliCldepto =  .Departamento			lxCliCnx1 =  .Credito			lxCliClfax =  .Fax			lxCliSexo =  .Sexo			lxCliEstado =  .Estadocivil			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClpertiva =  upper( .PercepcionIva_PK ) 			lxCliClpergan =  upper( .PercepcionGanancias_PK ) 			lxCliClpageweb =  .Paginaweb			lxCliClperibru =  .Percepcioningresosbrutos			lxCliHijos =  .Hijos			lxCliClacum =  .Dolaresacumulados			lxCliClentr =  .Lugardeentrega			lxCliClvcod =  upper( .CondicionPagoPreferente_PK ) 			lxCliClpais =  upper( .Pais_PK ) 			lxCliClsiprib =  upper( .CodigoSiprib_PK ) 			lxCliClmsn =  .Messenger			lxCliCltopeccte =  .Topectacte			lxCliCltope =  .Topefacturacion			lxCliPorcentc =  .Tasaceroporcen			lxCliAplicatc =  .Tasaceroaplica			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClemail =  .Email			lxCliRut =  .Rut			lxCliPcuit =  .Cuitpais
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
				insert into ZooLogic.CLI ( "Fecexpo","Fecimpo","Faltafw","Fmodifw","Cd1","Clfing","Fectrans","Clser","Clretivav","Clcalle","Cltpo","Centid","Timestamp","Ualtafw","Saltafw","Esttrans","Horaexpo","Haltafw","Bdmodifw","Hmodifw","Bdaltafw","Prinom","Smodifw","Apellido","Globalid","Clprov","Vmodifw","Clpin","Valtafw","Zadsfw","Umodifw","Horaimpo","Cimagen","Cc051","Clcod","Cltrans","Clobs","Clretganv","Clnro","Clloc","Cliva","Cc601","Climpd","Cltlf","Clclas","Vende","Clcodfant","Clfecha","Expergan","Experiva","Cltipconv","Clcuit","Cltipodoc","Clt_dir","Clcfi","Clretibrv","Clpiso","Clsujvinc","Cltmovil","Clcp","Clsitgan","Cltipocli","Cllistpre","Vhastagan","Vhastaiva","Clnroiibb","Clnom","Clnrodoc","Clt_cuit","Clretsegv","Cldepto","Cnx1","Clfax","Sexo","Estado","Clprv","Clcategcli","Clco_dto","Clpertiva","Clpergan","Clpageweb","Clperibru","Hijos","Clacum","Clentr","Clvcod","Clpais","Clsiprib","Clmsn","Cltopeccte","Cltope","Porcentc","Aplicatc","Clcondpag","Clemail","Rut","Pcuit" ) values ( <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'" >>, <<lxCliClser >>, <<"'" + this.FormatearTextoSql( lxCliClretivav ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'" >>, <<lxCliCltpo >>, <<lxCliCentid >>, <<lxCliTimestamp >>, <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliPrinom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliApellido ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCc051 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClretganv ) + "'" >>, <<lxCliClnro >>, <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'" >>, <<lxCliCliva >>, <<"'" + this.FormatearTextoSql( lxCliCc601 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliVende ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'" >>, <<iif( lxCliExpergan, 1, 0 ) >>, <<iif( lxCliExperiva, 1, 0 ) >>, <<lxCliCltipconv >>, <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClt_dir ) + "'" >>, <<lxCliClcfi >>, <<"'" + this.FormatearTextoSql( lxCliClretibrv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'" >>, <<iif( lxCliClsujvinc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliCltmovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'" >>, <<lxCliClsitgan >>, <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCllistpre ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliVhastagan ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliVhastaiva ) + "'" >>, <<lxCliClnroiibb >>, <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClt_cuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClretsegv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'" >>, <<lxCliCnx1 >>, <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpertiva ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpergan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClperibru ) + "'" >>, <<lxCliHijos >>, <<lxCliClacum >>, <<"'" + this.FormatearTextoSql( lxCliClentr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClvcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClsiprib ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClmsn ) + "'" >>, <<lxCliCltopeccte >>, <<lxCliCltope >>, <<lxCliPorcentc >>, <<iif( lxCliAplicatc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'" >> )
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
			for each loItem in this.oEntidad.ContactoDet
				if this.oEntidad.ContactoDet.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto_PK = loItem.Contacto_PK
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CONTACTODET("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxContacto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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
			local  lxCliFecexpo, lxCliFecimpo, lxCliFaltafw, lxCliFmodifw, lxCliCd1, lxCliClfing, lxCliFectrans, lxCliClser, lxCliClretivav, lxCliClcalle, lxCliCltpo, lxCliCentid, lxCliTimestamp, lxCliUaltafw, lxCliSaltafw, lxCliEsttrans, lxCliHoraexpo, lxCliHaltafw, lxCliBdmodifw, lxCliHmodifw, lxCliBdaltafw, lxCliPrinom, lxCliSmodifw, lxCliApellido, lxCliGlobalid, lxCliClprov, lxCliVmodifw, lxCliClpin, lxCliValtafw, lxCliZadsfw, lxCliUmodifw, lxCliHoraimpo, lxCliCimagen, lxCliCc051, lxCliClcod, lxCliCltrans, lxCliClobs, lxCliClretganv, lxCliClnro, lxCliClloc, lxCliCliva, lxCliCc601, lxCliClimpd, lxCliCltlf, lxCliClclas, lxCliVende, lxCliClcodfant, lxCliClfecha, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliClcuit, lxCliCltipodoc, lxCliClt_dir, lxCliClcfi, lxCliClretibrv, lxCliClpiso, lxCliClsujvinc, lxCliCltmovil, lxCliClcp, lxCliClsitgan, lxCliCltipocli, lxCliCllistpre, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClnom, lxCliClnrodoc, lxCliClt_cuit, lxCliClretsegv, lxCliCldepto, lxCliCnx1, lxCliClfax, lxCliSexo, lxCliEstado, lxCliClprv, lxCliClcategcli, lxCliClco_dto, lxCliClpertiva, lxCliClpergan, lxCliClpageweb, lxCliClperibru, lxCliHijos, lxCliClacum, lxCliClentr, lxCliClvcod, lxCliClpais, lxCliClsiprib, lxCliClmsn, lxCliCltopeccte, lxCliCltope, lxCliPorcentc, lxCliAplicatc, lxCliClcondpag, lxCliClemail, lxCliRut, lxCliPcuit
				lxCliFecexpo =  .Fechaexpo			lxCliFecimpo =  .Fechaimpo			lxCliFaltafw =  .Fechaaltafw			lxCliFmodifw =  .Fechamodificacionfw			lxCliCd1 =  .Fechaultimamodificacion			lxCliClfing =  .Fechadealta			lxCliFectrans =  .Fechatransferencia			lxCliClser =  .Clasificacion2			lxCliClretivav =  .Retencioniva			lxCliClcalle =  .Calle			lxCliCltpo =  .Tipointerno			lxCliCentid =  .Idcentralizador			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliUaltafw =  .Usuarioaltafw			lxCliSaltafw =  .Seriealtafw			lxCliEsttrans =  .Estadotransferencia			lxCliHoraexpo =  .Horaexpo			lxCliHaltafw =  .Horaaltafw			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliHmodifw =  .Horamodificacionfw			lxCliBdaltafw =  .Basededatosaltafw			lxCliPrinom =  .Primernombre			lxCliSmodifw =  .Seriemodificacionfw			lxCliApellido =  .Apellido			lxCliGlobalid =  .Idglobal			lxCliClprov =  .Jurisdiccion			lxCliVmodifw =  .Versionmodificacionfw			lxCliClpin =  .Pin			lxCliValtafw =  .Versionaltafw			lxCliZadsfw =  .Zadsfw			lxCliUmodifw =  .Usuariomodificacionfw			lxCliHoraimpo =  .Horaimpo			lxCliCimagen =  .Imagen			lxCliCc051 =  upper( .Corredor_PK ) 			lxCliClcod =  .Codigo			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClobs =  .Observacion			lxCliClretganv =  .Retencionganancias			lxCliClnro =  .Numero			lxCliClloc =  .Localidad			lxCliCliva =  .Situacionfiscal_PK 			lxCliCc601 =  .Transporte			lxCliClimpd =  .Clasificacionsecundaria			lxCliCltlf =  .Telefono			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliVende =  upper( .Vendedor_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliExpergan =  .Excluidopercepcionganancias			lxCliExperiva =  .Excluidopercepcioniva			lxCliCltipconv =  .Tipoconvenio			lxCliClcuit =  .Cuit			lxCliCltipodoc =  .Tipodocumento			lxCliClt_dir =  .Direcciontransporte			lxCliClcfi =  .Cfi			lxCliClretibrv =  .Retencioningresosbrutos			lxCliClpiso =  .Piso			lxCliClsujvinc =  .Sujetovinculado			lxCliCltmovil =  .Movil			lxCliClcp =  .Codigopostal			lxCliClsitgan =  .Situacionganancias			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliCllistpre =  upper( .ListaDePrecio_PK ) 			lxCliVhastagan =  .Vigenciahastagan			lxCliVhastaiva =  .Vigenciahastaiva			lxCliClnroiibb =  .Nroiibb			lxCliClnom =  .Nombre			lxCliClnrodoc =  .Nrodocumento			lxCliClt_cuit =  .Cuittransporte			lxCliClretsegv =  .Retencionseguridadsocial			lxCliCldepto =  .Departamento			lxCliCnx1 =  .Credito			lxCliClfax =  .Fax			lxCliSexo =  .Sexo			lxCliEstado =  .Estadocivil			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClpertiva =  upper( .PercepcionIva_PK ) 			lxCliClpergan =  upper( .PercepcionGanancias_PK ) 			lxCliClpageweb =  .Paginaweb			lxCliClperibru =  .Percepcioningresosbrutos			lxCliHijos =  .Hijos			lxCliClacum =  .Dolaresacumulados			lxCliClentr =  .Lugardeentrega			lxCliClvcod =  upper( .CondicionPagoPreferente_PK ) 			lxCliClpais =  upper( .Pais_PK ) 			lxCliClsiprib =  upper( .CodigoSiprib_PK ) 			lxCliClmsn =  .Messenger			lxCliCltopeccte =  .Topectacte			lxCliCltope =  .Topefacturacion			lxCliPorcentc =  .Tasaceroporcen			lxCliAplicatc =  .Tasaceroaplica			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClemail =  .Email			lxCliRut =  .Rut			lxCliPcuit =  .Cuitpais
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
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CLI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'">>,"Cd1" = <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'">>,"Clfing" = <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'">>,"Clser" = <<lxCliClser>>,"Clretivav" = <<"'" + this.FormatearTextoSql( lxCliClretivav ) + "'">>,"Clcalle" = <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'">>,"Cltpo" = <<lxCliCltpo>>,"Centid" = <<lxCliCentid>>,"Timestamp" = <<lxCliTimestamp>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'">>,"Prinom" = <<"'" + this.FormatearTextoSql( lxCliPrinom ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'">>,"Apellido" = <<"'" + this.FormatearTextoSql( lxCliApellido ) + "'">>,"Globalid" = <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'">>,"Clprov" = <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'">>,"Clpin" = <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'">>,"Cimagen" = <<"'" + this.FormatearTextoSql( lxCliCimagen ) + "'">>,"Cc051" = <<"'" + this.FormatearTextoSql( lxCliCc051 ) + "'">>,"Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">>,"Cltrans" = <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'">>,"Clretganv" = <<"'" + this.FormatearTextoSql( lxCliClretganv ) + "'">>,"Clnro" = <<lxCliClnro>>,"Clloc" = <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'">>,"Cliva" = <<lxCliCliva>>,"Cc601" = <<"'" + this.FormatearTextoSql( lxCliCc601 ) + "'">>,"Climpd" = <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'">>,"Clclas" = <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'">>,"Vende" = <<"'" + this.FormatearTextoSql( lxCliVende ) + "'">>,"Clcodfant" = <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'">>,"Clfecha" = <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'">>,"Expergan" = <<iif( lxCliExpergan, 1, 0 )>>,"Experiva" = <<iif( lxCliExperiva, 1, 0 )>>,"Cltipconv" = <<lxCliCltipconv>>,"Clcuit" = <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'">>,"Cltipodoc" = <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'">>,"Clt_dir" = <<"'" + this.FormatearTextoSql( lxCliClt_dir ) + "'">>,"Clcfi" = <<lxCliClcfi>>,"Clretibrv" = <<"'" + this.FormatearTextoSql( lxCliClretibrv ) + "'">>,"Clpiso" = <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'">>,"Clsujvinc" = <<iif( lxCliClsujvinc, 1, 0 )>>,"Cltmovil" = <<"'" + this.FormatearTextoSql( lxCliCltmovil ) + "'">>,"Clcp" = <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'">>,"Clsitgan" = <<lxCliClsitgan>>,"Cltipocli" = <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'">>,"Cllistpre" = <<"'" + this.FormatearTextoSql( lxCliCllistpre ) + "'">>,"Vhastagan" = <<"'" + this.ConvertirDateSql( lxCliVhastagan ) + "'">>,"Vhastaiva" = <<"'" + this.ConvertirDateSql( lxCliVhastaiva ) + "'">>,"Clnroiibb" = <<lxCliClnroiibb>>,"Clnom" = <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'">>,"Clnrodoc" = <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'">>,"Clt_cuit" = <<"'" + this.FormatearTextoSql( lxCliClt_cuit ) + "'">>,"Clretsegv" = <<"'" + this.FormatearTextoSql( lxCliClretsegv ) + "'">>,"Cldepto" = <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'">>,"Cnx1" = <<lxCliCnx1>>,"Clfax" = <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'">>,"Sexo" = <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'">>,"Estado" = <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'">>,"Clprv" = <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'">>,"Clcategcli" = <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'">>,"Clco_dto" = <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'">>,"Clpertiva" = <<"'" + this.FormatearTextoSql( lxCliClpertiva ) + "'">>,"Clpergan" = <<"'" + this.FormatearTextoSql( lxCliClpergan ) + "'">>,"Clpageweb" = <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'">>,"Clperibru" = <<"'" + this.FormatearTextoSql( lxCliClperibru ) + "'">>,"Hijos" = <<lxCliHijos>>,"Clacum" = <<lxCliClacum>>,"Clentr" = <<"'" + this.FormatearTextoSql( lxCliClentr ) + "'">>,"Clvcod" = <<"'" + this.FormatearTextoSql( lxCliClvcod ) + "'">>,"Clpais" = <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'">>,"Clsiprib" = <<"'" + this.FormatearTextoSql( lxCliClsiprib ) + "'">>,"Clmsn" = <<"'" + this.FormatearTextoSql( lxCliClmsn ) + "'">>,"Cltopeccte" = <<lxCliCltopeccte>>,"Cltope" = <<lxCliCltope>>,"Porcentc" = <<lxCliPorcentc>>,"Aplicatc" = <<iif( lxCliAplicatc, 1, 0 )>>,"Clcondpag" = <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'">>,"Clemail" = <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'">>,"Rut" = <<"'" + this.FormatearTextoSql( lxCliRut ) + "'">>,"Pcuit" = <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'">> where "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">> and  CLI.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CONTACTODET where "CONCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CliOtrasDir where "ODCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PerExcluido where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PerCliDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ContactoDet
				if this.oEntidad.ContactoDet.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto_PK = loItem.Contacto_PK
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CONTACTODET("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxContacto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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
				select "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Clfing" as "Fechadealta", "Fectrans" as "Fechatransferencia", "Clser" as "Clasificacion2", "Clretivav" as "Retencioniva", "Clcalle" as "Calle", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Prinom" as "Primernombre", "Smodifw" as "Seriemodificacionfw", "Apellido" as "Apellido", "Globalid" as "Idglobal", "Clprov" as "Jurisdiccion", "Vmodifw" as "Versionmodificacionfw", "Clpin" as "Pin", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Cimagen" as "Imagen", "Cc051" as "Corredor", "Clcod" as "Codigo", "Cltrans" as "Transportista", "Clobs" as "Observacion", "Clretganv" as "Retencionganancias", "Clnro" as "Numero", "Clloc" as "Localidad", "Cliva" as "Situacionfiscal", "Cc601" as "Transporte", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Clclas" as "Clasificacion", "Vende" as "Vendedor", "Clcodfant" as "Codnombrefantasia", "Clfecha" as "Fechanacimiento", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clt_dir" as "Direcciontransporte", "Clcfi" as "Cfi", "Clretibrv" as "Retencioningresosbrutos", "Clpiso" as "Piso", "Clsujvinc" as "Sujetovinculado", "Cltmovil" as "Movil", "Clcp" as "Codigopostal", "Clsitgan" as "Situacionganancias", "Cltipocli" as "Tipocli", "Cllistpre" as "Listadeprecio", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clnrodoc" as "Nrodocumento", "Clt_cuit" as "Cuittransporte", "Clretsegv" as "Retencionseguridadsocial", "Cldepto" as "Departamento", "Cnx1" as "Credito", "Clfax" as "Fax", "Sexo" as "Sexo", "Estado" as "Estadocivil", "Clprv" as "Provincia", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clpertiva" as "Percepcioniva", "Clpergan" as "Percepcionganancias", "Clpageweb" as "Paginaweb", "Clperibru" as "Percepcioningresosbrutos", "Hijos" as "Hijos", "Clacum" as "Dolaresacumulados", "Clentr" as "Lugardeentrega", "Clvcod" as "Condicionpagopreferente", "Clpais" as "Pais", "Clsiprib" as "Codigosiprib", "Clmsn" as "Messenger", "Cltopeccte" as "Topectacte", "Cltope" as "Topefacturacion", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica", "Clcondpag" as "Condiciondepago", "Clemail" as "Email", "Rut" as "Rut", "Pcuit" as "Cuitpais" from ZooLogic.CLI where "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">> and  CLI.CLCOD != ''
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )

			if reccount( 'c_CLIENTE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ContactoDet')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ContactoDet', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ContactoDet
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Clfing" as "Fechadealta", "Fectrans" as "Fechatransferencia", "Clser" as "Clasificacion2", "Clretivav" as "Retencioniva", "Clcalle" as "Calle", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Prinom" as "Primernombre", "Smodifw" as "Seriemodificacionfw", "Apellido" as "Apellido", "Globalid" as "Idglobal", "Clprov" as "Jurisdiccion", "Vmodifw" as "Versionmodificacionfw", "Clpin" as "Pin", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Cimagen" as "Imagen", "Cc051" as "Corredor", "Clcod" as "Codigo", "Cltrans" as "Transportista", "Clobs" as "Observacion", "Clretganv" as "Retencionganancias", "Clnro" as "Numero", "Clloc" as "Localidad", "Cliva" as "Situacionfiscal", "Cc601" as "Transporte", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Clclas" as "Clasificacion", "Vende" as "Vendedor", "Clcodfant" as "Codnombrefantasia", "Clfecha" as "Fechanacimiento", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clt_dir" as "Direcciontransporte", "Clcfi" as "Cfi", "Clretibrv" as "Retencioningresosbrutos", "Clpiso" as "Piso", "Clsujvinc" as "Sujetovinculado", "Cltmovil" as "Movil", "Clcp" as "Codigopostal", "Clsitgan" as "Situacionganancias", "Cltipocli" as "Tipocli", "Cllistpre" as "Listadeprecio", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clnrodoc" as "Nrodocumento", "Clt_cuit" as "Cuittransporte", "Clretsegv" as "Retencionseguridadsocial", "Cldepto" as "Departamento", "Cnx1" as "Credito", "Clfax" as "Fax", "Sexo" as "Sexo", "Estado" as "Estadocivil", "Clprv" as "Provincia", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clpertiva" as "Percepcioniva", "Clpergan" as "Percepcionganancias", "Clpageweb" as "Paginaweb", "Clperibru" as "Percepcioningresosbrutos", "Hijos" as "Hijos", "Clacum" as "Dolaresacumulados", "Clentr" as "Lugardeentrega", "Clvcod" as "Condicionpagopreferente", "Clpais" as "Pais", "Clsiprib" as "Codigosiprib", "Clmsn" as "Messenger", "Cltopeccte" as "Topectacte", "Cltope" as "Topefacturacion", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica", "Clcondpag" as "Condiciondepago", "Clemail" as "Email", "Rut" as "Rut", "Pcuit" as "Cuitpais" from ZooLogic.CLI where  CLI.CLCOD != '' order by CLCOD
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ContactoDet')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ContactoDet', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ContactoDet
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Clfing" as "Fechadealta", "Fectrans" as "Fechatransferencia", "Clser" as "Clasificacion2", "Clretivav" as "Retencioniva", "Clcalle" as "Calle", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Prinom" as "Primernombre", "Smodifw" as "Seriemodificacionfw", "Apellido" as "Apellido", "Globalid" as "Idglobal", "Clprov" as "Jurisdiccion", "Vmodifw" as "Versionmodificacionfw", "Clpin" as "Pin", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Cimagen" as "Imagen", "Cc051" as "Corredor", "Clcod" as "Codigo", "Cltrans" as "Transportista", "Clobs" as "Observacion", "Clretganv" as "Retencionganancias", "Clnro" as "Numero", "Clloc" as "Localidad", "Cliva" as "Situacionfiscal", "Cc601" as "Transporte", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Clclas" as "Clasificacion", "Vende" as "Vendedor", "Clcodfant" as "Codnombrefantasia", "Clfecha" as "Fechanacimiento", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clt_dir" as "Direcciontransporte", "Clcfi" as "Cfi", "Clretibrv" as "Retencioningresosbrutos", "Clpiso" as "Piso", "Clsujvinc" as "Sujetovinculado", "Cltmovil" as "Movil", "Clcp" as "Codigopostal", "Clsitgan" as "Situacionganancias", "Cltipocli" as "Tipocli", "Cllistpre" as "Listadeprecio", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clnrodoc" as "Nrodocumento", "Clt_cuit" as "Cuittransporte", "Clretsegv" as "Retencionseguridadsocial", "Cldepto" as "Departamento", "Cnx1" as "Credito", "Clfax" as "Fax", "Sexo" as "Sexo", "Estado" as "Estadocivil", "Clprv" as "Provincia", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clpertiva" as "Percepcioniva", "Clpergan" as "Percepcionganancias", "Clpageweb" as "Paginaweb", "Clperibru" as "Percepcioningresosbrutos", "Hijos" as "Hijos", "Clacum" as "Dolaresacumulados", "Clentr" as "Lugardeentrega", "Clvcod" as "Condicionpagopreferente", "Clpais" as "Pais", "Clsiprib" as "Codigosiprib", "Clmsn" as "Messenger", "Cltopeccte" as "Topectacte", "Cltope" as "Topefacturacion", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica", "Clcondpag" as "Condiciondepago", "Clemail" as "Email", "Rut" as "Rut", "Pcuit" as "Cuitpais" from ZooLogic.CLI where  funciones.padr( CLCOD, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CLI.CLCOD != '' order by CLCOD
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ContactoDet')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ContactoDet', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ContactoDet
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Clfing" as "Fechadealta", "Fectrans" as "Fechatransferencia", "Clser" as "Clasificacion2", "Clretivav" as "Retencioniva", "Clcalle" as "Calle", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Prinom" as "Primernombre", "Smodifw" as "Seriemodificacionfw", "Apellido" as "Apellido", "Globalid" as "Idglobal", "Clprov" as "Jurisdiccion", "Vmodifw" as "Versionmodificacionfw", "Clpin" as "Pin", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Cimagen" as "Imagen", "Cc051" as "Corredor", "Clcod" as "Codigo", "Cltrans" as "Transportista", "Clobs" as "Observacion", "Clretganv" as "Retencionganancias", "Clnro" as "Numero", "Clloc" as "Localidad", "Cliva" as "Situacionfiscal", "Cc601" as "Transporte", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Clclas" as "Clasificacion", "Vende" as "Vendedor", "Clcodfant" as "Codnombrefantasia", "Clfecha" as "Fechanacimiento", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clt_dir" as "Direcciontransporte", "Clcfi" as "Cfi", "Clretibrv" as "Retencioningresosbrutos", "Clpiso" as "Piso", "Clsujvinc" as "Sujetovinculado", "Cltmovil" as "Movil", "Clcp" as "Codigopostal", "Clsitgan" as "Situacionganancias", "Cltipocli" as "Tipocli", "Cllistpre" as "Listadeprecio", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clnrodoc" as "Nrodocumento", "Clt_cuit" as "Cuittransporte", "Clretsegv" as "Retencionseguridadsocial", "Cldepto" as "Departamento", "Cnx1" as "Credito", "Clfax" as "Fax", "Sexo" as "Sexo", "Estado" as "Estadocivil", "Clprv" as "Provincia", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clpertiva" as "Percepcioniva", "Clpergan" as "Percepcionganancias", "Clpageweb" as "Paginaweb", "Clperibru" as "Percepcioningresosbrutos", "Hijos" as "Hijos", "Clacum" as "Dolaresacumulados", "Clentr" as "Lugardeentrega", "Clvcod" as "Condicionpagopreferente", "Clpais" as "Pais", "Clsiprib" as "Codigosiprib", "Clmsn" as "Messenger", "Cltopeccte" as "Topectacte", "Cltope" as "Topefacturacion", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica", "Clcondpag" as "Condiciondepago", "Clemail" as "Email", "Rut" as "Rut", "Pcuit" as "Cuitpais" from ZooLogic.CLI where  funciones.padr( CLCOD, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CLI.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ContactoDet')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ContactoDet', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ContactoDet
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Clfing" as "Fechadealta", "Fectrans" as "Fechatransferencia", "Clser" as "Clasificacion2", "Clretivav" as "Retencioniva", "Clcalle" as "Calle", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Prinom" as "Primernombre", "Smodifw" as "Seriemodificacionfw", "Apellido" as "Apellido", "Globalid" as "Idglobal", "Clprov" as "Jurisdiccion", "Vmodifw" as "Versionmodificacionfw", "Clpin" as "Pin", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Cimagen" as "Imagen", "Cc051" as "Corredor", "Clcod" as "Codigo", "Cltrans" as "Transportista", "Clobs" as "Observacion", "Clretganv" as "Retencionganancias", "Clnro" as "Numero", "Clloc" as "Localidad", "Cliva" as "Situacionfiscal", "Cc601" as "Transporte", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Clclas" as "Clasificacion", "Vende" as "Vendedor", "Clcodfant" as "Codnombrefantasia", "Clfecha" as "Fechanacimiento", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clt_dir" as "Direcciontransporte", "Clcfi" as "Cfi", "Clretibrv" as "Retencioningresosbrutos", "Clpiso" as "Piso", "Clsujvinc" as "Sujetovinculado", "Cltmovil" as "Movil", "Clcp" as "Codigopostal", "Clsitgan" as "Situacionganancias", "Cltipocli" as "Tipocli", "Cllistpre" as "Listadeprecio", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clnrodoc" as "Nrodocumento", "Clt_cuit" as "Cuittransporte", "Clretsegv" as "Retencionseguridadsocial", "Cldepto" as "Departamento", "Cnx1" as "Credito", "Clfax" as "Fax", "Sexo" as "Sexo", "Estado" as "Estadocivil", "Clprv" as "Provincia", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clpertiva" as "Percepcioniva", "Clpergan" as "Percepcionganancias", "Clpageweb" as "Paginaweb", "Clperibru" as "Percepcioningresosbrutos", "Hijos" as "Hijos", "Clacum" as "Dolaresacumulados", "Clentr" as "Lugardeentrega", "Clvcod" as "Condicionpagopreferente", "Clpais" as "Pais", "Clsiprib" as "Codigosiprib", "Clmsn" as "Messenger", "Cltopeccte" as "Topectacte", "Cltope" as "Topefacturacion", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica", "Clcondpag" as "Condiciondepago", "Clemail" as "Email", "Rut" as "Rut", "Pcuit" as "Cuitpais" from ZooLogic.CLI where  CLI.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_CLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.CONTACTODET where CONCOD = <<"'" + this.FormatearTextoSql( c_CLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ContactoDet')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ContactoDet', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ContactoDet
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fecimpo,Faltafw,Fmodifw,Cd1,Clfing,Fectrans,Clser,Clretivav,Clcalle,Cltpo,Centid,Tim" + ;
"estamp,Ualtafw,Saltafw,Esttrans,Horaexpo,Haltafw,Bdmodifw,Hmodifw,Bdaltafw,Prinom,Smodifw,Apellido,G" + ;
"lobalid,Clprov,Vmodifw,Clpin,Valtafw,Zadsfw,Umodifw,Horaimpo,Cimagen,Cc051,Clcod,Cltrans,Clobs,Clret" + ;
"ganv,Clnro,Clloc,Cliva,Cc601,Climpd,Cltlf,Clclas,Vende,Clcodfant,Clfecha,Expergan,Experiva,Cltipconv" + ;
",Clcuit,Cltipodoc,Clt_dir,Clcfi,Clretibrv,Clpiso,Clsujvinc,Cltmovil,Clcp,Clsitgan,Cltipocli,Cllistpr" + ;
"e,Vhastagan,Vhastaiva,Clnroiibb,Clnom,Clnrodoc,Clt_cuit,Clretsegv,Cldepto,Cnx1,Clfax,Sexo,Estado,Clp" + ;
"rv,Clcategcli,Clco_dto,Clpertiva,Clpergan,Clpageweb,Clperibru,Hijos,Clacum,Clentr,Clvcod,Clpais,Clsi" + ;
"prib,Clmsn,Cltopeccte,Cltope,Porcentc,Aplicatc,Clcondpag,Clemail,Rut,Pcuit" + ;
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
			local  lxCliFecexpo, lxCliFecimpo, lxCliFaltafw, lxCliFmodifw, lxCliCd1, lxCliClfing, lxCliFectrans, lxCliClser, lxCliClretivav, lxCliClcalle, lxCliCltpo, lxCliCentid, lxCliTimestamp, lxCliUaltafw, lxCliSaltafw, lxCliEsttrans, lxCliHoraexpo, lxCliHaltafw, lxCliBdmodifw, lxCliHmodifw, lxCliBdaltafw, lxCliPrinom, lxCliSmodifw, lxCliApellido, lxCliGlobalid, lxCliClprov, lxCliVmodifw, lxCliClpin, lxCliValtafw, lxCliZadsfw, lxCliUmodifw, lxCliHoraimpo, lxCliCimagen, lxCliCc051, lxCliClcod, lxCliCltrans, lxCliClobs, lxCliClretganv, lxCliClnro, lxCliClloc, lxCliCliva, lxCliCc601, lxCliClimpd, lxCliCltlf, lxCliClclas, lxCliVende, lxCliClcodfant, lxCliClfecha, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliClcuit, lxCliCltipodoc, lxCliClt_dir, lxCliClcfi, lxCliClretibrv, lxCliClpiso, lxCliClsujvinc, lxCliCltmovil, lxCliClcp, lxCliClsitgan, lxCliCltipocli, lxCliCllistpre, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClnom, lxCliClnrodoc, lxCliClt_cuit, lxCliClretsegv, lxCliCldepto, lxCliCnx1, lxCliClfax, lxCliSexo, lxCliEstado, lxCliClprv, lxCliClcategcli, lxCliClco_dto, lxCliClpertiva, lxCliClpergan, lxCliClpageweb, lxCliClperibru, lxCliHijos, lxCliClacum, lxCliClentr, lxCliClvcod, lxCliClpais, lxCliClsiprib, lxCliClmsn, lxCliCltopeccte, lxCliCltope, lxCliPorcentc, lxCliAplicatc, lxCliClcondpag, lxCliClemail, lxCliRut, lxCliPcuit
				lxCliFecexpo = ctod( '  /  /    ' )			lxCliFecimpo = ctod( '  /  /    ' )			lxCliFaltafw = ctod( '  /  /    ' )			lxCliFmodifw = ctod( '  /  /    ' )			lxCliCd1 = ctod( '  /  /    ' )			lxCliClfing = ctod( '  /  /    ' )			lxCliFectrans = ctod( '  /  /    ' )			lxCliClser = 0			lxCliClretivav = []			lxCliClcalle = []			lxCliCltpo = 0			lxCliCentid = 0			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliUaltafw = []			lxCliSaltafw = []			lxCliEsttrans = []			lxCliHoraexpo = []			lxCliHaltafw = []			lxCliBdmodifw = []			lxCliHmodifw = []			lxCliBdaltafw = []			lxCliPrinom = []			lxCliSmodifw = []			lxCliApellido = []			lxCliGlobalid = []			lxCliClprov = []			lxCliVmodifw = []			lxCliClpin = []			lxCliValtafw = []			lxCliZadsfw = []			lxCliUmodifw = []			lxCliHoraimpo = []			lxCliCimagen = []			lxCliCc051 = []			lxCliClcod = []			lxCliCltrans = []			lxCliClobs = []			lxCliClretganv = []			lxCliClnro = 0			lxCliClloc = []			lxCliCliva = 0			lxCliCc601 = []			lxCliClimpd = []			lxCliCltlf = []			lxCliClclas = []			lxCliVende = []			lxCliClcodfant = []			lxCliClfecha = ctod( '  /  /    ' )			lxCliExpergan = .F.			lxCliExperiva = .F.			lxCliCltipconv = 0			lxCliClcuit = []			lxCliCltipodoc = []			lxCliClt_dir = []			lxCliClcfi = 0			lxCliClretibrv = []			lxCliClpiso = []			lxCliClsujvinc = .F.			lxCliCltmovil = []			lxCliClcp = []			lxCliClsitgan = 0			lxCliCltipocli = []			lxCliCllistpre = []			lxCliVhastagan = ctod( '  /  /    ' )			lxCliVhastaiva = ctod( '  /  /    ' )			lxCliClnroiibb = 0			lxCliClnom = []			lxCliClnrodoc = []			lxCliClt_cuit = []			lxCliClretsegv = []			lxCliCldepto = []			lxCliCnx1 = 0			lxCliClfax = []			lxCliSexo = []			lxCliEstado = []			lxCliClprv = []			lxCliClcategcli = []			lxCliClco_dto = []			lxCliClpertiva = []			lxCliClpergan = []			lxCliClpageweb = []			lxCliClperibru = []			lxCliHijos = 0			lxCliClacum = 0			lxCliClentr = []			lxCliClvcod = []			lxCliClpais = []			lxCliClsiprib = []			lxCliClmsn = []			lxCliCltopeccte = 0			lxCliCltope = 0			lxCliPorcentc = 0			lxCliAplicatc = .F.			lxCliClcondpag = []			lxCliClemail = []			lxCliRut = []			lxCliPcuit = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CONTACTODET where "CONCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CliOtrasDir where "ODCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PerExcluido where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
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
					"Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Clfing" as "Fechadealta", "Fectrans" as "Fechatransferencia", "Clser" as "Clasificacion2", "Clretivav" as "Retencioniva", "Clcalle" as "Calle", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Prinom" as "Primernombre", "Smodifw" as "Seriemodificacionfw", "Apellido" as "Apellido", "Globalid" as "Idglobal", "Clprov" as "Jurisdiccion", "Vmodifw" as "Versionmodificacionfw", "Clpin" as "Pin", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Cimagen" as "Imagen", "Cc051" as "Corredor", "Clcod" as "Codigo", "Cltrans" as "Transportista", "Clobs" as "Observacion", "Clretganv" as "Retencionganancias", "Clnro" as "Numero", "Clloc" as "Localidad", "Cliva" as "Situacionfiscal", "Cc601" as "Transporte", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Clclas" as "Clasificacion", "Vende" as "Vendedor", "Clcodfant" as "Codnombrefantasia", "Clfecha" as "Fechanacimiento", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clt_dir" as "Direcciontransporte", "Clcfi" as "Cfi", "Clretibrv" as "Retencioningresosbrutos", "Clpiso" as "Piso", "Clsujvinc" as "Sujetovinculado", "Cltmovil" as "Movil", "Clcp" as "Codigopostal", "Clsitgan" as "Situacionganancias", "Cltipocli" as "Tipocli", "Cllistpre" as "Listadeprecio", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clnrodoc" as "Nrodocumento", "Clt_cuit" as "Cuittransporte", "Clretsegv" as "Retencionseguridadsocial", "Cldepto" as "Departamento", "Cnx1" as "Credito", "Clfax" as "Fax", "Sexo" as "Sexo", "Estado" as "Estadocivil", "Clprv" as "Provincia", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clpertiva" as "Percepcioniva", "Clpergan" as "Percepcionganancias", "Clpageweb" as "Paginaweb", "Clperibru" as "Percepcioningresosbrutos", "Hijos" as "Hijos", "Clacum" as "Dolaresacumulados", "Clentr" as "Lugardeentrega", "Clvcod" as "Condicionpagopreferente", "Clpais" as "Pais", "Clsiprib" as "Codigosiprib", "Clmsn" as "Messenger", "Cltopeccte" as "Topectacte", "Cltope" as "Topefacturacion", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica", "Clcondpag" as "Condiciondepago", "Clemail" as "Email", "Rut" as "Rut", "Pcuit" as "Cuitpais"
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
	Function ObtenerDatosDetalleContactoDet( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CONTACTODET.CONCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleContactoDet( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CONTACTODET', 'ContactoDet', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleContactoDet( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleContactoDet( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAULTIMAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CD1 AS FECHAULTIMAMODIFICACION'
				Case lcAtributo == 'FECHADEALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFING AS FECHADEALTA'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'CLASIFICACION2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSER AS CLASIFICACION2'
				Case lcAtributo == 'RETENCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETIVAV AS RETENCIONIVA'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCALLE AS CALLE'
				Case lcAtributo == 'TIPOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTPO AS TIPOINTERNO'
				Case lcAtributo == 'IDCENTRALIZADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTID AS IDCENTRALIZADOR'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'PRIMERNOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRINOM AS PRIMERNOMBRE'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'APELLIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APELLIDO AS APELLIDO'
				Case lcAtributo == 'IDGLOBAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GLOBALID AS IDGLOBAL'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPROV AS JURISDICCION'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'PIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPIN AS PIN'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIMAGEN AS IMAGEN'
				Case lcAtributo == 'CORREDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CC051 AS CORREDOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTRANS AS TRANSPORTISTA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'RETENCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETGANV AS RETENCIONGANANCIAS'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRO AS NUMERO'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIVA AS SITUACIONFISCAL'
				Case lcAtributo == 'TRANSPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CC601 AS TRANSPORTE'
				Case lcAtributo == 'CLASIFICACIONSECUNDARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIMPD AS CLASIFICACIONSECUNDARIA'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCLAS AS CLASIFICACION'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDE AS VENDEDOR'
				Case lcAtributo == 'CODNOMBREFANTASIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCODFANT AS CODNOMBREFANTASIA'
				Case lcAtributo == 'FECHANACIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFECHA AS FECHANACIMIENTO'
				Case lcAtributo == 'EXCLUIDOPERCEPCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPERGAN AS EXCLUIDOPERCEPCIONGANANCIAS'
				Case lcAtributo == 'EXCLUIDOPERCEPCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPERIVA AS EXCLUIDOPERCEPCIONIVA'
				Case lcAtributo == 'TIPOCONVENIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPCONV AS TIPOCONVENIO'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCUIT AS CUIT'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'DIRECCIONTRANSPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLT_DIR AS DIRECCIONTRANSPORTE'
				Case lcAtributo == 'CFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS CFI'
				Case lcAtributo == 'RETENCIONINGRESOSBRUTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETIBRV AS RETENCIONINGRESOSBRUTOS'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPISO AS PISO'
				Case lcAtributo == 'SUJETOVINCULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSUJVINC AS SUJETOVINCULADO'
				Case lcAtributo == 'MOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTMOVIL AS MOVIL'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'SITUACIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSITGAN AS SITUACIONGANANCIAS'
				Case lcAtributo == 'TIPOCLI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPOCLI AS TIPOCLI'
				Case lcAtributo == 'LISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLISTPRE AS LISTADEPRECIO'
				Case lcAtributo == 'VIGENCIAHASTAGAN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VHASTAGAN AS VIGENCIAHASTAGAN'
				Case lcAtributo == 'VIGENCIAHASTAIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VHASTAIVA AS VIGENCIAHASTAIVA'
				Case lcAtributo == 'NROIIBB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNROIIBB AS NROIIBB'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'CUITTRANSPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLT_CUIT AS CUITTRANSPORTE'
				Case lcAtributo == 'RETENCIONSEGURIDADSOCIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETSEGV AS RETENCIONSEGURIDADSOCIAL'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'CREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNX1 AS CREDITO'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFAX AS FAX'
				Case lcAtributo == 'SEXO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEXO AS SEXO'
				Case lcAtributo == 'ESTADOCIVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADOCIVIL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
				Case lcAtributo == 'CATEGCLI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCATEGCLI AS CATEGCLI'
				Case lcAtributo == 'DESCUENTOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCO_DTO AS DESCUENTOPREFERENTE'
				Case lcAtributo == 'PERCEPCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPERTIVA AS PERCEPCIONIVA'
				Case lcAtributo == 'PERCEPCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPERGAN AS PERCEPCIONGANANCIAS'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'PERCEPCIONINGRESOSBRUTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPERIBRU AS PERCEPCIONINGRESOSBRUTOS'
				Case lcAtributo == 'HIJOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HIJOS AS HIJOS'
				Case lcAtributo == 'DOLARESACUMULADOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLACUM AS DOLARESACUMULADOS'
				Case lcAtributo == 'LUGARDEENTREGA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLENTR AS LUGARDEENTREGA'
				Case lcAtributo == 'CONDICIONPAGOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVCOD AS CONDICIONPAGOPREFERENTE'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAIS AS PAIS'
				Case lcAtributo == 'CODIGOSIPRIB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSIPRIB AS CODIGOSIPRIB'
				Case lcAtributo == 'MESSENGER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMSN AS MESSENGER'
				Case lcAtributo == 'TOPECTACTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTOPECCTE AS TOPECTACTE'
				Case lcAtributo == 'TOPEFACTURACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTOPE AS TOPEFACTURACION'
				Case lcAtributo == 'TASACEROPORCEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENTC AS TASACEROPORCEN'
				Case lcAtributo == 'TASACEROAPLICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APLICATC AS TASACEROAPLICA'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCONDPAG AS CONDICIONDEPAGO'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
				Case lcAtributo == 'RUT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUT AS RUT'
				Case lcAtributo == 'CUITPAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUIT AS CUITPAIS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleContactoDet( tcCampos As String ) As String
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTIMAMODIFICACION'
				lcCampo = 'CD1'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADEALTA'
				lcCampo = 'CLFING'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION2'
				lcCampo = 'CLSER'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONIVA'
				lcCampo = 'CLRETIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'CLCALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO'
				lcCampo = 'CLTPO'
			Case upper( alltrim( tcAtributo ) ) == 'IDCENTRALIZADOR'
				lcCampo = 'CENTID'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'PRIMERNOMBRE'
				lcCampo = 'PRINOM'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'APELLIDO'
				lcCampo = 'APELLIDO'
			Case upper( alltrim( tcAtributo ) ) == 'IDGLOBAL'
				lcCampo = 'GLOBALID'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'CLPROV'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'PIN'
				lcCampo = 'CLPIN'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'CIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CORREDOR'
				lcCampo = 'CC051'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'CLTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONGANANCIAS'
				lcCampo = 'CLRETGANV'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CLNRO'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'CLIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTE'
				lcCampo = 'CC601'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACIONSECUNDARIA'
				lcCampo = 'CLIMPD'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLCLAS'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDE'
			Case upper( alltrim( tcAtributo ) ) == 'CODNOMBREFANTASIA'
				lcCampo = 'CLCODFANT'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANACIMIENTO'
				lcCampo = 'CLFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDOPERCEPCIONGANANCIAS'
				lcCampo = 'EXPERGAN'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDOPERCEPCIONIVA'
				lcCampo = 'EXPERIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCONVENIO'
				lcCampo = 'CLTIPCONV'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CLCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'CLTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCIONTRANSPORTE'
				lcCampo = 'CLT_DIR'
			Case upper( alltrim( tcAtributo ) ) == 'CFI'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONINGRESOSBRUTOS'
				lcCampo = 'CLRETIBRV'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'CLPISO'
			Case upper( alltrim( tcAtributo ) ) == 'SUJETOVINCULADO'
				lcCampo = 'CLSUJVINC'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIL'
				lcCampo = 'CLTMOVIL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONGANANCIAS'
				lcCampo = 'CLSITGAN'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCLI'
				lcCampo = 'CLTIPOCLI'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIO'
				lcCampo = 'CLLISTPRE'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTAGAN'
				lcCampo = 'VHASTAGAN'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTAIVA'
				lcCampo = 'VHASTAIVA'
			Case upper( alltrim( tcAtributo ) ) == 'NROIIBB'
				lcCampo = 'CLNROIIBB'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CLNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CUITTRANSPORTE'
				lcCampo = 'CLT_CUIT'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONSEGURIDADSOCIAL'
				lcCampo = 'CLRETSEGV'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'CLDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'CREDITO'
				lcCampo = 'CNX1'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'CLFAX'
			Case upper( alltrim( tcAtributo ) ) == 'SEXO'
				lcCampo = 'SEXO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOCIVIL'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGCLI'
				lcCampo = 'CLCATEGCLI'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPREFERENTE'
				lcCampo = 'CLCO_DTO'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVA'
				lcCampo = 'CLPERTIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONGANANCIAS'
				lcCampo = 'CLPERGAN'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'CLPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONINGRESOSBRUTOS'
				lcCampo = 'CLPERIBRU'
			Case upper( alltrim( tcAtributo ) ) == 'HIJOS'
				lcCampo = 'HIJOS'
			Case upper( alltrim( tcAtributo ) ) == 'DOLARESACUMULADOS'
				lcCampo = 'CLACUM'
			Case upper( alltrim( tcAtributo ) ) == 'LUGARDEENTREGA'
				lcCampo = 'CLENTR'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONPAGOPREFERENTE'
				lcCampo = 'CLVCOD'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'CLPAIS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOSIPRIB'
				lcCampo = 'CLSIPRIB'
			Case upper( alltrim( tcAtributo ) ) == 'MESSENGER'
				lcCampo = 'CLMSN'
			Case upper( alltrim( tcAtributo ) ) == 'TOPECTACTE'
				lcCampo = 'CLTOPECCTE'
			Case upper( alltrim( tcAtributo ) ) == 'TOPEFACTURACION'
				lcCampo = 'CLTOPE'
			Case upper( alltrim( tcAtributo ) ) == 'TASACEROPORCEN'
				lcCampo = 'PORCENTC'
			Case upper( alltrim( tcAtributo ) ) == 'TASACEROAPLICA'
				lcCampo = 'APLICATC'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CLCONDPAG'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'RUT'
				lcCampo = 'RUT'
			Case upper( alltrim( tcAtributo ) ) == 'CUITPAIS'
				lcCampo = 'PCUIT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleContactoDet( tcAtributo As String ) As String
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
		if upper( alltrim( tcDetalle ) ) == 'CONTACTODET'
			lcRetorno = 'CONTACTODET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'OTRASDIRECCIONES'
			lcRetorno = 'CLIOTRASDIR'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'EXCLUIDOOTRAPERCEP'
			lcRetorno = 'PEREXCLUIDO'
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
			local  lxCliFecexpo, lxCliFecimpo, lxCliFaltafw, lxCliFmodifw, lxCliCd1, lxCliClfing, lxCliFectrans, lxCliClser, lxCliClretivav, lxCliClcalle, lxCliCltpo, lxCliCentid, lxCliTimestamp, lxCliUaltafw, lxCliSaltafw, lxCliEsttrans, lxCliHoraexpo, lxCliHaltafw, lxCliBdmodifw, lxCliHmodifw, lxCliBdaltafw, lxCliPrinom, lxCliSmodifw, lxCliApellido, lxCliGlobalid, lxCliClprov, lxCliVmodifw, lxCliClpin, lxCliValtafw, lxCliZadsfw, lxCliUmodifw, lxCliHoraimpo, lxCliCimagen, lxCliCc051, lxCliClcod, lxCliCltrans, lxCliClobs, lxCliClretganv, lxCliClnro, lxCliClloc, lxCliCliva, lxCliCc601, lxCliClimpd, lxCliCltlf, lxCliClclas, lxCliVende, lxCliClcodfant, lxCliClfecha, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliClcuit, lxCliCltipodoc, lxCliClt_dir, lxCliClcfi, lxCliClretibrv, lxCliClpiso, lxCliClsujvinc, lxCliCltmovil, lxCliClcp, lxCliClsitgan, lxCliCltipocli, lxCliCllistpre, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClnom, lxCliClnrodoc, lxCliClt_cuit, lxCliClretsegv, lxCliCldepto, lxCliCnx1, lxCliClfax, lxCliSexo, lxCliEstado, lxCliClprv, lxCliClcategcli, lxCliClco_dto, lxCliClpertiva, lxCliClpergan, lxCliClpageweb, lxCliClperibru, lxCliHijos, lxCliClacum, lxCliClentr, lxCliClvcod, lxCliClpais, lxCliClsiprib, lxCliClmsn, lxCliCltopeccte, lxCliCltope, lxCliPorcentc, lxCliAplicatc, lxCliClcondpag, lxCliClemail, lxCliRut, lxCliPcuit
				lxCliFecexpo =  .Fechaexpo			lxCliFecimpo =  .Fechaimpo			lxCliFaltafw =  .Fechaaltafw			lxCliFmodifw =  .Fechamodificacionfw			lxCliCd1 =  .Fechaultimamodificacion			lxCliClfing =  .Fechadealta			lxCliFectrans =  .Fechatransferencia			lxCliClser =  .Clasificacion2			lxCliClretivav =  .Retencioniva			lxCliClcalle =  .Calle			lxCliCltpo =  .Tipointerno			lxCliCentid =  .Idcentralizador			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliUaltafw =  .Usuarioaltafw			lxCliSaltafw =  .Seriealtafw			lxCliEsttrans =  .Estadotransferencia			lxCliHoraexpo =  .Horaexpo			lxCliHaltafw =  .Horaaltafw			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliHmodifw =  .Horamodificacionfw			lxCliBdaltafw =  .Basededatosaltafw			lxCliPrinom =  .Primernombre			lxCliSmodifw =  .Seriemodificacionfw			lxCliApellido =  .Apellido			lxCliGlobalid =  .Idglobal			lxCliClprov =  .Jurisdiccion			lxCliVmodifw =  .Versionmodificacionfw			lxCliClpin =  .Pin			lxCliValtafw =  .Versionaltafw			lxCliZadsfw =  .Zadsfw			lxCliUmodifw =  .Usuariomodificacionfw			lxCliHoraimpo =  .Horaimpo			lxCliCimagen =  .Imagen			lxCliCc051 =  upper( .Corredor_PK ) 			lxCliClcod =  .Codigo			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClobs =  .Observacion			lxCliClretganv =  .Retencionganancias			lxCliClnro =  .Numero			lxCliClloc =  .Localidad			lxCliCliva =  .Situacionfiscal_PK 			lxCliCc601 =  .Transporte			lxCliClimpd =  .Clasificacionsecundaria			lxCliCltlf =  .Telefono			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliVende =  upper( .Vendedor_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliExpergan =  .Excluidopercepcionganancias			lxCliExperiva =  .Excluidopercepcioniva			lxCliCltipconv =  .Tipoconvenio			lxCliClcuit =  .Cuit			lxCliCltipodoc =  .Tipodocumento			lxCliClt_dir =  .Direcciontransporte			lxCliClcfi =  .Cfi			lxCliClretibrv =  .Retencioningresosbrutos			lxCliClpiso =  .Piso			lxCliClsujvinc =  .Sujetovinculado			lxCliCltmovil =  .Movil			lxCliClcp =  .Codigopostal			lxCliClsitgan =  .Situacionganancias			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliCllistpre =  upper( .ListaDePrecio_PK ) 			lxCliVhastagan =  .Vigenciahastagan			lxCliVhastaiva =  .Vigenciahastaiva			lxCliClnroiibb =  .Nroiibb			lxCliClnom =  .Nombre			lxCliClnrodoc =  .Nrodocumento			lxCliClt_cuit =  .Cuittransporte			lxCliClretsegv =  .Retencionseguridadsocial			lxCliCldepto =  .Departamento			lxCliCnx1 =  .Credito			lxCliClfax =  .Fax			lxCliSexo =  .Sexo			lxCliEstado =  .Estadocivil			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClpertiva =  upper( .PercepcionIva_PK ) 			lxCliClpergan =  upper( .PercepcionGanancias_PK ) 			lxCliClpageweb =  .Paginaweb			lxCliClperibru =  .Percepcioningresosbrutos			lxCliHijos =  .Hijos			lxCliClacum =  .Dolaresacumulados			lxCliClentr =  .Lugardeentrega			lxCliClvcod =  upper( .CondicionPagoPreferente_PK ) 			lxCliClpais =  upper( .Pais_PK ) 			lxCliClsiprib =  upper( .CodigoSiprib_PK ) 			lxCliClmsn =  .Messenger			lxCliCltopeccte =  .Topectacte			lxCliCltope =  .Topefacturacion			lxCliPorcentc =  .Tasaceroporcen			lxCliAplicatc =  .Tasaceroaplica			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClemail =  .Email			lxCliRut =  .Rut			lxCliPcuit =  .Cuitpais
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CLI ( "Fecexpo","Fecimpo","Faltafw","Fmodifw","Cd1","Clfing","Fectrans","Clser","Clretivav","Clcalle","Cltpo","Centid","Timestamp","Ualtafw","Saltafw","Esttrans","Horaexpo","Haltafw","Bdmodifw","Hmodifw","Bdaltafw","Prinom","Smodifw","Apellido","Globalid","Clprov","Vmodifw","Clpin","Valtafw","Zadsfw","Umodifw","Horaimpo","Cimagen","Cc051","Clcod","Cltrans","Clobs","Clretganv","Clnro","Clloc","Cliva","Cc601","Climpd","Cltlf","Clclas","Vende","Clcodfant","Clfecha","Expergan","Experiva","Cltipconv","Clcuit","Cltipodoc","Clt_dir","Clcfi","Clretibrv","Clpiso","Clsujvinc","Cltmovil","Clcp","Clsitgan","Cltipocli","Cllistpre","Vhastagan","Vhastaiva","Clnroiibb","Clnom","Clnrodoc","Clt_cuit","Clretsegv","Cldepto","Cnx1","Clfax","Sexo","Estado","Clprv","Clcategcli","Clco_dto","Clpertiva","Clpergan","Clpageweb","Clperibru","Hijos","Clacum","Clentr","Clvcod","Clpais","Clsiprib","Clmsn","Cltopeccte","Cltope","Porcentc","Aplicatc","Clcondpag","Clemail","Rut","Pcuit" ) values ( <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'" >>, <<lxCliClser >>, <<"'" + this.FormatearTextoSql( lxCliClretivav ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'" >>, <<lxCliCltpo >>, <<lxCliCentid >>, <<lxCliTimestamp >>, <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliPrinom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliApellido ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCc051 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClretganv ) + "'" >>, <<lxCliClnro >>, <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'" >>, <<lxCliCliva >>, <<"'" + this.FormatearTextoSql( lxCliCc601 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliVende ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'" >>, <<iif( lxCliExpergan, 1, 0 ) >>, <<iif( lxCliExperiva, 1, 0 ) >>, <<lxCliCltipconv >>, <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClt_dir ) + "'" >>, <<lxCliClcfi >>, <<"'" + this.FormatearTextoSql( lxCliClretibrv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'" >>, <<iif( lxCliClsujvinc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliCltmovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'" >>, <<lxCliClsitgan >>, <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCllistpre ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliVhastagan ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliVhastaiva ) + "'" >>, <<lxCliClnroiibb >>, <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClt_cuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClretsegv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'" >>, <<lxCliCnx1 >>, <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpertiva ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpergan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClperibru ) + "'" >>, <<lxCliHijos >>, <<lxCliClacum >>, <<"'" + this.FormatearTextoSql( lxCliClentr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClvcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClsiprib ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClmsn ) + "'" >>, <<lxCliCltopeccte >>, <<lxCliCltope >>, <<lxCliPorcentc >>, <<iif( lxCliAplicatc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CLI' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ContactoDet
				if this.oEntidad.ContactoDet.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto_PK = loItem.Contacto_PK
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CONTACTODET("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxContacto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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
			local  lxCliFecexpo, lxCliFecimpo, lxCliFaltafw, lxCliFmodifw, lxCliCd1, lxCliClfing, lxCliFectrans, lxCliClser, lxCliClretivav, lxCliClcalle, lxCliCltpo, lxCliCentid, lxCliTimestamp, lxCliUaltafw, lxCliSaltafw, lxCliEsttrans, lxCliHoraexpo, lxCliHaltafw, lxCliBdmodifw, lxCliHmodifw, lxCliBdaltafw, lxCliPrinom, lxCliSmodifw, lxCliApellido, lxCliGlobalid, lxCliClprov, lxCliVmodifw, lxCliClpin, lxCliValtafw, lxCliZadsfw, lxCliUmodifw, lxCliHoraimpo, lxCliCimagen, lxCliCc051, lxCliClcod, lxCliCltrans, lxCliClobs, lxCliClretganv, lxCliClnro, lxCliClloc, lxCliCliva, lxCliCc601, lxCliClimpd, lxCliCltlf, lxCliClclas, lxCliVende, lxCliClcodfant, lxCliClfecha, lxCliExpergan, lxCliExperiva, lxCliCltipconv, lxCliClcuit, lxCliCltipodoc, lxCliClt_dir, lxCliClcfi, lxCliClretibrv, lxCliClpiso, lxCliClsujvinc, lxCliCltmovil, lxCliClcp, lxCliClsitgan, lxCliCltipocli, lxCliCllistpre, lxCliVhastagan, lxCliVhastaiva, lxCliClnroiibb, lxCliClnom, lxCliClnrodoc, lxCliClt_cuit, lxCliClretsegv, lxCliCldepto, lxCliCnx1, lxCliClfax, lxCliSexo, lxCliEstado, lxCliClprv, lxCliClcategcli, lxCliClco_dto, lxCliClpertiva, lxCliClpergan, lxCliClpageweb, lxCliClperibru, lxCliHijos, lxCliClacum, lxCliClentr, lxCliClvcod, lxCliClpais, lxCliClsiprib, lxCliClmsn, lxCliCltopeccte, lxCliCltope, lxCliPorcentc, lxCliAplicatc, lxCliClcondpag, lxCliClemail, lxCliRut, lxCliPcuit
				lxCliFecexpo =  .Fechaexpo			lxCliFecimpo =  .Fechaimpo			lxCliFaltafw =  .Fechaaltafw			lxCliFmodifw =  .Fechamodificacionfw			lxCliCd1 =  .Fechaultimamodificacion			lxCliClfing =  .Fechadealta			lxCliFectrans =  .Fechatransferencia			lxCliClser =  .Clasificacion2			lxCliClretivav =  .Retencioniva			lxCliClcalle =  .Calle			lxCliCltpo =  .Tipointerno			lxCliCentid =  .Idcentralizador			lxCliTimestamp = goLibrerias.ObtenerTimestamp()			lxCliUaltafw =  .Usuarioaltafw			lxCliSaltafw =  .Seriealtafw			lxCliEsttrans =  .Estadotransferencia			lxCliHoraexpo =  .Horaexpo			lxCliHaltafw =  .Horaaltafw			lxCliBdmodifw =  .Basededatosmodificacionfw			lxCliHmodifw =  .Horamodificacionfw			lxCliBdaltafw =  .Basededatosaltafw			lxCliPrinom =  .Primernombre			lxCliSmodifw =  .Seriemodificacionfw			lxCliApellido =  .Apellido			lxCliGlobalid =  .Idglobal			lxCliClprov =  .Jurisdiccion			lxCliVmodifw =  .Versionmodificacionfw			lxCliClpin =  .Pin			lxCliValtafw =  .Versionaltafw			lxCliZadsfw =  .Zadsfw			lxCliUmodifw =  .Usuariomodificacionfw			lxCliHoraimpo =  .Horaimpo			lxCliCimagen =  .Imagen			lxCliCc051 =  upper( .Corredor_PK ) 			lxCliClcod =  .Codigo			lxCliCltrans =  upper( .Transportista_PK ) 			lxCliClobs =  .Observacion			lxCliClretganv =  .Retencionganancias			lxCliClnro =  .Numero			lxCliClloc =  .Localidad			lxCliCliva =  .Situacionfiscal_PK 			lxCliCc601 =  .Transporte			lxCliClimpd =  .Clasificacionsecundaria			lxCliCltlf =  .Telefono			lxCliClclas =  upper( .Clasificacion_PK ) 			lxCliVende =  upper( .Vendedor_PK ) 			lxCliClcodfant =  upper( .CodNombreFantasia_PK ) 			lxCliClfecha =  .Fechanacimiento			lxCliExpergan =  .Excluidopercepcionganancias			lxCliExperiva =  .Excluidopercepcioniva			lxCliCltipconv =  .Tipoconvenio			lxCliClcuit =  .Cuit			lxCliCltipodoc =  .Tipodocumento			lxCliClt_dir =  .Direcciontransporte			lxCliClcfi =  .Cfi			lxCliClretibrv =  .Retencioningresosbrutos			lxCliClpiso =  .Piso			lxCliClsujvinc =  .Sujetovinculado			lxCliCltmovil =  .Movil			lxCliClcp =  .Codigopostal			lxCliClsitgan =  .Situacionganancias			lxCliCltipocli =  upper( .TipoCli_PK ) 			lxCliCllistpre =  upper( .ListaDePrecio_PK ) 			lxCliVhastagan =  .Vigenciahastagan			lxCliVhastaiva =  .Vigenciahastaiva			lxCliClnroiibb =  .Nroiibb			lxCliClnom =  .Nombre			lxCliClnrodoc =  .Nrodocumento			lxCliClt_cuit =  .Cuittransporte			lxCliClretsegv =  .Retencionseguridadsocial			lxCliCldepto =  .Departamento			lxCliCnx1 =  .Credito			lxCliClfax =  .Fax			lxCliSexo =  .Sexo			lxCliEstado =  .Estadocivil			lxCliClprv =  upper( .Provincia_PK ) 			lxCliClcategcli =  upper( .CategCli_PK ) 			lxCliClco_dto =  upper( .DescuentoPreferente_PK ) 			lxCliClpertiva =  upper( .PercepcionIva_PK ) 			lxCliClpergan =  upper( .PercepcionGanancias_PK ) 			lxCliClpageweb =  .Paginaweb			lxCliClperibru =  .Percepcioningresosbrutos			lxCliHijos =  .Hijos			lxCliClacum =  .Dolaresacumulados			lxCliClentr =  .Lugardeentrega			lxCliClvcod =  upper( .CondicionPagoPreferente_PK ) 			lxCliClpais =  upper( .Pais_PK ) 			lxCliClsiprib =  upper( .CodigoSiprib_PK ) 			lxCliClmsn =  .Messenger			lxCliCltopeccte =  .Topectacte			lxCliCltope =  .Topefacturacion			lxCliPorcentc =  .Tasaceroporcen			lxCliAplicatc =  .Tasaceroaplica			lxCliClcondpag =  upper( .CondicionDePago_PK ) 			lxCliClemail =  .Email			lxCliRut =  .Rut			lxCliPcuit =  .Cuitpais
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  CLI.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CLI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCliFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCliFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCliFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCliFmodifw ) + "'">>, "Cd1" = <<"'" + this.ConvertirDateSql( lxCliCd1 ) + "'">>, "Clfing" = <<"'" + this.ConvertirDateSql( lxCliClfing ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCliFectrans ) + "'">>, "Clser" = <<lxCliClser>>, "Clretivav" = <<"'" + this.FormatearTextoSql( lxCliClretivav ) + "'">>, "Clcalle" = <<"'" + this.FormatearTextoSql( lxCliClcalle ) + "'">>, "Cltpo" = <<lxCliCltpo>>, "Centid" = <<lxCliCentid>>, "Timestamp" = <<lxCliTimestamp>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCliUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCliSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCliEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCliHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCliHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCliBdmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCliHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCliBdaltafw ) + "'">>, "Prinom" = <<"'" + this.FormatearTextoSql( lxCliPrinom ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCliSmodifw ) + "'">>, "Apellido" = <<"'" + this.FormatearTextoSql( lxCliApellido ) + "'">>, "Globalid" = <<"'" + this.FormatearTextoSql( lxCliGlobalid ) + "'">>, "Clprov" = <<"'" + this.FormatearTextoSql( lxCliClprov ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCliVmodifw ) + "'">>, "Clpin" = <<"'" + this.FormatearTextoSql( lxCliClpin ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCliValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCliZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCliUmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCliHoraimpo ) + "'">>, "Cimagen" = <<"'" + this.FormatearTextoSql( lxCliCimagen ) + "'">>, "Cc051" = <<"'" + this.FormatearTextoSql( lxCliCc051 ) + "'">>, "Clcod" = <<"'" + this.FormatearTextoSql( lxCliClcod ) + "'">>, "Cltrans" = <<"'" + this.FormatearTextoSql( lxCliCltrans ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxCliClobs ) + "'">>, "Clretganv" = <<"'" + this.FormatearTextoSql( lxCliClretganv ) + "'">>, "Clnro" = <<lxCliClnro>>, "Clloc" = <<"'" + this.FormatearTextoSql( lxCliClloc ) + "'">>, "Cliva" = <<lxCliCliva>>, "Cc601" = <<"'" + this.FormatearTextoSql( lxCliCc601 ) + "'">>, "Climpd" = <<"'" + this.FormatearTextoSql( lxCliClimpd ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxCliCltlf ) + "'">>, "Clclas" = <<"'" + this.FormatearTextoSql( lxCliClclas ) + "'">>, "Vende" = <<"'" + this.FormatearTextoSql( lxCliVende ) + "'">>, "Clcodfant" = <<"'" + this.FormatearTextoSql( lxCliClcodfant ) + "'">>, "Clfecha" = <<"'" + this.ConvertirDateSql( lxCliClfecha ) + "'">>, "Expergan" = <<iif( lxCliExpergan, 1, 0 )>>, "Experiva" = <<iif( lxCliExperiva, 1, 0 )>>, "Cltipconv" = <<lxCliCltipconv>>, "Clcuit" = <<"'" + this.FormatearTextoSql( lxCliClcuit ) + "'">>, "Cltipodoc" = <<"'" + this.FormatearTextoSql( lxCliCltipodoc ) + "'">>, "Clt_dir" = <<"'" + this.FormatearTextoSql( lxCliClt_dir ) + "'">>, "Clcfi" = <<lxCliClcfi>>, "Clretibrv" = <<"'" + this.FormatearTextoSql( lxCliClretibrv ) + "'">>, "Clpiso" = <<"'" + this.FormatearTextoSql( lxCliClpiso ) + "'">>, "Clsujvinc" = <<iif( lxCliClsujvinc, 1, 0 )>>, "Cltmovil" = <<"'" + this.FormatearTextoSql( lxCliCltmovil ) + "'">>, "Clcp" = <<"'" + this.FormatearTextoSql( lxCliClcp ) + "'">>, "Clsitgan" = <<lxCliClsitgan>>, "Cltipocli" = <<"'" + this.FormatearTextoSql( lxCliCltipocli ) + "'">>, "Cllistpre" = <<"'" + this.FormatearTextoSql( lxCliCllistpre ) + "'">>, "Vhastagan" = <<"'" + this.ConvertirDateSql( lxCliVhastagan ) + "'">>, "Vhastaiva" = <<"'" + this.ConvertirDateSql( lxCliVhastaiva ) + "'">>, "Clnroiibb" = <<lxCliClnroiibb>>, "Clnom" = <<"'" + this.FormatearTextoSql( lxCliClnom ) + "'">>, "Clnrodoc" = <<"'" + this.FormatearTextoSql( lxCliClnrodoc ) + "'">>, "Clt_cuit" = <<"'" + this.FormatearTextoSql( lxCliClt_cuit ) + "'">>, "Clretsegv" = <<"'" + this.FormatearTextoSql( lxCliClretsegv ) + "'">>, "Cldepto" = <<"'" + this.FormatearTextoSql( lxCliCldepto ) + "'">>, "Cnx1" = <<lxCliCnx1>>, "Clfax" = <<"'" + this.FormatearTextoSql( lxCliClfax ) + "'">>, "Sexo" = <<"'" + this.FormatearTextoSql( lxCliSexo ) + "'">>, "Estado" = <<"'" + this.FormatearTextoSql( lxCliEstado ) + "'">>, "Clprv" = <<"'" + this.FormatearTextoSql( lxCliClprv ) + "'">>, "Clcategcli" = <<"'" + this.FormatearTextoSql( lxCliClcategcli ) + "'">>, "Clco_dto" = <<"'" + this.FormatearTextoSql( lxCliClco_dto ) + "'">>, "Clpertiva" = <<"'" + this.FormatearTextoSql( lxCliClpertiva ) + "'">>, "Clpergan" = <<"'" + this.FormatearTextoSql( lxCliClpergan ) + "'">>, "Clpageweb" = <<"'" + this.FormatearTextoSql( lxCliClpageweb ) + "'">>, "Clperibru" = <<"'" + this.FormatearTextoSql( lxCliClperibru ) + "'">>, "Hijos" = <<lxCliHijos>>, "Clacum" = <<lxCliClacum>>, "Clentr" = <<"'" + this.FormatearTextoSql( lxCliClentr ) + "'">>, "Clvcod" = <<"'" + this.FormatearTextoSql( lxCliClvcod ) + "'">>, "Clpais" = <<"'" + this.FormatearTextoSql( lxCliClpais ) + "'">>, "Clsiprib" = <<"'" + this.FormatearTextoSql( lxCliClsiprib ) + "'">>, "Clmsn" = <<"'" + this.FormatearTextoSql( lxCliClmsn ) + "'">>, "Cltopeccte" = <<lxCliCltopeccte>>, "Cltope" = <<lxCliCltope>>, "Porcentc" = <<lxCliPorcentc>>, "Aplicatc" = <<iif( lxCliAplicatc, 1, 0 )>>, "Clcondpag" = <<"'" + this.FormatearTextoSql( lxCliClcondpag ) + "'">>, "Clemail" = <<"'" + this.FormatearTextoSql( lxCliClemail ) + "'">>, "Rut" = <<"'" + this.FormatearTextoSql( lxCliRut ) + "'">>, "Pcuit" = <<"'" + this.FormatearTextoSql( lxCliPcuit ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CLI' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CONTACTODET where "CONCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CliOtrasDir where "ODCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PerExcluido where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PerCliDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ContactoDet
				if this.oEntidad.ContactoDet.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto_PK = loItem.Contacto_PK
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CONTACTODET("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxContacto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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
			loColeccion.Agregar([delete from ZooLogic.CONTACTODET where "CONCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CliOtrasDir where "ODCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PerExcluido where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCLICLIVA as variant, lxCLICLCLAS as variant, lxCLICLTIPCONV as variant, lxCLICLCUIT as variant, lxCLICLNROIIBB as variant, lxCLICLTOPECCTE as variant, lxCLIRUT as variant, lcMensajeExtra as String
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
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CLI set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, CD1 = ] + "'" + this.ConvertirDateSql( &lcCursor..CD1 ) + "'"+ [, CLFING = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, CLSER = ] + transform( &lcCursor..CLSER )+ [, CLRETIVAV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETIVAV ) + "'"+ [, CLCalle = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCalle ) + "'"+ [, CLTPO = ] + transform( &lcCursor..CLTPO )+ [, centid = ] + transform( &lcCursor..centid )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, PRINOM = ] + "'" + this.FormatearTextoSql( &lcCursor..PRINOM ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, APELLIDO = ] + "'" + this.FormatearTextoSql( &lcCursor..APELLIDO ) + "'"+ [, globalid = ] + "'" + this.FormatearTextoSql( &lcCursor..globalid ) + "'"+ [, CLPROV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPROV ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, CLPIN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPIN ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, CIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'"+ [, CC051 = ] + "'" + this.FormatearTextoSql( &lcCursor..CC051 ) + "'"+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTRANS ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CLRETGANV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETGANV ) + "'"+ [, CLNro = ] + transform( &lcCursor..CLNro )+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLIVA = ] + transform( &lcCursor..CLIVA )+ [, CC601 = ] + "'" + this.FormatearTextoSql( &lcCursor..CC601 ) + "'"+ [, CLIMPD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, CLCLAS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'"+ [, Vende = ] + "'" + this.FormatearTextoSql( &lcCursor..Vende ) + "'"+ [, CLCODFANT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANT ) + "'"+ [, CLFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'"+ [, EXPERGAN = ] + Transform( iif( &lcCursor..EXPERGAN, 1, 0 ))+ [, EXPERIVA = ] + Transform( iif( &lcCursor..EXPERIVA, 1, 0 ))+ [, CLTIPCONV = ] + transform( &lcCursor..CLTIPCONV )+ [, CLCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"+ [, CLTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"+ [, CLT_DIR = ] + "'" + this.FormatearTextoSql( &lcCursor..CLT_DIR ) + "'"+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, CLRETIBRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETIBRV ) + "'"+ [, ClPiso = ] + "'" + this.FormatearTextoSql( &lcCursor..ClPiso ) + "'"+ [, ClSujVinc = ] + Transform( iif( &lcCursor..ClSujVinc, 1, 0 ))+ [, CLTMovil = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTMovil ) + "'"+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, CLSITGAN = ] + transform( &lcCursor..CLSITGAN )+ [, CLTipoCli = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCli ) + "'"+ [, CLLISTPRE = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLISTPRE ) + "'"+ [, VHastaGan = ] + "'" + this.ConvertirDateSql( &lcCursor..VHastaGan ) + "'"+ [, VHastaIva = ] + "'" + this.ConvertirDateSql( &lcCursor..VHastaIva ) + "'"+ [, CLNROIIBB = ] + transform( &lcCursor..CLNROIIBB )+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, CLNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'"+ [, CLT_CUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLT_CUIT ) + "'"+ [, CLRETSEGV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETSEGV ) + "'"+ [, CLDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'"+ [, CNX1 = ] + transform( &lcCursor..CNX1 )+ [, CLFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"+ [, Sexo = ] + "'" + this.FormatearTextoSql( &lcCursor..Sexo ) + "'"+ [, Estado = ] + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"+ [, CLCategCli = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCategCli ) + "'"+ [, CLCO_DTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCO_DTO ) + "'"+ [, CLPERTIVA = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPERTIVA ) + "'"+ [, CLPERGAN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPERGAN ) + "'"+ [, CLPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'"+ [, CLPERIBRU = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPERIBRU ) + "'"+ [, Hijos = ] + transform( &lcCursor..Hijos )+ [, CLACUM = ] + transform( &lcCursor..CLACUM )+ [, CLENTR = ] + "'" + this.FormatearTextoSql( &lcCursor..CLENTR ) + "'"+ [, CLVCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLVCOD ) + "'"+ [, CLPAIS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAIS ) + "'"+ [, CLSIPRIB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLSIPRIB ) + "'"+ [, CLMSN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLMSN ) + "'"+ [, CLTOPECCTE = ] + transform( &lcCursor..CLTOPECCTE )+ [, CLTOPE = ] + transform( &lcCursor..CLTOPE )+ [, PorcenTC = ] + transform( &lcCursor..PorcenTC )+ [, AplicaTC = ] + Transform( iif( &lcCursor..AplicaTC, 1, 0 ))+ [, CLCONDPAG = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'"+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"+ [, RUT = ] + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'"+ [, PCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUIT ) + "'" + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					lcCampo = lcCursor + '.' + this.cCampoCodigoWH
					this.AgregarMensajeWebHook( 'MODIFICAR', &lcCampo )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECIMPO, FALTAFW, FMODIFW, CD1, CLFING, FECTRANS, CLSER, CLRETIVAV, CLCalle, CLTPO, centid, TIMESTAMP, UALTAFW, SALTAFW, ESTTRANS, HORAEXPO, HALTAFW, BDMODIFW, HMODIFW, BDALTAFW, PRINOM, SMODIFW, APELLIDO, globalid, CLPROV, VMODIFW, CLPIN, VALTAFW, ZADSFW, UMODIFW, HORAIMPO, CIMAGEN, CC051, CLCOD, CLTRANS, CLOBS, CLRETGANV, CLNro, CLLOC, CLIVA, CC601, CLIMPD, CLTLF, CLCLAS, Vende, CLCODFANT, CLFECHA, EXPERGAN, EXPERIVA, CLTIPCONV, CLCUIT, CLTIPODOC, CLT_DIR, CLCFI, CLRETIBRV, ClPiso, ClSujVinc, CLTMovil, CLCP, CLSITGAN, CLTipoCli, CLLISTPRE, VHastaGan, VHastaIva, CLNROIIBB, CLNOM, CLNRODOC, CLT_CUIT, CLRETSEGV, CLDEPTO, CNX1, CLFAX, Sexo, Estado, CLPRV, CLCategCli, CLCO_DTO, CLPERTIVA, CLPERGAN, CLPAGEWEB, CLPERIBRU, Hijos, CLACUM, CLENTR, CLVCOD, CLPAIS, CLSIPRIB, CLMSN, CLTOPECCTE, CLTOPE, PorcenTC, AplicaTC, CLCONDPAG, CLEMAIL, RUT, PCUIT
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CD1 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLSER ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETIVAV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCalle ) + "'" + ',' + transform( &lcCursor..CLTPO ) + ',' + transform( &lcCursor..centid ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PRINOM ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..APELLIDO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..globalid ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPROV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPIN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CC051 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETGANV ) + "'" + ',' + transform( &lcCursor..CLNro ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'" + ',' + transform( &lcCursor..CLIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CC601 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vende ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANT ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'" + ',' + Transform( iif( &lcCursor..EXPERGAN, 1, 0 )) + ',' + Transform( iif( &lcCursor..EXPERIVA, 1, 0 )) + ',' + transform( &lcCursor..CLTIPCONV )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLT_DIR ) + "'" + ',' + transform( &lcCursor..CLCFI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETIBRV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClPiso ) + "'" + ',' + Transform( iif( &lcCursor..ClSujVinc, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTMovil ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'" + ',' + transform( &lcCursor..CLSITGAN ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCli ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLISTPRE ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..VHastaGan ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..VHastaIva ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLNROIIBB ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLT_CUIT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETSEGV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'" + ',' + transform( &lcCursor..CNX1 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Sexo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCategCli ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCO_DTO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPERTIVA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPERGAN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPERIBRU ) + "'" + ',' + transform( &lcCursor..Hijos ) + ',' + transform( &lcCursor..CLACUM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLENTR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLVCOD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAIS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLSIPRIB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLMSN ) + "'" + ',' + transform( &lcCursor..CLTOPECCTE ) + ',' + transform( &lcCursor..CLTOPE ) + ',' + transform( &lcCursor..PorcenTC ) + ',' + Transform( iif( &lcCursor..AplicaTC, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUIT ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CLI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CliOtrasDir Where ODCOD] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PerExcluido Where Cod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PerCliDet Where Cod] + lcIn  )
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
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CLCOD C (5) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'ITEMCONTACTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMOTRASDIRECCIONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMEXCLUIDOOTRAPERCEP'
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
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  CD1       
		* Validar ANTERIORES A 1/1/1753  CLFING    
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  CLFECHA   
		* Validar ANTERIORES A 1/1/1753  VHastaGan 
		* Validar ANTERIORES A 1/1/1753  VHastaIva 
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CLI
Create Table ZooLogic.TablaTrabajo_CLI ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"cd1" datetime  null, 
"clfing" datetime  null, 
"fectrans" datetime  null, 
"clser" numeric( 1, 0 )  null, 
"clretivav" char( 1 )  null, 
"clcalle" char( 250 )  null, 
"cltpo" numeric( 1, 0 )  null, 
"centid" numeric( 10, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"prinom" char( 60 )  null, 
"smodifw" char( 7 )  null, 
"apellido" char( 60 )  null, 
"globalid" char( 38 )  null, 
"clprov" char( 2 )  null, 
"vmodifw" char( 13 )  null, 
"clpin" char( 60 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"cimagen" char( 180 )  null, 
"cc051" char( 5 )  null, 
"clcod" char( 5 )  null, 
"cltrans" char( 6 )  null, 
"clobs" varchar(max)  null, 
"clretganv" char( 1 )  null, 
"clnro" numeric( 5, 0 )  null, 
"clloc" char( 70 )  null, 
"cliva" numeric( 2, 0 )  null, 
"cc601" char( 51 )  null, 
"climpd" char( 8 )  null, 
"cltlf" char( 30 )  null, 
"clclas" char( 10 )  null, 
"vende" char( 5 )  null, 
"clcodfant" char( 10 )  null, 
"clfecha" datetime  null, 
"expergan" bit  null, 
"experiva" bit  null, 
"cltipconv" numeric( 1, 0 )  null, 
"clcuit" char( 15 )  null, 
"cltipodoc" char( 2 )  null, 
"clt_dir" char( 70 )  null, 
"clcfi" numeric( 1, 0 )  null, 
"clretibrv" char( 1 )  null, 
"clpiso" char( 3 )  null, 
"clsujvinc" bit  null, 
"cltmovil" char( 30 )  null, 
"clcp" char( 8 )  null, 
"clsitgan" numeric( 1, 0 )  null, 
"cltipocli" char( 10 )  null, 
"cllistpre" char( 6 )  null, 
"vhastagan" datetime  null, 
"vhastaiva" datetime  null, 
"clnroiibb" numeric( 10, 0 )  null, 
"clnom" char( 30 )  null, 
"clnrodoc" char( 10 )  null, 
"clt_cuit" char( 15 )  null, 
"clretsegv" char( 1 )  null, 
"cldepto" char( 3 )  null, 
"cnx1" numeric( 12, 2 )  null, 
"clfax" char( 20 )  null, 
"sexo" char( 10 )  null, 
"estado" char( 13 )  null, 
"clprv" char( 2 )  null, 
"clcategcli" char( 10 )  null, 
"clco_dto" char( 10 )  null, 
"clpertiva" char( 10 )  null, 
"clpergan" char( 10 )  null, 
"clpageweb" char( 20 )  null, 
"clperibru" char( 1 )  null, 
"hijos" numeric( 2, 0 )  null, 
"clacum" numeric( 10, 2 )  null, 
"clentr" char( 32 )  null, 
"clvcod" char( 5 )  null, 
"clpais" char( 3 )  null, 
"clsiprib" char( 20 )  null, 
"clmsn" char( 32 )  null, 
"cltopeccte" numeric( 15, 2 )  null, 
"cltope" numeric( 10, 2 )  null, 
"porcentc" numeric( 6, 2 )  null, 
"aplicatc" bit  null, 
"clcondpag" char( 5 )  null, 
"clemail" char( 32 )  null, 
"rut" char( 12 )  null, 
"pcuit" char( 20 )  null )
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('cd1','cd1')
			.AgregarMapeo('clfing','clfing')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('clser','clser')
			.AgregarMapeo('clretivav','clretivav')
			.AgregarMapeo('clcalle','clcalle')
			.AgregarMapeo('cltpo','cltpo')
			.AgregarMapeo('centid','centid')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('prinom','prinom')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('apellido','apellido')
			.AgregarMapeo('globalid','globalid')
			.AgregarMapeo('clprov','clprov')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('clpin','clpin')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('cimagen','cimagen')
			.AgregarMapeo('cc051','cc051')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('cltrans','cltrans')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('clretganv','clretganv')
			.AgregarMapeo('clnro','clnro')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('cliva','cliva')
			.AgregarMapeo('cc601','cc601')
			.AgregarMapeo('climpd','climpd')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('clclas','clclas')
			.AgregarMapeo('vende','vende')
			.AgregarMapeo('clcodfant','clcodfant')
			.AgregarMapeo('clfecha','clfecha')
			.AgregarMapeo('expergan','expergan')
			.AgregarMapeo('experiva','experiva')
			.AgregarMapeo('cltipconv','cltipconv')
			.AgregarMapeo('clcuit','clcuit')
			.AgregarMapeo('cltipodoc','cltipodoc')
			.AgregarMapeo('clt_dir','clt_dir')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('clretibrv','clretibrv')
			.AgregarMapeo('clpiso','clpiso')
			.AgregarMapeo('clsujvinc','clsujvinc')
			.AgregarMapeo('cltmovil','cltmovil')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('clsitgan','clsitgan')
			.AgregarMapeo('cltipocli','cltipocli')
			.AgregarMapeo('cllistpre','cllistpre')
			.AgregarMapeo('vhastagan','vhastagan')
			.AgregarMapeo('vhastaiva','vhastaiva')
			.AgregarMapeo('clnroiibb','clnroiibb')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('clnrodoc','clnrodoc')
			.AgregarMapeo('clt_cuit','clt_cuit')
			.AgregarMapeo('clretsegv','clretsegv')
			.AgregarMapeo('cldepto','cldepto')
			.AgregarMapeo('cnx1','cnx1')
			.AgregarMapeo('clfax','clfax')
			.AgregarMapeo('sexo','sexo')
			.AgregarMapeo('estado','estado')
			.AgregarMapeo('clprv','clprv')
			.AgregarMapeo('clcategcli','clcategcli')
			.AgregarMapeo('clco_dto','clco_dto')
			.AgregarMapeo('clpertiva','clpertiva')
			.AgregarMapeo('clpergan','clpergan')
			.AgregarMapeo('clpageweb','clpageweb')
			.AgregarMapeo('clperibru','clperibru')
			.AgregarMapeo('hijos','hijos')
			.AgregarMapeo('clacum','clacum')
			.AgregarMapeo('clentr','clentr')
			.AgregarMapeo('clvcod','clvcod')
			.AgregarMapeo('clpais','clpais')
			.AgregarMapeo('clsiprib','clsiprib')
			.AgregarMapeo('clmsn','clmsn')
			.AgregarMapeo('cltopeccte','cltopeccte')
			.AgregarMapeo('cltope','cltope')
			.AgregarMapeo('porcentc','porcentc')
			.AgregarMapeo('aplicatc','aplicatc')
			.AgregarMapeo('clcondpag','clcondpag')
			.AgregarMapeo('clemail','clemail')
			.AgregarMapeo('rut','rut')
			.AgregarMapeo('pcuit','pcuit')
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.CD1 = isnull( d.CD1, t.CD1 ),t.CLFING = isnull( d.CLFING, t.CLFING ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.CLSER = isnull( d.CLSER, t.CLSER ),t.CLRETIVAV = isnull( d.CLRETIVAV, t.CLRETIVAV ),t.CLCALLE = isnull( d.CLCALLE, t.CLCALLE ),t.CLTPO = isnull( d.CLTPO, t.CLTPO ),t.CENTID = isnull( d.CENTID, t.CENTID ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.PRINOM = isnull( d.PRINOM, t.PRINOM ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.APELLIDO = isnull( d.APELLIDO, t.APELLIDO ),t.GLOBALID = isnull( d.GLOBALID, t.GLOBALID ),t.CLPROV = isnull( d.CLPROV, t.CLPROV ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.CLPIN = isnull( d.CLPIN, t.CLPIN ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.CIMAGEN = isnull( d.CIMAGEN, t.CIMAGEN ),t.CC051 = isnull( d.CC051, t.CC051 ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLTRANS = isnull( d.CLTRANS, t.CLTRANS ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CLRETGANV = isnull( d.CLRETGANV, t.CLRETGANV ),t.CLNRO = isnull( d.CLNRO, t.CLNRO ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLIVA = isnull( d.CLIVA, t.CLIVA ),t.CC601 = isnull( d.CC601, t.CC601 ),t.CLIMPD = isnull( d.CLIMPD, t.CLIMPD ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.CLCLAS = isnull( d.CLCLAS, t.CLCLAS ),t.VENDE = isnull( d.VENDE, t.VENDE ),t.CLCODFANT = isnull( d.CLCODFANT, t.CLCODFANT ),t.CLFECHA = isnull( d.CLFECHA, t.CLFECHA ),t.EXPERGAN = isnull( d.EXPERGAN, t.EXPERGAN ),t.EXPERIVA = isnull( d.EXPERIVA, t.EXPERIVA ),t.CLTIPCONV = isnull( d.CLTIPCONV, t.CLTIPCONV ),t.CLCUIT = isnull( d.CLCUIT, t.CLCUIT ),t.CLTIPODOC = isnull( d.CLTIPODOC, t.CLTIPODOC ),t.CLT_DIR = isnull( d.CLT_DIR, t.CLT_DIR ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.CLRETIBRV = isnull( d.CLRETIBRV, t.CLRETIBRV ),t.CLPISO = isnull( d.CLPISO, t.CLPISO ),t.CLSUJVINC = isnull( d.CLSUJVINC, t.CLSUJVINC ),t.CLTMOVIL = isnull( d.CLTMOVIL, t.CLTMOVIL ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.CLSITGAN = isnull( d.CLSITGAN, t.CLSITGAN ),t.CLTIPOCLI = isnull( d.CLTIPOCLI, t.CLTIPOCLI ),t.CLLISTPRE = isnull( d.CLLISTPRE, t.CLLISTPRE ),t.VHASTAGAN = isnull( d.VHASTAGAN, t.VHASTAGAN ),t.VHASTAIVA = isnull( d.VHASTAIVA, t.VHASTAIVA ),t.CLNROIIBB = isnull( d.CLNROIIBB, t.CLNROIIBB ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.CLNRODOC = isnull( d.CLNRODOC, t.CLNRODOC ),t.CLT_CUIT = isnull( d.CLT_CUIT, t.CLT_CUIT ),t.CLRETSEGV = isnull( d.CLRETSEGV, t.CLRETSEGV ),t.CLDEPTO = isnull( d.CLDEPTO, t.CLDEPTO ),t.CNX1 = isnull( d.CNX1, t.CNX1 ),t.CLFAX = isnull( d.CLFAX, t.CLFAX ),t.SEXO = isnull( d.SEXO, t.SEXO ),t.ESTADO = isnull( d.ESTADO, t.ESTADO ),t.CLPRV = isnull( d.CLPRV, t.CLPRV ),t.CLCATEGCLI = isnull( d.CLCATEGCLI, t.CLCATEGCLI ),t.CLCO_DTO = isnull( d.CLCO_DTO, t.CLCO_DTO ),t.CLPERTIVA = isnull( d.CLPERTIVA, t.CLPERTIVA ),t.CLPERGAN = isnull( d.CLPERGAN, t.CLPERGAN ),t.CLPAGEWEB = isnull( d.CLPAGEWEB, t.CLPAGEWEB ),t.CLPERIBRU = isnull( d.CLPERIBRU, t.CLPERIBRU ),t.HIJOS = isnull( d.HIJOS, t.HIJOS ),t.CLACUM = isnull( d.CLACUM, t.CLACUM ),t.CLENTR = isnull( d.CLENTR, t.CLENTR ),t.CLVCOD = isnull( d.CLVCOD, t.CLVCOD ),t.CLPAIS = isnull( d.CLPAIS, t.CLPAIS ),t.CLSIPRIB = isnull( d.CLSIPRIB, t.CLSIPRIB ),t.CLMSN = isnull( d.CLMSN, t.CLMSN ),t.CLTOPECCTE = isnull( d.CLTOPECCTE, t.CLTOPECCTE ),t.CLTOPE = isnull( d.CLTOPE, t.CLTOPE ),t.PORCENTC = isnull( d.PORCENTC, t.PORCENTC ),t.APLICATC = isnull( d.APLICATC, t.APLICATC ),t.CLCONDPAG = isnull( d.CLCONDPAG, t.CLCONDPAG ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL ),t.RUT = isnull( d.RUT, t.RUT ),t.PCUIT = isnull( d.PCUIT, t.PCUIT )
					from ZooLogic.CLI t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.CLI(Fecexpo,Fecimpo,Faltafw,Fmodifw,Cd1,Clfing,Fectrans,Clser,Clretivav,Clcalle,Cltpo,Centid,Timestamp,Ualtafw,Saltafw,Esttrans,Horaexpo,Haltafw,Bdmodifw,Hmodifw,Bdaltafw,Prinom,Smodifw,Apellido,Globalid,Clprov,Vmodifw,Clpin,Valtafw,Zadsfw,Umodifw,Horaimpo,Cimagen,Cc051,Clcod,Cltrans,Clobs,Clretganv,Clnro,Clloc,Cliva,Cc601,Climpd,Cltlf,Clclas,Vende,Clcodfant,Clfecha,Expergan,Experiva,Cltipconv,Clcuit,Cltipodoc,Clt_dir,Clcfi,Clretibrv,Clpiso,Clsujvinc,Cltmovil,Clcp,Clsitgan,Cltipocli,Cllistpre,Vhastagan,Vhastaiva,Clnroiibb,Clnom,Clnrodoc,Clt_cuit,Clretsegv,Cldepto,Cnx1,Clfax,Sexo,Estado,Clprv,Clcategcli,Clco_dto,Clpertiva,Clpergan,Clpageweb,Clperibru,Hijos,Clacum,Clentr,Clvcod,Clpais,Clsiprib,Clmsn,Cltopeccte,Cltope,Porcentc,Aplicatc,Clcondpag,Clemail,Rut,Pcuit)
					Select isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.CD1,''),isnull( d.CLFING,''),isnull( d.FECTRANS,''),isnull( d.CLSER,0),isnull( d.CLRETIVAV,''),isnull( d.CLCALLE,''),isnull( d.CLTPO,0),isnull( d.CENTID,0),isnull( d.TIMESTAMP,0),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.PRINOM,''),isnull( d.SMODIFW,''),isnull( d.APELLIDO,''),isnull( d.GLOBALID,''),isnull( d.CLPROV,''),isnull( d.VMODIFW,''),isnull( d.CLPIN,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.CIMAGEN,''),isnull( d.CC051,''),isnull( d.CLCOD,''),isnull( d.CLTRANS,''),isnull( d.CLOBS,''),isnull( d.CLRETGANV,''),isnull( d.CLNRO,0),isnull( d.CLLOC,''),isnull( d.CLIVA,0),isnull( d.CC601,''),isnull( d.CLIMPD,''),isnull( d.CLTLF,''),isnull( d.CLCLAS,''),isnull( d.VENDE,''),isnull( d.CLCODFANT,''),isnull( d.CLFECHA,''),isnull( d.EXPERGAN,0),isnull( d.EXPERIVA,0),isnull( d.CLTIPCONV,0),isnull( d.CLCUIT,''),isnull( d.CLTIPODOC,''),isnull( d.CLT_DIR,''),isnull( d.CLCFI,0),isnull( d.CLRETIBRV,''),isnull( d.CLPISO,''),isnull( d.CLSUJVINC,0),isnull( d.CLTMOVIL,''),isnull( d.CLCP,''),isnull( d.CLSITGAN,0),isnull( d.CLTIPOCLI,''),isnull( d.CLLISTPRE,''),isnull( d.VHASTAGAN,''),isnull( d.VHASTAIVA,''),isnull( d.CLNROIIBB,0),isnull( d.CLNOM,''),isnull( d.CLNRODOC,''),isnull( d.CLT_CUIT,''),isnull( d.CLRETSEGV,''),isnull( d.CLDEPTO,''),isnull( d.CNX1,0),isnull( d.CLFAX,''),isnull( d.SEXO,''),isnull( d.ESTADO,''),isnull( d.CLPRV,''),isnull( d.CLCATEGCLI,''),isnull( d.CLCO_DTO,''),isnull( d.CLPERTIVA,''),isnull( d.CLPERGAN,''),isnull( d.CLPAGEWEB,''),isnull( d.CLPERIBRU,''),isnull( d.HIJOS,0),isnull( d.CLACUM,0),isnull( d.CLENTR,''),isnull( d.CLVCOD,''),isnull( d.CLPAIS,''),isnull( d.CLSIPRIB,''),isnull( d.CLMSN,''),isnull( d.CLTOPECCTE,0),isnull( d.CLTOPE,0),isnull( d.PORCENTC,0),isnull( d.APLICATC,0),isnull( d.CLCONDPAG,''),isnull( d.CLEMAIL,''),isnull( d.RUT,''),isnull( d.PCUIT,'')
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
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaultimamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechaultimamodificacion, ctod( '  /  /    ' ) ) )
					.Fechadealta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechadealta, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Clasificacion2 = nvl( c_CLIENTE.Clasificacion2, 0 )
					.Retencioniva = nvl( c_CLIENTE.Retencioniva, [] )
					.Calle = nvl( c_CLIENTE.Calle, [] )
					.Tipointerno = nvl( c_CLIENTE.Tipointerno, 0 )
					.Idcentralizador = nvl( c_CLIENTE.Idcentralizador, 0 )
					.Timestamp = nvl( c_CLIENTE.Timestamp, 0 )
					.Usuarioaltafw = nvl( c_CLIENTE.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_CLIENTE.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_CLIENTE.Estadotransferencia, [] )
					.Horaexpo = nvl( c_CLIENTE.Horaexpo, [] )
					.Horaaltafw = nvl( c_CLIENTE.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CLIENTE.Basededatosmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_CLIENTE.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CLIENTE.Basededatosaltafw, [] )
					.Primernombre = nvl( c_CLIENTE.Primernombre, [] )
					.Seriemodificacionfw = nvl( c_CLIENTE.Seriemodificacionfw, [] )
					.Apellido = nvl( c_CLIENTE.Apellido, [] )
					.Idglobal = nvl( c_CLIENTE.Idglobal, [] )
					.Jurisdiccion = nvl( c_CLIENTE.Jurisdiccion, [] )
					.Versionmodificacionfw = nvl( c_CLIENTE.Versionmodificacionfw, [] )
					.Pin = nvl( c_CLIENTE.Pin, [] )
					.Versionaltafw = nvl( c_CLIENTE.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_CLIENTE.Usuariomodificacionfw, [] )
					.Horaimpo = nvl( c_CLIENTE.Horaimpo, [] )
					.Imagen = nvl( c_CLIENTE.Imagen, [] )
					.Corredor_PK =  nvl( c_CLIENTE.Corredor, [] )
					.Codigo = nvl( c_CLIENTE.Codigo, [] )
					.Transportista_PK =  nvl( c_CLIENTE.Transportista, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Retencionganancias = nvl( c_CLIENTE.Retencionganancias, [] )
					.Numero = nvl( c_CLIENTE.Numero, 0 )
					.Localidad = nvl( c_CLIENTE.Localidad, [] )
					.Situacionfiscal_PK =  nvl( c_CLIENTE.Situacionfiscal, 0 )
					.Transporte = nvl( c_CLIENTE.Transporte, [] )
					.Clasificacionsecundaria = nvl( c_CLIENTE.Clasificacionsecundaria, [] )
					.Telefono = nvl( c_CLIENTE.Telefono, [] )
					.Clasificacion_PK =  nvl( c_CLIENTE.Clasificacion, [] )
					.Vendedor_PK =  nvl( c_CLIENTE.Vendedor, [] )
					.Codnombrefantasia_PK =  nvl( c_CLIENTE.Codnombrefantasia, [] )
					.Contactodet.Limpiar()
					.Contactodet.SetearEsNavegacion( .lProcesando )
					.Contactodet.Cargar()
					.Otrasdirecciones.Limpiar()
					.Otrasdirecciones.SetearEsNavegacion( .lProcesando )
					.Otrasdirecciones.Cargar()
					.Fechanacimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Fechanacimiento, ctod( '  /  /    ' ) ) )
					.Excluidopercepcionganancias = nvl( c_CLIENTE.Excluidopercepcionganancias, .F. )
					.Excluidopercepcioniva = nvl( c_CLIENTE.Excluidopercepcioniva, .F. )
					.Tipoconvenio = nvl( c_CLIENTE.Tipoconvenio, 0 )
					.Cuit = nvl( c_CLIENTE.Cuit, [] )
					.Tipodocumento = nvl( c_CLIENTE.Tipodocumento, [] )
					.Excluidootrapercep.Limpiar()
					.Excluidootrapercep.SetearEsNavegacion( .lProcesando )
					.Excluidootrapercep.Cargar()
					.Direcciontransporte = nvl( c_CLIENTE.Direcciontransporte, [] )
					.Cfi = nvl( c_CLIENTE.Cfi, 0 )
					.Retencioningresosbrutos = nvl( c_CLIENTE.Retencioningresosbrutos, [] )
					.Piso = nvl( c_CLIENTE.Piso, [] )
					.Sujetovinculado = nvl( c_CLIENTE.Sujetovinculado, .F. )
					.Movil = nvl( c_CLIENTE.Movil, [] )
					.Codigopostal = nvl( c_CLIENTE.Codigopostal, [] )
					.Situacionganancias = nvl( c_CLIENTE.Situacionganancias, 0 )
					.Tipocli_PK =  nvl( c_CLIENTE.Tipocli, [] )
					.Listadeprecio_PK =  nvl( c_CLIENTE.Listadeprecio, [] )
					.Vigenciahastagan = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Vigenciahastagan, ctod( '  /  /    ' ) ) )
					.Vigenciahastaiva = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTE.Vigenciahastaiva, ctod( '  /  /    ' ) ) )
					.Nroiibb = nvl( c_CLIENTE.Nroiibb, 0 )
					.Nombre = nvl( c_CLIENTE.Nombre, [] )
					.Nrodocumento = nvl( c_CLIENTE.Nrodocumento, [] )
					.Cuittransporte = nvl( c_CLIENTE.Cuittransporte, [] )
					.Retencionseguridadsocial = nvl( c_CLIENTE.Retencionseguridadsocial, [] )
					.Departamento = nvl( c_CLIENTE.Departamento, [] )
					.Credito = nvl( c_CLIENTE.Credito, 0 )
					.Fax = nvl( c_CLIENTE.Fax, [] )
					.Percepciones.Limpiar()
					.Percepciones.SetearEsNavegacion( .lProcesando )
					.Percepciones.Cargar()
					.Sexo = nvl( c_CLIENTE.Sexo, [] )
					.Estadocivil = nvl( c_CLIENTE.Estadocivil, [] )
					.Provincia_PK =  nvl( c_CLIENTE.Provincia, [] )
					.Categcli_PK =  nvl( c_CLIENTE.Categcli, [] )
					.Descuentopreferente_PK =  nvl( c_CLIENTE.Descuentopreferente, [] )
					.Percepcioniva_PK =  nvl( c_CLIENTE.Percepcioniva, [] )
					.Percepcionganancias_PK =  nvl( c_CLIENTE.Percepcionganancias, [] )
					.Paginaweb = nvl( c_CLIENTE.Paginaweb, [] )
					.Percepcioningresosbrutos = nvl( c_CLIENTE.Percepcioningresosbrutos, [] )
					.Hijos = nvl( c_CLIENTE.Hijos, 0 )
					.Dolaresacumulados = nvl( c_CLIENTE.Dolaresacumulados, 0 )
					.Lugardeentrega = nvl( c_CLIENTE.Lugardeentrega, [] )
					.Condicionpagopreferente_PK =  nvl( c_CLIENTE.Condicionpagopreferente, [] )
					.Pais_PK =  nvl( c_CLIENTE.Pais, [] )
					.Codigosiprib_PK =  nvl( c_CLIENTE.Codigosiprib, [] )
					.Messenger = nvl( c_CLIENTE.Messenger, [] )
					.Topectacte = nvl( c_CLIENTE.Topectacte, 0 )
					.Topefacturacion = nvl( c_CLIENTE.Topefacturacion, 0 )
					.Tasaceroporcen = nvl( c_CLIENTE.Tasaceroporcen, 0 )
					.Tasaceroaplica = nvl( c_CLIENTE.Tasaceroaplica, .F. )
					.Condiciondepago_PK =  nvl( c_CLIENTE.Condiciondepago, [] )
					.Email = nvl( c_CLIENTE.Email, [] )
					.Rut = nvl( c_CLIENTE.Rut, [] )
					.Cuitpais = nvl( c_CLIENTE.Cuitpais, [] )
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
		
		loDetalle = this.oEntidad.ContactoDet
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
			"Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Cd1" as "Fechaultimamodificacion", "Clfing" as "Fechadealta", "Fectrans" as "Fechatransferencia", "Clser" as "Clasificacion2", "Clretivav" as "Retencioniva", "Clcalle" as "Calle", "Cltpo" as "Tipointerno", "Centid" as "Idcentralizador", "Timestamp" as "Timestamp", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Prinom" as "Primernombre", "Smodifw" as "Seriemodificacionfw", "Apellido" as "Apellido", "Globalid" as "Idglobal", "Clprov" as "Jurisdiccion", "Vmodifw" as "Versionmodificacionfw", "Clpin" as "Pin", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Cimagen" as "Imagen", "Cc051" as "Corredor", "Clcod" as "Codigo", "Cltrans" as "Transportista", "Clobs" as "Observacion", "Clretganv" as "Retencionganancias", "Clnro" as "Numero", "Clloc" as "Localidad", "Cliva" as "Situacionfiscal", "Cc601" as "Transporte", "Climpd" as "Clasificacionsecundaria", "Cltlf" as "Telefono", "Clclas" as "Clasificacion", "Vende" as "Vendedor", "Clcodfant" as "Codnombrefantasia", "Clfecha" as "Fechanacimiento", "Expergan" as "Excluidopercepcionganancias", "Experiva" as "Excluidopercepcioniva", "Cltipconv" as "Tipoconvenio", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clt_dir" as "Direcciontransporte", "Clcfi" as "Cfi", "Clretibrv" as "Retencioningresosbrutos", "Clpiso" as "Piso", "Clsujvinc" as "Sujetovinculado", "Cltmovil" as "Movil", "Clcp" as "Codigopostal", "Clsitgan" as "Situacionganancias", "Cltipocli" as "Tipocli", "Cllistpre" as "Listadeprecio", "Vhastagan" as "Vigenciahastagan", "Vhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clnrodoc" as "Nrodocumento", "Clt_cuit" as "Cuittransporte", "Clretsegv" as "Retencionseguridadsocial", "Cldepto" as "Departamento", "Cnx1" as "Credito", "Clfax" as "Fax", "Sexo" as "Sexo", "Estado" as "Estadocivil", "Clprv" as "Provincia", "Clcategcli" as "Categcli", "Clco_dto" as "Descuentopreferente", "Clpertiva" as "Percepcioniva", "Clpergan" as "Percepcionganancias", "Clpageweb" as "Paginaweb", "Clperibru" as "Percepcioningresosbrutos", "Hijos" as "Hijos", "Clacum" as "Dolaresacumulados", "Clentr" as "Lugardeentrega", "Clvcod" as "Condicionpagopreferente", "Clpais" as "Pais", "Clsiprib" as "Codigosiprib", "Clmsn" as "Messenger", "Cltopeccte" as "Topectacte", "Cltope" as "Topefacturacion", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica", "Clcondpag" as "Condiciondepago", "Clemail" as "Email", "Rut" as "Rut", "Pcuit" as "Cuitpais"
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
	<row entidad="CLIENTE                                 " atributo="FECHAEXPO                               " tabla="CLI            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHAIMPO                               " tabla="CLI            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHAALTAFW                             " tabla="CLI            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHAMODIFICACIONFW                     " tabla="CLI            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHAULTIMAMODIFICACION                 " tabla="CLI            " campo="CD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima Modificación                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHADEALTA                             " tabla="CLI            " campo="CLFING    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha Alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHATRANSFERENCIA                      " tabla="CLI            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CLASIFICACION2                          " tabla="CLI            " campo="CLSER     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Clasificación                                                                                                                                                   " dominio="CLASIFICACION                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="RETENCIONIVA                            " tabla="CLI            " campo="CLRETIVAV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Retención de Iva                                                                                                                                                " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CALLE                                   " tabla="CLI            " campo="CLCALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIPOINTERNO                             " tabla="CLI            " campo="CLTPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="IDCENTRALIZADOR                         " tabla="CLI            " campo="CENTID    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id de centralización                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIMESTAMP                               " tabla="CLI            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="USUARIOALTAFW                           " tabla="CLI            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SERIEALTAFW                             " tabla="CLI            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="ESTADOTRANSFERENCIA                     " tabla="CLI            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HORAEXPO                                " tabla="CLI            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HORAALTAFW                              " tabla="CLI            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CLI            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HORAMODIFICACIONFW                      " tabla="CLI            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="BASEDEDATOSALTAFW                       " tabla="CLI            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PRIMERNOMBRE                            " tabla="CLI            " campo="PRINOM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SERIEMODIFICACIONFW                     " tabla="CLI            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="APELLIDO                                " tabla="CLI            " campo="APELLIDO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="IDGLOBAL                                " tabla="CLI            " campo="GLOBALID  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id de centralización en zNube                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="JURISDICCION                            " tabla="CLI            " campo="CLPROV    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Jurisdicción                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VERSIONMODIFICACIONFW                   " tabla="CLI            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PIN                                     " tabla="CLI            " campo="CLPIN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VERSIONALTAFW                           " tabla="CLI            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="ZADSFW                                  " tabla="CLI            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="USUARIOMODIFICACIONFW                   " tabla="CLI            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HORAIMPO                                " tabla="CLI            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="IMAGEN                                  " tabla="CLI            " campo="CIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Imagen                                                                                                                                                          " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CORREDOR                                " tabla="CLI            " campo="CC051     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CORREDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Corredor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODIGO                                  " tabla="CLI            " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TRANSPORTISTA                           " tabla="CLI            " campo="CLTRANS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Transportista                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="OBSERVACION                             " tabla="CLI            " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="RETENCIONGANANCIAS                      " tabla="CLI            " campo="CLRETGANV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Retención de Ganancias                                                                                                                                          " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NUMERO                                  " tabla="CLI            " campo="CLNRO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Nro                                                                                                                                                             " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="LOCALIDAD                               " tabla="CLI            " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Localidad                                                                                                                                                       " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SITUACIONFISCAL                         " tabla="CLI            " campo="CLIVA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="404" etiqueta="Situación Fiscal                                                                                                                                                " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TRANSPORTE                              " tabla="CLI            " campo="CC601     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="51" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Transporte                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CLASIFICACIONSECUNDARIA                 " tabla="CLI            " campo="CLIMPD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Clasificación Secundaria                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TELEFONO                                " tabla="CLI            " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SITFISCALURUGUAY                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="2                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="408" etiqueta="Situación del cliente                                                                                                                                           " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CLASIFICACION                           " tabla="CLI            " campo="CLCLAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VENDEDOR                                " tabla="CLI            " campo="VENDE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODNOMBREFANTASIA                       " tabla="CLI            " campo="CLCODFANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMBREDEFANTASIA                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="54" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CONTACTODET                             " tabla="CONTACTODET    " campo="CONCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Contactos                                                                                                                                                       " dominio="DETALLEITEMCONTACTO           " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="OTRASDIRECCIONES                        " tabla="CLIOTRASDIR    " campo="ODCOD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Otras direcciones                                                                                                                                               " dominio="DETALLEITEMOTRASDIRECCIONES   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FECHANACIMIENTO                         " tabla="CLI            " campo="CLFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Fecha de nacimiento                                                                                                                                             " dominio="FECHALARGACALENDARIO          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="EXCLUIDOPERCEPCIONGANANCIAS             " tabla="CLI            " campo="EXPERGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Excluido                                                                                                                                                        " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="EXCLUIDOPERCEPCIONIVA                   " tabla="CLI            " campo="EXPERIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Excluido                                                                                                                                                        " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIPOCONVENIO                            " tabla="CLI            " campo="CLTIPCONV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Tipo de Convenio                                                                                                                                                " dominio="CONVENIOCONNUMERO             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CUIT                                    " tabla="CLI            " campo="CLCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="CUIT                                                                                                                                                            " dominio="CUITBUSQUEDA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIPODOCUMENTO                           " tabla="CLI            " campo="CLTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="T./Nro.Doc                                                                                                                                                      " dominio="DOCUMENTOCLIENTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="EXCLUIDOOTRAPERCEP                      " tabla="PEREXCLUIDO    " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Impuestos excluidos                                                                                                                                             " dominio="DETALLEITEMEXCLUIDOOTRAPERCEP " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="9" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="DIRECCIONTRANSPORTE                     " tabla="CLI            " campo="CLT_DIR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Dirección                                                                                                                                                       " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CFI                                     " tabla="CLI            " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente Frecuente Importante                                                                                                                                    " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="RETENCIONINGRESOSBRUTOS                 " tabla="CLI            " campo="CLRETIBRV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Retención de Ingresos Brutos                                                                                                                                    " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PISO                                    " tabla="CLI            " campo="CLPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SUJETOVINCULADO                         " tabla="CLI            " campo="CLSUJVINC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sujeto vinculado                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="MOVIL                                   " tabla="CLI            " campo="CLTMOVIL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Teléfono móvil                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODIGOPOSTAL                            " tabla="CLI            " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Código Postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SITUACIONGANANCIAS                      " tabla="CLI            " campo="CLSITGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Situación                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TIPOCLI                                 " tabla="CLI            " campo="CLTIPOCLI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOCLIENTE                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="56" etiqueta="Tipo                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="LISTADEPRECIO                           " tabla="CLI            " campo="CLLISTPRE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="Listadeprecios                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Lista de precios                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VIGENCIAHASTAGAN                        " tabla="CLI            " campo="VHASTAGAN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia Fecha de Ganancia                                                                                                                                      " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="VIGENCIAHASTAIVA                        " tabla="CLI            " campo="VHASTAIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia Fecha de Iva                                                                                                                                           " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NROIIBB                                 " tabla="CLI            " campo="CLNROIIBB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Nro. de IIBB                                                                                                                                                    " dominio="CONVENIOCONNUMERO             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NRODOCUMENTO                            " tabla="CLI            " campo="CLNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="T./Nro.Doc                                                                                                                                                      " dominio="DOCUMENTOCLIENTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CUITTRANSPORTE                          " tabla="CLI            " campo="CLT_CUIT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="CUIT                                                                                                                                                            " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="RETENCIONSEGURIDADSOCIAL                " tabla="CLI            " campo="CLRETSEGV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Retención de Seguridad Social                                                                                                                                   " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="DEPARTAMENTO                            " tabla="CLI            " campo="CLDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CREDITO                                 " tabla="CLI            " campo="CNX1      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Crédito                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="FAX                                     " tabla="CLI            " campo="CLFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PERCEPCIONES                            " tabla="PERCLIDET      " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Percepciones                                                                                                                                                    " dominio="DETALLEITEMPERCEPCIONES       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="SEXO                                    " tabla="CLI            " campo="SEXO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Sexo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="ESTADOCIVIL                             " tabla="CLI            " campo="ESTADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Estado civil                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PROVINCIA                               " tabla="CLI            " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CATEGCLI                                " tabla="CLI            " campo="CLCATEGCLI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIACLIENTE                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="58" etiqueta="Categoría                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="DESCUENTOPREFERENTE                     " tabla="CLI            " campo="CLCO_DTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESCUENTO                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Descuento                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PERCEPCIONIVA                           " tabla="CLI            " campo="CLPERTIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PERCEPCIONGANANCIAS                     " tabla="CLI            " campo="CLPERGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PAGINAWEB                               " tabla="CLI            " campo="CLPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Página Web                                                                                                                                                      " dominio="WEB                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PERCEPCIONINGRESOSBRUTOS                " tabla="CLI            " campo="CLPERIBRU " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Percepción de Ingresos Brutos                                                                                                                                   " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="HIJOS                                   " tabla="CLI            " campo="HIJOS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Cantidad de hijos                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="DOLARESACUMULADOS                       " tabla="CLI            " campo="CLACUM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="U$S Acumulados                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="LUGARDEENTREGA                          " tabla="CLI            " campo="CLENTR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="32" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="466" etiqueta="Entregar en                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CONDICIONPAGOPREFERENTE                 " tabla="CLI            " campo="CLVCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="PAIS                                    " tabla="CLI            " campo="CLPAIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="468" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CODIGOSIPRIB                            " tabla="CLI            " campo="CLSIPRIB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DATOSADICIONALESSIPRIB                  " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="470" etiqueta="IIBB Santa Fe SIPRIB                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="MESSENGER                               " tabla="CLI            " campo="CLMSN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="32" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Messenger                                                                                                                                                       " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TOPECTACTE                              " tabla="CLI            " campo="CLTOPECCTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="472" etiqueta="Limite de Crédito                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TOPEFACTURACION                         " tabla="CLI            " campo="CLTOPE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tope facturación                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TASACEROPORCEN                          " tabla="CLI            " campo="PORCENTC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="474" etiqueta="IIBB Mendoza con certificado tasa cero                                                                                                                          " dominio="NUMERICOCHECK                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="TASACEROAPLICA                          " tabla="CLI            " campo="APLICATC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="476" etiqueta="Aplica                                                                                                                                                          " dominio="NUMERICOCHECK                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CONDICIONDEPAGO                         " tabla="CLI            " campo="CLCONDPAG " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="478" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="EMAIL                                   " tabla="CLI            " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="32" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="480" etiqueta="E-Mail                                                                                                                                                          " dominio="MAILCLIENTE                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="RUT                                     " tabla="CLI            " campo="RUT       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="R.U.T.                                                                                                                                                          " dominio="RUT                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999999-X              " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="CUITPAIS                                " tabla="CLI            " campo="PCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="482" etiqueta="CUIT Pais                                                                                                                                                       " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="401" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On CLI.CLTRANS = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SITUACIONFISCAL                         " atributo="DESCRIPCION                             " tabla="SITFISCAL      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Sit.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SITFISCAL On CLI.CLIVA = SITFISCAL.Codigo And  SITFISCAL.CODIGO != 0                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On CLI.CLCLAS = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On CLI.VENDE = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="NOMBREFANTASIA                          " tabla="NOMFANT        " campo="NFNOMF    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="55" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NOMFANT On CLI.CLCODFANT = NOMFANT.NFCOD And  NOMFANT.NFCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOCLIENTE                             " atributo="DESCRIPCION                             " tabla="TIPOCLI        " campo="TCDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="57" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOCLI On CLI.CLTIPOCLI = TIPOCLI.TCCOD And  TIPOCLI.TCCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="439" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On CLI.CLLISTPRE = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="455" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On CLI.CLPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIACLIENTE                        " atributo="DESCRIPCION                             " tabla="CATCLI         " campo="CGDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="59" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATCLI On CLI.CLCATEGCLI = CATCLI.CGCod And  CATCLI.CGCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCION                             " tabla="DESCUENTOS     " campo="DES       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="457" etiqueta="Detalle Des.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESCUENTOS On CLI.CLCO_DTO = DESCUENTOS.codigo And  DESCUENTOS.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="459" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On CLI.CLPERTIVA = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="461" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On CLI.CLPERGAN = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="469" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On CLI.CLPAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="DESCRIPCION                             " tabla="SIPRIBDATADIC  " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="Código SIPRIB                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="471" etiqueta="Detalle IIB.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SIPRIBDATADIC On CLI.CLSIPRIB = SIPRIBDATADIC.Codigo And  SIPRIBDATADIC.CODIGO != ''                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="479" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On CLI.CLCONDPAG = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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