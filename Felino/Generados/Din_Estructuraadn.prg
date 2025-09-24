
*------------------------------------------------------------------------------------
define class Din_EstructuraAdn as zoosession of zoosession.prg
	cXml = ''
	cXmlIndice = ''
	cXmlOperacionesMenu = ''
	cXmlOperacionesEntidades = ''
	cXmlEstructuraEntidadesMenuPrincipalItems = ''
	cProyecto = 'FELINO'
	cXmlRelacionEntreComprobantes = ''
	cCursorFuncionalidades = sys( 2015 )
	cPathBase = ''

	*------------------------------------------------------------------------------------------
	function Init() as Void
		DoDefault()
		this.cPathBase = left(this.classlibrary,rat('\',this.classlibrary))
	EndFunc

	*----------------------------------------------
	Function ObtenerNativa() as String
		Local lcXML as String

		lcXML = filetostr(this.cPathBase+'Din_ADNNativa.xml')
		return lcXml
	endfunc

	*----------------------------------------------
	Function ObtenerSQLServer() as String
		Local lcXML as String

		lcXML = filetostr(this.cPathBase+'Din_ADNSqlServer.xml')

		return lcXml
	endfunc

	*----------------------------------------------
	Function ObtenerCamposAuditoriaEntidad() as Void
		with this

			text to .cXml noshow
<?xml version = "1.0" encoding="Windows-1252" standalone="yes"?>
<VFPData xml:space="preserve">
	<xsd:schema id="VFPData" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
		<xsd:element name="VFPData" msdata:IsDataSet="true">
			<xsd:complexType>
				<xsd:choice maxOccurs="unbounded">
					<xsd:element name="row" minOccurs="0" maxOccurs="unbounded">
						<xsd:complexType>
							<xsd:attribute name="campo" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tipodato" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="dominio" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="20"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="longitud" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="decimales" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="espk" type="xsd:boolean" use="required"/>
							<xsd:attribute name="escc" type="xsd:boolean" use="required"/>
							<xsd:attribute name="valor" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="etiqueta" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="200"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="etiquetareporte" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="200"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="busquedaordenamiento" type="xsd:boolean" use="required"/>
							<xsd:attribute name="admitebusqueda" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="10"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="muestrarelacion" type="xsd:boolean" use="required"/>
						</xsd:complexType>
					</xsd:element>
				</xsd:choice>
				<xsd:anyAttribute namespace="http://www.w3.org/XML/1998/namespace" processContents="lax"/>
			</xsd:complexType>
		</xsd:element>
	</xsd:schema>
	<row campo="ADT_Cod   " tipodato="G         " dominio="CODIGO              " longitud="38" decimales="0" espk="true" escc="false" valor="goLibrerias.ObtenerGuidPk()                                                                                                                                                                                                                                   " etiqueta="C�digo                                                                                                                                                                                                  " etiquetareporte="C�digo                                                                                                                                                                                                  " busquedaordenamiento="true" admitebusqueda="1" muestrarelacion="false"/>
	<row campo="ADT_Fecha " tipodato="D         " dominio="FECHA               " longitud="8" decimales="0" espk="false" escc="false" valor="golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() )                                                                                                                                                                                              " etiqueta="Fecha                                                                                                                                                                                                   " etiquetareporte="Fecha                                                                                                                                                                                                   " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="false"/>
	<row campo="ADT_Hora  " tipodato="C         " dominio="CARACTER            " longitud="8" decimales="0" espk="false" escc="false" valor="golibrerias.obtenerhora()                                                                                                                                                                                                                                     " etiqueta="Hora                                                                                                                                                                                                    " etiquetareporte="Hora                                                                                                                                                                                                    " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="false"/>
	<row campo="ADT_Serie " tipodato="C         " dominio="CARACTER            " longitud="20" decimales="0" espk="false" escc="false" valor="alltrim( _screen.zoo.app.cSerie )                                                                                                                                                                                                                             " etiqueta="Serie                                                                                                                                                                                                   " etiquetareporte="Serie                                                                                                                                                                                                   " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="false"/>
	<row campo="ADT_Usr   " tipodato="C         " dominio="CARACTER            " longitud="100" decimales="0" espk="false" escc="false" valor="goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                        " etiqueta="Usuario                                                                                                                                                                                                 " etiquetareporte="Usuario                                                                                                                                                                                                 " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="false"/>
	<row campo="ADT_Ent   " tipodato="C         " dominio="CARACTER            " longitud="40" decimales="0" espk="false" escc="false" valor="this.oEntidad.ObtenerNombre()                                                                                                                                                                                                                                 " etiqueta="Entidad                                                                                                                                                                                                 " etiquetareporte="Entidad                                                                                                                                                                                                 " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="false"/>
	<row campo="ADT_Comp  " tipodato="C         " dominio="CARACTER            " longitud="254" decimales="0" espk="false" escc="false" valor="lcDescripcionFW                                                                                                                                                                                                                                               " etiqueta="Descripci�n                                                                                                                                                                                             " etiquetareporte="Descripci�n                                                                                                                                                                                             " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="true"/>
	<row campo="ADT_ADN   " tipodato="C         " dominio="CARACTER            " longitud="10" decimales="0" espk="false" escc="false" valor="alltrim('1.00')                                                                                                                                                                                                                                               " etiqueta="ADN                                                                                                                                                                                                     " etiquetareporte="ADN                                                                                                                                                                                                     " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="false"/>
	<row campo="ADT_Vers  " tipodato="C         " dominio="CARACTER            " longitud="13" decimales="0" espk="false" escc="false" valor="_Screen.zoo.app.obtenerversion()                                                                                                                                                                                                                              " etiqueta="Versi�n                                                                                                                                                                                                 " etiquetareporte="Versi�n                                                                                                                                                                                                 " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="false"/>
	<row campo="ADT_Ext   " tipodato="L         " dominio="SINOBOOL            " longitud="1" decimales="0" espk="false" escc="false" valor=".F.                                                                                                                                                                                                                                                           " etiqueta="Informaci�n remota                                                                                                                                                                                      " etiquetareporte="Informaci�n remota                                                                                                                                                                                      " busquedaordenamiento="false" admitebusqueda="0" muestrarelacion="false"/>
</VFPData>

			endtext

		endwith
		return this.cXml
	endfunc

	*----------------------------------------------
	Function ObtenerCamposAuditoriaDetalle() as Void
		with this

			text to .cXml noshow
<?xml version = "1.0" encoding="Windows-1252" standalone="yes"?>
<VFPData xml:space="preserve">
	<xsd:schema id="VFPData" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
		<xsd:element name="VFPData" msdata:IsDataSet="true">
			<xsd:complexType>
				<xsd:choice maxOccurs="unbounded">
					<xsd:element name="row" minOccurs="0" maxOccurs="unbounded">
						<xsd:complexType>
							<xsd:attribute name="campo" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tipodato" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="longitud" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="decimales" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="espk" type="xsd:boolean" use="required"/>
							<xsd:attribute name="escc" type="xsd:boolean" use="required"/>
							<xsd:attribute name="valor" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="etiqueta" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="200"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="etiquetareporte" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="200"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
						</xsd:complexType>
					</xsd:element>
				</xsd:choice>
				<xsd:anyAttribute namespace="http://www.w3.org/XML/1998/namespace" processContents="lax"/>
			</xsd:complexType>
		</xsd:element>
	</xsd:schema>
	<row campo="ADT_Cod   " tipodato="N         " longitud="9" decimales="0" espk="false" escc="false" valor="                                                                                                                                                                                                                                                              " etiqueta="Codigo                                                                                                                                                                                                  " etiquetareporte="Codigo                                                                                                                                                                                                  "/>
</VFPData>

			endtext

		endwith
		return this.cXml
	endfunc


	*----------------------------------------------
	Function EntidadRecibeModoInseguroCentral( tcEntidad as string ) as Boolean
		local llRetorno as boolean
		do case
			case upper( alltrim( tcEntidad ) ) = 'AJUSTEDESTOCK'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'RECIBO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'ORDENDEPAGO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'PAGO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTEDEESTADOS'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONES'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTECCCLIENTE'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTECCPROVEEDOR'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONESIVA'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONESGANANCIAS'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONESSUSS'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONRECIBIDO'
				llRetorno = .F.
		otherwise
			llRetorno = .T.
		endcase
		return llRetorno
	endfunc

	*----------------------------------------------
	Function EntidadRecibeModoInseguroDB( tcEntidad as string ) as Boolean
		local llRetorno as boolean
		do case
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDECAJA'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'MOVIMIENTODESTOCK'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTEDESTOCK'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'RECIBO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'PEDIDO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'ORDENDEPAGO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'MERCADERIAENTRANSITO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'PAGO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTEDEESTADOS'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONES'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTECCCLIENTE'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTECCPROVEEDOR'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONESIVA'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONESGANANCIAS'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONESSUSS'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONRECIBIDO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'VALORESENTRANSITO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'PREPARACIONDEMERCADERIA'
				llRetorno = .F.
		otherwise
			llRetorno = .T.
		endcase
		return llRetorno
	endfunc


	*----------------------------------------------
	Function ObtenerIndices() as String
		Local lcXML as String

		lcXML = filetostr(this.cPathBase+'Din_ADNIndices.xml')
		return lcXml
	endfunc

	*----------------------------------------------
	Function ObtenerOperaciones() As String
		Local lcXML as String
		lcXML = filetostr(this.cPathBase+'Din_ADNOperaciones.xml')
		this.cXmlOperacionesMenu = this.ObtenerSucursalesDeSeguridadXML( lcXml )
		return this.cXmlOperacionesMenu
	EndFunc

	*------------------------------------------------------------------------------------
	Function ObtenerColeccionOperaciones( tnDataSessionId as integer, tcClavePadre as String, toColOperaciones as ZooColeccion of ZooColeccion.prg ) as Void
		local lnData as Integer, loColOperacion as zoocoleccion OF zoocoleccion.prg, lcClavePadre as String, llRetornarCol as Boolean
		lcClavePadre = iif( vartype( tcClavePadre ) == 'C', tcClavePadre, null )
		llRetornarCol = .t.
		lnData = set('Datasession')
		set datasession to ( tnDataSessionId )
		if vartype( toColOperaciones ) == 'O'
			llRetornarCol = .f.
			loColOperaciones = toColOperaciones
		else
			loColOperaciones = _screen.zoo.CrearObjeto( 'ZooColeccion' )
		endif
		this.ObtenerSucursalesDeSeguridad( loColOperaciones, lcClavePadre )
		this.xmlacursor(filetostr(this.cPathBase+'din_ADNOperaciones.xml'),'auxOpe')
		select('auxOpe')
		scan
			if empty( alltrim( rama ) )
				lcPadre = ''
			else
				lcPadre = right( alltrim( rama ), len( alltrim( rama )) - rat( '.', alltrim( rama )))
			endif
			this.AgregarItemOper( loColOperaciones, alltrim( auxOpe.id ),alltrim( auxOpe.entidad ),alltrim( auxOpe.item ),alltrim( lcPadre );
			,alltrim( auxOpe.tipoOpcion ),auxOpe.Orden,auxOpe.nivel,alltrim( auxOpe.rama ),alltrim( auxOpe.Operacion ),alltrim( auxOpe.Descripcion );
			,'',datetime(),lcClavePadre,iif(empty(modo),2,modo), 2 )
		endscan
		use in select('auxOpe')
		set datasession to ( lnData )
		if llRetornarCol
			return loColOperaciones
		endif
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerSucursalesDeSeguridad( toColOperaciones, tcClavePadre ) as Void
		local lcXML as String, lcCursor as String, lcTablaSeguridad as String, lcSql as String
		lcCursor = sys( 2015 )
		if goDatos.EsNativa()
			lcTablaSeguridad = addbs( this.ObtenerRutaTablasSeguridad()) + 'basededatos.dbf'
		endif
		lcSql = 'Select cast( ' + goDatos.ObtenerSchemaFunciones() + '.DesEncriptar192( ' + goDatos.ObtenerFuncion( 'Alltrim' ) + '( idDB )) as char(254)) as idDB, cast( ' + goDatos.ObtenerSchemaFunciones() + '.DesEncriptar192( ' + goDatos.ObtenerFuncion( 'Alltrim' ) + '( NombreDB )) as char(254)) as NombreDB, cast( ' + goDatos.ObtenerSchemaFunciones() + '.DesEncriptar192( ' + goDatos.ObtenerFuncion( 'Alltrim' ) + '( Usuario )) as char(254)) as Usuario, fecha from ' + goDatos.ObtenerSchemaSeguridad() + 'BaseDeDatos order by NombreDB'
		if goDatos.EsSqlServer()
			lcXML = goDatos.EjecutarSql( lcSql )
		else
			lcXML = goDatos.Consultar( lcSQl, lcTablaSeguridad )
		endif
		xmltocursor( lcXML, lcCursor )
		select &lcCursor
			this.AgregarItemOper( toColOperaciones, 'DB1', '', 'Base de datos', '', 'BD', 999, 1, '', 'Base de datos', 'Base de datos', '', datetime(), tcClavePadre,6 )
		scan
			this.AgregarItemOper( toColOperaciones, alltrim( idDB ), '', NombreDB, 'DB1', 'BD', 999, 2, 'DB1', NombreDB, NombreDB, '', datetime(), tcClavePadre )
		endscan
		use in select( lcCursor )
	endfunc

	*------------------------------------------------------------------------------------
	protected function ObtenerRutaTablasSeguridad() as String
		return _Screen.zoo.app.cRutaTablasSeguridad
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerSucursalesDeSeguridadXML( tcXML as String ) as String
		local lcXML as String, lcCursorOPer as String, lcCursor as String, loItem as Object, lcTablaSeguridad as String, lcSql as String

		lcCursor = sys( 2015 )
		lcCursorOPer = sys( 2015 )

		this.XmlACursor( tcXML, lcCursorOPer )
		if goDatos.EsNativa()
			lcTablaSeguridad = addbs( this.ObtenerRutaTablasSeguridad()) + 'basededatos.dbf'
		endif
		lcSql = 'Select cast( ' + goDatos.ObtenerSchemaFunciones() + '.DesEncriptar192( ' + goDatos.ObtenerFuncion( 'Alltrim' ) + '( idDB )) as char(254)) as idDB, cast( ' + goDatos.ObtenerSchemaFunciones() + '.DesEncriptar192( ' + goDatos.ObtenerFuncion( 'Alltrim' ) + '( NombreDB )) as char(254)) as NombreDB, cast( ' + goDatos.ObtenerSchemaFunciones() + '.DesEncriptar192( ' + goDatos.ObtenerFuncion( 'Alltrim' ) + '( Usuario )) as char(254)) as Usuario, fecha from ' + goDatos.ObtenerSchemaSeguridad() + 'BaseDeDatos'
		if goDatos.EsSqlServer()
			if goServicios.Librerias.ExisteBaseDeDatosSqlServer( _screen.zoo.app.cNombreBaseDeDatosSql )
				lcXML = goDatos.EjecutarSql( lcSql )
			else
				goServicios.Errores.LevantarExcepcion( 'La base de datos ' + _screen.zoo.app.cNombreBaseDeDatosSql + ' no existe' )
			endif
		else
			lcXML = goDatos.Consultar( lcSQl, lcTablaSeguridad )
		endif
		this.xmlacursor( lcXML, lcCursor )

		select &lcCursor
		insert into &lcCursorOper ( id, item, itempadre, tipoopcion, orden, nivel, operacion, descripcion, rama ) values ;
		( 'DB1', 'Base de datos', '', 'BD', 999, 1, '', 'Base de datos', 'Base de datos' ) 

		scan
			insert into &lcCursorOper ( id, item, itempadre, tipoopcion, orden, nivel, operacion, descripcion, rama ) values ;
			( &lcCursor..idDB, &lcCursor..NombreDB, 'DB1', 'BD', 999, 2, 'DB1', &lcCursor..NombreDB, &lcCursor..NombreDB ) 
		endscan

		lcXML = this.CursorAXml( lcCursorOPer )
		use in select( lcCursor )
		use in select( lcCursorOPer )

		return lcXML
	endfunc

	*------------------------------------------------------------------------------------
	Function AgregarItemOper( toCol, tcId, tcEntidad, tcItem, tcItemPadre, tcTipoOpcion, tnOrden, tnNivel, tcRama, tcOperacion, tcDescripcion, tcUsuario, ttFecha, tcFiltroPadre, tnModo, tnModoPerfil ) as Void
		local loItem as Custom

		if empty(tnModo)
			tnModo = 2
		endif
		if isnull( tcFiltroPadre ) or alltrim( upper( tcFiltroPadre )) == alltrim( upper( tcItemPadre ))
			loItem = newobject( 'ItemAcceso' )
			loItem.id = tcId
			loItem.entidad = tcEntidad
			loItem.item = tcItem
			loItem.itempadre = tcItemPadre
			loItem.tipoopcion = tcTipoOpcion
			loItem.Orden = tnOrden
			loItem.nivel = tnNivel
			loItem.Rama = tcRama
			loItem.Operacion = tcOperacion
			loItem.Descripcion = tcDescripcion
			loItem.Modo = tnModo
			loItem.ModoPerfil = tnModoPerfil
			loItem.Usuario = ''
			loItem.Fecha = ctot( '' )
			loItem.lEliminar = .f.
			loItem.dtUltimoAcceso = ctot( '' )
			loItem.nIndice = toCol.Count + 1

			toCol.Agregar( loItem, tcId )
		endif
	endfunc

	*------------------------------------------------------------------------------------
	Function AgregarItemMotivoyOrigenDestino( toCol, tcEntidad, tcAtributo, tcCampo ) as Void
		local loItem as Custom

		loItem = newobject( 'ItemMotivo' )
		loItem.entidad = tcEntidad
		loItem.Atributo = tcAtributo
		loItem.Campo = tcCampo

		toCol.Agregar( loItem, tcEntidad)
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerColeccionAtributosPk() as zoocoleccion
		Local loAtributosPk as zoocoleccion OF zoocoleccion.prg
			loAtributosPk = _screen.zoo.crearObjeto( 'zoocoleccion' )
		with loAtributosPk
			.Agregar( '5','PROVEEDOR' )
			.Agregar( '5','VENDEDOR' )
			.Agregar( '5','CLIENTE' )
			.Agregar( '20','COMPROBANTEDECAJA' )
			.Agregar( '20','MODIFICACIONPRECIOS' )
			.Agregar( '38','VALEDECAMBIO' )
			.Agregar( '6','TRANSPORTISTA' )
			.Agregar( '3','UNIDADDEMEDIDA' )
			.Agregar( '10','FORMULA' )
			.Agregar( '20','MINIMOREPOSICION' )
			.Agregar( '10','GRUPO' )
			.Agregar( '10','NOMBREDEFANTASIA' )
			.Agregar( '10','CONTACTO' )
			.Agregar( '20','ASIENTO' )
			.Agregar( '10','CLIENTEECOMMERCE' )
			.Agregar( '20','DATOSADICIONALESSIPRIB' )
			.Agregar( '20','SERVICIOREST' )
			.Agregar( '20','INTERACCIONDEORDEN' )
			.Agregar( '20','ORDENDESERVICIO' )
			.Agregar( '20','GESTIONVENDEDOR' )
			.Agregar( '20','VALORESENTRANSITO' )
			.Agregar( '20','REGISTRODECUENTA' )
			.Agregar( '10','CONCEPTOENTIDADFINANCIERA' )
			.Agregar( '20','MOVIMIENTOBANCARIO' )
			.Agregar( '40','WEBHOOK' )
			.Agregar( '30','MARCA' )
		endwith
		return loAtributosPk
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerColeccionEntidadesConMotivo() as zoocoleccion
		Local loEntidad as zoocoleccion OF zoocoleccion.prg
			loEntidad  = _screen.zoo.crearObjeto( 'zoocoleccion' )
		with this 
.AgregarItemMotivoyOrigenDestino( loEntidad, 'BOLSASYCAJAS','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'CANCELACIONDECOMPRA','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'MERCADERIAENTRANSITO','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'MOVIMIENTODESTOCK','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'PEDIDO','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'PEDIDODECOMPRA','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'PREPARACIONDEMERCADERIA','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'PRESUPUESTO','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'PRESUPUESTODECOMPRA','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'REMITO','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'REMITODECOMPRA','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'REQUERIMIENTODECOMPRA','Motivo','MOTIVO')
		endwith
		return loEntidad
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerColeccionEntidadesConOrigenDestino() as zoocoleccion
		Local loEntidad as zoocoleccion OF zoocoleccion.prg
			loEntidad  = _screen.zoo.crearObjeto( 'zoocoleccion' )
		with this 
.AgregarItemMotivoyOrigenDestino( loEntidad, 'COMPROBANTEDECAJA','OrigenDestino','ORIGDEST')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'MERCADERIAENTRANSITO','OrigenDestino','ORIGDEST')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'MOVIMIENTODESTOCK','OrigenDestino','ORIGDEST')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'VALORESENTRANSITO','OrigenDestino','OrigDest')
		endwith
		return loEntidad
	endfunc

	*----------------------------------------------
	Function ObtenerVersion() as String
		Return '15.0007.14697'
	endfunc

	*----------------------------------------------
	Function ObtenerFuncionalidades() as String
		Local lcXML as String

		lcXML = filetostr(this.cPathBase+'Din_ADNFuncionalidades.xml')
		return lcXml
	endfunc

	*----------------------------------------------
	function VerificarFuncionalidad( tcEntidad as string, tcFuncionalidad as string ) as boolean
		local llRetorno as boolean, lcCursor as string, lcFuncionalidad as string
		lcCursor = this.cCursorFuncionalidades
		lcFuncionalidad = upper( alltrim( tcFuncionalidad ) )
		if left( lcFuncionalidad, 1 ) # '<'
			lcFuncionalidad = '<' + lcFuncionalidad
		endif
		if right( lcFuncionalidad, 1 ) # '>'
			lcFuncionalidad = lcFuncionalidad + '>'
		endif
		if !used( lcCursor )
			this.XmlACursor( this.ObtenerFuncionalidades(), lcCursor )
		endif
		locate for upper( alltrim( Entidad ) ) == upper( alltrim( tcEntidad ) ) and lcFuncionalidad $ upper( alltrim( Funcionalidades ) )
		llRetorno = found( lcCursor )
		return llRetorno
	endfunc

	*----------------------------------------------
	function CopiarTablasSucursalNativa( tcRutaOrigen as String, tcRutaDestino as String, tcSucursalOrigen as String, tcSucursalDestino as String ) as Void
		local loLogCopia as Object, lcMensaje as String, lcSql as String, lcTabla as String, lcTablaOrigen as String, lcTablaDestino as String, lcSucOrigen as string, lcSucDestino as string
		loLogCopia = _Screen.zoo.crearobjeto( 'MostrarCopiaDB' )
		loLogCopia.inicializar( tcSucursalDestino, tcRutaDestino , 9)

		lcSucOrigen = 'o_' + strtran( strtran( strtran( alltrim( tcSucursalOrigen ), '-', '' ), ' ', ''), '.', '')
		lcSucDestino = 'd_' + strtran( strtran( strtran( alltrim( tcSucursalDestino ), '-', '' ), ' ', ''), '.', '')
		try
			*----------CACEPV----------------------------
			lcTabla = 'CACEPV'
			lcTablaOrigen = lcSucOrigen + '_CACEPV'
			lcTablaDestino = lcSucDestino + '_CACEPV'
			use in 0 addbs( tcRutaDestino ) + 'CACEPV' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'CACEPV' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CANTDESDE,CANTHASTA,CDESC,CLCFI,CLOBS,CODLISTA,COMP,CUOTAS,DESDESDE,DESHASTA,DIADO,DIAJU,DIALU,DIAMA,DIAMI,DIASA,DIAVI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,FPODESD,FPODESH,FPORECD,FPORECH,HALTAFW,HMODIFW,HORADESDE,HORAEXPO,HORAHASTA,HORAIMPO,JJCO,NUMERO,RECDESDE,RECHASTA,SALTAFW,SMODIFW,SUCDESDE,SUCHASTA,TIMESTAMP,TOTALDESDE,TOTALHASTA,UALTAFW,UMODIFW,VALTAFW,VDESDE,VHASTA,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CANTDESDE,CANTHASTA,CDESC,CLCFI,CLOBS,CODLISTA,COMP,CUOTAS,DESDESDE,DESHASTA,DIADO,DIAJU,DIALU,DIAMA,DIAMI,DIASA,DIAVI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,FPODESD,FPODESH,FPORECD,FPORECH,HALTAFW,HMODIFW,HORADESDE,HORAEXPO,HORAHASTA,HORAIMPO,JJCO,NUMERO,RECDESDE,RECHASTA,SALTAFW,SMODIFW,SUCDESDE,SUCHASTA,TIMESTAMP,TOTALDESDE,TOTALHASTA,UALTAFW,UMODIFW,VALTAFW,VDESDE,VHASTA,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_CACEPV_CLOBS'
				lcTablaDestino = 'd_CACEPV_CLOBS'
				use in 0 addbs( tcRutaDestino ) + 'CACEPV_CLOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'CACEPV_CLOBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( NUMERO, Orden, Texto ) ' + ;
				'select  NUMERO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_CACEPV_ZADSFW'
				lcTablaDestino = 'd_CACEPV_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'CACEPV_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'CACEPV_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( NUMERO, Orden, Texto ) ' + ;
				'select  NUMERO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------CAJAESTA----------------------------
			lcTabla = 'CAJAESTA'
			lcTablaOrigen = lcSucOrigen + '_CAJAESTA'
			lcTablaDestino = lcSucDestino + '_CAJAESTA'
			use in 0 addbs( tcRutaDestino ) + 'CAJAESTA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'CAJAESTA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (ARQUEO,BDALTAFW,BDMODIFW,DESCRIP,ESTADO,ESTTRANS,FALTAFW,FECEXPO,FECHA,FECHAP,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,IDCAJAAUD,IDUSUARIOP,OBS,SALTAFW,SMODIFW,TIMESTAMP,TOTMONEDA,UALTAFW,UMODIFW,USAVEND,VALTAFW,VMODIFW,ZADSFW) select ARQUEO,BDALTAFW,BDMODIFW,DESCRIP,ESTADO,ESTTRANS,FALTAFW,FECEXPO,FECHA,FECHAP,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,IDCAJAAUD,IDUSUARIOP,OBS,SALTAFW,SMODIFW,TIMESTAMP,TOTMONEDA,UALTAFW,UMODIFW,USAVEND,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_CAJAESTA_OBS'
				lcTablaDestino = 'd_CAJAESTA_OBS'
				use in 0 addbs( tcRutaDestino ) + 'CAJAESTA_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'CAJAESTA_OBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( NUMCAJA, Orden, Texto ) ' + ;
				'select  NUMCAJA, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_CAJAESTA_ZADSFW'
				lcTablaDestino = 'd_CAJAESTA_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'CAJAESTA_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'CAJAESTA_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( NUMCAJA, Orden, Texto ) ' + ;
				'select  NUMCAJA, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------DENOMINA----------------------------
			lcTabla = 'DENOMINA'
			lcTablaOrigen = lcSucOrigen + '_DENOMINA'
			lcTablaDestino = lcSucDestino + '_DENOMINA'
			use in 0 addbs( tcRutaDestino ) + 'DENOMINA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'DENOMINA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CODIGO,DESCRI,NROITEM,ORDEN,TIPO,VALOR) select CODIGO,DESCRI,NROITEM,ORDEN,TIPO,VALOR from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------IBM4610KC4----------------------------
			lcTabla = 'IBM4610KC4'
			lcTablaOrigen = lcSucOrigen + '_IBM4610KC4'
			lcTablaDestino = lcSucDestino + '_IBM4610KC4'
			use in 0 addbs( tcRutaDestino ) + 'IBM4610KC4' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'IBM4610KC4' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,BLOQREG,CCOD,CDET,CDETI,CEXCEP,COBS,COBSI,CRESP,CRESPI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,BLOQREG,CCOD,CDET,CDETI,CEXCEP,COBS,COBSI,CRESP,CRESPI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_IBM4610KC4_ZADSFW'
				lcTablaDestino = 'd_IBM4610KC4_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'IBM4610KC4_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'IBM4610KC4_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( CCOD, Orden, Texto ) ' + ;
				'select  CCOD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------ORDAT----------------------------
			lcTabla = 'ORDAT'
			lcTablaOrigen = lcSucOrigen + '_ORDAT'
			lcTablaDestino = lcSucDestino + '_ORDAT'
			use in 0 addbs( tcRutaDestino ) + 'ORDAT' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'ORDAT' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OOBS,SALTAFW,SMODIFW,TIMESTAMP,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OOBS,SALTAFW,SMODIFW,TIMESTAMP,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_ORDAT_OOBS'
				lcTablaDestino = 'd_ORDAT_OOBS'
				use in 0 addbs( tcRutaDestino ) + 'ORDAT_OOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'ORDAT_OOBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( CODIGO, Orden, Texto ) ' + ;
				'select  CODIGO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_ORDAT_ZADSFW'
				lcTablaDestino = 'd_ORDAT_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'ORDAT_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'ORDAT_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( CODIGO, Orden, Texto ) ' + ;
				'select  CODIGO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------PARAMETROSSUCURSAL----------------------------
			lcTabla = 'PARAMETROSSUCURSAL'
			lcTablaOrigen = lcSucOrigen + '_PARAMETROSSUCURSAL'
			lcTablaDestino = lcSucDestino + '_PARAMETROSSUCURSAL'
			use in 0 addbs( tcRutaDestino ) + 'PARAMETROSSUCURSAL' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'PARAMETROSSUCURSAL' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (DECIMALES,IDNODO,IDUNICO,LONGITUD,PARAMETRO,PROYECTO,VALOR) select DECIMALES,IDNODO,IDUNICO,LONGITUD,PARAMETRO,PROYECTO,VALOR from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------POOLDECLASE----------------------------
			lcTabla = 'POOLDECLASE'
			lcTablaOrigen = lcSucOrigen + '_POOLDECLASE'
			lcTablaDestino = lcSucDestino + '_POOLDECLASE'
			use in 0 addbs( tcRutaDestino ) + 'POOLDECLASE' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'POOLDECLASE' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CANTOBJ,CODIGO,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MODO,NOMBRE,PRIORIDAD,SALTAFW,SMODIFW,UALTAFW,ULTFECUSO,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CANTOBJ,CODIGO,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MODO,NOMBRE,PRIORIDAD,SALTAFW,SMODIFW,UALTAFW,ULTFECUSO,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_POOLDECLASE_ZADSFW'
				lcTablaDestino = 'd_POOLDECLASE_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'POOLDECLASE_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'POOLDECLASE_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( CODIGO, Orden, Texto ) ' + ;
				'select  CODIGO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------SYS_S----------------------------
			lcTabla = 'SYS_S'
			lcTablaOrigen = lcSucOrigen + '_SYS_S'
			lcTablaDestino = lcSucDestino + '_SYS_S'
			use in 0 addbs( tcRutaDestino ) + 'SYS_S' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'SYS_S' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (DECIMALES,IDNODO,IDUNICO,LONGITUD,PARAMETRO,PROYECTO,VALOR) select DECIMALES,IDNODO,IDUNICO,LONGITUD,PARAMETRO,PROYECTO,VALOR from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------TARJEACREDET----------------------------
			lcTabla = 'TARJEACREDET'
			lcTablaOrigen = lcSucOrigen + '_TARJEACREDET'
			lcTablaDestino = lcSucDestino + '_TARJEACREDET'
			use in 0 addbs( tcRutaDestino ) + 'TARJEACREDET' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'TARJEACREDET' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CANTTIEMPO,COD,CUOTAS,MODOTIEMPO,NROITEM) select CANTTIEMPO,COD,CUOTAS,MODOTIEMPO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

		catch to loError
			lcMensaje = 'Problemas al generar la nueva base de datos. '
			lcMensaje= lcMensaje + 'Cierre las aplicaciones relacionadas y verifique los permisos de escritura que posee. Si el problema persiste, p�ngase en contacto con el administrador.'
			loLogCopia.Actualizar( lcTabla , 'Error al copiar.' )
			goServicios.Errores.LevantarExcepcion( lcMensaje )
		finally
			loLogCopia.Finalizar()
			release loLogCopia
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
		endtry
	endfunc

	*----------------------------------------------
	function CopiarTablasSucursalSqlServer( tcRutaOrigen as String, tcRutaDestino as String, tcSucursalOrigen as String, tcSucursalDestino as String ) as Void
		local loLogCopia as Object, lcMensaje as String, lcSql as String, lcTabla as String, lcTablaOrigen as String, lcTablaDestino as String 
		loLogCopia = _Screen.zoo.crearobjeto( 'MostrarCopiaDB' )
		loLogCopia.inicializar( tcSucursalDestino, 'SqlServer' , 9)

		try
			*----------goServicios.Estructura.ObtenerEsquema( 'CACEPV' ) + '.CACEPV'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'CACEPV' ) + '.CACEPV'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CANTDESDE,CANTHASTA,CDESC,CLCFI,CLOBS,CODLISTA,COMP,CUOTAS,DESDESDE,DESHASTA,DIADO,DIAJU,DIALU,DIAMA,DIAMI,DIASA,DIAVI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,FPODESD,FPODESH,FPORECD,FPORECH,HALTAFW,HMODIFW,HORADESDE,HORAEXPO,HORAHASTA,HORAIMPO,JJCO,NUMERO,RECDESDE,RECHASTA,SALTAFW,SMODIFW,SUCDESDE,SUCHASTA,TIMESTAMP,TOTALDESDE,TOTALHASTA,UALTAFW,UMODIFW,VALTAFW,VDESDE,VHASTA,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CANTDESDE,CANTHASTA,CDESC,CLCFI,CLOBS,CODLISTA,COMP,CUOTAS,DESDESDE,DESHASTA,DIADO,DIAJU,DIALU,DIAMA,DIAMI,DIASA,DIAVI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,FPODESD,FPODESH,FPORECD,FPORECH,HALTAFW,HMODIFW,HORADESDE,HORAEXPO,HORAHASTA,HORAIMPO,JJCO,NUMERO,RECDESDE,RECHASTA,SALTAFW,SMODIFW,SUCDESDE,SUCHASTA,TIMESTAMP,TOTALDESDE,TOTALHASTA,UALTAFW,UMODIFW,VALTAFW,VDESDE,VHASTA,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'CAJAESTA' ) + '.CAJAESTA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'CAJAESTA' ) + '.CAJAESTA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (ARQUEO,BDALTAFW,BDMODIFW,DESCRIP,ESTADO,ESTTRANS,FALTAFW,FECEXPO,FECHA,FECHAP,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,IDCAJAAUD,IDUSUARIOP,OBS,SALTAFW,SMODIFW,TIMESTAMP,TOTMONEDA,UALTAFW,UMODIFW,USAVEND,VALTAFW,VMODIFW,ZADSFW) select ARQUEO,BDALTAFW,BDMODIFW,DESCRIP,ESTADO,ESTTRANS,FALTAFW,FECEXPO,FECHA,FECHAP,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,IDCAJAAUD,IDUSUARIOP,OBS,SALTAFW,SMODIFW,TIMESTAMP,TOTMONEDA,UALTAFW,UMODIFW,USAVEND,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'DENOMINA' ) + '.DENOMINA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'DENOMINA' ) + '.DENOMINA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CODIGO,DESCRI,NROITEM,ORDEN,TIPO,VALOR) select CODIGO,DESCRI,NROITEM,ORDEN,TIPO,VALOR from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'IBM4610KC4' ) + '.IBM4610KC4'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'IBM4610KC4' ) + '.IBM4610KC4'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,BLOQREG,CCOD,CDET,CDETI,CEXCEP,COBS,COBSI,CRESP,CRESPI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,BLOQREG,CCOD,CDET,CDETI,CEXCEP,COBS,COBSI,CRESP,CRESPI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'ORDAT' ) + '.ORDAT'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'ORDAT' ) + '.ORDAT'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OOBS,SALTAFW,SMODIFW,TIMESTAMP,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OOBS,SALTAFW,SMODIFW,TIMESTAMP,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'POOLDECLASE' ) + '.POOLDECLASE'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'POOLDECLASE' ) + '.POOLDECLASE'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CANTOBJ,CODIGO,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MODO,NOMBRE,PRIORIDAD,SALTAFW,SMODIFW,UALTAFW,ULTFECUSO,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CANTOBJ,CODIGO,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MODO,NOMBRE,PRIORIDAD,SALTAFW,SMODIFW,UALTAFW,ULTFECUSO,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'TARJEACREDET' ) + '.TARJEACREDET'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'TARJEACREDET' ) + '.TARJEACREDET'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CANTTIEMPO,COD,CUOTAS,MODOTIEMPO,NROITEM) select CANTTIEMPO,COD,CUOTAS,MODOTIEMPO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------PARAMETROS.SUCURSAL----------------------------
			lcTabla = 'PARAMETROS.SUCURSAL'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				delete from  << lcTablaDestino >> 
				insert into << lcTablaDestino >> (IDCABECERA,IDUNICO,VALOR) select IDCABECERA,IDUNICO,VALOR from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------REGISTROS.SUCURSAL----------------------------
			lcTabla = 'REGISTROS.SUCURSAL'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				delete from  << lcTablaDestino >> 
				insert into << lcTablaDestino >> (IDCABECERA,IDUNICO,VALOR) select IDCABECERA,IDUNICO,VALOR from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

		catch to loError
			lcMensaje = 'Problemas al generar la nueva base de datos. '
			lcMensaje= lcMensaje + 'Cierre las aplicaciones relacionadas y verifique los permisos de escritura que posee. Si el problema persiste, p�ngase en contacto con el administrador.'
			loLogCopia.Actualizar( lcTabla , 'Error al copiar.' )
			goServicios.Errores.LevantarExcepcion( lcMensaje )
		finally
			loLogCopia.Finalizar()
			release loLogCopia
		endtry
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerColeccionModulosPorEntidad() as ZooColeccion of ZooColeccion.prg
		local loColeccion as zoocoleccion OF zoocoleccion.prg
		loColeccion = _screen.zoo.CrearObjeto( 'ZooColeccion' )
		loColeccion.Agregar( 'B','ARTICULO' )
		loColeccion.Agregar( 'B','PROVEEDOR' )
		loColeccion.Agregar( 'B','MATERIAL' )
		loColeccion.Agregar( 'B','COLOR' )
		loColeccion.Agregar( 'B','LISTADEPRECIOS' )
		loColeccion.Agregar( 'B','VALOR' )
		loColeccion.Agregar( 'B','VENDEDOR' )
		loColeccion.Agregar( 'B','CLIENTE' )
		loColeccion.Agregar( 'B','FACTURA' )
		loColeccion.Agregar( 'B','STOCKCOMBINACION' )
		loColeccion.Agregar( 'B','PROVINCIA' )
		loColeccion.Agregar( 'B','CORREDOR' )
		loColeccion.Agregar( 'B','BANCO' )
		loColeccion.Agregar( 'B','SUCURSAL' )
		loColeccion.Agregar( 'B','DOCUMENTOPROPIO' )
		loColeccion.Agregar( 'B','ITEMARTICULOSVENTAS' )
		loColeccion.Agregar( 'B','ITEMVALORES' )
		loColeccion.Agregar( 'B','PRECIODEARTICULO' )
		loColeccion.Agregar( 'B','TICKETFACTURA' )
		loColeccion.Agregar( 'B','NOTADECREDITO' )
		loColeccion.Agregar( 'B','NOTADEDEBITO' )
		loColeccion.Agregar( 'B','TICKETNOTADECREDITO' )
		loColeccion.Agregar( 'B','TICKETNOTADEDEBITO' )
		loColeccion.Agregar( 'B','STOCKARTICULOS' )
		loColeccion.Agregar( 'B','MONEDA' )
		loColeccion.Agregar( 'B','ITEMCONDICIONDEPAGO' )
		loColeccion.Agregar( 'B','ITEMMONEDA' )
		loColeccion.Agregar( 'B','ORIGENDEDATOS' )
		loColeccion.Agregar( 'B','ENTIDADFINANCIERA' )
		loColeccion.Agregar( 'B','MOTIVO' )
		loColeccion.Agregar( 'B','REMITO' )
		loColeccion.Agregar( 'B','CAJAAUDITORIA' )
		loColeccion.Agregar( 'B','CAJAESTADO' )
		loColeccion.Agregar( 'B','CAJASALDOS' )
		loColeccion.Agregar( 'B','ITEMCAJAAUDITORIA' )
		loColeccion.Agregar( 'B','MOVIMIENTODECAJA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOS' )
		loColeccion.Agregar( 'B','ITEMVALORESCAJA' )
		loColeccion.Agregar( 'B','CONCEPTOCAJA' )
		loColeccion.Agregar( 'B','COMPROBANTEDECAJA' )
		loColeccion.Agregar( 'B','GRUPOVALOR' )
		loColeccion.Agregar( 'B','MODIFICACIONPRECIOS' )
		loColeccion.Agregar( 'B','ITEMMODIFICACIONPRECIOS' )
		loColeccion.Agregar( 'B','MOVIMIENTODESTOCK' )
		loColeccion.Agregar( 'B','ITEMMOVSTOCK' )
		loColeccion.Agregar( 'B','BUZON' )
		loColeccion.Agregar( 'B','PAISES' )
		loColeccion.Agregar( 'B','TALONARIO' )
		loColeccion.Agregar( 'B','NUMERACIONES' )
		loColeccion.Agregar( 'B','ITEMTALONARIO' )
		loColeccion.Agregar( 'B','DEVOLUCION' )
		loColeccion.Agregar( 'B','INFORMACIONADICIONALCOMPVTAS' )
		loColeccion.Agregar( 'B','PERCEPCION' )
		loColeccion.Agregar( 'B','AJUSTEDESTOCK' )
		loColeccion.Agregar( 'B','ITEMAJUSTEDESTOCK' )
		loColeccion.Agregar( 'B','AGRUPAMIENTO' )
		loColeccion.Agregar( 'B','ITEMAGRUPAMIENTO' )
		loColeccion.Agregar( 'B','ITEMBASEDEDATOS' )
		loColeccion.Agregar( 'B','BASEDEDATOS' )
		loColeccion.Agregar( 'B','CTACTE' )
		loColeccion.Agregar( 'B','RECIBO' )
		loColeccion.Agregar( 'B','ITEMRECIBO' )
		loColeccion.Agregar( 'B','MEMORIA' )
		loColeccion.Agregar( 'B','ITEMCOMPROBANTE' )
		loColeccion.Agregar( 'B','DISENOIMPRESION' )
		loColeccion.Agregar( 'B','ITEMAREASIMPRESION' )
		loColeccion.Agregar( 'B','ITEMATRIBUTOSIMPRESION' )
		loColeccion.Agregar( 'B','TIPOAREAIMPRESION' )
		loColeccion.Agregar( 'B','ESTILOIMPRESION' )
		loColeccion.Agregar( 'B','TIPOATRIBUTOIMPRESION' )
		loColeccion.Agregar( 'B','SELECCIONDISENOIMPRESION' )
		loColeccion.Agregar( 'B','DISENOEXPO' )
		loColeccion.Agregar( 'B','ITEMATRIBUTOSEXPO' )
		loColeccion.Agregar( 'B','DESCUENTO' )
		loColeccion.Agregar( 'B','FORMATOEXPORTACION' )
		loColeccion.Agregar( 'B','TIPOAREAEXPORTACION' )
		loColeccion.Agregar( 'B','TIPOATRIBUTOSEXPORTACION' )
		loColeccion.Agregar( 'B','ITEMAREASEXPO' )
		loColeccion.Agregar( 'B','TIPOARCHIVOEXPORTACION' )
		loColeccion.Agregar( 'B','TIPOREGISTROEXPORTACION' )
		loColeccion.Agregar( 'B','CONVERSION' )
		loColeccion.Agregar( 'B','CONVERSIONVALORES' )
		loColeccion.Agregar( 'B','EXPOAGRUPADAS' )
		loColeccion.Agregar( 'B','ITEMEXPOAGRUPADAS' )
		loColeccion.Agregar( 'B','ITEMATRIBUTOSIMPO' )
		loColeccion.Agregar( 'B','ITEMAREASIMPO' )
		loColeccion.Agregar( 'B','TIPOARCHIVOIMPORTACION' )
		loColeccion.Agregar( 'B','IMPOAGRUPADAS' )
		loColeccion.Agregar( 'B','ITEMIMPOAGRUPADAS' )
		loColeccion.Agregar( 'B','TIINVENTARIOACONT' )
		loColeccion.Agregar( 'B','TIINVENTARIOACONTDETALLE' )
		loColeccion.Agregar( 'B','TIINVENTARIOFISICO' )
		loColeccion.Agregar( 'B','TIINVENTARIOFISICODETALLE' )
		loColeccion.Agregar( 'B','TIDIFERENCIASDEINVENTARIO' )
		loColeccion.Agregar( 'B','TIDIFERENCIASDEINVENTARIODETALLE' )
		loColeccion.Agregar( 'B','EQUIVALENCIA' )
		loColeccion.Agregar( 'B','REDONDEODEPRECIOS' )
		loColeccion.Agregar( 'B','ITEMREDONDEOTABLA' )
		loColeccion.Agregar( 'B','ITEMREDONDEOCENTAVOS' )
		loColeccion.Agregar( 'B','ITEMREDONDEOENTEROS' )
		loColeccion.Agregar( 'B','ITEMPRUEBAREDONDEO' )
		loColeccion.Agregar( 'B','CONDICIONIMPO' )
		loColeccion.Agregar( 'B','DISENOIMPO' )
		loColeccion.Agregar( 'B','PICKING' )
		loColeccion.Agregar( 'B','ITEMCOMPROBANTESPICKING' )
		loColeccion.Agregar( 'B','ITEMDIFERENCIASPICKING' )
		loColeccion.Agregar( 'B','ITEMOKPICKING' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOVENTAS' )
		loColeccion.Agregar( 'B','DATOSFISCALES' )
		loColeccion.Agregar( 'B','ITEMDATOSFISCALES' )
		loColeccion.Agregar( 'B','JURISDICCION' )
		loColeccion.Agregar( 'B','ITEMPERCEPCIONES' )
		loColeccion.Agregar( 'B','ITEMCAI' )
		loColeccion.Agregar( 'B','CAI' )
		loColeccion.Agregar( 'B','SCRIPT' )
		loColeccion.Agregar( 'B','ITEMINSTRUCCIONSCRIPT' )
		loColeccion.Agregar( 'B','VALEDECAMBIO' )
		loColeccion.Agregar( 'B','CONSUMOCLIENTE' )
		loColeccion.Agregar( 'B','LIMITECONSUMO' )
		loColeccion.Agregar( 'B','REGLASTRANSFERENCIAS' )
		loColeccion.Agregar( 'B','ERRORESCFIBM4610KC4' )
		loColeccion.Agregar( 'B','CODIGOPOSTAL' )
		loColeccion.Agregar( 'B','ACCIONESAUTOMATICAS' )
		loColeccion.Agregar( 'B','ITEMACCIONESAUTOMATICAS' )
		loColeccion.Agregar( 'B','SENIA' )
		loColeccion.Agregar( 'B','PEDIDO' )
		loColeccion.Agregar( 'B','ITEMAJSTOCKART' )
		loColeccion.Agregar( 'B','ITEMAJAUDICOMBINACION' )
		loColeccion.Agregar( 'B','ITEMAJAUDIARTICULOS' )
		loColeccion.Agregar( 'B','ITEMARTICULOSSENIADOS' )
		loColeccion.Agregar( 'B','ITEMSENIAS' )
		loColeccion.Agregar( 'B','IMPRESIONDEETIQUETA' )
		loColeccion.Agregar( 'B','ITEMIMPETIQUETA' )
		loColeccion.Agregar( 'B','CLASIFICACIONCLIENTE' )
		loColeccion.Agregar( 'B','SENIAPENDIENTE' )
		loColeccion.Agregar( 'B','ITEMSENIAPENDIENTE' )
		loColeccion.Agregar( 'B','CHEQUE' )
		loColeccion.Agregar( 'B','IMPUESTO' )
		loColeccion.Agregar( 'B','ITEMARTICULOSCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOCOMPRA' )
		loColeccion.Agregar( 'B','FACTURADECOMPRA' )
		loColeccion.Agregar( 'B','ITEMVALORESCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSC' )
		loColeccion.Agregar( 'B','OPERADORADETARJETA' )
		loColeccion.Agregar( 'B','ITEMPLANDECUOTA' )
		loColeccion.Agregar( 'B','CIERREDELOTE' )
		loColeccion.Agregar( 'B','ITEMLOTE' )
		loColeccion.Agregar( 'B','POS' )
		loColeccion.Agregar( 'B','CUPON' )
		loColeccion.Agregar( 'B','ITEMOPERADORASDETARJETA' )
		loColeccion.Agregar( 'B','PRESUPUESTO' )
		loColeccion.Agregar( 'B','TIPOIMPUESTO' )
		loColeccion.Agregar( 'B','TRANSPORTISTA' )
		loColeccion.Agregar( 'B','DATOSTARJETA' )
		loColeccion.Agregar( 'B','ITEMDATOSPLANES' )
		loColeccion.Agregar( 'B','CALCULODEPRECIOS' )
		loColeccion.Agregar( 'B','ITEMCALCULODEPRECIOS' )
		loColeccion.Agregar( 'B','TRATAMIENTOCOMPROBANTES' )
		loColeccion.Agregar( 'B','FACTURAELECTRONICA' )
		loColeccion.Agregar( 'B','NOTADECREDITOELECTRONICA' )
		loColeccion.Agregar( 'B','NOTADEDEBITOELECTRONICA' )
		loColeccion.Agregar( 'B','CAE' )
		loColeccion.Agregar( 'B','FAVORITOLISTADOS' )
		loColeccion.Agregar( 'B','ITEMFAVORITOSLISTADOS' )
		loColeccion.Agregar( 'B','CAEPORLOTE' )
		loColeccion.Agregar( 'B','COMPORTAMIENTOCODIGOSUGERIDOENTIDAD' )
		loColeccion.Agregar( 'B','ZUDESCARGALAN' )
		loColeccion.Agregar( 'B','INFORMACIONLISTADOS' )
		loColeccion.Agregar( 'B','CTACTECOMPRA' )
		loColeccion.Agregar( 'B','ORDENDEPAGO' )
		loColeccion.Agregar( 'B','ITEMORDENDEPAGO' )
		loColeccion.Agregar( 'B','NOTADEDEBITOCOMPRA' )
		loColeccion.Agregar( 'B','ITEMARTICULOSNDCOMPRA' )
		loColeccion.Agregar( 'B','ITEMVALORESNDCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSNDC' )
		loColeccion.Agregar( 'B','ITEMIMPUESTONDCOMPRA' )
		loColeccion.Agregar( 'B','NOTADECREDITOCOMPRA' )
		loColeccion.Agregar( 'B','ITEMARTICULOSNCCOMPRA' )
		loColeccion.Agregar( 'B','ITEMVALORESNCCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSNCC' )
		loColeccion.Agregar( 'B','ITEMIMPUESTONCCOMPRA' )
		loColeccion.Agregar( 'B','SUCURSALBANCARIA' )
		loColeccion.Agregar( 'B','CUENTABANCARIA' )
		loColeccion.Agregar( 'B','CHEQUERA' )
		loColeccion.Agregar( 'B','CHEQUEPROPIO' )
		loColeccion.Agregar( 'B','ESTADOCONTROLADORFISCAL' )
		loColeccion.Agregar( 'B','CANJEDECUPONES' )
		loColeccion.Agregar( 'B','ITEMCANJECUPONES' )
		loColeccion.Agregar( 'B','ITEMCUPON' )
		loColeccion.Agregar( 'B','CUPONESPENDIENTES' )
		loColeccion.Agregar( 'B','FACTURAELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'B','INCOTERMS' )
		loColeccion.Agregar( 'B','UNIDADDEMEDIDA' )
		loColeccion.Agregar( 'B','UNIDADDEMEDIDAAFIP' )
		loColeccion.Agregar( 'B','ITEMPAIS' )
		loColeccion.Agregar( 'B','PAISAFIP' )
		loColeccion.Agregar( 'B','MONEDAAFIP' )
		loColeccion.Agregar( 'B','NOTADECREDITOELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'B','NOTADEDEBITOELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'B','AGRUPAMIENTODEBUZONES' )
		loColeccion.Agregar( 'B','ITEMAGRUPAMIENTOBUZONES' )
		loColeccion.Agregar( 'B','ITEMBUZONES' )
		loColeccion.Agregar( 'B','IMPRIMIRCOMPROBANTEPORLOTE' )
		loColeccion.Agregar( 'B','FORMULA' )
		loColeccion.Agregar( 'B','SALTODECAMPO' )
		loColeccion.Agregar( 'B','COMISION' )
		loColeccion.Agregar( 'B','CLASEDETARJETA' )
		loColeccion.Agregar( 'B','ITEMCLASEDETARJETA' )
		loColeccion.Agregar( 'I','TIINVENTARIOFISICODETALLETMP' )
		loColeccion.Agregar( 'B','MERCADERIAENTRANSITO' )
		loColeccion.Agregar( 'B','ITEMCOINCIDENCIAPICKING' )
		loColeccion.Agregar( 'B','ITEMDIFORIGINALPICKING' )
		loColeccion.Agregar( 'B','MINIMOREPOSICION' )
		loColeccion.Agregar( 'B','ITEMMINIMOREPOSICION' )
		loColeccion.Agregar( 'SUIOPQDGHJKLMN','LISTADOSPERSONALIZADOS' )
		loColeccion.Agregar( 'B','REGISTRODEMANTENIMIENTO' )
		loColeccion.Agregar( 'B','PROMOCION' )
		loColeccion.Agregar( 'B','SELECCIONPARAINSERTAR' )
		loColeccion.Agregar( 'B','PAGO' )
		loColeccion.Agregar( 'B','AJUSTEDEESTADOS' )
		loColeccion.Agregar( 'B','ITEMAJUSTEDEESTADOS' )
		loColeccion.Agregar( 'B','ITEMAJESTADOSAUDCOMB' )
		loColeccion.Agregar( 'B','ITEMAJUSTECOMPROBANTES' )
		loColeccion.Agregar( 'B','ITEMRETENCIONES' )
		loColeccion.Agregar( 'B','COMPROBANTEDERETENCIONES' )
		loColeccion.Agregar( 'B','CONVENIOMULTILATERAL' )
		loColeccion.Agregar( 'B','ITEMARTICULOSPRECOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSPREC' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOPRECOMPRA' )
		loColeccion.Agregar( 'B','PRESUPUESTODECOMPRA' )
		loColeccion.Agregar( 'B','ITEMARTICULOSPEDCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSPEDC' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOPEDCOMPRA' )
		loColeccion.Agregar( 'B','PEDIDODECOMPRA' )
		loColeccion.Agregar( 'B','ITEMARTICULOSSOLCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSSOLC' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSOLCOMPRA' )
		loColeccion.Agregar( 'B','SOLICITUDDECOMPRA' )
		loColeccion.Agregar( 'B','REQUERIMIENTODECOMPRA' )
		loColeccion.Agregar( 'B','ITEMARTICULOSREQCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSREQC' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOREQCOMPRA' )
		loColeccion.Agregar( 'B','REMITODECOMPRA' )
		loColeccion.Agregar( 'B','CANCELACIONDECOMPRA' )
		loColeccion.Agregar( 'B','ITEMARTICULOSREMCOMPRA' )
		loColeccion.Agregar( 'B','ITEMARTICULOSCANCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOREMCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOCANCOMPRA' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSREMC' )
		loColeccion.Agregar( 'B','ITEMIMPUESTOSCANC' )
		loColeccion.Agregar( 'B','PROPIEDADESLISTADOS' )
		loColeccion.Agregar( 'B','AJUSTEDECUPON' )
		loColeccion.Agregar( 'B','BOLSASYCAJAS' )
		loColeccion.Agregar( 'B','ITEMBOLSASYCAJAS' )
		loColeccion.Agregar( 'B','AJUSTECCCLIENTE' )
		loColeccion.Agregar( 'B','ITEMAJUSTECCCLIENTE' )
		loColeccion.Agregar( 'B','ITEMAJUSTECCPROVEEDOR' )
		loColeccion.Agregar( 'B','AJUSTECCPROVEEDOR' )
		loColeccion.Agregar( 'B','CANCELACIONDESENIAS' )
		loColeccion.Agregar( 'B','ITEMCANCELACIONDESENIAS' )
		loColeccion.Agregar( 'B','GTIN' )
		loColeccion.Agregar( 'B','ITEMEQUIGTIN' )
		loColeccion.Agregar( 'B','PASAJEDESTOCK' )
		loColeccion.Agregar( 'B','SELECCIONBASESARCHIVADAS' )
		loColeccion.Agregar( 'B','PRECARGAETIART' )
		loColeccion.Agregar( 'B','NUEVOENBASEA' )
		loColeccion.Agregar( 'B','ITEMCOMPROBANTESENBASEA' )
		loColeccion.Agregar( 'B','LISTADEPRECIOSCALCULADA' )
		loColeccion.Agregar( 'B','REGISTRODEACTIVIDAD' )
		loColeccion.Agregar( 'B','CONCILIACIONDECAJA' )
		loColeccion.Agregar( 'SUIOPTQDGHJKLMWN','POOLDECLASE' )
		loColeccion.Agregar( 'SUIOPTQDGHJKLMWN','ACCESOAOBJETO' )
		loColeccion.Agregar( 'B','ITEMMONEDASDETARJETA' )
		loColeccion.Agregar( 'SUIOPTQDGHJKLMWN','EXPRESIONLISTADOPERSONALIZADO' )
		loColeccion.Agregar( 'B','ITEMCOMISIONVENDEDOR' )
		loColeccion.Agregar( 'B','CUPONESHUERFANOS' )
		loColeccion.Agregar( 'B','ITEMCUPONHUERFANO' )
		loColeccion.Agregar( 'B','NOMENCLADORARBA' )
		loColeccion.Agregar( 'B','GRUPO' )
		loColeccion.Agregar( 'B','CLASIFICACIONARTICULO' )
		loColeccion.Agregar( 'B','UNIDADDEMEDIDAARBA' )
		loColeccion.Agregar( 'B','REMITOELECTRONICO' )
		loColeccion.Agregar( 'B','DESTINODESCARGACHEQUES' )
		loColeccion.Agregar( 'B','DESCARGADECHEQUES' )
		loColeccion.Agregar( 'B','ITEMDESCARGACHEQUE' )
		loColeccion.Agregar( 'B','FACTURADEEXPORTACION' )
		loColeccion.Agregar( 'B','NOTADECREDITODEEXPORTACION' )
		loColeccion.Agregar( 'B','NOTADEDEBITODEEXPORTACION' )
		loColeccion.Agregar( 'B','EDICIONIMPUESTOIVACOMPRAS' )
		loColeccion.Agregar( 'B','ITEMIVACOMPRAS' )
		loColeccion.Agregar( 'B','REGISTRODEBAJA' )
		loColeccion.Agregar( 'B','NOMBREDEFANTASIA' )
		loColeccion.Agregar( 'B','TIPODEDIRECCION' )
		loColeccion.Agregar( 'B','CONTACTO' )
		loColeccion.Agregar( 'B','TIPOCLIENTE' )
		loColeccion.Agregar( 'B','CATEGORIACLIENTE' )
		loColeccion.Agregar( 'B','CRITERIOSVALORES' )
		loColeccion.Agregar( 'B','DESPACHODEIMPORTACION' )
		loColeccion.Agregar( 'B','SELECCIONDESPACHO' )
		loColeccion.Agregar( 'SUIOPQDGHJKLMN','REGISTRODESALUDSERVIDORDEDATOS' )
		loColeccion.Agregar( 'B','REGIMENIMPOSITIVO' )
		loColeccion.Agregar( 'B','CLASIFICACIONCONCEPTOPAGO' )
		loColeccion.Agregar( 'B','CONCEPTOPAGO' )
		loColeccion.Agregar( 'B','COMPROBANTEPAGO' )
		loColeccion.Agregar( 'B','ITEMCOMPROBANTEPAGO' )
		loColeccion.Agregar( 'B','ITEMVALORESCOMPROPAGO' )
		loColeccion.Agregar( 'B','COMPROBANTEDERETENCIONESIVA' )
		loColeccion.Agregar( 'B','COMPROBANTEDERETENCIONESGANANCIAS' )
		loColeccion.Agregar( 'B','COMPROBANTEDERETENCIONESSUSS' )
		loColeccion.Agregar( 'B','CONDICIONDEPAGO' )
		loColeccion.Agregar( 'SIPDJN','ITEMPAGOSPERSONALIZADOS' )
		loColeccion.Agregar( 'B','TIPODEOPERACIONAFIP' )
		loColeccion.Agregar( 'B','ASOCIACIONARTICULOSOPERACIONESAFIP' )
		loColeccion.Agregar( 'B','FERIADO' )
		loColeccion.Agregar( 'B','ITEMFERIADO' )
		loColeccion.Agregar( 'B','REGISTRODEACTIVIDADDET' )
		loColeccion.Agregar( 'B','DATOSADICIONALESCOMPROBANTESA' )
		loColeccion.Agregar( 'B','AGRUPAMIENTOPUBLICACIONES' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLIC' )
		loColeccion.Agregar( 'B','CONCEPTOLIQUIDACIONTARJETA' )
		loColeccion.Agregar( 'B','LIQUIDACIONDIARIA' )
		loColeccion.Agregar( 'B','LIQUIDACIONMENSUAL' )
		loColeccion.Agregar( 'B','PLANDECUENTAS' )
		loColeccion.Agregar( 'B','MAILPORLOTE' )
		loColeccion.Agregar( 'B','EMAIL' )
		loColeccion.Agregar( 'B','CUENTACORREO' )
		loColeccion.Agregar( 'B','COMPROBANTEDERETENCIONRECIBIDO' )
		loColeccion.Agregar( 'B','DATOSRETENCIONRECIBIDO' )
		loColeccion.Agregar( 'B','REPORTEELECTRONICO' )
		loColeccion.Agregar( 'B','COMPLETARDESDEVENTAS' )
		loColeccion.Agregar( 'B','CENTRODECOSTO' )
		loColeccion.Agregar( 'B','DISTRIBUCIONCENTRODECOSTO' )
		loColeccion.Agregar( 'B','ASIENTO' )
		loColeccion.Agregar( 'B','RAZONSOCIAL' )
		loColeccion.Agregar( 'B','EJERCICIO' )
		loColeccion.Agregar( 'B','ASIGNARZBD' )
		loColeccion.Agregar( 'B','IMPDIRVAL' )
		loColeccion.Agregar( 'B','IMPDIRART' )
		loColeccion.Agregar( 'B','IMPDIRCLI' )
		loColeccion.Agregar( 'B','IMPDIRPRO' )
		loColeccion.Agregar( 'B','IMPDIRIMP' )
		loColeccion.Agregar( 'B','IMPDIRCAJ' )
		loColeccion.Agregar( 'B','IMPDIRCON' )
		loColeccion.Agregar( 'B','IMPDIRDES' )
		loColeccion.Agregar( 'B','IMPDIROPE' )
		loColeccion.Agregar( 'B','IMPDIRLIQ' )
		loColeccion.Agregar( 'B','IMPVERCC' )
		loColeccion.Agregar( 'B','IMPDIRCCA' )
		loColeccion.Agregar( 'B','IMPDIRCCC' )
		loColeccion.Agregar( 'B','ASIENTOSPERIODICOS' )
		loColeccion.Agregar( 'B','APERTURAEJERCICIO' )
		loColeccion.Agregar( 'B','CONTABILIZACION' )
		loColeccion.Agregar( 'B','ASIENTOTIPO' )
		loColeccion.Agregar( 'B','CIERREEJERCICIO' )
		loColeccion.Agregar( 'B','ENTREGADEMERCADERIAS' )
		loColeccion.Agregar( 'B','ITEMREMITOS' )
		loColeccion.Agregar( 'B','ECOMMERCE' )
		loColeccion.Agregar( 'B','CLIENTEECOMMERCE' )
		loColeccion.Agregar( 'B','OPERACIONECOMMERCE' )
		loColeccion.Agregar( 'B','ITEMPUBLICACIONECOM' )
		loColeccion.Agregar( 'B','COMPROBANTESECOMMERCE' )
		loColeccion.Agregar( 'B','ITEMOPERACIONESECOM' )
		loColeccion.Agregar( 'B','PUNTOSDEVENTA' )
		loColeccion.Agregar( 'B','DATOSADICIONALESSIPRIB' )
		loColeccion.Agregar( 'B','SERVICIOREST' )
		loColeccion.Agregar( 'B','CLAVESECRETAREST' )
		loColeccion.Agregar( 'B','AGRUPALISTADOSPERSONALIZADOS' )
		loColeccion.Agregar( 'B','REPORTEAUDITORIACIERREZ' )
		loColeccion.Agregar( 'B','MOTIVODESCUENTOYDEVOLUCION' )
		loColeccion.Agregar( 'B','CODIGOAUTORIZACIONDJCP' )
		loColeccion.Agregar( 'B','ARQUEODECAJA' )
		loColeccion.Agregar( 'E','ITEMDESCUENTO' )
		loColeccion.Agregar( 'B','CODIGODESERVICIO' )
		loColeccion.Agregar( 'B','TIPODEORDEN' )
		loColeccion.Agregar( 'B','ESTADOSDEINTERACCION' )
		loColeccion.Agregar( 'B','INTERACCIONDEORDEN' )
		loColeccion.Agregar( 'B','ENTIDADADICIONAL1' )
		loColeccion.Agregar( 'B','ENTIDADADICIONAL2' )
		loColeccion.Agregar( 'B','ENTIDADADICIONAL3' )
		loColeccion.Agregar( 'B','ORDENDESERVICIO' )
		loColeccion.Agregar( 'B','SELECCIONORDENDESERVICIO' )
		loColeccion.Agregar( 'B','SELECCIONOPERACIONECOMMERCE' )
		loColeccion.Agregar( 'B','GESTIONVENDEDOR' )
		loColeccion.Agregar( 'B','FILTRARCOMPROBANTESACONTROLAR' )
		loColeccion.Agregar( 'B','COTIZACION' )
		loColeccion.Agregar( 'B','EMAILENCOMPROBANTE' )
		loColeccion.Agregar( 'B','SELECCIONCOMPROBANTEASOCIADO' )
		loColeccion.Agregar( 'B','FACTURAELECTRONICADECREDITO' )
		loColeccion.Agregar( 'B','NOTADECREDITOELECTRONICADECREDITO' )
		loColeccion.Agregar( 'B','NOTADEDEBITOELECTRONICADECREDITO' )
		loColeccion.Agregar( 'B','CONFIRMACIONFECHAVTOMIPYME' )
		loColeccion.Agregar( 'B','NUEVOENTREGAONLINE' )
		loColeccion.Agregar( 'B','SELECCIONDISENOIMPORTACION' )
		loColeccion.Agregar( 'B','ENVIODEMENSAJERIA' )
		loColeccion.Agregar( 'B','DATOSTAREAPROGRAMADAECOMMERCE' )
		loColeccion.Agregar( 'E','ITEMPLATAFORMAS' )
		loColeccion.Agregar( 'B','ITEMPARTICIPANTES' )
		loColeccion.Agregar( 'E','ITEMKITS' )
		loColeccion.Agregar( 'B','VALORESENTRANSITO' )
		loColeccion.Agregar( 'B','CONFIRMACIONVALORESENTRANSITO' )
		loColeccion.Agregar( 'B','DATOSTRANSACCIONBANCARIA' )
		loColeccion.Agregar( 'B','REGISTRODECUENTA' )
		loColeccion.Agregar( 'B','TRANSFERENCIAENTRECUENTAS' )
		loColeccion.Agregar( 'B','COMPLETARDATOSREGISTRO' )
		loColeccion.Agregar( 'B','ITEMDATOSREGISTRO' )
		loColeccion.Agregar( 'B','CONCEPTOENTIDADFINANCIERA' )
		loColeccion.Agregar( 'B','MOVIMIENTOBANCARIO' )
		loColeccion.Agregar( 'B','CONCILIACIONES' )
		loColeccion.Agregar( 'B','ITEMMOVBANCARIOS' )
		loColeccion.Agregar( 'B','ITEMREGCONCILIABLES' )
		loColeccion.Agregar( 'B','HERRAMIENTACONCILIACION' )
		loColeccion.Agregar( 'B','ITEMMOVBANCARIOSTOOL' )
		loColeccion.Agregar( 'B','ITEMREGCONCILIABLESTOOL' )
		loColeccion.Agregar( 'B','TIPODECOMPROBANTEDECOMPRA' )
		loColeccion.Agregar( 'B','DEUDADECHEQUES' )
		loColeccion.Agregar( 'B','CHEQUESDISPONIBLES' )
		loColeccion.Agregar( 'B','ITEMCHEQUEDISPONIBLE' )
		loColeccion.Agregar( 'B','CODBARRAALTER' )
		loColeccion.Agregar( 'B','PREPARACIONDEMERCADERIA' )
		loColeccion.Agregar( 'B','FACTURAAGRUPADA' )
		loColeccion.Agregar( 'B','NOTADECREDITOAGRUPADA' )
		loColeccion.Agregar( 'B','NOTADEDEBITOAGRUPADA' )
		loColeccion.Agregar( 'E','ITEMERRORESECOMMERCE' )
		loColeccion.Agregar( 'B','DATOSADICIONALESSIRE' )
		loColeccion.Agregar( 'B','HERRAMIENTAAGRUPADORADEPACKS' )
		loColeccion.Agregar( 'B','LINKQRENETIQUETA' )
		loColeccion.Agregar( 'B','WEBHOOK' )
		loColeccion.Agregar( 'SUIOPTQDGHJKLMN','TIQUETDECAMBIO' )
		loColeccion.Agregar( 'B','PERSONALIZACIONDEENTIDADES' )
		loColeccion.Agregar( 'B','DIRECCIONENTREGAENCOMPROBANTE' )
		loColeccion.Agregar( 'B','FECHACANCELACION' )
		loColeccion.Agregar( 'B','MARCA' )
		loColeccion.Agregar( 'B','ETIQUETASECOMMERCE' )
		loColeccion.Agregar( 'B','CATEGORIASECOMMERCE' )
		loColeccion.Agregar( 'B','CONFIGURACIONARTICULOECOMMERCE' )
		loColeccion.Agregar( 'B','ITEMCATEGORIASECOM' )
		loColeccion.Agregar( 'B','ITEMETIQUETASECOM' )
		loColeccion.Agregar( 'B','ITEMDIMENSIONESECOM' )
		loColeccion.Agregar( 'B','CATEGORIASGOOGLESHOPPING' )
		loColeccion.Agregar( 'B','APERTURAAUTOMATICAENTIDADES' )
		loColeccion.Agregar( 'B','OPEECOMENPROCESO' )
		loColeccion.Agregar( 'B','CAEA' )
		loColeccion.Agregar( 'B','CAEAINFORMA' )
		loColeccion.Agregar( 'B','ITEMCAEAINFORMA' )
		loColeccion.Agregar( 'B','MAQUINARIA' )
		loColeccion.Agregar( 'B','CONSUMOPRODUCCION' )
		loColeccion.Agregar( 'B','ITEMMAQUINARIACONSUMO' )
		loColeccion.Agregar( 'B','CLASIFICACIONPRODUCCION' )
		loColeccion.Agregar( 'B','RUBROPRODUCCION' )
		loColeccion.Agregar( 'B','TIPIFICACIONPRODUCCION1' )
		loColeccion.Agregar( 'B','TIPIFICACIONPRODUCCION2' )
		loColeccion.Agregar( 'B','VENDEDORENCOMPROBANTE' )
		loColeccion.Agregar( 'B','CONDICIONDEPAGOENCOMPROBANTE' )
		loColeccion.Agregar( 'B','INVENTARIO' )
		loColeccion.Agregar( 'B','INSUMO' )
		loColeccion.Agregar( 'B','CURVADEPRODUCCION' )
		loColeccion.Agregar( 'B','MOTIVODESCARTE' )
		loColeccion.Agregar( 'B','TALLER' )
		loColeccion.Agregar( 'B','PROCESOPRODUCCION' )
		loColeccion.Agregar( 'DJN','ITEMVALEDECAMBIO' )
		loColeccion.Agregar( 'B','FILTRARCOMPROBANTESAINSERTAR' )
		loColeccion.Agregar( 'B','SELECOMPAINSERTAR' )
		loColeccion.Agregar( 'B','ITEMSELECOMPAINSERTAR' )
		loColeccion.Agregar( 'JD','INFORMEVENTASLPS' )
		loColeccion.Agregar( 'B','SELECCHEQUETERCEROS' )
		loColeccion.Agregar( 'B','SELECHEQUEAINSERTAR' )
		loColeccion.Agregar( 'B','ITEMSELECHEQUEAINSERTAR' )
		loColeccion.Agregar( 'B','RETIRODEEFECTIVO' )
		loColeccion.Agregar( 'B','GESTIONCHCUSTODIA' )
		loColeccion.Agregar( 'B','ITEMCHCUSTODIA' )
		loColeccion.Agregar( 'B','GENERADORTOKEN' )
		loColeccion.Agregar( 'B','LISTADECOSTOSDEPRODUCCION' )
		loColeccion.Agregar( 'B','MODIFICACIONDECOSTOSDEPRODUCCION' )
		loColeccion.Agregar( 'B','COTIZACIONGESTIONDEORDENDEPRODUCCION' )
		loColeccion.Agregar( 'B','LIQUIDACIONDETALLER' )
		loColeccion.Agregar( 'B','COSTODEINSUMO' )
		loColeccion.Agregar( 'B','PROCESARNCPENDIENTEPROMOBANCO' )
		loColeccion.Agregar( 'B','ALIVIODECAJA' )
		loColeccion.Agregar( 'B','ITEMALIVIO' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICDJC' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICCOS' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICDES' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICEA1' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICEA2' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICEA3' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICEDI' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICINO' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICMAR' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICMDD' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICODS' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICSDC' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICTDO' )
		loColeccion.Agregar( 'B','ITEMAGRUPAPUBLICWHK' )
		return loColeccion
	endfunc

*------------------------------------------------------------------------------------
	Function ObtenerEstructuraPrecios() as String
		local lcRetorno
		lcRetorno = "select * from PRECIOAR where 1 = 0"
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerSelectConsultaPrecios( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean ) as String
		local lcRetorno
		lcRetorno = "Select PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, ( select Funciones.ObtenerTimestampVigenteDeLaCombinacion(PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "') ) as TIMESTAMPA, '" + tcListaPrecios + "' as ListaPre   From PRECIOAR" + ;
		' Inner Join LPRECIO on PRECIOAR.LISTAPRE = LPRECIO.LPR_NUMERO and LPRECIO.LPR_NUMERO = [' + tcListaPrecios + '] Inner Join ART on PRECIOAR.ARTICULO = ART.ARTCOD Left Join COL on PRECIOAR.COLORES = COL.COLCOD'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerSelectPreciosVigentes( tdFechaVigencia as Date, tcListaPrecios as String ) as String
		local lcRetorno
		lcRetorno = "Select SB.LISTAPRE, SB.ARTICULO, SB.COLORES, SB.TALLE, SB.FECHAVIG, SB.TIMESTAMPA, SB.PDIRECTO " + ;
		"From ( " + ;
		"Select LISTAPRE, ARTICULO, COLORES, TALLE, FECHAVIG, TIMESTAMPA, PDIRECTO , Row_Number() Over( Partition By LISTAPRE, ARTICULO, COLORES, TALLE Order By FECHAVIG Desc, TIMESTAMPA Desc ) Prioridad " + ;
		"From PRECIOAR " + ;
		"Where LISTAPRE = [" + tcListaPrecios + "] and FECHAVIG <= [" + dtos( tdFechaVigencia ) + "] " + ;
		") as SB Where SB.Prioridad = 1 "
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerSelectConsultaPreciosConPrecioActual( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "Select distinct PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, ( select Funciones.ObtenerTimestampVigenteDeLaCombinacion(PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "') ) as TIMESTAMPA, '" + tcListaPrecios + "' as ListaPre " + ;
		", ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL  From PRECIOAR" + ;
		' Inner Join LPRECIO on PRECIOAR.LISTAPRE = LPRECIO.LPR_NUMERO and LPRECIO.LPR_NUMERO = [' + tcListaPrecios + '] Inner Join ART on PRECIOAR.ARTICULO = ART.ARTCOD Left Join COL on PRECIOAR.COLORES = COL.COLCOD'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerFuncionPrecioRealDeLaCombinacionConVigencia( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, ( select Funciones.ObtenerTimestampVigenteDeLaCombinacion(PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "') ) as TIMESTAMPA, '" + tcListaPrecios + "' as ListaPre " + ;
		", ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL  "
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerFuncionPrecioRealParticipantesKitsYPacksConVigencia( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(KitPartDet.IPPART, KitPartDet.IPCOLOR, KitPartDet.IPTALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) * KitPartDet.CANT ) as PDIRECTO, ( select Funciones.ObtenerTimestampVigenteDeLaCombinacion(ARTICULO, COLORES, TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "') ) as TIMESTAMPA, '" + tcListaPrecios + "' as ListaPre " + ;
		", ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(ARTICULO, COLORES, TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL  "
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerFuncionPrecioRealDelStockConVigencia( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(COMB.COART, COMB.COCOL, COMB.COTLL, '" + tcListaPrecios + "', '" + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, '" + tcListaPrecios + "' as ListaPre , ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(COMB.COART, COMB.COCOL, COMB.COTLL, '" + tcListaActual + "', '" + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL "
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerWhereConsultaPrecios() as String
		local lcRetorno
		lcRetorno = "PRECIOAR.ARTICULO != [' + rtrim( goRegistry.Felino.CodigoDeArticuloSena ) + '] and PRECIOAR.ARTICULO >= [' + This.f_ARTICULO_Desde_PK + '] and PRECIOAR.ARTICULO <= [' + This.f_ARTICULO_Hasta_PK + '] and " + ;
			"PRECIOAR.COLORES >= [' + This.f_COLOR_Desde_PK + '] and PRECIOAR.COLORES <= [' + This.f_COLOR_Hasta_PK + '] and " + ;
			"PRECIOAR.TALLE >= [' + This.f_TALLE_Desde + '] and PRECIOAR.TALLE <= [' + This.f_TALLE_Hasta + '] and " + ;
			"ART.ARTFAB >= [' + This.f_ARTICULO_PROVEEDOR_Desde_PK + '] and ART.ARTFAB <= [' + This.f_ARTICULO_PROVEEDOR_Hasta_PK + '] and " + ;
			"ART.ARTUNI >= [' + This.f_ARTICULO_UNIDAD_Desde_PK + '] and ART.ARTUNI <= [' + This.f_ARTICULO_UNIDAD_Hasta_PK + '] and " + ;
			"ART.AMATE >= [' + This.f_ARTICULO_MATERIAL_Desde_PK + '] and ART.AMATE <= [' + This.f_ARTICULO_MATERIAL_Hasta_PK + '] and " + ;
			"ART.AESTA >= ' + transform( This.f_ARTICULO_ESTACION_Desde ) + ' and ART.AESTA <= ' + transform( This.f_ARTICULO_ESTACION_Hasta ) + ' and " + ;
			"ART.AANO >= [' + This.f_ARTICULO_ANIO_Desde + '] and ART.AANO <= [' + This.f_ARTICULO_ANIO_Hasta + '] and " + ;
			"DTos( ART.FALTAFW ) >= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Desde ) + '] and DTos( ART.FALTAFW ) <= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Hasta ) + '] and " + ;
			"ART.ASTOCK >= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Desde ) + ' and ART.ASTOCK <= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Hasta ) + ' and " + ;
			"ART.ARTNARBA >= [' + This.f_ARTICULO_NOMENCLADOR_Desde_PK + '] and ART.ARTNARBA <= [' + This.f_ARTICULO_NOMENCLADOR_Hasta_PK + '] and " + ;
			"ART.CLASIFART >= [' + This.f_ARTICULO_CLASIFICACION_Desde_PK + '] and ART.CLASIFART <= [' + This.f_ARTICULO_CLASIFICACION_Hasta_PK + '] and " + ;
			"PRECIOAR.TimestampA >= ' + transform( This.f_TIMESTAMPALTA_Desde ) + ' and PRECIOAR.TimestampA <= ' + transform( This.f_TIMESTAMPALTA_Hasta ) + ' and " + ;
			"PRECIOAR.PDIRECTO >= ' + transform( This.f_PRECIODIRECTO_Desde ) + ' and PRECIOAR.PDIRECTO <= ' + transform( This.f_PRECIODIRECTO_Hasta ) + ' and " + ;
			"ART.Marca >= [' + This.f_ARTICULO_MARCA_Desde_PK + '] and ART.Marca <= [' + This.f_ARTICULO_MARCA_Hasta_PK + ']"
		lcRetorno = lcRetorno + " and ( PRECIOAR.COLORES= [] or COL.COLCOD is not null )" 
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerWhereArticuloDeProveedor() as String
		return " where ART.ARTFAB"
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerAgrupamientoyOrdenConsultaPrecios() as String
		local lcRetorno
		lcRetorno = " group by PRECIOAR.ARTICULO, PRECIOAR.COLORES, PRECIOAR.TALLE " + ;
					"order by PRECIOAR.ARTICULO + PRECIOAR.COLORES + PRECIOAR.TALLE "
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerTablasConsultaPrecios() as String
		local lcRetorno
		lcRetorno = 'PRECIOAR'
		lcRetorno = lcRetorno + ',ART'
		lcRetorno = lcRetorno + ',COL'
		lcRetorno = lcRetorno + ',LPRECIO'
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerTablasParticipantes() as String
		local lcRetorno
		lcRetorno = 'KitPartDet'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerCampoClaveArticulo() as String
		local lcRetorno
		lcRetorno = 'ARTCOD'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerLeftJoinsCombinacion() as String
		local lcRetorno
		lcRetorno = ' left join COMB on COMB.COART = ART.ARTCOD '
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerLeftJoinsCombinacionPrecios() as String
		local lcRetorno
		lcRetorno = ' left join PRECIOAR on COMB.COART = PRECIOAR.ARTICULO and COMB.COCOL = PRECIOAR.COLORES and COMB.COTLL = PRECIOAR.TALLE '
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerCampoClavePrimariaParticipantes() as String
		local lcRetorno
		lcRetorno = 'KitPartDet.CODIGO'
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerSelectStockArticulo() as String
		local lcRetorno
		lcRetorno = 'Select ART.* From ART'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerWhereStockArticulo() as String
		local lcRetorno
			lcRetorno = "ART.ARTCOD >= [' + This.f_ARTICULO_Desde_PK + '] and ART.ARTCOD <= [' + This.f_ARTICULO_Hasta_PK + '] and " + ;
			"ART.ARTCOD != [' + rtrim( goRegistry.Felino.CodigoDeArticuloSena ) + '] and " + ;
			"ART.ARTFAB >= [' + This.f_ARTICULO_PROVEEDOR_Desde_PK + '] and ART.ARTFAB <= [' + This.f_ARTICULO_PROVEEDOR_Hasta_PK + '] and " + ;
			"ART.ARTUNI >= [' + This.f_ARTICULO_UNIDAD_Desde_PK + '] and ART.ARTUNI <= [' + This.f_ARTICULO_UNIDAD_Hasta_PK + '] and " + ;
			"ART.AMATE >= [' + This.f_ARTICULO_MATERIAL_Desde_PK + '] and ART.AMATE <= [' + This.f_ARTICULO_MATERIAL_Hasta_PK + '] and " + ;
			"ART.AESTA >= ' + transform( This.f_ARTICULO_ESTACION_Desde ) + ' and ART.AESTA <= ' + transform( This.f_ARTICULO_ESTACION_Hasta ) + ' and " + ;
			"ART.AANO >= [' + This.f_ARTICULO_ANIO_Desde + '] and ART.AANO <= [' + This.f_ARTICULO_ANIO_Hasta + '] and " + ;
			"DTos( ART.FALTAFW ) >= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Desde ) + '] and DTos( ART.FALTAFW ) <= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Hasta ) + '] and " + ;
			"ART.ASTOCK >= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Desde ) + ' and ART.ASTOCK <= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Hasta ) + ' and " + ;
			"ART.ARTNARBA >= [' + This.f_ARTICULO_NOMENCLADOR_Desde_PK + '] and ART.ARTNARBA <= [' + This.f_ARTICULO_NOMENCLADOR_Hasta_PK + '] and " + ;
			"ART.CLASIFART >= [' + This.f_ARTICULO_CLASIFICACION_Desde_PK + '] and ART.CLASIFART <= [' + This.f_ARTICULO_CLASIFICACION_Hasta_PK + '] and " + ;
			"ART.Marca >= [' + This.f_ARTICULO_MARCA_Desde_PK + '] and ART.Marca <= [' + This.f_ARTICULO_MARCA_Hasta_PK + ']"
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerTablasStockArticulo() as String
		local lcRetorno
		lcRetorno = 'ART'
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerSelectStockArticuloCombinacionConPrecios( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "Select COMB.COART, COMB.COCOL, COMB.COTLL, ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(COMB.COART, COMB.COCOL, COMB.COTLL, '" + tcListaPrecios + "', '" + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, '" + tcListaPrecios + "' as ListaPre , ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(COMB.COART, COMB.COCOL, COMB.COTLL, '" + tcListaActual + "', '" + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL From COMB Inner Join ART on COMB.COART = ART.ARTCOD Left Join COL on COMB.COCOL = COL.COLCOD"
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerSelectStockArticuloCombinacion() as String
		local lcRetorno
		lcRetorno = 'Select COMB.* From COMB Inner Join ART on COMB.COART = ART.ARTCOD Left Join COL on COMB.COCOL = COL.COLCOD'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerWhereStockArticuloCombinacion() as String
		local lcRetorno
		lcRetorno = ;
			"ART.ARTCOD != [' + rtrim( goRegistry.Felino.CodigoDeArticuloSena ) + '] and " + ;
			"COMB.COART >= [' + This.f_ARTICULO_Desde_PK + '] and COMB.COART <= [' + This.f_ARTICULO_Hasta_PK + '] and " + ;
			"COMB.COCOL >= [' + This.f_COLOR_Desde_PK + '] and COMB.COCOL <= [' + This.f_COLOR_Hasta_PK + '] and " + ;
			"COMB.COTLL >= [' + This.f_TALLE_Desde + '] and COMB.COTLL <= [' + This.f_TALLE_Hasta + '] and " + ;
			"ART.ARTFAB >= [' + This.f_ARTICULO_PROVEEDOR_Desde_PK + '] and ART.ARTFAB <= [' + This.f_ARTICULO_PROVEEDOR_Hasta_PK + '] and " + ;
			"ART.ARTUNI >= [' + This.f_ARTICULO_UNIDAD_Desde_PK + '] and ART.ARTUNI <= [' + This.f_ARTICULO_UNIDAD_Hasta_PK + '] and " + ;
			"ART.AMATE >= [' + This.f_ARTICULO_MATERIAL_Desde_PK + '] and ART.AMATE <= [' + This.f_ARTICULO_MATERIAL_Hasta_PK + '] and " + ;
			"ART.AESTA >= ' + transform( This.f_ARTICULO_ESTACION_Desde ) + ' and ART.AESTA <= ' + transform( This.f_ARTICULO_ESTACION_Hasta ) + ' and " + ;
			"ART.AANO >= [' + This.f_ARTICULO_ANIO_Desde + '] and ART.AANO <= [' + This.f_ARTICULO_ANIO_Hasta + '] and " + ;
			"DTos( ART.FALTAFW ) >= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Desde ) + '] and DTos( ART.FALTAFW ) <= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Hasta ) + '] and " + ;
			"ART.ASTOCK >= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Desde ) + ' and ART.ASTOCK <= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Hasta ) + ' and " + ;
			"ART.ARTNARBA >= [' + This.f_ARTICULO_NOMENCLADOR_Desde_PK + '] and ART.ARTNARBA <= [' + This.f_ARTICULO_NOMENCLADOR_Hasta_PK + '] and " + ;
			"ART.CLASIFART >= [' + This.f_ARTICULO_CLASIFICACION_Desde_PK + '] and ART.CLASIFART <= [' + This.f_ARTICULO_CLASIFICACION_Hasta_PK + '] and " + ;
			"ART.Marca >= [' + This.f_ARTICULO_MARCA_Desde_PK + '] and ART.Marca <= [' + This.f_ARTICULO_MARCA_Hasta_PK + ']"
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerTablasStockCombinacion() as String
		local lcRetorno
		lcRetorno = 'COMB'
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerTablasStockArticuloCombinacion() as String
		local lcRetorno
		lcRetorno = 'COMB'
		lcRetorno = lcRetorno + ',ART'
		lcRetorno = lcRetorno + ',COL'
		return lcRetorno
	endfunc

*------------------------------------------------------------------------------------
	Function ObtenerSentenciaInsertAtributosArticulos( tcCursor as String ) as String
		return '( ARTICULO ) values ( ' + tcCursor + '.' + 'ARTCOD )' 
	endfunc
	*------------------------------------------------------------------------------------
	Function ObtenerSentenciaInsertAtributosCombinacion( tcCursor as String ) as String
		return '( ARTICULO, COLORES, TALLE ) values ( ' + tcCursor + '.' + 'COART, ' + tcCursor + '.' + 'COCOL, ' + tcCursor + '.' + 'COTLL )' 
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerCamposEstadosDeStock() as string
		return 'CANTIDAD,PEDCOMPRA,PEDIDO,PRECOMPRA,PREPARADO,PRESUPUESTADO,REQCOMPRA,SENIADO,SOLCOMPRA'
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerCamposAtributosCombinacionDeStock() as string
		return 'COART, COCOL, COTLL'
	endfunc

	*----------------------------------------------
	Function ObtenerRelacionEntreComprobantes() As String
		with this

			text to .cXmlRelacionEntreComprobantes NoShow
<?xml version = "1.0" encoding="Windows-1252" standalone="yes"?>
<VFPData>
	<xsd:schema id="VFPData" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
		<xsd:element name="VFPData" msdata:IsDataSet="true">
			<xsd:complexType>
				<xsd:choice maxOccurs="unbounded">
					<xsd:element name="row" minOccurs="0" maxOccurs="unbounded">
						<xsd:complexType>
							<xsd:attribute name="idcomp" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="10"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="idcompafectado" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="10"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="modifica_stock" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="version_exe" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="4"/>
										<xsd:fractionDigits value="2"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="version_zoo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="4"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="version_cli" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="4"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="modi_afestock" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="_idregistro" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
						</xsd:complexType>
					</xsd:element>
				</xsd:choice>
				<xsd:anyAttribute namespace="http://www.w3.org/XML/1998/namespace" processContents="lax"/>
			</xsd:complexType>
		</xsd:element>
	</xsd:schema>
	<row idcomp="1" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="1"/>
	<row idcomp="2" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="2"/>
	<row idcomp="3" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="3"/>
	<row idcomp="3" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="4"/>
	<row idcomp="5" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="5"/>
	<row idcomp="5" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="6"/>
	<row idcomp="3" idcompafectado="12" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="7"/>
	<row idcomp="5" idcompafectado="12" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="8"/>
	<row idcomp="12" idcompafectado="11" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="9"/>
	<row idcomp="11" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="10"/>
	<row idcomp="23" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="11"/>
	<row idcomp="1" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="12"/>
	<row idcomp="1" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="13"/>
	<row idcomp="1" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="14"/>
	<row idcomp="2" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="15"/>
	<row idcomp="2" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="16"/>
	<row idcomp="2" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="17"/>
	<row idcomp="27" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="18"/>
	<row idcomp="27" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="19"/>
	<row idcomp="27" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="20"/>
	<row idcomp="33" idcompafectado="35" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="21"/>
	<row idcomp="3" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="22"/>
	<row idcomp="5" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="23"/>
	<row idcomp="28" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="24"/>
	<row idcomp="28" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="25"/>
	<row idcomp="28" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="26"/>
	<row idcomp="35" idcompafectado="33" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="27"/>
	<row idcomp="12" idcompafectado="23" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="28"/>
	<row idcomp="12" idcompafectado="25" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="29"/>
	<row idcomp="41" idcompafectado="38" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="30"/>
	<row idcomp="8" idcompafectado="41" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="31"/>
	<row idcomp="8" idcompafectado="38" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="32"/>
	<row idcomp="47" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="33"/>
	<row idcomp="47" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="34"/>
	<row idcomp="47" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="35"/>
	<row idcomp="47" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="36"/>
	<row idcomp="48" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="37"/>
	<row idcomp="48" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="38"/>
	<row idcomp="48" idcompafectado="12" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="39"/>
	<row idcomp="48" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="40"/>
	<row idcomp="47" idcompafectado="48" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="41"/>
	<row idcomp="48" idcompafectado="47" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="42"/>
	<row idcomp="4" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="43"/>
	<row idcomp="6" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="44"/>
	<row idcomp="49" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="45"/>
	<row idcomp="33" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="46"/>
	<row idcomp="11" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="47"/>
	<row idcomp="11" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="48"/>
	<row idcomp="11" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="49"/>
	<row idcomp="54" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="50"/>
	<row idcomp="54" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="51"/>
	<row idcomp="54" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="52"/>
	<row idcomp="54" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="53"/>
	<row idcomp="54" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="54"/>
	<row idcomp="54" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="55"/>
	<row idcomp="27" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="56"/>
	<row idcomp="54" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="57"/>
	<row idcomp="1" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="58"/>
	<row idcomp="2" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="59"/>
	<row idcomp="55" idcompafectado="12" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="60"/>
	<row idcomp="55" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="61"/>
	<row idcomp="55" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="62"/>
	<row idcomp="55" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="63"/>
	<row idcomp="55" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="64"/>
	<row idcomp="28" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="65"/>
	<row idcomp="56" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="66"/>
	<row idcomp="3" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="67"/>
	<row idcomp="11" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="68"/>
	<row idcomp="5" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="69"/>
	<row idcomp="48" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="70"/>
	<row idcomp="47" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="71"/>
	<row idcomp="3" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="72"/>
	<row idcomp="3" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="73"/>
	<row idcomp="3" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="74"/>
	<row idcomp="3" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="75"/>
	<row idcomp="5" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="76"/>
	<row idcomp="5" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="77"/>
	<row idcomp="5" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="78"/>
	<row idcomp="5" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="79"/>
	<row idcomp="28" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="80"/>
	<row idcomp="28" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="81"/>
	<row idcomp="28" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="82"/>
	<row idcomp="28" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="83"/>
	<row idcomp="55" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="84"/>
	<row idcomp="55" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="85"/>
	<row idcomp="55" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="86"/>
	<row idcomp="55" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="87"/>
	<row idcomp="35" idcompafectado="36" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="88"/>
	<row idcomp="48" idcompafectado="49" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="89"/>
	<row idcomp="57" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="90"/>
	<row idcomp="57" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="91"/>
	<row idcomp="1" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="92"/>
	<row idcomp="2" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="93"/>
	<row idcomp="11" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="94"/>
	<row idcomp="12" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="95"/>
	<row idcomp="27" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="96"/>
	<row idcomp="33" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="97"/>
	<row idcomp="47" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="98"/>
	<row idcomp="54" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="99"/>
	<row idcomp="51" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="100"/>
	<row idcomp="51" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="101"/>
	<row idcomp="51" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="102"/>
	<row idcomp="51" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="103"/>
	<row idcomp="51" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="104"/>
	<row idcomp="51" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="105"/>
	<row idcomp="51" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="106"/>
	<row idcomp="51" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="107"/>
	<row idcomp="52" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="108"/>
	<row idcomp="52" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="109"/>
	<row idcomp="52" idcompafectado="12" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="110"/>
	<row idcomp="52" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="111"/>
	<row idcomp="52" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="112"/>
	<row idcomp="52" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="113"/>
	<row idcomp="52" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="114"/>
	<row idcomp="52" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="115"/>
	<row idcomp="52" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="116"/>
	<row idcomp="53" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="117"/>
</VFPData>

			endtext
		endwith
		return this.cXmlRelacionEntreComprobantes
	endfunc

	*----------------------------------------------
	Function ObtenerEntidadesMenuPrincipalItems() As String
			this.cXmlEstructuraEntidadesMenuPrincipalItems = filetostr(this.cPathBase+'Din_ADNEntidadesMenu.xml')
		return this.cXmlEstructuraEntidadesMenuPrincipalItems
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerColeccionEntidadesConMenu() as object
		local loColeccion as zoocoleccion OF zoocoleccion.prg
		loColeccion = _screen.zoo.CrearObjeto( 'ZooColeccion' )
		loColeccion.Agregar( 'AGRUPAMIENTO','AGRUPAMIENTO' )
		loColeccion.Agregar( 'AGRUPAMIENTODEBUZONES','AGRUPAMIENTODEBUZONES' )
		loColeccion.Agregar( 'AJUSTEDEESTADOS','AJUSTEDEESTADOS' )
		loColeccion.Agregar( 'AJUSTEDESTOCK','AJUSTEDESTOCK' )
		loColeccion.Agregar( 'ALIVIODECAJA','ALIVIODECAJA' )
		loColeccion.Agregar( 'APERTURAAUTOMATICAENTIDADES','APERTURAAUTOMATICAENTIDADES' )
		loColeccion.Agregar( 'ARQUEODECAJA','ARQUEODECAJA' )
		loColeccion.Agregar( 'ARTICULO','ARTICULO' )
		loColeccion.Agregar( 'ASIENTO','ASIENTO' )
		loColeccion.Agregar( 'ACCIONESAUTOMATICAS','ACCIONESAUTOMATICAS' )
		loColeccion.Agregar( 'BANCO','BANCO' )
		loColeccion.Agregar( 'BASEDEDATOS','BASEDEDATOS' )
		loColeccion.Agregar( 'BUZON','BUZON' )
		loColeccion.Agregar( 'CAEA','CAEA' )
		loColeccion.Agregar( 'CAEAINFORMA','CAEAINFORMA' )
		loColeccion.Agregar( 'CAEPORLOTE','CAEPORLOTE' )
		loColeccion.Agregar( 'CANCELACIONDESENIAS','CANCELACIONDESENIAS' )
		loColeccion.Agregar( 'CATEGORIASECOMMERCE','CATEGORIASECOMMERCE' )
		loColeccion.Agregar( 'CATEGORIASGOOGLESHOPPING','CATEGORIASGOOGLESHOPPING' )
		loColeccion.Agregar( 'CENTRODECOSTO','CENTRODECOSTO' )
		loColeccion.Agregar( 'CHEQUE','CHEQUE' )
		loColeccion.Agregar( 'CIERREDELOTE','CIERREDELOTE' )
		loColeccion.Agregar( 'CLASEDETARJETA','CLASEDETARJETA' )
		loColeccion.Agregar( 'CLIENTE','CLIENTE' )
		loColeccion.Agregar( 'CLIENTEECOMMERCE','CLIENTEECOMMERCE' )
		loColeccion.Agregar( 'CODIGOAUTORIZACIONDJCP','CODIGOAUTORIZACIONDJCP' )
		loColeccion.Agregar( 'CODIGODESERVICIO','CODIGODESERVICIO' )
		loColeccion.Agregar( 'COLOR','COLOR' )
		loColeccion.Agregar( 'COMPROBANTEDECAJA','COMPROBANTEDECAJA' )
		loColeccion.Agregar( 'COMPROBANTEPAGO','COMPROBANTEPAGO' )
		loColeccion.Agregar( 'COMPROBANTESECOMMERCE','COMPROBANTESECOMMERCE' )
		loColeccion.Agregar( 'CONCEPTOCAJA','CONCEPTOCAJA' )
		loColeccion.Agregar( 'CONCEPTOLIQUIDACIONTARJETA','CONCEPTOLIQUIDACIONTARJETA' )
		loColeccion.Agregar( 'CONCEPTOPAGO','CONCEPTOPAGO' )
		loColeccion.Agregar( 'CONCILIACIONDECAJA','CONCILIACIONDECAJA' )
		loColeccion.Agregar( 'CONDICIONDEPAGO','CONDICIONDEPAGO' )
		loColeccion.Agregar( 'CONDICIONIMPO','CONDICIONIMPO' )
		loColeccion.Agregar( 'CONFIGURACIONARTICULOECOMMERCE','CONFIGURACIONARTICULOECOMMERCE' )
		loColeccion.Agregar( 'CONSUMOCLIENTE','CONSUMOCLIENTE' )
		loColeccion.Agregar( 'CONTACTO','CONTACTO' )
		loColeccion.Agregar( 'CONVERSION','CONVERSION' )
		loColeccion.Agregar( 'CONVERSIONVALORES','CONVERSIONVALORES' )
		loColeccion.Agregar( 'COTIZACION','COTIZACION' )
		loColeccion.Agregar( 'CUPON','CUPON' )
		loColeccion.Agregar( 'CAJAESTADO','CAJAESTADO' )
		loColeccion.Agregar( 'CATEGORIACLIENTE','CATEGORIACLIENTE' )
		loColeccion.Agregar( 'CLASIFICACIONCLIENTE','CLASIFICACIONCLIENTE' )
		loColeccion.Agregar( 'DATOSFISCALES','DATOSFISCALES' )
		loColeccion.Agregar( 'DATOSTARJETA','DATOSTARJETA' )
		loColeccion.Agregar( 'DESPACHODEIMPORTACION','DESPACHODEIMPORTACION' )
		loColeccion.Agregar( 'DEVOLUCION','DEVOLUCION' )
		loColeccion.Agregar( 'DISENOEXPO','DISENOEXPO' )
		loColeccion.Agregar( 'DISENOIMPO','DISENOIMPO' )
		loColeccion.Agregar( 'DISENOIMPRESION','DISENOIMPRESION' )
		loColeccion.Agregar( 'DISTRIBUCIONCENTRODECOSTO','DISTRIBUCIONCENTRODECOSTO' )
		loColeccion.Agregar( 'ECOMMERCE','ECOMMERCE' )
		loColeccion.Agregar( 'ENTIDADADICIONAL1','ENTIDADADICIONAL1' )
		loColeccion.Agregar( 'ENTIDADADICIONAL2','ENTIDADADICIONAL2' )
		loColeccion.Agregar( 'ENTIDADADICIONAL3','ENTIDADADICIONAL3' )
		loColeccion.Agregar( 'ENTREGADEMERCADERIAS','ENTREGADEMERCADERIAS' )
		loColeccion.Agregar( 'ESTADOSDEINTERACCION','ESTADOSDEINTERACCION' )
		loColeccion.Agregar( 'ETIQUETASECOMMERCE','ETIQUETASECOMMERCE' )
		loColeccion.Agregar( 'EXPOAGRUPADAS','EXPOAGRUPADAS' )
		loColeccion.Agregar( 'EQUIVALENCIA','EQUIVALENCIA' )
		loColeccion.Agregar( 'FACTURA','FACTURA' )
		loColeccion.Agregar( 'FACTURADECOMPRA','FACTURADECOMPRA' )
		loColeccion.Agregar( 'FACTURADEEXPORTACION','FACTURADEEXPORTACION' )
		loColeccion.Agregar( 'FACTURAELECTRONICA','FACTURAELECTRONICA' )
		loColeccion.Agregar( 'FERIADO','FERIADO' )
		loColeccion.Agregar( 'FORMATOEXPORTACION','FORMATOEXPORTACION' )
		loColeccion.Agregar( 'GESTIONVENDEDOR','GESTIONVENDEDOR' )
		loColeccion.Agregar( 'GRUPOVALOR','GRUPOVALOR' )
		loColeccion.Agregar( 'IMPOAGRUPADAS','IMPOAGRUPADAS' )
		loColeccion.Agregar( 'IMPRIMIRCOMPROBANTEPORLOTE','IMPRIMIRCOMPROBANTEPORLOTE' )
		loColeccion.Agregar( 'IMPUESTO','IMPUESTO' )
		loColeccion.Agregar( 'INTERACCIONDEORDEN','INTERACCIONDEORDEN' )
		loColeccion.Agregar( 'IMPRESIONDEETIQUETA','IMPRESIONDEETIQUETA' )
		loColeccion.Agregar( 'LIMITECONSUMO','LIMITECONSUMO' )
		loColeccion.Agregar( 'LIQUIDACIONDIARIA','LIQUIDACIONDIARIA' )
		loColeccion.Agregar( 'LIQUIDACIONMENSUAL','LIQUIDACIONMENSUAL' )
		loColeccion.Agregar( 'LISTADEPRECIOS','LISTADEPRECIOS' )
		loColeccion.Agregar( 'LISTADEPRECIOSCALCULADA','LISTADEPRECIOSCALCULADA' )
		loColeccion.Agregar( 'MARCA','MARCA' )
		loColeccion.Agregar( 'MATERIAL','MATERIAL' )
		loColeccion.Agregar( 'MINIMOREPOSICION','MINIMOREPOSICION' )
		loColeccion.Agregar( 'MODIFICACIONPRECIOS','MODIFICACIONPRECIOS' )
		loColeccion.Agregar( 'MONEDAEXTRANJERA','MONEDAEXTRANJERA' )
		loColeccion.Agregar( 'MOTIVO','MOTIVO' )
		loColeccion.Agregar( 'MOTIVODESCUENTOYDEVOLUCION','MOTIVODESCUENTOYDEVOLUCION' )
		loColeccion.Agregar( 'MOVIMIENTODESTOCK','MOVIMIENTODESTOCK' )
		loColeccion.Agregar( 'NOMBREDEFANTASIA','NOMBREDEFANTASIA' )
		loColeccion.Agregar( 'NOMENCLADORARBA','NOMENCLADORARBA' )
		loColeccion.Agregar( 'NOTADECREDITO','NOTADECREDITO' )
		loColeccion.Agregar( 'NOTADECREDITODEEXPORTACION','NOTADECREDITODEEXPORTACION' )
		loColeccion.Agregar( 'NOTADECREDITOELECTRONICA','NOTADECREDITOELECTRONICA' )
		loColeccion.Agregar( 'NOTADEDEBITO','NOTADEDEBITO' )
		loColeccion.Agregar( 'NOTADEDEBITODEEXPORTACION','NOTADEDEBITODEEXPORTACION' )
		loColeccion.Agregar( 'NOTADEDEBITOELECTRONICA','NOTADEDEBITOELECTRONICA' )
		loColeccion.Agregar( 'NUMERACIONES','NUMERACIONES' )
		loColeccion.Agregar( 'OPERACIONECOMMERCE','OPERACIONECOMMERCE' )
		loColeccion.Agregar( 'OPERADORADETARJETA','OPERADORADETARJETA' )
		loColeccion.Agregar( 'ORDENDEPAGO','ORDENDEPAGO' )
		loColeccion.Agregar( 'ORDENDESERVICIO','ORDENDESERVICIO' )
		loColeccion.Agregar( 'ORIGENDEDATOS','ORIGENDEDATOS' )
		loColeccion.Agregar( 'PAISES','PAISES' )
		loColeccion.Agregar( 'PEDIDO','PEDIDO' )
		loColeccion.Agregar( 'PERCEPCION','PERCEPCION' )
		loColeccion.Agregar( 'PLANDECUENTAS','PLANDECUENTAS' )
		loColeccion.Agregar( 'POS','POS' )
		loColeccion.Agregar( 'PROVEEDOR','PROVEEDOR' )
		loColeccion.Agregar( 'PROVINCIA','PROVINCIA' )
		loColeccion.Agregar( 'PUNTOSDEVENTA','PUNTOSDEVENTA' )
		loColeccion.Agregar( 'PICKING','PICKING' )
		loColeccion.Agregar( 'PRESUPUESTO','PRESUPUESTO' )
		loColeccion.Agregar( 'RECIBO','RECIBO' )
		loColeccion.Agregar( 'REMITO','REMITO' )
		loColeccion.Agregar( 'REPORTEAUDITORIACIERREZ','REPORTEAUDITORIACIERREZ' )
		loColeccion.Agregar( 'REPORTEELECTRONICO','REPORTEELECTRONICO' )
		loColeccion.Agregar( 'REGLASTRANSFERENCIAS','REGLASTRANSFERENCIAS' )
		loColeccion.Agregar( 'SCRIPT','SCRIPT' )
		loColeccion.Agregar( 'SENIA','SENIA' )
		loColeccion.Agregar( 'TALONARIO','TALONARIO' )
		loColeccion.Agregar( 'TICKETFACTURA','TICKETFACTURA' )
		loColeccion.Agregar( 'TICKETNOTADECREDITO','TICKETNOTADECREDITO' )
		loColeccion.Agregar( 'TICKETNOTADEDEBITO','TICKETNOTADEDEBITO' )
		loColeccion.Agregar( 'TIDIFERENCIASDEINVENTARIO','TIDIFERENCIASDEINVENTARIO' )
		loColeccion.Agregar( 'TIDIFERENCIASDEINVENTARIODETALLE','TIDIFERENCIASDEINVENTARIODETALLE' )
		loColeccion.Agregar( 'TIINVENTARIOACONT','TIINVENTARIOACONT' )
		loColeccion.Agregar( 'TIINVENTARIOFISICO','TIINVENTARIOFISICO' )
		loColeccion.Agregar( 'TIINVENTARIOFISICODETALLE','TIINVENTARIOFISICODETALLE' )
		loColeccion.Agregar( 'TIPODEDIRECCION','TIPODEDIRECCION' )
		loColeccion.Agregar( 'TIPODEORDEN','TIPODEORDEN' )
		loColeccion.Agregar( 'TIPOIMPUESTO','TIPOIMPUESTO' )
		loColeccion.Agregar( 'TRANSPORTISTA','TRANSPORTISTA' )
		loColeccion.Agregar( 'TIPOCLIENTE','TIPOCLIENTE' )
		loColeccion.Agregar( 'UNIDADDEMEDIDAARBA','UNIDADDEMEDIDAARBA' )
		loColeccion.Agregar( 'VALEDECAMBIO','VALEDECAMBIO' )
		loColeccion.Agregar( 'VALOR','VALOR' )
		loColeccion.Agregar( 'VALORESENTRANSITO','VALORESENTRANSITO' )
		loColeccion.Agregar( 'VENDEDOR','VENDEDOR' )
		loColeccion.Agregar( 'WEBHOOK','WEBHOOK' )
		return loColeccion
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerCamposAtributosCombinacionConcatenados() as string
		return 'ARTICULO, COLORES, TALLE'
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerValidacionesDeFiltrosDeDescuentos() as String
		local lcRetorno as String
		
		text to lcRetorno textmerge noshow
			iif( .nEvitar = 3, .T., this.ValidarCaracteres( .ListaDesde, .ListaHasta, this.oEntidadPadre.LISTADEPRECIOS_PK ) ) and iif( .nEvitar = 1, .T., this.ValidarCaracteres( .Cliente_ClasificacionCDesde, .Cliente_ClasificacionCHasta, this.oEntidadPadre.CLIENTE.Clasificacion_PK ) ) and iif( .nEvitar = 1, .T., this.ValidarCaracteres( .Cliente_TipoCDesde, .Cliente_TipoCHasta, this.oEntidadPadre.CLIENTE.TipoCli_PK ) ) and iif( .nEvitar = 1, .T., this.ValidarCaracteres( .Cliente_CategoriaCDesde, .Cliente_CategoriaCHasta, this.oEntidadPadre.CLIENTE.CategCli_PK ) ) and iif( .nEvitar = 2, .T., this.ValidarCaracteres( .VendDesde, .VendHasta, this.oEntidadPadre.VENDEDOR_PK ) ) and .T.
		endtext
		
		return lcRetorno
	endfunc

*-----------------------------------------------------------------------------------------
	Function ObtenerAtributosDeFiltrosDeDescuentos() as Object
		local loRetorno
		
		loRetorno = _screen.zoo.crearobjeto( 'ZooColeccion' )
		loRetorno.add( 'ListaDesde' )
		loRetorno.add( 'ListaHasta' )
		loRetorno.add( 'VendHasta' )
		loRetorno.add( 'Cliente_ClasificacionCDesde' )
		loRetorno.add( 'Cliente_ClasificacionCHasta' )
		loRetorno.add( 'Cliente_TipoCDesde' )
		loRetorno.add( 'Cliente_TipoCHasta' )
		loRetorno.add( 'Cliente_CategoriaCDesde' )
		loRetorno.add( 'Cliente_CategoriaCHasta' )
		loRetorno.add( 'VendDesde' )
		
		return loRetorno
	endfunc



enddefine
*-----------------------------------------------------------------------------------------
define class ItemAcceso as custom
	id = ''
	entidad = ''
	item = ''
	itempadre = ''
	tipoopcion = ''
	Orden = 0
	nivel = 0
	Rama = ''
	Operacion = ''
	Descripcion = ''
	Modo = 2
	ModoPerfil = 2
	Usuario = ''
	Fecha = ctot( '' )
	lEliminar = .f.
	dtUltimoAcceso = ctot( '' )
	nIndice = 0
enddefine

*-----------------------------------------------------------------------------------------
define class ItemMotivo as custom
	entidad = ''
	Atributo = ''
	Campo = ''
enddefine
