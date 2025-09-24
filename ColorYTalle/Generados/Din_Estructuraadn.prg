
*------------------------------------------------------------------------------------
define class Din_EstructuraAdn as zoosession of zoosession.prg
	cXml = ''
	cXmlIndice = ''
	cXmlOperacionesMenu = ''
	cXmlOperacionesEntidades = ''
	cXmlEstructuraEntidadesMenuPrincipalItems = ''
	cProyecto = 'ColoryTalle'
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
			case upper( alltrim( tcEntidad ) ) = 'RECIBO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTEDESTOCK'
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
			case upper( alltrim( tcEntidad ) ) = 'MODIFICACIONPRECIOS'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'MOVIMIENTODESTOCK'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'DATOSFISCALES'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'MERCADERIAENTRANSITO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'REMITO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'RECIBO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTEDESTOCK'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'PEDIDO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'ORDENDEPAGO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'PAGO'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTEDEESTADOS'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'COMPROBANTEDERETENCIONES'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'PEDIDODECOMPRA'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTECCCLIENTE'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'AJUSTECCPROVEEDOR'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'GTIN'
				llRetorno = .F.
			case upper( alltrim( tcEntidad ) ) = 'ITEMEQUIGTIN'
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
			.Agregar( '6','COLOR' )
			.Agregar( '10','VENDEDOR' )
			.Agregar( '15','ARTICULO' )
			.Agregar( '10','PROVEEDOR' )
			.Agregar( '10','CLIENTE' )
			.Agregar( '10','MATERIAL' )
			.Agregar( '20','COMPROBANTEDECAJA' )
			.Agregar( '5','TALLE' )
			.Agregar( '5','TEMPORADA' )
			.Agregar( '20','MODIFICACIONPRECIOS' )
			.Agregar( '38','VALEDECAMBIO' )
			.Agregar( '3','UNIDADDEMEDIDA' )
			.Agregar( '10','FAMILIA' )
			.Agregar( '10','LINEA' )
			.Agregar( '10','GRUPO' )
			.Agregar( '10','CATEGORIADEARTICULO' )
			.Agregar( '10','CLASIFICACIONARTICULO' )
			.Agregar( '10','TIPODEARTICULO' )
			.Agregar( '15','TRANSPORTISTA' )
			.Agregar( '10','FORMULA' )
			.Agregar( '20','MINIMOREPOSICION' )
			.Agregar( '10','CLASIFICACIONCONCEPTOCAJA' )
			.Agregar( '10','CLIENTERECOMENDANTE' )
			.Agregar( '20','ASIENTO' )
			.Agregar( '10','CLIENTEECOMMERCE' )
			.Agregar( '20','SERVICIOREST' )
			.Agregar( '20','DATOSADICIONALESSIPRIB' )
			.Agregar( '20','INTERACCIONDEORDEN' )
			.Agregar( '20','ORDENDESERVICIO' )
			.Agregar( '20','GESTIONVENDEDOR' )
			.Agregar( '20','VALORESENTRANSITO' )
			.Agregar( '20','REGISTRODECUENTA' )
			.Agregar( '10','CONCEPTOENTIDADFINANCIERA' )
			.Agregar( '20','MOVIMIENTOBANCARIO' )
			.Agregar( '40','WEBHOOK' )
			.Agregar( '30','MARCA' )
			.Agregar( '20','AJUSTECHEQUERECHAZADO' )
			.Agregar( '20','MODIFICACIONDECOSTOSDEPRODUCCION' )
			.Agregar( '20','REGISTRODECOSTOS' )
		endwith
		return loAtributosPk
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerColeccionEntidadesConMotivo() as zoocoleccion
		Local loEntidad as zoocoleccion OF zoocoleccion.prg
			loEntidad  = _screen.zoo.crearObjeto( 'zoocoleccion' )
		with this 
.AgregarItemMotivoyOrigenDestino( loEntidad, 'AJUSTECHEQUERECHAZADO','MotivoAjuste','AjMotivo')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'BOLSASYCAJAS','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'CANCELACIONDECOMPRA','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'DEVOLUCION','Motivo','MOTIVO')
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
.AgregarItemMotivoyOrigenDestino( loEntidad, 'SOLICITUDDECOMPRA','Motivo','MOTIVO')
.AgregarItemMotivoyOrigenDestino( loEntidad, 'TIDIFERENCIASDEINVENTARIO','MSMotivo','MSMOTIVO')
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
.AgregarItemMotivoyOrigenDestino( loEntidad, 'TIDIFERENCIASDEINVENTARIO','MSOrigenDestino','MSORIGDEST')
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
		loLogCopia.inicializar( tcSucursalDestino, tcRutaDestino , 98)

		lcSucOrigen = 'o_' + strtran( strtran( strtran( alltrim( tcSucursalOrigen ), '-', '' ), ' ', ''), '.', '')
		lcSucDestino = 'd_' + strtran( strtran( strtran( alltrim( tcSucursalDestino ), '-', '' ), ' ', ''), '.', '')
		try
			*----------AGRUPUB001----------------------------
			lcTabla = 'AGRUPUB001'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB001'
			lcTablaDestino = lcSucDestino + '_AGRUPUB001'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB001' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB001' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB003----------------------------
			lcTabla = 'AGRUPUB003'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB003'
			lcTablaDestino = lcSucDestino + '_AGRUPUB003'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB003' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB003' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB010----------------------------
			lcTabla = 'AGRUPUB010'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB010'
			lcTablaDestino = lcSucDestino + '_AGRUPUB010'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB010' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB010' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB056----------------------------
			lcTabla = 'AGRUPUB056'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB056'
			lcTablaDestino = lcSucDestino + '_AGRUPUB056'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB056' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB056' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB131----------------------------
			lcTabla = 'AGRUPUB131'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB131'
			lcTablaDestino = lcSucDestino + '_AGRUPUB131'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB131' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB131' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB132----------------------------
			lcTabla = 'AGRUPUB132'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB132'
			lcTablaDestino = lcSucDestino + '_AGRUPUB132'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB132' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB132' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB150----------------------------
			lcTabla = 'AGRUPUB150'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB150'
			lcTablaDestino = lcSucDestino + '_AGRUPUB150'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB150' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB150' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB153----------------------------
			lcTabla = 'AGRUPUB153'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB153'
			lcTablaDestino = lcSucDestino + '_AGRUPUB153'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB153' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB153' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB205----------------------------
			lcTabla = 'AGRUPUB205'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB205'
			lcTablaDestino = lcSucDestino + '_AGRUPUB205'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB205' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB205' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB206----------------------------
			lcTabla = 'AGRUPUB206'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB206'
			lcTablaDestino = lcSucDestino + '_AGRUPUB206'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB206' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB206' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUB208----------------------------
			lcTabla = 'AGRUPUB208'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUB208'
			lcTablaDestino = lcSucDestino + '_AGRUPUB208'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUB208' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUB208' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBADC----------------------------
			lcTabla = 'AGRUPUBADC'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBADC'
			lcTablaDestino = lcSucDestino + '_AGRUPUBADC'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBADC' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBADC' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBAJR----------------------------
			lcTabla = 'AGRUPUBAJR'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBAJR'
			lcTablaDestino = lcSucDestino + '_AGRUPUBAJR'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBAJR' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBAJR' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBART----------------------------
			lcTabla = 'AGRUPUBART'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBART'
			lcTablaDestino = lcSucDestino + '_AGRUPUBART'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBART' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBART' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCAV----------------------------
			lcTabla = 'AGRUPUBCAV'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCAV'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCAV'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCAV' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCAV' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCBA----------------------------
			lcTabla = 'AGRUPUBCBA'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCBA'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCBA'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCBA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCBA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCCA----------------------------
			lcTabla = 'AGRUPUBCCA'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCCA'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCCA'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCCA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCCA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCDP----------------------------
			lcTabla = 'AGRUPUBCDP'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCDP'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCDP'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCDP' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCDP' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCDT----------------------------
			lcTabla = 'AGRUPUBCDT'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCDT'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCDT'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCDT' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCDT' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCLA----------------------------
			lcTabla = 'AGRUPUBCLA'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCLA'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCLA'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCLA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCLA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCLT----------------------------
			lcTabla = 'AGRUPUBCLT'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCLT'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCLT'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCLT' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCLT' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCOM----------------------------
			lcTabla = 'AGRUPUBCOM'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCOM'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCOM'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCOM' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCOM' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBCOS----------------------------
			lcTabla = 'AGRUPUBCOS'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBCOS'
			lcTablaDestino = lcSucDestino + '_AGRUPUBCOS'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBCOS' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBCOS' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBDES----------------------------
			lcTabla = 'AGRUPUBDES'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBDES'
			lcTablaDestino = lcSucDestino + '_AGRUPUBDES'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBDES' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBDES' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBDET----------------------------
			lcTabla = 'AGRUPUBDET'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBDET'
			lcTablaDestino = lcSucDestino + '_AGRUPUBDET'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBDET' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBDET' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBDFI----------------------------
			lcTabla = 'AGRUPUBDFI'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBDFI'
			lcTablaDestino = lcSucDestino + '_AGRUPUBDFI'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBDFI' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBDFI' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBDJC----------------------------
			lcTabla = 'AGRUPUBDJC'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBDJC'
			lcTablaDestino = lcSucDestino + '_AGRUPUBDJC'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBDJC' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBDJC' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBEA1----------------------------
			lcTabla = 'AGRUPUBEA1'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBEA1'
			lcTablaDestino = lcSucDestino + '_AGRUPUBEA1'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBEA1' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBEA1' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBEA2----------------------------
			lcTabla = 'AGRUPUBEA2'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBEA2'
			lcTablaDestino = lcSucDestino + '_AGRUPUBEA2'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBEA2' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBEA2' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBEA3----------------------------
			lcTabla = 'AGRUPUBEA3'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBEA3'
			lcTablaDestino = lcSucDestino + '_AGRUPUBEA3'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBEA3' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBEA3' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBEDI----------------------------
			lcTabla = 'AGRUPUBEDI'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBEDI'
			lcTablaDestino = lcSucDestino + '_AGRUPUBEDI'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBEDI' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBEDI' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBENF----------------------------
			lcTabla = 'AGRUPUBENF'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBENF'
			lcTablaDestino = lcSucDestino + '_AGRUPUBENF'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBENF' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBENF' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBFER----------------------------
			lcTabla = 'AGRUPUBFER'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBFER'
			lcTablaDestino = lcSucDestino + '_AGRUPUBFER'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBFER' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBFER' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBFML----------------------------
			lcTabla = 'AGRUPUBFML'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBFML'
			lcTablaDestino = lcSucDestino + '_AGRUPUBFML'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBFML' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBFML' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBGDV----------------------------
			lcTabla = 'AGRUPUBGDV'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBGDV'
			lcTablaDestino = lcSucDestino + '_AGRUPUBGDV'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBGDV' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBGDV' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBGPV----------------------------
			lcTabla = 'AGRUPUBGPV'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBGPV'
			lcTablaDestino = lcSucDestino + '_AGRUPUBGPV'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBGPV' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBGPV' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBGRP----------------------------
			lcTabla = 'AGRUPUBGRP'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBGRP'
			lcTablaDestino = lcSucDestino + '_AGRUPUBGRP'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBGRP' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBGRP' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBIMS----------------------------
			lcTabla = 'AGRUPUBIMS'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBIMS'
			lcTablaDestino = lcSucDestino + '_AGRUPUBIMS'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBIMS' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBIMS' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBINO----------------------------
			lcTabla = 'AGRUPUBINO'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBINO'
			lcTablaDestino = lcSucDestino + '_AGRUPUBINO'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBINO' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBINO' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBLIN----------------------------
			lcTabla = 'AGRUPUBLIN'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBLIN'
			lcTablaDestino = lcSucDestino + '_AGRUPUBLIN'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBLIN' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBLIN' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBLPR----------------------------
			lcTabla = 'AGRUPUBLPR'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBLPR'
			lcTablaDestino = lcSucDestino + '_AGRUPUBLPR'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBLPR' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBLPR' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBLQR----------------------------
			lcTabla = 'AGRUPUBLQR'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBLQR'
			lcTablaDestino = lcSucDestino + '_AGRUPUBLQR'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBLQR' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBLQR' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBMAR----------------------------
			lcTabla = 'AGRUPUBMAR'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBMAR'
			lcTablaDestino = lcSucDestino + '_AGRUPUBMAR'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBMAR' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBMAR' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBMDD----------------------------
			lcTabla = 'AGRUPUBMDD'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBMDD'
			lcTablaDestino = lcSucDestino + '_AGRUPUBMDD'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBMDD' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBMDD' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBMIL----------------------------
			lcTabla = 'AGRUPUBMIL'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBMIL'
			lcTablaDestino = lcSucDestino + '_AGRUPUBMIL'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBMIL' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBMIL' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBMIN----------------------------
			lcTabla = 'AGRUPUBMIN'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBMIN'
			lcTablaDestino = lcSucDestino + '_AGRUPUBMIN'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBMIN' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBMIN' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBMON----------------------------
			lcTabla = 'AGRUPUBMON'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBMON'
			lcTablaDestino = lcSucDestino + '_AGRUPUBMON'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBMON' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBMON' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBMOT----------------------------
			lcTabla = 'AGRUPUBMOT'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBMOT'
			lcTablaDestino = lcSucDestino + '_AGRUPUBMOT'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBMOT' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBMOT' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBODS----------------------------
			lcTabla = 'AGRUPUBODS'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBODS'
			lcTablaDestino = lcSucDestino + '_AGRUPUBODS'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBODS' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBODS' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBPAI----------------------------
			lcTabla = 'AGRUPUBPAI'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBPAI'
			lcTablaDestino = lcSucDestino + '_AGRUPUBPAI'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBPAI' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBPAI' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBPR0----------------------------
			lcTabla = 'AGRUPUBPR0'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBPR0'
			lcTablaDestino = lcSucDestino + '_AGRUPUBPR0'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBPR0' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBPR0' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBPRO----------------------------
			lcTabla = 'AGRUPUBPRO'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBPRO'
			lcTablaDestino = lcSucDestino + '_AGRUPUBPRO'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBPRO' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBPRO' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBPRV----------------------------
			lcTabla = 'AGRUPUBPRV'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBPRV'
			lcTablaDestino = lcSucDestino + '_AGRUPUBPRV'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBPRV' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBPRV' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBPTC----------------------------
			lcTabla = 'AGRUPUBPTC'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBPTC'
			lcTablaDestino = lcSucDestino + '_AGRUPUBPTC'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBPTC' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBPTC' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBRED----------------------------
			lcTabla = 'AGRUPUBRED'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBRED'
			lcTablaDestino = lcSucDestino + '_AGRUPUBRED'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBRED' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBRED' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBREG----------------------------
			lcTabla = 'AGRUPUBREG'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBREG'
			lcTablaDestino = lcSucDestino + '_AGRUPUBREG'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBREG' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBREG' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBSDC----------------------------
			lcTabla = 'AGRUPUBSDC'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBSDC'
			lcTablaDestino = lcSucDestino + '_AGRUPUBSDC'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBSDC' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBSDC' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBSGR----------------------------
			lcTabla = 'AGRUPUBSGR'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBSGR'
			lcTablaDestino = lcSucDestino + '_AGRUPUBSGR'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBSGR' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBSGR' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBSMT----------------------------
			lcTabla = 'AGRUPUBSMT'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBSMT'
			lcTablaDestino = lcSucDestino + '_AGRUPUBSMT'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBSMT' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBSMT' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBTDD----------------------------
			lcTabla = 'AGRUPUBTDD'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBTDD'
			lcTablaDestino = lcSucDestino + '_AGRUPUBTDD'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBTDD' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBTDD' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBTDO----------------------------
			lcTabla = 'AGRUPUBTDO'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBTDO'
			lcTablaDestino = lcSucDestino + '_AGRUPUBTDO'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBTDO' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBTDO' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBTIM----------------------------
			lcTabla = 'AGRUPUBTIM'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBTIM'
			lcTablaDestino = lcSucDestino + '_AGRUPUBTIM'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBTIM' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBTIM' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBUDM----------------------------
			lcTabla = 'AGRUPUBUDM'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBUDM'
			lcTablaDestino = lcSucDestino + '_AGRUPUBUDM'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBUDM' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBUDM' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBVAL----------------------------
			lcTabla = 'AGRUPUBVAL'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBVAL'
			lcTablaDestino = lcSucDestino + '_AGRUPUBVAL'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBVAL' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBVAL' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBVEN----------------------------
			lcTabla = 'AGRUPUBVEN'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBVEN'
			lcTablaDestino = lcSucDestino + '_AGRUPUBVEN'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBVEN' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBVEN' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------AGRUPUBWHK----------------------------
			lcTabla = 'AGRUPUBWHK'
			lcTablaOrigen = lcSucOrigen + '_AGRUPUBWHK'
			lcTablaDestino = lcSucDestino + '_AGRUPUBWHK'
			use in 0 addbs( tcRutaDestino ) + 'AGRUPUBWHK' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'AGRUPUBWHK' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------CACEPV----------------------------
			lcTabla = 'CACEPV'
			lcTablaOrigen = lcSucOrigen + '_CACEPV'
			lcTablaDestino = lcSucDestino + '_CACEPV'
			use in 0 addbs( tcRutaDestino ) + 'CACEPV' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'CACEPV' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CANTDESDE,CANTHASTA,CDESC,CLCFI,CLOBS,CODLISTA,COMP,CUOTAS,DESDESDE,DESHASTA,DIADO,DIAJU,DIALU,DIAMA,DIAMI,DIASA,DIAVI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,FPODESD,FPODESH,FPORECD,FPORECH,HALTAFW,HMODIFW,HORADESDE,HORAEXPO,HORAHASTA,HORAIMPO,JJCO,NUMERO,RECDESDE,RECHASTA,SALTAFW,SMODIFW,SUCDESDE,SUCHASTA,TIMESTAMP,TIPAGRUPUB,TOTALDESDE,TOTALHASTA,UALTAFW,UMODIFW,VALTAFW,VDESDE,VHASTA,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CANTDESDE,CANTHASTA,CDESC,CLCFI,CLOBS,CODLISTA,COMP,CUOTAS,DESDESDE,DESHASTA,DIADO,DIAJU,DIALU,DIAMA,DIAMI,DIASA,DIAVI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,FPODESD,FPODESH,FPORECD,FPORECH,HALTAFW,HMODIFW,HORADESDE,HORAEXPO,HORAHASTA,HORAIMPO,JJCO,NUMERO,RECDESDE,RECHASTA,SALTAFW,SMODIFW,SUCDESDE,SUCHASTA,TIMESTAMP,TIPAGRUPUB,TOTALDESDE,TOTALHASTA,UALTAFW,UMODIFW,VALTAFW,VDESDE,VHASTA,VMODIFW,ZADSFW from << lcTablaOrigen >>
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

			*----------CLATARJ----------------------------
			lcTabla = 'CLATARJ'
			lcTablaOrigen = lcSucOrigen + '_CLATARJ'
			lcTablaDestino = lcSucDestino + '_CLATARJ'
			use in 0 addbs( tcRutaDestino ) + 'CLATARJ' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'CLATARJ' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CDTCODIGO,CDTDESC,CDTOBS,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CDTCODIGO,CDTDESC,CDTOBS,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_CLATARJ_CDTOBS'
				lcTablaDestino = 'd_CLATARJ_CDTOBS'
				use in 0 addbs( tcRutaDestino ) + 'CLATARJ_CDTOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'CLATARJ_CDTOBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( CDTCODIGO, Orden, Texto ) ' + ;
				'select  CDTCODIGO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_CLATARJ_ZADSFW'
				lcTablaDestino = 'd_CLATARJ_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'CLATARJ_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'CLATARJ_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( CDTCODIGO, Orden, Texto ) ' + ;
				'select  CDTCODIGO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------CODSERV----------------------------
			lcTabla = 'CODSERV'
			lcTablaOrigen = lcSucOrigen + '_CODSERV'
			lcTablaDestino = lcSucDestino + '_CODSERV'
			use in 0 addbs( tcRutaDestino ) + 'CODSERV' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'CODSERV' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCR,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,PROVEEDOR,SALTAFW,SMODIFW,TIPAGRUPUB,TIPOORDEN,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCR,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,PROVEEDOR,SALTAFW,SMODIFW,TIPAGRUPUB,TIPOORDEN,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_CODSERV_OBS'
				lcTablaDestino = 'd_CODSERV_OBS'
				use in 0 addbs( tcRutaDestino ) + 'CODSERV_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'CODSERV_OBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_CODSERV_ZADSFW'
				lcTablaDestino = 'd_CODSERV_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'CODSERV_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'CODSERV_ZADSFW' alias &lcTablaOrigen
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

			*----------COTIZA----------------------------
			lcTabla = 'COTIZA'
			lcTablaOrigen = lcSucOrigen + '_COTIZA'
			lcTablaDestino = lcSucDestino + '_COTIZA'
			use in 0 addbs( tcRutaDestino ) + 'COTIZA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'COTIZA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CODIGO,COTIZ,FECHA,HORA,NROITEM) select CODIGO,COTIZ,FECHA,HORA,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------DATOSFISCALDET----------------------------
			lcTabla = 'DATOSFISCALDET'
			lcTablaOrigen = lcSucOrigen + '_DATOSFISCALDET'
			lcTablaDestino = lcSucDestino + '_DATOSFISCALDET'
			use in 0 addbs( tcRutaDestino ) + 'DATOSFISCALDET' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'DATOSFISCALDET' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BLOQREG,CODRELA,CODUNICO,IMPUESTO,NROITEM) select BLOQREG,CODRELA,CODUNICO,IMPUESTO,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------DATOSFISCALES----------------------------
			lcTabla = 'DATOSFISCALES'
			lcTablaOrigen = lcSucOrigen + '_DATOSFISCALES'
			lcTablaDestino = lcSucDestino + '_DATOSFISCALES'
			use in 0 addbs( tcRutaDestino ) + 'DATOSFISCALES' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'DATOSFISCALES' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AFIP366814,AUTOJUR,AUTOPERR,BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DASIPRIB,DESCRIPCIO,ESTTRANS,EXPOENOP,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,JURISDSIEM,MONTOMIN,NROIIBBOBL,OBS,PERSIPRIB,REINTEGRO,RETSIPRIB,SALTAFW,SEPARAIIBB,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select AFIP366814,AUTOJUR,AUTOPERR,BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DASIPRIB,DESCRIPCIO,ESTTRANS,EXPOENOP,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,JURISDSIEM,MONTOMIN,NROIIBBOBL,OBS,PERSIPRIB,REINTEGRO,RETSIPRIB,SALTAFW,SEPARAIIBB,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_DATOSFISCALES_OBS'
				lcTablaDestino = 'd_DATOSFISCALES_OBS'
				use in 0 addbs( tcRutaDestino ) + 'DATOSFISCALES_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'DATOSFISCALES_OBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_DATOSFISCALES_ZADSFW'
				lcTablaDestino = 'd_DATOSFISCALES_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'DATOSFISCALES_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'DATOSFISCALES_ZADSFW' alias &lcTablaOrigen
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

			*----------ENTFIN----------------------------
			lcTabla = 'ENTFIN'
			lcTablaOrigen = lcSucOrigen + '_ENTFIN'
			lcTablaDestino = lcSucDestino + '_ENTFIN'
			use in 0 addbs( tcRutaDestino ) + 'ENTFIN' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'ENTFIN' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,EFCOD,EFCUIT,EFDES,EFRUT,EOBS,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,EFCOD,EFCUIT,EFDES,EFRUT,EOBS,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_ENTFIN_EOBS'
				lcTablaDestino = 'd_ENTFIN_EOBS'
				use in 0 addbs( tcRutaDestino ) + 'ENTFIN_EOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'ENTFIN_EOBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( EFCOD, Orden, Texto ) ' + ;
				'select  EFCOD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_ENTFIN_ZADSFW'
				lcTablaDestino = 'd_ENTFIN_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'ENTFIN_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'ENTFIN_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( EFCOD, Orden, Texto ) ' + ;
				'select  EFCOD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------ESCALAIMP----------------------------
			lcTabla = 'ESCALAIMP'
			lcTablaOrigen = lcSucOrigen + '_ESCALAIMP'
			lcTablaDestino = lcSucDestino + '_ESCALAIMP'
			use in 0 addbs( tcRutaDestino ) + 'ESCALAIMP' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'ESCALAIMP' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BLOQREG,CODIGO,EXCEDENTE,HASTA,MAYORA,MONTOFIJO,NROITEM,PORCENTAJE) select BLOQREG,CODIGO,EXCEDENTE,HASTA,MAYORA,MONTOFIJO,NROITEM,PORCENTAJE from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------FORMULA----------------------------
			lcTabla = 'FORMULA'
			lcTablaOrigen = lcSucOrigen + '_FORMULA'
			lcTablaDestino = lcSucDestino + '_FORMULA'
			use in 0 addbs( tcRutaDestino ) + 'FORMULA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'FORMULA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DESCRIP,ESTTRANS,EXPRESION,EXPRSQL,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DESCRIP,ESTTRANS,EXPRESION,EXPRSQL,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_FORMULA_EXPRESION'
				lcTablaDestino = 'd_FORMULA_EXPRESION'
				use in 0 addbs( tcRutaDestino ) + 'FORMULA_EXPRESION' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'FORMULA_EXPRESION' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_FORMULA_EXPRSQL'
				lcTablaDestino = 'd_FORMULA_EXPRSQL'
				use in 0 addbs( tcRutaDestino ) + 'FORMULA_EXPRSQL' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'FORMULA_EXPRSQL' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_FORMULA_OBS'
				lcTablaDestino = 'd_FORMULA_OBS'
				use in 0 addbs( tcRutaDestino ) + 'FORMULA_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'FORMULA_OBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_FORMULA_ZADSFW'
				lcTablaDestino = 'd_FORMULA_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'FORMULA_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'FORMULA_ZADSFW' alias &lcTablaOrigen
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

			*----------GRUPOVALOR----------------------------
			lcTabla = 'GRUPOVALOR'
			lcTablaOrigen = lcSucOrigen + '_GRUPOVALOR'
			lcTablaDestino = lcSucDestino + '_GRUPOVALOR'
			use in 0 addbs( tcRutaDestino ) + 'GRUPOVALOR' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'GRUPOVALOR' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,GOBS,GRUNOM,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,GOBS,GRUNOM,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_GRUPOVALOR_GOBS'
				lcTablaDestino = 'd_GRUPOVALOR_GOBS'
				use in 0 addbs( tcRutaDestino ) + 'GRUPOVALOR_GOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'GRUPOVALOR_GOBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_GRUPOVALOR_ZADSFW'
				lcTablaDestino = 'd_GRUPOVALOR_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'GRUPOVALOR_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'GRUPOVALOR_ZADSFW' alias &lcTablaOrigen
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

			*----------IMPUESTO----------------------------
			lcTabla = 'IMPUESTO'
			lcTablaOrigen = lcSucOrigen + '_IMPUESTO'
			lcTablaDestino = lcSucDestino + '_IMPUESTO'
			use in 0 addbs( tcRutaDestino ) + 'IMPUESTO' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'IMPUESTO' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (APLICAART,APLICACION,BASECALC,BDALTAFW,BDMODIFW,BLOQREG,CODIGO,COMPMBASE,COMPMMIN,COMPMPORC,COMPMREG,CONMULEXT,CONVENIO,CONVLOCAL,CONVMULTI,CONVNOINSC,DESCRIP,ESCALA,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,JURISDICCI,MAXBIENES,MAXSERV,MENALICNI,MINIMO,MONOMESES,MONOPORC,MONOREG,MONTO,OBS,PAGOCTA,PORCBASE,PORCEN5329,PORCENTAJE,REGIMEN,REGIMENIMP,RESOLU,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPO,TUCALICNI,TUCCFCERO,TUCREDALIC,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select APLICAART,APLICACION,BASECALC,BDALTAFW,BDMODIFW,BLOQREG,CODIGO,COMPMBASE,COMPMMIN,COMPMPORC,COMPMREG,CONMULEXT,CONVENIO,CONVLOCAL,CONVMULTI,CONVNOINSC,DESCRIP,ESCALA,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,JURISDICCI,MAXBIENES,MAXSERV,MENALICNI,MINIMO,MONOMESES,MONOPORC,MONOREG,MONTO,OBS,PAGOCTA,PORCBASE,PORCEN5329,PORCENTAJE,REGIMEN,REGIMENIMP,RESOLU,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPO,TUCALICNI,TUCCFCERO,TUCREDALIC,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_IMPUESTO_OBS'
				lcTablaDestino = 'd_IMPUESTO_OBS'
				use in 0 addbs( tcRutaDestino ) + 'IMPUESTO_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'IMPUESTO_OBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_IMPUESTO_ZADSFW'
				lcTablaDestino = 'd_IMPUESTO_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'IMPUESTO_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'IMPUESTO_ZADSFW' alias &lcTablaOrigen
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

			*----------LPRECIO----------------------------
			lcTabla = 'LPRECIO'
			lcTablaOrigen = lcSucOrigen + '_LPRECIO'
			lcTablaDestino = lcSucDestino + '_LPRECIO'
			use in 0 addbs( tcRutaDestino ) + 'LPRECIO' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'LPRECIO' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CANTIDAD,COEFICIENT,ESTTRANS,FALTAFW,FECEXPO,FECHAHASTA,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,LHABILITAC,LISTABASE,LOBS,LORDCONS,LPR_CONDIV,LPR_DESC,LPR_MONEDA,LPR_NOMBRE,LPR_NUMERO,LPR_REDOND,MONEDACOTI,NIVELVIS,OPERADOR,PCALCULADO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TREDONDEO,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CANTIDAD,COEFICIENT,ESTTRANS,FALTAFW,FECEXPO,FECHAHASTA,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,LHABILITAC,LISTABASE,LOBS,LORDCONS,LPR_CONDIV,LPR_DESC,LPR_MONEDA,LPR_NOMBRE,LPR_NUMERO,LPR_REDOND,MONEDACOTI,NIVELVIS,OPERADOR,PCALCULADO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TREDONDEO,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_LPRECIO_LOBS'
				lcTablaDestino = 'd_LPRECIO_LOBS'
				use in 0 addbs( tcRutaDestino ) + 'LPRECIO_LOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'LPRECIO_LOBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( LPR_NUMERO, Orden, Texto ) ' + ;
				'select  LPR_NUMERO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_LPRECIO_ZADSFW'
				lcTablaDestino = 'd_LPRECIO_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'LPRECIO_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'LPRECIO_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( LPR_NUMERO, Orden, Texto ) ' + ;
				'select  LPR_NUMERO, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------MONEDA----------------------------
			lcTabla = 'MONEDA'
			lcTablaOrigen = lcSucOrigen + '_MONEDA'
			lcTablaDestino = lcSucDestino + '_MONEDA'
			use in 0 addbs( tcRutaDestino ) + 'MONEDA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'MONEDA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,COBLIG,CODIGO,DESCRIP,EAFIP,EDGI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MCOTAFIP,MOBS,SALTAFW,SIMBOLO,SMODIFW,TIMESTAMP,TIPAGRUPUB,TOLNEG,TOLPOS,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,COBLIG,CODIGO,DESCRIP,EAFIP,EDGI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MCOTAFIP,MOBS,SALTAFW,SIMBOLO,SMODIFW,TIMESTAMP,TIPAGRUPUB,TOLNEG,TOLPOS,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_MONEDA_MOBS'
				lcTablaDestino = 'd_MONEDA_MOBS'
				use in 0 addbs( tcRutaDestino ) + 'MONEDA_MOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'MONEDA_MOBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_MONEDA_ZADSFW'
				lcTablaDestino = 'd_MONEDA_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'MONEDA_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'MONEDA_ZADSFW' alias &lcTablaOrigen
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

			*----------OPETAR----------------------------
			lcTabla = 'OPETAR'
			lcTablaOrigen = lcSucOrigen + '_OPETAR'
			lcTablaDestino = lcSucDestino + '_OPETAR'
			use in 0 addbs( tcRutaDestino ) + 'OPETAR' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'OPETAR' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,CTABANC,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,PAGADORA,PROVEEDOR,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,CTABANC,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,PAGADORA,PROVEEDOR,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_OPETAR_OBS'
				lcTablaDestino = 'd_OPETAR_OBS'
				use in 0 addbs( tcRutaDestino ) + 'OPETAR_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'OPETAR_OBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_OPETAR_ZADSFW'
				lcTablaDestino = 'd_OPETAR_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'OPETAR_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'OPETAR_ZADSFW' alias &lcTablaOrigen
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

			*----------OPETARDET----------------------------
			lcTabla = 'OPETARDET'
			lcTablaOrigen = lcSucOrigen + '_OPETARDET'
			lcTablaDestino = lcSucDestino + '_OPETARDET'
			use in 0 addbs( tcRutaDestino ) + 'OPETARDET' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'OPETARDET' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CDTCODIGO,CLTARJ,DESCRIP,ENTFIN,ENTFINDESC,NROITEM) select CDTCODIGO,CLTARJ,DESCRIP,ENTFIN,ENTFINDESC,NROITEM from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------ORDAT----------------------------
			lcTabla = 'ORDAT'
			lcTablaOrigen = lcSucOrigen + '_ORDAT'
			lcTablaDestino = lcSucDestino + '_ORDAT'
			use in 0 addbs( tcRutaDestino ) + 'ORDAT' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'ORDAT' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OOBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OOBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
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

			*----------PAISES----------------------------
			lcTabla = 'PAISES'
			lcTablaOrigen = lcSucOrigen + '_PAISES'
			lcTablaDestino = lcSucDestino + '_PAISES'
			use in 0 addbs( tcRutaDestino ) + 'PAISES' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'PAISES' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,PAAF,PCOD,PDES,POBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,PAAF,PCOD,PDES,POBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_PAISES_POBS'
				lcTablaDestino = 'd_PAISES_POBS'
				use in 0 addbs( tcRutaDestino ) + 'PAISES_POBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'PAISES_POBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( PCOD, Orden, Texto ) ' + ;
				'select  PCOD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_PAISES_ZADSFW'
				lcTablaDestino = 'd_PAISES_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'PAISES_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'PAISES_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( PCOD, Orden, Texto ) ' + ;
				'select  PCOD, Orden, Texto from ' + lcTablaOrigen
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

			*----------PROVINCI----------------------------
			lcTabla = 'PROVINCI'
			lcTablaOrigen = lcSucOrigen + '_PROVINCI'
			lcTablaDestino = lcSucDestino + '_PROVINCI'
			use in 0 addbs( tcRutaDestino ) + 'PROVINCI' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'PROVINCI' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (ARBA,BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,POBS,PRV_COD,PRV_DES,PRV_IVALIB,PRV_JUR,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select ARBA,BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,POBS,PRV_COD,PRV_DES,PRV_IVALIB,PRV_JUR,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_PROVINCI_POBS'
				lcTablaDestino = 'd_PROVINCI_POBS'
				use in 0 addbs( tcRutaDestino ) + 'PROVINCI_POBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'PROVINCI_POBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( PRV_COD, Orden, Texto ) ' + ;
				'select  PRV_COD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_PROVINCI_ZADSFW'
				lcTablaDestino = 'd_PROVINCI_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'PROVINCI_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'PROVINCI_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( PRV_COD, Orden, Texto ) ' + ;
				'select  PRV_COD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------REDO----------------------------
			lcTabla = 'REDO'
			lcTablaOrigen = lcSucOrigen + '_REDO'
			lcTablaDestino = lcSucDestino + '_REDO'
			use in 0 addbs( tcRutaDestino ) + 'REDO' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'REDO' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,REDOENT,REDOPRE,REDOTCENT,REDOTENT,RNORMAL,ROBS,RTABLA,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,REDOENT,REDOPRE,REDOTCENT,REDOTENT,RNORMAL,ROBS,RTABLA,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_REDO_ROBS'
				lcTablaDestino = 'd_REDO_ROBS'
				use in 0 addbs( tcRutaDestino ) + 'REDO_ROBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'REDO_ROBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_REDO_ZADSFW'
				lcTablaDestino = 'd_REDO_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'REDO_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'REDO_ZADSFW' alias &lcTablaOrigen
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

			*----------REGIMP----------------------------
			lcTabla = 'REGIMP'
			lcTablaOrigen = lcSucOrigen + '_REGIMP'
			lcTablaDestino = lcSucDestino + '_REGIMP'
			use in 0 addbs( tcRutaDestino ) + 'REGIMP' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'REGIMP' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPO,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPO,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_REGIMP_OBS'
				lcTablaDestino = 'd_REGIMP_OBS'
				use in 0 addbs( tcRutaDestino ) + 'REGIMP_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'REGIMP_OBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_REGIMP_ZADSFW'
				lcTablaDestino = 'd_REGIMP_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'REGIMP_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'REGIMP_ZADSFW' alias &lcTablaOrigen
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

			*----------SALTODECAMPO----------------------------
			lcTabla = 'SALTODECAMPO'
			lcTablaOrigen = lcSucOrigen + '_SALTODECAMPO'
			lcTablaDestino = lcSucDestino + '_SALTODECAMPO'
			use in 0 addbs( tcRutaDestino ) + 'SALTODECAMPO' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'SALTODECAMPO' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (ATRDESC,ATRIBUTO,BDALTAFW,BDMODIFW,CODIGO,DETALLE,ENTDESC,ENTIDAD,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MOSTRAR,NOOBLIGAAP,OBLIGA,OBS,OCULTAR,PERSETIQ,SALTA,SALTAFW,SMODIFW,TIPAGRUPUB,UALTAFW,UMODIFW,USAETIQ,USAVALSIS,USAVSANT,VALTAFW,VMODIFW,VSUGERIDO,ZADSFW) select ATRDESC,ATRIBUTO,BDALTAFW,BDMODIFW,CODIGO,DETALLE,ENTDESC,ENTIDAD,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MOSTRAR,NOOBLIGAAP,OBLIGA,OBS,OCULTAR,PERSETIQ,SALTA,SALTAFW,SMODIFW,TIPAGRUPUB,UALTAFW,UMODIFW,USAETIQ,USAVALSIS,USAVSANT,VALTAFW,VMODIFW,VSUGERIDO,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_SALTODECAMPO_OBS'
				lcTablaDestino = 'd_SALTODECAMPO_OBS'
				use in 0 addbs( tcRutaDestino ) + 'SALTODECAMPO_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'SALTODECAMPO_OBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_SALTODECAMPO_ZADSFW'
				lcTablaDestino = 'd_SALTODECAMPO_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'SALTODECAMPO_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'SALTODECAMPO_ZADSFW' alias &lcTablaOrigen
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

			*----------TARJEDET----------------------------
			lcTabla = 'TARJEDET'
			lcTablaOrigen = lcSucOrigen + '_TARJEDET'
			lcTablaDestino = lcSucDestino + '_TARJEDET'
			use in 0 addbs( tcRutaDestino ) + 'TARJEDET' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'TARJEDET' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CANTTIEMPO,COD,CUOTAS,DESCUENTO,MODOTIEMPO,MONTODESDE,NROITEM,RECARGO,TIPOMONTO) select CANTTIEMPO,COD,CUOTAS,DESCUENTO,MODOTIEMPO,MONTODESDE,NROITEM,RECARGO,TIPOMONTO from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------TIPODIR----------------------------
			lcTabla = 'TIPODIR'
			lcTablaOrigen = lcSucOrigen + '_TIPODIR'
			lcTablaDestino = lcSucDestino + '_TIPODIR'
			use in 0 addbs( tcRutaDestino ) + 'TIPODIR' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'TIPODIR' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TDCOD,TDDES,TDOBS,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TDCOD,TDDES,TDOBS,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_TIPODIR_TDOBS'
				lcTablaDestino = 'd_TIPODIR_TDOBS'
				use in 0 addbs( tcRutaDestino ) + 'TIPODIR_TDOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'TIPODIR_TDOBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( TDCOD, Orden, Texto ) ' + ;
				'select  TDCOD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_TIPODIR_ZADSFW'
				lcTablaDestino = 'd_TIPODIR_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'TIPODIR_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'TIPODIR_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( TDCOD, Orden, Texto ) ' + ;
				'select  TDCOD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------TIPOORDEN----------------------------
			lcTabla = 'TIPOORDEN'
			lcTablaOrigen = lcSucOrigen + '_TIPOORDEN'
			lcTablaDestino = lcSucDestino + '_TIPOORDEN'
			use in 0 addbs( tcRutaDestino ) + 'TIPOORDEN' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'TIPOORDEN' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCR,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCR,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_TIPOORDEN_OBS'
				lcTablaDestino = 'd_TIPOORDEN_OBS'
				use in 0 addbs( tcRutaDestino ) + 'TIPOORDEN_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'TIPOORDEN_OBS' alias &lcTablaOrigen
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
				lcTablaOrigen = 'o_TIPOORDEN_ZADSFW'
				lcTablaDestino = 'd_TIPOORDEN_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'TIPOORDEN_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'TIPOORDEN_ZADSFW' alias &lcTablaOrigen
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

			*----------UMARBA----------------------------
			lcTabla = 'UMARBA'
			lcTablaOrigen = lcSucOrigen + '_UMARBA'
			lcTablaDestino = lcSucDestino + '_UMARBA'
			use in 0 addbs( tcRutaDestino ) + 'UMARBA' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'UMARBA' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,COD,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,COD,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_UMARBA_OBS'
				lcTablaDestino = 'd_UMARBA_OBS'
				use in 0 addbs( tcRutaDestino ) + 'UMARBA_OBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'UMARBA_OBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( COD, Orden, Texto ) ' + ;
				'select  COD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_UMARBA_ZADSFW'
				lcTablaDestino = 'd_UMARBA_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'UMARBA_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'UMARBA_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( COD, Orden, Texto ) ' + ;
				'select  COD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------XVAL----------------------------
			lcTabla = 'XVAL'
			lcTablaOrigen = lcSucOrigen + '_XVAL'
			lcTablaDestino = lcSucDestino + '_XVAL'
			use in 0 addbs( tcRutaDestino ) + 'XVAL' alias &lcTablaDestino exclusive
			use in 0 addbs( tcRutaOrigen ) + 'XVAL' alias &lcTablaOrigen
			zap in ( lcTablaDestino )
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (ARQTOT,BCOADEP,BDALTAFW,BDMODIFW,BLOMODDES,CCADEP,CLCFI,CLCLAS,CLCOD,CLDESCP,CLGRUP,CLNOM,CLOBS,CLRECARGO,CLSMONET,CLVISUALIZ,CTABANC,ELECTRO,EQEPSON,EQIBM,ESTTRANS,FACTELEC,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,IDCAJA,IMPRCHQCF,LEYENDA,MNTOMAXRET,MODIFECHA,MODOREDON,NOAPLIRC,NOARRASTRA,OPETAR,PAGUESEA,PERSOCOMP,PERVUELTO,PRESTADOR,REDONDEO,RETIRAEFEC,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPOTARJ,UALTAFW,UMODIFW,VALLINCE,VALORACRED,VALORRETEF,VALTAFW,VMODIFW,ZADSFW) select ARQTOT,BCOADEP,BDALTAFW,BDMODIFW,BLOMODDES,CCADEP,CLCFI,CLCLAS,CLCOD,CLDESCP,CLGRUP,CLNOM,CLOBS,CLRECARGO,CLSMONET,CLVISUALIZ,CTABANC,ELECTRO,EQEPSON,EQIBM,ESTTRANS,FACTELEC,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,IDCAJA,IMPRCHQCF,LEYENDA,MNTOMAXRET,MODIFECHA,MODOREDON,NOAPLIRC,NOARRASTRA,OPETAR,PAGUESEA,PERSOCOMP,PERVUELTO,PRESTADOR,REDONDEO,RETIRAEFEC,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPOTARJ,UALTAFW,UMODIFW,VALLINCE,VALORACRED,VALORRETEF,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			&lcSql
			use in select( lcTablaOrigen )
			use in select( lcTablaDestino )
			try
				lcTablaOrigen = 'o_XVAL_CLOBS'
				lcTablaDestino = 'd_XVAL_CLOBS'
				use in 0 addbs( tcRutaDestino ) + 'XVAL_CLOBS' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'XVAL_CLOBS' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( CLCOD, Orden, Texto ) ' + ;
				'select  CLCOD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
			try
				lcTablaOrigen = 'o_XVAL_ZADSFW'
				lcTablaDestino = 'd_XVAL_ZADSFW'
				use in 0 addbs( tcRutaDestino ) + 'XVAL_ZADSFW' alias &lcTablaDestino exclusive
				use in 0 addbs( tcRutaOrigen ) + 'XVAL_ZADSFW' alias &lcTablaOrigen
				zap in ( lcTablaDestino )
				lcSql = 'insert into ' + lcTablaDestino + '( CLCOD, Orden, Texto ) ' + ;
				'select  CLCOD, Orden, Texto from ' + lcTablaOrigen
				&lcSql
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				use in select( lcTablaDestino ) 
				use in select( lcTablaOrigen ) 
			endtry
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
		loLogCopia.inicializar( tcSucursalDestino, 'SqlServer' , 98)

		try
			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB001' ) + '.AGRUPUB001'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB001' ) + '.AGRUPUB001'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB003' ) + '.AGRUPUB003'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB003' ) + '.AGRUPUB003'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB010' ) + '.AGRUPUB010'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB010' ) + '.AGRUPUB010'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB056' ) + '.AGRUPUB056'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB056' ) + '.AGRUPUB056'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB131' ) + '.AGRUPUB131'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB131' ) + '.AGRUPUB131'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB132' ) + '.AGRUPUB132'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB132' ) + '.AGRUPUB132'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB150' ) + '.AGRUPUB150'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB150' ) + '.AGRUPUB150'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB153' ) + '.AGRUPUB153'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB153' ) + '.AGRUPUB153'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB205' ) + '.AGRUPUB205'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB205' ) + '.AGRUPUB205'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB206' ) + '.AGRUPUB206'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB206' ) + '.AGRUPUB206'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUB208' ) + '.AGRUPUB208'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUB208' ) + '.AGRUPUB208'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBADC' ) + '.AGRUPUBADC'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBADC' ) + '.AGRUPUBADC'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBAJR' ) + '.AGRUPUBAJR'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBAJR' ) + '.AGRUPUBAJR'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBART' ) + '.AGRUPUBART'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBART' ) + '.AGRUPUBART'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCAV' ) + '.AGRUPUBCAV'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCAV' ) + '.AGRUPUBCAV'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCBA' ) + '.AGRUPUBCBA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCBA' ) + '.AGRUPUBCBA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCCA' ) + '.AGRUPUBCCA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCCA' ) + '.AGRUPUBCCA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCDP' ) + '.AGRUPUBCDP'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCDP' ) + '.AGRUPUBCDP'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCDT' ) + '.AGRUPUBCDT'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCDT' ) + '.AGRUPUBCDT'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCLA' ) + '.AGRUPUBCLA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCLA' ) + '.AGRUPUBCLA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCLT' ) + '.AGRUPUBCLT'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCLT' ) + '.AGRUPUBCLT'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCOM' ) + '.AGRUPUBCOM'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCOM' ) + '.AGRUPUBCOM'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCOS' ) + '.AGRUPUBCOS'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBCOS' ) + '.AGRUPUBCOS'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBDES' ) + '.AGRUPUBDES'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBDES' ) + '.AGRUPUBDES'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBDET' ) + '.AGRUPUBDET'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBDET' ) + '.AGRUPUBDET'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBDFI' ) + '.AGRUPUBDFI'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBDFI' ) + '.AGRUPUBDFI'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBDJC' ) + '.AGRUPUBDJC'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBDJC' ) + '.AGRUPUBDJC'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBEA1' ) + '.AGRUPUBEA1'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBEA1' ) + '.AGRUPUBEA1'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBEA2' ) + '.AGRUPUBEA2'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBEA2' ) + '.AGRUPUBEA2'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBEA3' ) + '.AGRUPUBEA3'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBEA3' ) + '.AGRUPUBEA3'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBEDI' ) + '.AGRUPUBEDI'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBEDI' ) + '.AGRUPUBEDI'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBENF' ) + '.AGRUPUBENF'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBENF' ) + '.AGRUPUBENF'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBFER' ) + '.AGRUPUBFER'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBFER' ) + '.AGRUPUBFER'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBFML' ) + '.AGRUPUBFML'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBFML' ) + '.AGRUPUBFML'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBGDV' ) + '.AGRUPUBGDV'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBGDV' ) + '.AGRUPUBGDV'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBGPV' ) + '.AGRUPUBGPV'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBGPV' ) + '.AGRUPUBGPV'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBGRP' ) + '.AGRUPUBGRP'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBGRP' ) + '.AGRUPUBGRP'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBIMS' ) + '.AGRUPUBIMS'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBIMS' ) + '.AGRUPUBIMS'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBINO' ) + '.AGRUPUBINO'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBINO' ) + '.AGRUPUBINO'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBLIN' ) + '.AGRUPUBLIN'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBLIN' ) + '.AGRUPUBLIN'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBLPR' ) + '.AGRUPUBLPR'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBLPR' ) + '.AGRUPUBLPR'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBLQR' ) + '.AGRUPUBLQR'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBLQR' ) + '.AGRUPUBLQR'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMAR' ) + '.AGRUPUBMAR'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMAR' ) + '.AGRUPUBMAR'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMDD' ) + '.AGRUPUBMDD'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMDD' ) + '.AGRUPUBMDD'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMIL' ) + '.AGRUPUBMIL'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMIL' ) + '.AGRUPUBMIL'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMIN' ) + '.AGRUPUBMIN'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMIN' ) + '.AGRUPUBMIN'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMON' ) + '.AGRUPUBMON'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMON' ) + '.AGRUPUBMON'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMOT' ) + '.AGRUPUBMOT'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBMOT' ) + '.AGRUPUBMOT'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBODS' ) + '.AGRUPUBODS'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBODS' ) + '.AGRUPUBODS'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPAI' ) + '.AGRUPUBPAI'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPAI' ) + '.AGRUPUBPAI'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPR0' ) + '.AGRUPUBPR0'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPR0' ) + '.AGRUPUBPR0'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPRO' ) + '.AGRUPUBPRO'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPRO' ) + '.AGRUPUBPRO'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPRV' ) + '.AGRUPUBPRV'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPRV' ) + '.AGRUPUBPRV'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPTC' ) + '.AGRUPUBPTC'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBPTC' ) + '.AGRUPUBPTC'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBRED' ) + '.AGRUPUBRED'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBRED' ) + '.AGRUPUBRED'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBREG' ) + '.AGRUPUBREG'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBREG' ) + '.AGRUPUBREG'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBSDC' ) + '.AGRUPUBSDC'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBSDC' ) + '.AGRUPUBSDC'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBSGR' ) + '.AGRUPUBSGR'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBSGR' ) + '.AGRUPUBSGR'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBSMT' ) + '.AGRUPUBSMT'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBSMT' ) + '.AGRUPUBSMT'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBTDD' ) + '.AGRUPUBTDD'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBTDD' ) + '.AGRUPUBTDD'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBTDO' ) + '.AGRUPUBTDO'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBTDO' ) + '.AGRUPUBTDO'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBTIM' ) + '.AGRUPUBTIM'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBTIM' ) + '.AGRUPUBTIM'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBUDM' ) + '.AGRUPUBUDM'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBUDM' ) + '.AGRUPUBUDM'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBVAL' ) + '.AGRUPUBVAL'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBVAL' ) + '.AGRUPUBVAL'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBVEN' ) + '.AGRUPUBVEN'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBVEN' ) + '.AGRUPUBVEN'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'AGRUPUBWHK' ) + '.AGRUPUBWHK'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'AGRUPUBWHK' ) + '.AGRUPUBWHK'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AGRUP,AGRUPDES,CODIGO,NROITEM) select AGRUP,AGRUPDES,CODIGO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'CACEPV' ) + '.CACEPV'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'CACEPV' ) + '.CACEPV'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CANTDESDE,CANTHASTA,CDESC,CLCFI,CLOBS,CODLISTA,COMP,CUOTAS,DESDESDE,DESHASTA,DIADO,DIAJU,DIALU,DIAMA,DIAMI,DIASA,DIAVI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,FPODESD,FPODESH,FPORECD,FPORECH,HALTAFW,HMODIFW,HORADESDE,HORAEXPO,HORAHASTA,HORAIMPO,JJCO,NUMERO,RECDESDE,RECHASTA,SALTAFW,SMODIFW,SUCDESDE,SUCHASTA,TIMESTAMP,TIPAGRUPUB,TOTALDESDE,TOTALHASTA,UALTAFW,UMODIFW,VALTAFW,VDESDE,VHASTA,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CANTDESDE,CANTHASTA,CDESC,CLCFI,CLOBS,CODLISTA,COMP,CUOTAS,DESDESDE,DESHASTA,DIADO,DIAJU,DIALU,DIAMA,DIAMI,DIASA,DIAVI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,FPODESD,FPODESH,FPORECD,FPORECH,HALTAFW,HMODIFW,HORADESDE,HORAEXPO,HORAHASTA,HORAIMPO,JJCO,NUMERO,RECDESDE,RECHASTA,SALTAFW,SMODIFW,SUCDESDE,SUCHASTA,TIMESTAMP,TIPAGRUPUB,TOTALDESDE,TOTALHASTA,UALTAFW,UMODIFW,VALTAFW,VDESDE,VHASTA,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'CLATARJ' ) + '.CLATARJ'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'CLATARJ' ) + '.CLATARJ'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CDTCODIGO,CDTDESC,CDTOBS,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CDTCODIGO,CDTDESC,CDTOBS,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'CODSERV' ) + '.CODSERV'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'CODSERV' ) + '.CODSERV'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCR,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,PROVEEDOR,SALTAFW,SMODIFW,TIPAGRUPUB,TIPOORDEN,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCR,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,PROVEEDOR,SALTAFW,SMODIFW,TIPAGRUPUB,TIPOORDEN,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'COTIZA' ) + '.COTIZA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'COTIZA' ) + '.COTIZA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CODIGO,COTIZ,FECHA,HORA,NROITEM) select CODIGO,COTIZ,FECHA,HORA,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'DATOSFISCALDET' ) + '.DATOSFISCALDET'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'DATOSFISCALDET' ) + '.DATOSFISCALDET'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BLOQREG,CODRELA,CODUNICO,IMPUESTO,NROITEM) select BLOQREG,CODRELA,CODUNICO,IMPUESTO,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'DATOSFISCALES' ) + '.DATOSFISCALES'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'DATOSFISCALES' ) + '.DATOSFISCALES'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (AFIP366814,AUTOJUR,AUTOPERR,BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DASIPRIB,DESCRIPCIO,ESTTRANS,EXPOENOP,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,JURISDSIEM,MONTOMIN,NROIIBBOBL,OBS,PERSIPRIB,REINTEGRO,RETSIPRIB,SALTAFW,SEPARAIIBB,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select AFIP366814,AUTOJUR,AUTOPERR,BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DASIPRIB,DESCRIPCIO,ESTTRANS,EXPOENOP,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,JURISDSIEM,MONTOMIN,NROIIBBOBL,OBS,PERSIPRIB,REINTEGRO,RETSIPRIB,SALTAFW,SEPARAIIBB,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
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

			*----------goServicios.Estructura.ObtenerEsquema( 'ENTFIN' ) + '.ENTFIN'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'ENTFIN' ) + '.ENTFIN'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,EFCOD,EFCUIT,EFDES,EFRUT,EOBS,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,EFCOD,EFCUIT,EFDES,EFRUT,EOBS,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'ESCALAIMP' ) + '.ESCALAIMP'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'ESCALAIMP' ) + '.ESCALAIMP'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BLOQREG,CODIGO,EXCEDENTE,HASTA,MAYORA,MONTOFIJO,NROITEM,PORCENTAJE) select BLOQREG,CODIGO,EXCEDENTE,HASTA,MAYORA,MONTOFIJO,NROITEM,PORCENTAJE from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'FORMULA' ) + '.FORMULA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'FORMULA' ) + '.FORMULA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DESCRIP,ESTTRANS,EXPRESION,EXPRSQL,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DESCRIP,ESTTRANS,EXPRESION,EXPRSQL,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'GRUPOVALOR' ) + '.GRUPOVALOR'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'GRUPOVALOR' ) + '.GRUPOVALOR'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,GOBS,GRUNOM,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,GOBS,GRUNOM,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
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

			*----------goServicios.Estructura.ObtenerEsquema( 'IMPUESTO' ) + '.IMPUESTO'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'IMPUESTO' ) + '.IMPUESTO'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (APLICAART,APLICACION,BASECALC,BDALTAFW,BDMODIFW,BLOQREG,CODIGO,COMPMBASE,COMPMMIN,COMPMPORC,COMPMREG,CONMULEXT,CONVENIO,CONVLOCAL,CONVMULTI,CONVNOINSC,DESCRIP,ESCALA,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,JURISDICCI,MAXBIENES,MAXSERV,MENALICNI,MINIMO,MONOMESES,MONOPORC,MONOREG,MONTO,OBS,PAGOCTA,PORCBASE,PORCEN5329,PORCENTAJE,REGIMEN,REGIMENIMP,RESOLU,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPO,TUCALICNI,TUCCFCERO,TUCREDALIC,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select APLICAART,APLICACION,BASECALC,BDALTAFW,BDMODIFW,BLOQREG,CODIGO,COMPMBASE,COMPMMIN,COMPMPORC,COMPMREG,CONMULEXT,CONVENIO,CONVLOCAL,CONVMULTI,CONVNOINSC,DESCRIP,ESCALA,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,JURISDICCI,MAXBIENES,MAXSERV,MENALICNI,MINIMO,MONOMESES,MONOPORC,MONOREG,MONTO,OBS,PAGOCTA,PORCBASE,PORCEN5329,PORCENTAJE,REGIMEN,REGIMENIMP,RESOLU,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPO,TUCALICNI,TUCCFCERO,TUCREDALIC,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'LPRECIO' ) + '.LPRECIO'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'LPRECIO' ) + '.LPRECIO'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CANTIDAD,COEFICIENT,ESTTRANS,FALTAFW,FECEXPO,FECHAHASTA,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,LHABILITAC,LISTABASE,LOBS,LORDCONS,LPR_CONDIV,LPR_DESC,LPR_MONEDA,LPR_NOMBRE,LPR_NUMERO,LPR_REDOND,MONEDACOTI,NIVELVIS,OPERADOR,PCALCULADO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TREDONDEO,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CANTIDAD,COEFICIENT,ESTTRANS,FALTAFW,FECEXPO,FECHAHASTA,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,LHABILITAC,LISTABASE,LOBS,LORDCONS,LPR_CONDIV,LPR_DESC,LPR_MONEDA,LPR_NOMBRE,LPR_NUMERO,LPR_REDOND,MONEDACOTI,NIVELVIS,OPERADOR,PCALCULADO,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TREDONDEO,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'MONEDA' ) + '.MONEDA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'MONEDA' ) + '.MONEDA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,COBLIG,CODIGO,DESCRIP,EAFIP,EDGI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MCOTAFIP,MOBS,SALTAFW,SIMBOLO,SMODIFW,TIMESTAMP,TIPAGRUPUB,TOLNEG,TOLPOS,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,COBLIG,CODIGO,DESCRIP,EAFIP,EDGI,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MCOTAFIP,MOBS,SALTAFW,SIMBOLO,SMODIFW,TIMESTAMP,TIPAGRUPUB,TOLNEG,TOLPOS,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'OPETAR' ) + '.OPETAR'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'OPETAR' ) + '.OPETAR'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,CTABANC,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,PAGADORA,PROVEEDOR,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,CTABANC,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,PAGADORA,PROVEEDOR,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'OPETARDET' ) + '.OPETARDET'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'OPETARDET' ) + '.OPETARDET'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CDTCODIGO,CLTARJ,DESCRIP,ENTFIN,ENTFINDESC,NROITEM) select CDTCODIGO,CLTARJ,DESCRIP,ENTFIN,ENTFINDESC,NROITEM from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'ORDAT' ) + '.ORDAT'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'ORDAT' ) + '.ORDAT'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OOBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OOBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'PAISES' ) + '.PAISES'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'PAISES' ) + '.PAISES'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,PAAF,PCOD,PDES,POBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,PAAF,PCOD,PDES,POBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
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

			*----------goServicios.Estructura.ObtenerEsquema( 'PROVINCI' ) + '.PROVINCI'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'PROVINCI' ) + '.PROVINCI'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (ARBA,BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,POBS,PRV_COD,PRV_DES,PRV_IVALIB,PRV_JUR,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select ARBA,BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,POBS,PRV_COD,PRV_DES,PRV_IVALIB,PRV_JUR,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'REDO' ) + '.REDO'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'REDO' ) + '.REDO'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,REDOENT,REDOPRE,REDOTCENT,REDOTENT,RNORMAL,ROBS,RTABLA,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,REDOENT,REDOPRE,REDOTCENT,REDOTENT,RNORMAL,ROBS,RTABLA,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'REGIMP' ) + '.REGIMP'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'REGIMP' ) + '.REGIMP'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPO,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,BLOQREG,CODIGO,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPO,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'SALTODECAMPO' ) + '.SALTODECAMPO'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'SALTODECAMPO' ) + '.SALTODECAMPO'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (ATRDESC,ATRIBUTO,BDALTAFW,BDMODIFW,CODIGO,DETALLE,ENTDESC,ENTIDAD,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MOSTRAR,NOOBLIGAAP,OBLIGA,OBS,OCULTAR,PERSETIQ,SALTA,SALTAFW,SMODIFW,TIPAGRUPUB,UALTAFW,UMODIFW,USAETIQ,USAVALSIS,USAVSANT,VALTAFW,VMODIFW,VSUGERIDO,ZADSFW) select ATRDESC,ATRIBUTO,BDALTAFW,BDMODIFW,CODIGO,DETALLE,ENTDESC,ENTIDAD,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,MOSTRAR,NOOBLIGAAP,OBLIGA,OBS,OCULTAR,PERSETIQ,SALTA,SALTAFW,SMODIFW,TIPAGRUPUB,UALTAFW,UMODIFW,USAETIQ,USAVALSIS,USAVSANT,VALTAFW,VMODIFW,VSUGERIDO,ZADSFW from << lcTablaOrigen >>
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

			*----------goServicios.Estructura.ObtenerEsquema( 'TARJEDET' ) + '.TARJEDET'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'TARJEDET' ) + '.TARJEDET'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (CANTTIEMPO,COD,CUOTAS,DESCUENTO,MODOTIEMPO,MONTODESDE,NROITEM,RECARGO,TIPOMONTO) select CANTTIEMPO,COD,CUOTAS,DESCUENTO,MODOTIEMPO,MONTODESDE,NROITEM,RECARGO,TIPOMONTO from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'TIPODIR' ) + '.TIPODIR'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'TIPODIR' ) + '.TIPODIR'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TDCOD,TDDES,TDOBS,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,SALTAFW,SMODIFW,TDCOD,TDDES,TDOBS,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'TIPOORDEN' ) + '.TIPOORDEN'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'TIPOORDEN' ) + '.TIPOORDEN'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,CODIGO,DESCR,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,CODIGO,DESCR,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,TIPAGRUPUB,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'UMARBA' ) + '.UMARBA'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'UMARBA' ) + '.UMARBA'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (BDALTAFW,BDMODIFW,COD,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW) select BDALTAFW,BDMODIFW,COD,DESCRIP,ESTTRANS,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,OBS,SALTAFW,SMODIFW,UALTAFW,UMODIFW,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
			endtext
			goDatos.EjecutarSql( lcSql )
			loLogCopia.Actualizar( lcTabla, 'Copiado ok.' )

			*----------goServicios.Estructura.ObtenerEsquema( 'XVAL' ) + '.XVAL'----------------------------
			lcTabla = goServicios.Estructura.ObtenerEsquema( 'XVAL' ) + '.XVAL'
			lcTablaOrigen = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalOrigen ) + ']' + '.' + lcTabla
			lcTablaDestino = '[' + goServicios.Librerias.ObtenerNombreSucursal( tcSucursalDestino ) + ']' + '.' + lcTabla
			text to lcSql textmerge noshow pretext 7
				insert into << lcTablaDestino >> (ARQTOT,BCOADEP,BDALTAFW,BDMODIFW,BLOMODDES,CCADEP,CLCFI,CLCLAS,CLCOD,CLDESCP,CLGRUP,CLNOM,CLOBS,CLRECARGO,CLSMONET,CLVISUALIZ,CTABANC,ELECTRO,EQEPSON,EQIBM,ESTTRANS,FACTELEC,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,IDCAJA,IMPRCHQCF,LEYENDA,MNTOMAXRET,MODIFECHA,MODOREDON,NOAPLIRC,NOARRASTRA,OPETAR,PAGUESEA,PERSOCOMP,PERVUELTO,PRESTADOR,REDONDEO,RETIRAEFEC,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPOTARJ,UALTAFW,UMODIFW,VALLINCE,VALORACRED,VALORRETEF,VALTAFW,VMODIFW,ZADSFW) select ARQTOT,BCOADEP,BDALTAFW,BDMODIFW,BLOMODDES,CCADEP,CLCFI,CLCLAS,CLCOD,CLDESCP,CLGRUP,CLNOM,CLOBS,CLRECARGO,CLSMONET,CLVISUALIZ,CTABANC,ELECTRO,EQEPSON,EQIBM,ESTTRANS,FACTELEC,FALTAFW,FECEXPO,FECIMPO,FECTRANS,FMODIFW,HALTAFW,HMODIFW,HORAEXPO,HORAIMPO,IDCAJA,IMPRCHQCF,LEYENDA,MNTOMAXRET,MODIFECHA,MODOREDON,NOAPLIRC,NOARRASTRA,OPETAR,PAGUESEA,PERSOCOMP,PERVUELTO,PRESTADOR,REDONDEO,RETIRAEFEC,SALTAFW,SMODIFW,TIMESTAMP,TIPAGRUPUB,TIPOTARJ,UALTAFW,UMODIFW,VALLINCE,VALORACRED,VALORRETEF,VALTAFW,VMODIFW,ZADSFW from << lcTablaOrigen >>
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
		loColeccion.Agregar( 'SIPDJKXN','COLOR' )
		loColeccion.Agregar( 'SIPDJKN','PAISES' )
		loColeccion.Agregar( 'SIPDJKN','PROVINCIA' )
		loColeccion.Agregar( 'SIPDJN','VENDEDOR' )
		loColeccion.Agregar( 'SIPDJKXN','ARTICULO' )
		loColeccion.Agregar( 'SIPDJKN','PROVEEDOR' )
		loColeccion.Agregar( 'PDJKN','MONEDA' )
		loColeccion.Agregar( 'PDJKN','VALOR' )
		loColeccion.Agregar( 'PDJKN','GRUPOVALOR' )
		loColeccion.Agregar( 'PDJKN','CONCEPTOCAJA' )
		loColeccion.Agregar( 'PDJKN','LISTADEPRECIOS' )
		loColeccion.Agregar( 'SIPDJN','CLIENTE' )
		loColeccion.Agregar( 'PDJKN','ENTIDADFINANCIERA' )
		loColeccion.Agregar( 'SIPDK','MOTIVO' )
		loColeccion.Agregar( 'SUIPDJKN','ORIGENDEDATOS' )
		loColeccion.Agregar( 'DJ','FACTURA' )
		loColeccion.Agregar( 'SUIOPQDGJKLMN','AGRUPAMIENTO' )
		loColeccion.Agregar( 'SIPDJKXN','MATERIAL' )
		loColeccion.Agregar( 'SIPQDJKN','TALONARIO' )
		loColeccion.Agregar( 'SIPQDJKN','NUMERACIONES' )
		loColeccion.Agregar( 'DJKN','COMPROBANTEDECAJA' )
		loColeccion.Agregar( 'DJ','NOTADECREDITO' )
		loColeccion.Agregar( 'DJ','NOTADEDEBITO' )
		loColeccion.Agregar( 'DJ','TICKETFACTURA' )
		loColeccion.Agregar( 'DJ','TICKETNOTADECREDITO' )
		loColeccion.Agregar( 'DJ','TICKETNOTADEDEBITO' )
		loColeccion.Agregar( 'DJKN','CAJAESTADO' )
		loColeccion.Agregar( 'SUIPDGJKLN','BUZON' )
		loColeccion.Agregar( 'SIPDJKXN','TALLE' )
		loColeccion.Agregar( 'SIPDJKXN','TEMPORADA' )
		loColeccion.Agregar( 'P','MODIFICACIONPRECIOS' )
		loColeccion.Agregar( 'SIX','MOVIMIENTODESTOCK' )
		loColeccion.Agregar( 'SIPDJN','CLASIFICACIONCLIENTE' )
		loColeccion.Agregar( 'SIPDJKLN','DISENOIMPRESION' )
		loColeccion.Agregar( 'SIPDJKLN','ESTILOIMPRESION' )
		loColeccion.Agregar( 'SIPDJKN','EQUIVALENCIA' )
		loColeccion.Agregar( 'P','REDONDEODEPRECIOS' )
		loColeccion.Agregar( 'SUIPDGJKLN','DISENOIMPO' )
		loColeccion.Agregar( 'PGL','DISENOEXPO' )
		loColeccion.Agregar( 'SUIPDGJKLN','CONDICIONIMPO' )
		loColeccion.Agregar( 'SUIPDGJKLN','FORMATOEXPORTACION' )
		loColeccion.Agregar( 'SUIPDGJKLN','CONVERSION' )
		loColeccion.Agregar( 'SUIPDGJKLN','CONVERSIONVALORES' )
		loColeccion.Agregar( 'SUIPDGJKLN','IMPOAGRUPADAS' )
		loColeccion.Agregar( 'PGL','EXPOAGRUPADAS' )
		loColeccion.Agregar( 'SIPDJKN','DATOSFISCALES' )
		loColeccion.Agregar( 'I','TIINVENTARIOACONT' )
		loColeccion.Agregar( 'I','TIINVENTARIOFISICO' )
		loColeccion.Agregar( 'I','TIINVENTARIOFISICODETALLE' )
		loColeccion.Agregar( 'I','TIDIFERENCIASDEINVENTARIO' )
		loColeccion.Agregar( 'I','TIDIFERENCIASDEINVENTARIODETALLE' )
		loColeccion.Agregar( 'SI','MERCADERIAENTRANSITO' )
		loColeccion.Agregar( 'SIPDJN','CAI' )
		loColeccion.Agregar( 'SID','REMITO' )
		loColeccion.Agregar( 'SUIPQDGJKLMN','SCRIPT' )
		loColeccion.Agregar( 'DJ','VALEDECAMBIO' )
		loColeccion.Agregar( 'PDJN','LIMITECONSUMO' )
		loColeccion.Agregar( 'PDJN','DESCUENTO' )
		loColeccion.Agregar( 'SUPDGJKLMN','REGLASTRANSFERENCIAS' )
		loColeccion.Agregar( 'SSUIIOPPQQDDGJJKKLMNN','ACCIONESAUTOMATICAS' )
		loColeccion.Agregar( 'SIPDJKXN','UNIDADDEMEDIDA' )
		loColeccion.Agregar( 'SIPDJKXN','FAMILIA' )
		loColeccion.Agregar( 'SIPDJKXN','LINEA' )
		loColeccion.Agregar( 'SIPDJKXN','GRUPO' )
		loColeccion.Agregar( 'SIPDJKXN','CATEGORIADEARTICULO' )
		loColeccion.Agregar( 'SIPDJKXN','CLASIFICACIONARTICULO' )
		loColeccion.Agregar( 'SIPDJKXN','TIPODEARTICULO' )
		loColeccion.Agregar( 'SID','DEVOLUCION' )
		loColeccion.Agregar( 'SIPDJKN','CLASIFICACIONPROVEEDOR' )
		loColeccion.Agregar( 'SIPDJKN','CLASIFICACIONVENDEDOR' )
		loColeccion.Agregar( 'DJN','RECIBO' )
		loColeccion.Agregar( 'SI','AJUSTEDESTOCK' )
		loColeccion.Agregar( 'L','IMPRESIONDEETIQUETA' )
		loColeccion.Agregar( 'DJN','SENIA' )
		loColeccion.Agregar( 'DJKN','CHEQUE' )
		loColeccion.Agregar( 'SIPDGJKLMN','DISENOTRANSFORMACIONLINCE' )
		loColeccion.Agregar( 'DJ','PEDIDO' )
		loColeccion.Agregar( 'D','PRESUPUESTO' )
		loColeccion.Agregar( 'SIPDK','TRANSPORTISTA' )
		loColeccion.Agregar( 'K','FACTURADECOMPRA' )
		loColeccion.Agregar( 'SIPDJKN','TIPOIMPUESTO' )
		loColeccion.Agregar( 'PDJKN','CONDICIONDEPAGO' )
		loColeccion.Agregar( 'SIPDJKN','IMPUESTO' )
		loColeccion.Agregar( 'P','CALCULODEPRECIOS' )
		loColeccion.Agregar( 'PT','OPERADORADETARJETA' )
		loColeccion.Agregar( 'T','CIERREDELOTE' )
		loColeccion.Agregar( 'T','POS' )
		loColeccion.Agregar( 'TDJ','CUPON' )
		loColeccion.Agregar( 'DJN','TRATAMIENTOCOMPROBANTES' )
		loColeccion.Agregar( 'SIPDGJKLMN','EQUIVALORLINCE' )
		loColeccion.Agregar( 'DJ','FACTURAELECTRONICA' )
		loColeccion.Agregar( 'DJ','NOTADECREDITOELECTRONICA' )
		loColeccion.Agregar( 'DJ','NOTADEDEBITOELECTRONICA' )
		loColeccion.Agregar( 'DJN','CAEPORLOTE' )
		loColeccion.Agregar( 'SUIOPQDGJKLMN','ZUDESCARGALAN' )
		loColeccion.Agregar( 'SUWIOPQDGJKLMN','BASEDEDATOS' )
		loColeccion.Agregar( 'K','ORDENDEPAGO' )
		loColeccion.Agregar( 'SIPDJKN','COMPORTAMIENTOCODIGOSUGERIDOENTIDAD' )
		loColeccion.Agregar( 'K','NOTADEDEBITOCOMPRA' )
		loColeccion.Agregar( 'K','NOTADECREDITOCOMPRA' )
		loColeccion.Agregar( 'PDJKN','SUCURSALBANCARIA' )
		loColeccion.Agregar( 'PDJKN','CUENTABANCARIA' )
		loColeccion.Agregar( 'PDJKN','CHEQUERA' )
		loColeccion.Agregar( 'DJKN','CHEQUEPROPIO' )
		loColeccion.Agregar( 'TDJK','CANJEDECUPONES' )
		loColeccion.Agregar( 'N','FACTURAELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'N','NOTADECREDITOELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'N','NOTADEDEBITOELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'SIPDJKN','AGRUPAMIENTODEBUZONES' )
		loColeccion.Agregar( 'DJN','IMPRIMIRCOMPROBANTEPORLOTE' )
		loColeccion.Agregar( 'SIPDJKXN','PALETADECOLORES' )
		loColeccion.Agregar( 'SIPDJKXN','CURVADETALLES' )
		loColeccion.Agregar( 'P','FORMULA' )
		loColeccion.Agregar( 'SIPDJKN','SALTODECAMPO' )
		loColeccion.Agregar( 'DJ','COMISION' )
		loColeccion.Agregar( 'SUWIOPQDGJKLMN','SUCURSAL' )
		loColeccion.Agregar( 'SUWIOPQDGJKLMN','TIPOSUCURSAL' )
		loColeccion.Agregar( 'SUWIOPQDGJKLMN','LINEASUCURSAL' )
		loColeccion.Agregar( 'SUWIOPQDGJKLMN','SEGMENTACION' )
		loColeccion.Agregar( 'PT','CLASEDETARJETA' )
		loColeccion.Agregar( 'SIDJKN','PICKING' )
		loColeccion.Agregar( 'J','OBJETIVOSVENTA' )
		loColeccion.Agregar( 'J','TIPOOBJETIVO' )
		loColeccion.Agregar( 'SI','MINIMOREPOSICION' )
		loColeccion.Agregar( 'SUIOPQDGJKLMN','REGISTRODEMANTENIMIENTO' )
		loColeccion.Agregar( 'DJ','PROMOCION' )
		loColeccion.Agregar( 'K','PAGO' )
		loColeccion.Agregar( 'SI','AJUSTEDEESTADOS' )
		loColeccion.Agregar( 'K','COMPROBANTEDERETENCIONES' )
		loColeccion.Agregar( 'K','PRESUPUESTODECOMPRA' )
		loColeccion.Agregar( 'DJK','PEDIDODECOMPRA' )
		loColeccion.Agregar( 'K','SOLICITUDDECOMPRA' )
		loColeccion.Agregar( 'K','REMITODECOMPRA' )
		loColeccion.Agregar( 'K','CANCELACIONDECOMPRA' )
		loColeccion.Agregar( 'K','REQUERIMIENTODECOMPRA' )
		loColeccion.Agregar( 'SI','BOLSASYCAJAS' )
		loColeccion.Agregar( 'DJN','AJUSTECCCLIENTE' )
		loColeccion.Agregar( 'K','AJUSTECCPROVEEDOR' )
		loColeccion.Agregar( 'DJN','CANCELACIONDESENIAS' )
		loColeccion.Agregar( 'DJ','GTIN' )
		loColeccion.Agregar( 'I','PASAJEDESTOCK' )
		loColeccion.Agregar( 'PDJKN','CONCILIACIONDECAJA' )
		loColeccion.Agregar( 'PDJKN','LISTADEPRECIOSCALCULADA' )
		loColeccion.Agregar( 'SIPDJKN','NOMENCLADORARBA' )
		loColeccion.Agregar( 'SIPDJN','UNIDADDEMEDIDAARBA' )
		loColeccion.Agregar( 'SID','REMITOELECTRONICO' )
		loColeccion.Agregar( 'DJKN','DESTINODESCARGACHEQUES' )
		loColeccion.Agregar( 'DJKN','DESCARGADECHEQUES' )
		loColeccion.Agregar( 'N','FACTURADEEXPORTACION' )
		loColeccion.Agregar( 'N','NOTADECREDITODEEXPORTACION' )
		loColeccion.Agregar( 'N','NOTADEDEBITODEEXPORTACION' )
		loColeccion.Agregar( 'SIPDJN','NOMBREDEFANTASIA' )
		loColeccion.Agregar( 'SIPDJN','TIPODEDIRECCION' )
		loColeccion.Agregar( 'SIPDJN','TIPOCLIENTE' )
		loColeccion.Agregar( 'SIPDJN','CATEGORIACLIENTE' )
		loColeccion.Agregar( 'PDJKN','CRITERIOSVALORES' )
		loColeccion.Agregar( 'N','DESPACHODEIMPORTACION' )
		loColeccion.Agregar( 'SIPDJKN','REGIMENIMPOSITIVO' )
		loColeccion.Agregar( 'SIPDJKN','CLASIFICACIONCONCEPTOPAGO' )
		loColeccion.Agregar( 'SIPDJKN','CONCEPTOPAGO' )
		loColeccion.Agregar( 'K','COMPROBANTEPAGO' )
		loColeccion.Agregar( 'K','COMPROBANTEDERETENCIONESIVA' )
		loColeccion.Agregar( 'K','COMPROBANTEDERETENCIONESGANANCIAS' )
		loColeccion.Agregar( 'K','COMPROBANTEDERETENCIONESSUSS' )
		loColeccion.Agregar( 'SIPDJKN','TIPODEOPERACIONAFIP' )
		loColeccion.Agregar( 'SIPDJKN','ASOCIACIONARTICULOSOPERACIONESAFIP' )
		loColeccion.Agregar( 'PJK','FERIADO' )
		loColeccion.Agregar( 'SIPDJKN','CLASIFICACIONCONCEPTOCAJA' )
		loColeccion.Agregar( 'DJN','MAILPORLOTE' )
		loColeccion.Agregar( 'SUIOPQDGJKLMN','EMAIL' )
		loColeccion.Agregar( 'SUIOPQDGJKLMN','CUENTACORREO' )
		loColeccion.Agregar( 'T','CONCEPTOLIQUIDACIONTARJETA' )
		loColeccion.Agregar( 'T','LIQUIDACIONDIARIA' )
		loColeccion.Agregar( 'T','LIQUIDACIONMENSUAL' )
		loColeccion.Agregar( 'F','PLANDECUENTAS' )
		loColeccion.Agregar( 'DJN','COMPROBANTEDERETENCIONRECIBIDO' )
		loColeccion.Agregar( 'DJN','REPORTEELECTRONICO' )
		loColeccion.Agregar( 'F','CENTRODECOSTO' )
		loColeccion.Agregar( 'F','DISTRIBUCIONCENTRODECOSTO' )
		loColeccion.Agregar( 'F','ASIENTO' )
		loColeccion.Agregar( 'F','RAZONSOCIAL' )
		loColeccion.Agregar( 'F','EJERCICIO' )
		loColeccion.Agregar( 'F','ASIGNARZBD' )
		loColeccion.Agregar( 'F','IMPDIRVAL' )
		loColeccion.Agregar( 'FF','IMPDIRART' )
		loColeccion.Agregar( 'F','IMPDIRCLI' )
		loColeccion.Agregar( 'F','IMPDIRPRO' )
		loColeccion.Agregar( 'F','IMPDIRIMP' )
		loColeccion.Agregar( 'F','IMPDIRCAJ' )
		loColeccion.Agregar( 'F','IMPDIRCON' )
		loColeccion.Agregar( 'F','IMPDIRDES' )
		loColeccion.Agregar( 'F','IMPDIROPE' )
		loColeccion.Agregar( 'F','IMPDIRLIQ' )
		loColeccion.Agregar( 'F','IMPVERCC' )
		loColeccion.Agregar( 'F','CONTABILIZACION' )
		loColeccion.Agregar( 'F','ASIENTOTIPO' )
		loColeccion.Agregar( 'F','CIERREEJERCICIO' )
		loColeccion.Agregar( 'F','IMPDIRCCA' )
		loColeccion.Agregar( 'F','IMPDIRCCC' )
		loColeccion.Agregar( 'F','APERTURAEJERCICIO' )
		loColeccion.Agregar( 'SID','ENTREGADEMERCADERIAS' )
		loColeccion.Agregar( 'E','CLIENTEECOMMERCE' )
		loColeccion.Agregar( 'E','COMPROBANTESECOMMERCE' )
		loColeccion.Agregar( 'E','ECOMMERCE' )
		loColeccion.Agregar( 'E','OPERACIONECOMMERCE' )
		loColeccion.Agregar( 'SIPDJKN','PUNTOSDEVENTA' )
		loColeccion.Agregar( 'DHJ','SERVICIOREST' )
		loColeccion.Agregar( 'DHJ','CLAVESECRETAREST' )
		loColeccion.Agregar( 'SIOQDJF','AGRUPALISTADOSPERSONALIZADOS' )
		loColeccion.Agregar( 'QDGJ','REPORTEAUDITORIACIERREZ' )
		loColeccion.Agregar( 'PDJN','MOTIVODESCUENTOYDEVOLUCION' )
		loColeccion.Agregar( 'PDJKN','CODIGOAUTORIZACIONDJCP' )
		loColeccion.Agregar( 'DJKN','ARQUEODECAJA' )
		loColeccion.Agregar( 'SPDJ','CODIGODESERVICIO' )
		loColeccion.Agregar( 'SPDJ','TIPODEORDEN' )
		loColeccion.Agregar( 'SPDJ','ESTADOSDEINTERACCION' )
		loColeccion.Agregar( 'SPDJ','INTERACCIONDEORDEN' )
		loColeccion.Agregar( 'SPDJ','ENTIDADADICIONAL1' )
		loColeccion.Agregar( 'SPDJ','ENTIDADADICIONAL2' )
		loColeccion.Agregar( 'SPDJ','ENTIDADADICIONAL3' )
		loColeccion.Agregar( 'SPDJ','ORDENDESERVICIO' )
		loColeccion.Agregar( 'PG','ERRORSAP' )
		loColeccion.Agregar( 'PDJN','GESTIONVENDEDOR' )
		loColeccion.Agregar( 'PDJKN','COTIZACION' )
		loColeccion.Agregar( 'E','ENVIODEMENSAJERIA' )
		loColeccion.Agregar( 'DJK','VALORESENTRANSITO' )
		loColeccion.Agregar( 'K','REGISTRODECUENTA' )
		loColeccion.Agregar( 'K','TRANSFERENCIAENTRECUENTAS' )
		loColeccion.Agregar( 'PK','CONCEPTOENTIDADFINANCIERA' )
		loColeccion.Agregar( 'K','MOVIMIENTOBANCARIO' )
		loColeccion.Agregar( 'K','CONCILIACIONES' )
		loColeccion.Agregar( 'K','HERRAMIENTACONCILIACION' )
		loColeccion.Agregar( 'D','PREPARACIONDEMERCADERIA' )
		loColeccion.Agregar( 'DJ','FACTURAAGRUPADA' )
		loColeccion.Agregar( 'SPDJKN','CODBARRAALTER' )
		loColeccion.Agregar( 'F','IMPDIRCUE' )
		loColeccion.Agregar( 'DJ','NOTADECREDITOAGRUPADA' )
		loColeccion.Agregar( 'DJ','NOTADEDEBITOAGRUPADA' )
		loColeccion.Agregar( 'DJK','ENVIODECUENTACORRIENTEPORMAIL' )
		loColeccion.Agregar( 'F','INDICESINFLACION' )
		loColeccion.Agregar( 'SI','HERRAMIENTAAGRUPADORADEPACKS' )
		loColeccion.Agregar( 'P','LINKQRENETIQUETA' )
		loColeccion.Agregar( 'H','WEBHOOK' )
		loColeccion.Agregar( 'F','RENUMERAASIENTOS' )
		loColeccion.Agregar( 'SIPDJXN','MARCA' )
		loColeccion.Agregar( 'PE','ETIQUETASECOMMERCE' )
		loColeccion.Agregar( 'PE','CATEGORIASECOMMERCE' )
		loColeccion.Agregar( 'PE','CONFIGURACIONARTICULOECOMMERCE' )
		loColeccion.Agregar( 'PE','CATEGORIASGOOGLESHOPPING' )
		loColeccion.Agregar( 'SIOPQDJKN','APERTURAAUTOMATICAENTIDADES' )
		loColeccion.Agregar( 'DJN','CAEA' )
		loColeccion.Agregar( 'DJN','CAEAINFORMA' )
		loColeccion.Agregar( 'X','INVENTARIO' )
		loColeccion.Agregar( 'X','INSUMO' )
		loColeccion.Agregar( 'XXXXXX','MOTIVODESCARTE' )
		loColeccion.Agregar( 'X','MAQUINARIA' )
		loColeccion.Agregar( 'X','PROCESOPRODUCCION' )
		loColeccion.Agregar( 'X','CURVADEPRODUCCION' )
		loColeccion.Agregar( 'X','TALLER' )
		loColeccion.Agregar( 'X','MODELODEPRODUCCION' )
		loColeccion.Agregar( 'X','ORDENDEPRODUCCION' )
		loColeccion.Agregar( 'X','GESTIONDEPRODUCCION' )
		loColeccion.Agregar( 'X','MOVIMIENTOSTOCKAPRODUCC' )
		loColeccion.Agregar( 'X','MOVIMIENTOSTOCKAINVENT' )
		loColeccion.Agregar( 'X','MOVIMIENTOSTOCKDESDEPRODUCC' )
		loColeccion.Agregar( 'X','FINALDEPRODUCCION' )
		loColeccion.Agregar( 'DJK','AJUSTECHEQUERECHAZADO' )
		loColeccion.Agregar( 'DJKN','GESTIONCHCUSTODIA' )
		loColeccion.Agregar( 'X','LISTADECOSTOSDEPRODUCCION' )
		loColeccion.Agregar( 'X','MODIFICACIONDECOSTOSDEPRODUCCION' )
		loColeccion.Agregar( 'X','COTIZACIONPRODUCCION' )
		loColeccion.Agregar( 'X','LIQUIDACIONDETALLER' )
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
		lcRetorno = "Select PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, ( select Funciones.ObtenerTimestampVigenteDeLaCombinacion(PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "') ) as TIMESTAMPA, '" + tcListaPrecios + "' as ListaPre   From PRECIOAR" + ;
		' Inner Join LPRECIO on PRECIOAR.LISTAPRE = LPRECIO.LPR_NUMERO and LPRECIO.LPR_NUMERO = [' + tcListaPrecios + '] Inner Join ART on PRECIOAR.ARTICULO = ART.ARTCOD Left Join COL on PRECIOAR.cColor = COL.COLCOD Left Join Talle on PRECIOAR.Talle = Talle.Codigo'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerSelectPreciosVigentes( tdFechaVigencia as Date, tcListaPrecios as String ) as String
		local lcRetorno
		lcRetorno = "Select SB.LISTAPRE, SB.ARTICULO, SB.CCOLOR, SB.TALLE, SB.FECHAVIG, SB.TIMESTAMPA, SB.PDIRECTO " + ;
		"From ( " + ;
		"Select LISTAPRE, ARTICULO, CCOLOR, TALLE, FECHAVIG, TIMESTAMPA, PDIRECTO , Row_Number() Over( Partition By LISTAPRE, ARTICULO, CCOLOR, TALLE Order By FECHAVIG Desc, TIMESTAMPA Desc ) Prioridad " + ;
		"From PRECIOAR " + ;
		"Where LISTAPRE = [" + tcListaPrecios + "] and FECHAVIG <= [" + dtos( tdFechaVigencia ) + "] " + ;
		") as SB Where SB.Prioridad = 1 "
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerSelectConsultaPreciosConPrecioActual( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "Select distinct PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, ( select Funciones.ObtenerTimestampVigenteDeLaCombinacion(PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "') ) as TIMESTAMPA, '" + tcListaPrecios + "' as ListaPre " + ;
		", ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL  From PRECIOAR" + ;
		' Inner Join LPRECIO on PRECIOAR.LISTAPRE = LPRECIO.LPR_NUMERO and LPRECIO.LPR_NUMERO = [' + tcListaPrecios + '] Inner Join ART on PRECIOAR.ARTICULO = ART.ARTCOD Left Join COL on PRECIOAR.cColor = COL.COLCOD Left Join Talle on PRECIOAR.Talle = Talle.Codigo'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerFuncionPrecioRealDeLaCombinacionConVigencia( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, ( select Funciones.ObtenerTimestampVigenteDeLaCombinacion(PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "') ) as TIMESTAMPA, '" + tcListaPrecios + "' as ListaPre " + ;
		", ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL  "
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerFuncionPrecioRealParticipantesKitsYPacksConVigencia( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(KitPartDet.IPPART, KitPartDet.IPCOLOR, KitPartDet.IPTALLE, '" + tcListaPrecios + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) * KitPartDet.CANT ) as PDIRECTO, ( select Funciones.ObtenerTimestampVigenteDeLaCombinacion(ARTICULO, CCOLOR, TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "') ) as TIMESTAMPA, '" + tcListaPrecios + "' as ListaPre " + ;
		", ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(ARTICULO, CCOLOR, TALLE, '" + tcListaActual + "', ' " + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL  "
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerFuncionPrecioRealDelStockConVigencia( tdFechaVigencia as Date, tcListaPrecios as String, tlNoVerificarCalculadaAlMomento as Boolean, tcListaActual as String ) as String
		local lcRetorno
		lcRetorno = "( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(COMB.COART, COMB.COCOL, COMB.TALLE, '" + tcListaPrecios + "', '" + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, '" + tcListaPrecios + "' as ListaPre , ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(COMB.COART, COMB.COCOL, COMB.TALLE, '" + tcListaActual + "', '" + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL "
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerWhereConsultaPrecios() as String
		local lcRetorno
		lcRetorno = "PRECIOAR.ARTICULO != [' + rtrim( goRegistry.Felino.CodigoDeArticuloSena ) + '] and PRECIOAR.ARTICULO >= [' + This.f_ARTICULO_Desde_PK + '] and PRECIOAR.ARTICULO <= [' + This.f_ARTICULO_Hasta_PK + '] and " + ;
			"PRECIOAR.cColor >= [' + This.f_COLOR_Desde_PK + '] and PRECIOAR.cColor <= [' + This.f_COLOR_Hasta_PK + '] and " + ;
			"PRECIOAR.Talle >= [' + This.f_TALLE_Desde_PK + '] and PRECIOAR.Talle <= [' + This.f_TALLE_Hasta_PK + '] and " + ;
			"ART.ARTFAB >= [' + This.f_ARTICULO_PROVEEDOR_Desde_PK + '] and ART.ARTFAB <= [' + This.f_ARTICULO_PROVEEDOR_Hasta_PK + '] and " + ;
			"ART.UniMed >= [' + This.f_ARTICULO_UNIDADDEMEDIDA_Desde_PK + '] and ART.UniMed <= [' + This.f_ARTICULO_UNIDADDEMEDIDA_Hasta_PK + '] and " + ;
			"ART.ATEMPORADA >= [' + This.f_ARTICULO_TEMPORADA_Desde_PK + '] and ART.ATEMPORADA <= [' + This.f_ARTICULO_TEMPORADA_Hasta_PK + '] and " + ;
			"ART.Ano >= ' + transform( This.f_ARTICULO_ANO_Desde ) + ' and ART.Ano <= ' + transform( This.f_ARTICULO_ANO_Hasta ) + ' and " + ;
			"ART.Familia >= [' + This.f_ARTICULO_FAMILIA_Desde_PK + '] and ART.Familia <= [' + This.f_ARTICULO_FAMILIA_Hasta_PK + '] and " + ;
			"ART.Mat >= [' + This.f_ARTICULO_MATERIAL_Desde_PK + '] and ART.Mat <= [' + This.f_ARTICULO_MATERIAL_Hasta_PK + '] and " + ;
			"ART.Linea >= [' + This.f_ARTICULO_LINEA_Desde_PK + '] and ART.Linea <= [' + This.f_ARTICULO_LINEA_Hasta_PK + '] and " + ;
			"ART.Grupo >= [' + This.f_ARTICULO_GRUPO_Desde_PK + '] and ART.Grupo <= [' + This.f_ARTICULO_GRUPO_Hasta_PK + '] and " + ;
			"ART.CateArti >= [' + This.f_ARTICULO_CATEGORIADEARTICULO_Desde_PK + '] and ART.CateArti <= [' + This.f_ARTICULO_CATEGORIADEARTICULO_Hasta_PK + '] and " + ;
			"ART.ClasifArt >= [' + This.f_ARTICULO_CLASIFICACION_Desde_PK + '] and ART.ClasifArt <= [' + This.f_ARTICULO_CLASIFICACION_Hasta_PK + '] and " + ;
			"ART.TipoArti >= [' + This.f_ARTICULO_TIPODEARTICULO_Desde_PK + '] and ART.TipoArti <= [' + This.f_ARTICULO_TIPODEARTICULO_Hasta_PK + '] and " + ;
			"DTos( ART.FALTAFW ) >= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Desde ) + '] and DTos( ART.FALTAFW ) <= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Hasta ) + '] and " + ;
			"DTos( ART.FMODIFW ) >= [' + dtos( This.f_ARTICULO_FECHAMODIFICACIONFW_Desde ) + '] and DTos( ART.FMODIFW ) <= [' + dtos( This.f_ARTICULO_FECHAMODIFICACIONFW_Hasta ) + '] and " + ;
			"DTos( ART.FECTRANS ) >= [' + dtos( This.f_ARTICULO_FECHATRANSFERENCIA_Desde ) + '] and DTos( ART.FECTRANS ) <= [' + dtos( This.f_ARTICULO_FECHATRANSFERENCIA_Hasta ) + '] and " + ;
			"DTos( ART.FECIMPO ) >= [' + dtos( This.f_ARTICULO_FECHAIMPO_Desde ) + '] and DTos( ART.FECIMPO ) <= [' + dtos( This.f_ARTICULO_FECHAIMPO_Hasta ) + '] and " + ;
			"DTos( ART.FECEXPO ) >= [' + dtos( This.f_ARTICULO_FECHAEXPO_Desde ) + '] and DTos( ART.FECEXPO ) <= [' + dtos( This.f_ARTICULO_FECHAEXPO_Hasta ) + '] and " + ;
			"ART.ASTOCK >= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Desde ) + ' and ART.ASTOCK <= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Hasta ) + ' and " + ;
			"ART.ARTNARBA >= [' + This.f_ARTICULO_NOMENCLADOR_Desde_PK + '] and ART.ARTNARBA <= [' + This.f_ARTICULO_NOMENCLADOR_Hasta_PK + '] and " + ;
			"PRECIOAR.TimestampA >= ' + transform( This.f_TIMESTAMPALTA_Desde ) + ' and PRECIOAR.TimestampA <= ' + transform( This.f_TIMESTAMPALTA_Hasta ) + ' and " + ;
			"PRECIOAR.PDIRECTO >= ' + transform( This.f_PRECIODIRECTO_Desde ) + ' and PRECIOAR.PDIRECTO <= ' + transform( This.f_PRECIODIRECTO_Hasta ) + ' and " + ;
			"ART.PalCol >= [' + This.f_ARTICULO_PALETADECOLORES_Desde_PK + '] and ART.PalCol <= [' + This.f_ARTICULO_PALETADECOLORES_Hasta_PK + '] and " + ;
			"ART.Curtall >= [' + This.f_ARTICULO_CURVADETALLES_Desde_PK + '] and ART.Curtall <= [' + This.f_ARTICULO_CURVADETALLES_Hasta_PK + '] and " + ;
			"ART.Marca >= [' + This.f_ARTICULO_MARCA_Desde_PK + '] and ART.Marca <= [' + This.f_ARTICULO_MARCA_Hasta_PK + ']"
		lcRetorno = lcRetorno + " and ( PRECIOAR.cColor= [] or COL.COLCOD is not null )" + " and ( PRECIOAR.Talle= [] or Talle.Codigo is not null )" 
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerWhereArticuloDeProveedor() as String
		return " where ART.ARTFAB"
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerAgrupamientoyOrdenConsultaPrecios() as String
		local lcRetorno
		lcRetorno = " group by PRECIOAR.ARTICULO, PRECIOAR.CCOLOR, PRECIOAR.TALLE " + ;
					"order by PRECIOAR.ARTICULO + PRECIOAR.CCOLOR + PRECIOAR.TALLE "
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerTablasConsultaPrecios() as String
		local lcRetorno
		lcRetorno = 'PRECIOAR'
		lcRetorno = lcRetorno + ',ART'
		lcRetorno = lcRetorno + ',LPRECIO'
		lcRetorno = lcRetorno + ',COL'
		lcRetorno = lcRetorno + ',Talle'
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
		lcRetorno = ' left join PRECIOAR on COMB.COART = PRECIOAR.ARTICULO and COMB.COCOL = PRECIOAR.CCOLOR and COMB.TALLE = PRECIOAR.TALLE '
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
			"ART.UniMed >= [' + This.f_ARTICULO_UNIDADDEMEDIDA_Desde_PK + '] and ART.UniMed <= [' + This.f_ARTICULO_UNIDADDEMEDIDA_Hasta_PK + '] and " + ;
			"ART.ATEMPORADA >= [' + This.f_ARTICULO_TEMPORADA_Desde_PK + '] and ART.ATEMPORADA <= [' + This.f_ARTICULO_TEMPORADA_Hasta_PK + '] and " + ;
			"ART.Ano >= ' + transform( This.f_ARTICULO_ANO_Desde ) + ' and ART.Ano <= ' + transform( This.f_ARTICULO_ANO_Hasta ) + ' and " + ;
			"ART.Familia >= [' + This.f_ARTICULO_FAMILIA_Desde_PK + '] and ART.Familia <= [' + This.f_ARTICULO_FAMILIA_Hasta_PK + '] and " + ;
			"ART.Mat >= [' + This.f_ARTICULO_MATERIAL_Desde_PK + '] and ART.Mat <= [' + This.f_ARTICULO_MATERIAL_Hasta_PK + '] and " + ;
			"ART.Linea >= [' + This.f_ARTICULO_LINEA_Desde_PK + '] and ART.Linea <= [' + This.f_ARTICULO_LINEA_Hasta_PK + '] and " + ;
			"ART.Grupo >= [' + This.f_ARTICULO_GRUPO_Desde_PK + '] and ART.Grupo <= [' + This.f_ARTICULO_GRUPO_Hasta_PK + '] and " + ;
			"ART.CateArti >= [' + This.f_ARTICULO_CATEGORIADEARTICULO_Desde_PK + '] and ART.CateArti <= [' + This.f_ARTICULO_CATEGORIADEARTICULO_Hasta_PK + '] and " + ;
			"ART.ClasifArt >= [' + This.f_ARTICULO_CLASIFICACION_Desde_PK + '] and ART.ClasifArt <= [' + This.f_ARTICULO_CLASIFICACION_Hasta_PK + '] and " + ;
			"ART.TipoArti >= [' + This.f_ARTICULO_TIPODEARTICULO_Desde_PK + '] and ART.TipoArti <= [' + This.f_ARTICULO_TIPODEARTICULO_Hasta_PK + '] and " + ;
			"DTos( ART.FALTAFW ) >= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Desde ) + '] and DTos( ART.FALTAFW ) <= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Hasta ) + '] and " + ;
			"DTos( ART.FMODIFW ) >= [' + dtos( This.f_ARTICULO_FECHAMODIFICACIONFW_Desde ) + '] and DTos( ART.FMODIFW ) <= [' + dtos( This.f_ARTICULO_FECHAMODIFICACIONFW_Hasta ) + '] and " + ;
			"DTos( ART.FECTRANS ) >= [' + dtos( This.f_ARTICULO_FECHATRANSFERENCIA_Desde ) + '] and DTos( ART.FECTRANS ) <= [' + dtos( This.f_ARTICULO_FECHATRANSFERENCIA_Hasta ) + '] and " + ;
			"DTos( ART.FECIMPO ) >= [' + dtos( This.f_ARTICULO_FECHAIMPO_Desde ) + '] and DTos( ART.FECIMPO ) <= [' + dtos( This.f_ARTICULO_FECHAIMPO_Hasta ) + '] and " + ;
			"DTos( ART.FECEXPO ) >= [' + dtos( This.f_ARTICULO_FECHAEXPO_Desde ) + '] and DTos( ART.FECEXPO ) <= [' + dtos( This.f_ARTICULO_FECHAEXPO_Hasta ) + '] and " + ;
			"ART.ASTOCK >= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Desde ) + ' and ART.ASTOCK <= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Hasta ) + ' and " + ;
			"ART.ARTNARBA >= [' + This.f_ARTICULO_NOMENCLADOR_Desde_PK + '] and ART.ARTNARBA <= [' + This.f_ARTICULO_NOMENCLADOR_Hasta_PK + '] and " + ;
			"ART.PalCol >= [' + This.f_ARTICULO_PALETADECOLORES_Desde_PK + '] and ART.PalCol <= [' + This.f_ARTICULO_PALETADECOLORES_Hasta_PK + '] and " + ;
			"ART.Curtall >= [' + This.f_ARTICULO_CURVADETALLES_Desde_PK + '] and ART.Curtall <= [' + This.f_ARTICULO_CURVADETALLES_Hasta_PK + '] and " + ;
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
		lcRetorno = "Select COMB.COART, COMB.COCOL, COMB.TALLE, ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(COMB.COART, COMB.COCOL, COMB.TALLE, '" + tcListaPrecios + "', '" + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PDIRECTO, '" + tcListaPrecios + "' as ListaPre , ( select Funciones.ObtenerPrecioRealDeLaCombinacionConVigencia(COMB.COART, COMB.COCOL, COMB.TALLE, '" + tcListaActual + "', '" + dtos( tdFechaVigencia ) + "', " + iif(tlNoVerificarCalculadaAlMomento,"1","0") + " ) ) as PACTUAL From COMB Inner Join ART on COMB.COART = ART.ARTCOD Left Join COL on COMB.COCOL = COL.COLCOD Left Join Talle on COMB.Talle = Talle.Codigo"
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerSelectStockArticuloCombinacion() as String
		local lcRetorno
		lcRetorno = 'Select COMB.* From COMB Inner Join ART on COMB.COART = ART.ARTCOD Left Join COL on COMB.COCOL = COL.COLCOD Left Join Talle on COMB.Talle = Talle.Codigo'
		return lcRetorno
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerWhereStockArticuloCombinacion() as String
		local lcRetorno
		lcRetorno = ;
			"ART.ARTCOD != [' + rtrim( goRegistry.Felino.CodigoDeArticuloSena ) + '] and " + ;
			"COMB.COART >= [' + This.f_ARTICULO_Desde_PK + '] and COMB.COART <= [' + This.f_ARTICULO_Hasta_PK + '] and " + ;
			"COMB.COCOL >= [' + This.f_COLOR_Desde_PK + '] and COMB.COCOL <= [' + This.f_COLOR_Hasta_PK + '] and " + ;
			"COMB.Talle >= [' + This.f_TALLE_Desde_PK + '] and COMB.Talle <= [' + This.f_TALLE_Hasta_PK + '] and " + ;
			"ART.ARTFAB >= [' + This.f_ARTICULO_PROVEEDOR_Desde_PK + '] and ART.ARTFAB <= [' + This.f_ARTICULO_PROVEEDOR_Hasta_PK + '] and " + ;
			"ART.UniMed >= [' + This.f_ARTICULO_UNIDADDEMEDIDA_Desde_PK + '] and ART.UniMed <= [' + This.f_ARTICULO_UNIDADDEMEDIDA_Hasta_PK + '] and " + ;
			"ART.ATEMPORADA >= [' + This.f_ARTICULO_TEMPORADA_Desde_PK + '] and ART.ATEMPORADA <= [' + This.f_ARTICULO_TEMPORADA_Hasta_PK + '] and " + ;
			"ART.Ano >= ' + transform( This.f_ARTICULO_ANO_Desde ) + ' and ART.Ano <= ' + transform( This.f_ARTICULO_ANO_Hasta ) + ' and " + ;
			"ART.Familia >= [' + This.f_ARTICULO_FAMILIA_Desde_PK + '] and ART.Familia <= [' + This.f_ARTICULO_FAMILIA_Hasta_PK + '] and " + ;
			"ART.Mat >= [' + This.f_ARTICULO_MATERIAL_Desde_PK + '] and ART.Mat <= [' + This.f_ARTICULO_MATERIAL_Hasta_PK + '] and " + ;
			"ART.Linea >= [' + This.f_ARTICULO_LINEA_Desde_PK + '] and ART.Linea <= [' + This.f_ARTICULO_LINEA_Hasta_PK + '] and " + ;
			"ART.Grupo >= [' + This.f_ARTICULO_GRUPO_Desde_PK + '] and ART.Grupo <= [' + This.f_ARTICULO_GRUPO_Hasta_PK + '] and " + ;
			"ART.CateArti >= [' + This.f_ARTICULO_CATEGORIADEARTICULO_Desde_PK + '] and ART.CateArti <= [' + This.f_ARTICULO_CATEGORIADEARTICULO_Hasta_PK + '] and " + ;
			"ART.ClasifArt >= [' + This.f_ARTICULO_CLASIFICACION_Desde_PK + '] and ART.ClasifArt <= [' + This.f_ARTICULO_CLASIFICACION_Hasta_PK + '] and " + ;
			"ART.TipoArti >= [' + This.f_ARTICULO_TIPODEARTICULO_Desde_PK + '] and ART.TipoArti <= [' + This.f_ARTICULO_TIPODEARTICULO_Hasta_PK + '] and " + ;
			"DTos( ART.FALTAFW ) >= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Desde ) + '] and DTos( ART.FALTAFW ) <= [' + dtos( This.f_ARTICULO_FECHAALTAFW_Hasta ) + '] and " + ;
			"DTos( ART.FMODIFW ) >= [' + dtos( This.f_ARTICULO_FECHAMODIFICACIONFW_Desde ) + '] and DTos( ART.FMODIFW ) <= [' + dtos( This.f_ARTICULO_FECHAMODIFICACIONFW_Hasta ) + '] and " + ;
			"DTos( ART.FECTRANS ) >= [' + dtos( This.f_ARTICULO_FECHATRANSFERENCIA_Desde ) + '] and DTos( ART.FECTRANS ) <= [' + dtos( This.f_ARTICULO_FECHATRANSFERENCIA_Hasta ) + '] and " + ;
			"DTos( ART.FECIMPO ) >= [' + dtos( This.f_ARTICULO_FECHAIMPO_Desde ) + '] and DTos( ART.FECIMPO ) <= [' + dtos( This.f_ARTICULO_FECHAIMPO_Hasta ) + '] and " + ;
			"DTos( ART.FECEXPO ) >= [' + dtos( This.f_ARTICULO_FECHAEXPO_Desde ) + '] and DTos( ART.FECEXPO ) <= [' + dtos( This.f_ARTICULO_FECHAEXPO_Hasta ) + '] and " + ;
			"ART.ASTOCK >= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Desde ) + ' and ART.ASTOCK <= ' + transform( This.f_ARTICULO_COMPORTAMIENTO_Hasta ) + ' and " + ;
			"ART.ARTNARBA >= [' + This.f_ARTICULO_NOMENCLADOR_Desde_PK + '] and ART.ARTNARBA <= [' + This.f_ARTICULO_NOMENCLADOR_Hasta_PK + '] and " + ;
			"ART.PalCol >= [' + This.f_ARTICULO_PALETADECOLORES_Desde_PK + '] and ART.PalCol <= [' + This.f_ARTICULO_PALETADECOLORES_Hasta_PK + '] and " + ;
			"ART.Curtall >= [' + This.f_ARTICULO_CURVADETALLES_Desde_PK + '] and ART.Curtall <= [' + This.f_ARTICULO_CURVADETALLES_Hasta_PK + '] and " + ;
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
		lcRetorno = lcRetorno + ',TALLE'
		return lcRetorno
	endfunc

*------------------------------------------------------------------------------------
	Function ObtenerSentenciaInsertAtributosArticulos( tcCursor as String ) as String
		return '( ARTICULO ) values ( ' + tcCursor + '.' + 'ARTCOD )' 
	endfunc
	*------------------------------------------------------------------------------------
	Function ObtenerSentenciaInsertAtributosCombinacion( tcCursor as String ) as String
		return '( ARTICULO, CCOLOR, TALLE ) values ( ' + tcCursor + '.' + 'COART, ' + tcCursor + '.' + 'COCOL, ' + tcCursor + '.' + 'TALLE )' 
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerCamposEstadosDeStock() as string
		return 'CANTIDAD,PEDCOMP,PEDIDO,PREPARADO,PRESUPUESTADO,SENIADO,ENTRANSITO'
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerCamposAtributosCombinacionDeStock() as string
		return 'COART, COCOL, TALLE'
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
	<row idcomp="12" idcompafectado="11" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="8"/>
	<row idcomp="5" idcompafectado="12" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="9"/>
	<row idcomp="11" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="10"/>
	<row idcomp="23" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="11"/>
	<row idcomp="27" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="12"/>
	<row idcomp="28" idcompafectado="12" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="13"/>
	<row idcomp="3" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="14"/>
	<row idcomp="5" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="15"/>
	<row idcomp="28" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="16"/>
	<row idcomp="28" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="17"/>
	<row idcomp="28" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="18"/>
	<row idcomp="1" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="19"/>
	<row idcomp="1" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="20"/>
	<row idcomp="1" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="21"/>
	<row idcomp="2" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="22"/>
	<row idcomp="2" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="23"/>
	<row idcomp="2" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="24"/>
	<row idcomp="27" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="25"/>
	<row idcomp="27" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="26"/>
	<row idcomp="27" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="27"/>
	<row idcomp="33" idcompafectado="35" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="28"/>
	<row idcomp="35" idcompafectado="33" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="29"/>
	<row idcomp="33" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="30"/>
	<row idcomp="12" idcompafectado="23" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="31"/>
	<row idcomp="12" idcompafectado="25" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="32"/>
	<row idcomp="30" idcompafectado="39" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="33"/>
	<row idcomp="38" idcompafectado="30" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="34"/>
	<row idcomp="40" idcompafectado="38" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="35"/>
	<row idcomp="8" idcompafectado="40" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="36"/>
	<row idcomp="10" idcompafectado="8" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="37"/>
	<row idcomp="41" idcompafectado="39" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="38"/>
	<row idcomp="41" idcompafectado="30" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="39"/>
	<row idcomp="41" idcompafectado="38" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="40"/>
	<row idcomp="41" idcompafectado="40" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="41"/>
	<row idcomp="10" idcompafectado="41" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="42"/>
	<row idcomp="39" idcompafectado="42" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="43"/>
	<row idcomp="41" idcompafectado="42" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="44"/>
	<row idcomp="1" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="45"/>
	<row idcomp="1" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="46"/>
	<row idcomp="8" idcompafectado="38" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="47"/>
	<row idcomp="8" idcompafectado="30" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="48"/>
	<row idcomp="47" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="49"/>
	<row idcomp="47" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="50"/>
	<row idcomp="47" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="51"/>
	<row idcomp="47" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="52"/>
	<row idcomp="48" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="53"/>
	<row idcomp="48" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="54"/>
	<row idcomp="48" idcompafectado="12" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="55"/>
	<row idcomp="48" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="56"/>
	<row idcomp="47" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="57"/>
	<row idcomp="47" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="58"/>
	<row idcomp="47" idcompafectado="48" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="59"/>
	<row idcomp="48" idcompafectado="47" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="60"/>
	<row idcomp="2" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="61"/>
	<row idcomp="2" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="62"/>
	<row idcomp="27" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="63"/>
	<row idcomp="27" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="64"/>
	<row idcomp="4" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="65"/>
	<row idcomp="6" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="66"/>
	<row idcomp="29" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="67"/>
	<row idcomp="36" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="68"/>
	<row idcomp="49" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="69"/>
	<row idcomp="33" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="70"/>
	<row idcomp="11" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="71"/>
	<row idcomp="11" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="72"/>
	<row idcomp="11" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="73"/>
	<row idcomp="54" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="74"/>
	<row idcomp="54" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="75"/>
	<row idcomp="54" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="76"/>
	<row idcomp="54" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="77"/>
	<row idcomp="54" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="78"/>
	<row idcomp="54" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="79"/>
	<row idcomp="27" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="80"/>
	<row idcomp="54" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="81"/>
	<row idcomp="1" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="82"/>
	<row idcomp="2" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="83"/>
	<row idcomp="55" idcompafectado="12" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="84"/>
	<row idcomp="55" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="85"/>
	<row idcomp="55" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="86"/>
	<row idcomp="55" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="87"/>
	<row idcomp="55" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="88"/>
	<row idcomp="28" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="89"/>
	<row idcomp="56" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="90"/>
	<row idcomp="3" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="91"/>
	<row idcomp="11" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="92"/>
	<row idcomp="5" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="93"/>
	<row idcomp="48" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="94"/>
	<row idcomp="47" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="95"/>
	<row idcomp="57" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="96"/>
	<row idcomp="57" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="97"/>
	<row idcomp="1" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="98"/>
	<row idcomp="2" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="99"/>
	<row idcomp="11" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="100"/>
	<row idcomp="12" idcompafectado="57" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="101"/>
	<row idcomp="27" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="102"/>
	<row idcomp="33" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="103"/>
	<row idcomp="47" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="104"/>
	<row idcomp="54" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="105"/>
	<row idcomp="3" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="106"/>
	<row idcomp="3" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="107"/>
	<row idcomp="3" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="108"/>
	<row idcomp="3" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="109"/>
	<row idcomp="5" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="110"/>
	<row idcomp="5" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="111"/>
	<row idcomp="5" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="112"/>
	<row idcomp="5" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="113"/>
	<row idcomp="28" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="114"/>
	<row idcomp="28" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="115"/>
	<row idcomp="28" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="116"/>
	<row idcomp="28" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="117"/>
	<row idcomp="55" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="118"/>
	<row idcomp="55" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="119"/>
	<row idcomp="55" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="120"/>
	<row idcomp="55" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="121"/>
	<row idcomp="35" idcompafectado="36" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="122"/>
	<row idcomp="48" idcompafectado="49" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="123"/>
	<row idcomp="51" idcompafectado="11" modifica_stock="false" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="124"/>
	<row idcomp="51" idcompafectado="3" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="125"/>
	<row idcomp="51" idcompafectado="5" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="126"/>
	<row idcomp="51" idcompafectado="28" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="127"/>
	<row idcomp="51" idcompafectado="23" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="128"/>
	<row idcomp="51" idcompafectado="25" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="129"/>
	<row idcomp="51" idcompafectado="55" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="130"/>
	<row idcomp="51" idcompafectado="57" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="true" _idregistro="131"/>
	<row idcomp="52" idcompafectado="1" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="132"/>
	<row idcomp="52" idcompafectado="2" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="133"/>
	<row idcomp="52" idcompafectado="12" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="134"/>
	<row idcomp="52" idcompafectado="27" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="135"/>
	<row idcomp="52" idcompafectado="54" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="136"/>
	<row idcomp="52" idcompafectado="4" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="137"/>
	<row idcomp="52" idcompafectado="6" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="138"/>
	<row idcomp="52" idcompafectado="29" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="139"/>
	<row idcomp="52" idcompafectado="56" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="140"/>
	<row idcomp="53" idcompafectado="11" modifica_stock="true" version_exe="0.00" version_zoo="0" version_cli="0" modi_afestock="false" _idregistro="141"/>
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
		loColeccion.Agregar( 'AGRUPALISTADOSPERSONALIZADOS','AGRUPALISTADOSPERSONALIZADOS' )
		loColeccion.Agregar( 'AGRUPAMIENTODEBUZONES','AGRUPAMIENTODEBUZONES' )
		loColeccion.Agregar( 'AJUSTECCCLIENTE','AJUSTECCCLIENTE' )
		loColeccion.Agregar( 'AJUSTECCPROVEEDOR','AJUSTECCPROVEEDOR' )
		loColeccion.Agregar( 'AJUSTECHEQUERECHAZADO','AJUSTECHEQUERECHAZADO' )
		loColeccion.Agregar( 'AJUSTEDEESTADOS','AJUSTEDEESTADOS' )
		loColeccion.Agregar( 'AJUSTEDESTOCK','AJUSTEDESTOCK' )
		loColeccion.Agregar( 'ALIVIODECAJA','ALIVIODECAJA' )
		loColeccion.Agregar( 'APERTURAAUTOMATICAENTIDADES','APERTURAAUTOMATICAENTIDADES' )
		loColeccion.Agregar( 'APERTURAEJERCICIO','APERTURAEJERCICIO' )
		loColeccion.Agregar( 'ARQUEODECAJA','ARQUEODECAJA' )
		loColeccion.Agregar( 'ARTICULO','ARTICULO' )
		loColeccion.Agregar( 'ASIENTO','ASIENTO' )
		loColeccion.Agregar( 'ASIENTOTIPO','ASIENTOTIPO' )
		loColeccion.Agregar( 'ASIGNARZBD','ASIGNARZBD' )
		loColeccion.Agregar( 'ASOCIACIONARTICULOSOPERACIONESAFIP','ASOCIACIONARTICULOSOPERACIONESAFIP' )
		loColeccion.Agregar( 'ACCIONESAUTOMATICAS','ACCIONESAUTOMATICAS' )
		loColeccion.Agregar( 'BASEDEDATOS','BASEDEDATOS' )
		loColeccion.Agregar( 'BOLSASYCAJAS','BOLSASYCAJAS' )
		loColeccion.Agregar( 'BUZON','BUZON' )
		loColeccion.Agregar( 'CAEA','CAEA' )
		loColeccion.Agregar( 'CAEAINFORMA','CAEAINFORMA' )
		loColeccion.Agregar( 'CAEPORLOTE','CAEPORLOTE' )
		loColeccion.Agregar( 'CAI','CAI' )
		loColeccion.Agregar( 'CALCULODEPRECIOS','CALCULODEPRECIOS' )
		loColeccion.Agregar( 'CANCELACIONDECOMPRA','CANCELACIONDECOMPRA' )
		loColeccion.Agregar( 'CANCELACIONDESENIAS','CANCELACIONDESENIAS' )
		loColeccion.Agregar( 'CANJEDECUPONES','CANJEDECUPONES' )
		loColeccion.Agregar( 'CATEGORIADEARTICULO','CATEGORIADEARTICULO' )
		loColeccion.Agregar( 'CATEGORIASECOMMERCE','CATEGORIASECOMMERCE' )
		loColeccion.Agregar( 'CATEGORIASGOOGLESHOPPING','CATEGORIASGOOGLESHOPPING' )
		loColeccion.Agregar( 'CENTRODECOSTO','CENTRODECOSTO' )
		loColeccion.Agregar( 'CHEQUE','CHEQUE' )
		loColeccion.Agregar( 'CHEQUEPROPIO','CHEQUEPROPIO' )
		loColeccion.Agregar( 'CHEQUERA','CHEQUERA' )
		loColeccion.Agregar( 'CIERREDELOTE','CIERREDELOTE' )
		loColeccion.Agregar( 'CIERREEJERCICIO','CIERREEJERCICIO' )
		loColeccion.Agregar( 'CLASEDETARJETA','CLASEDETARJETA' )
		loColeccion.Agregar( 'CLASIFICACIONARTICULO','CLASIFICACIONARTICULO' )
		loColeccion.Agregar( 'CLASIFICACIONCONCEPTOCAJA','CLASIFICACIONCONCEPTOCAJA' )
		loColeccion.Agregar( 'CLASIFICACIONCONCEPTOPAGO','CLASIFICACIONCONCEPTOPAGO' )
		loColeccion.Agregar( 'CLAVESECRETAREST','CLAVESECRETAREST' )
		loColeccion.Agregar( 'CLIENTE','CLIENTE' )
		loColeccion.Agregar( 'CLIENTEECOMMERCE','CLIENTEECOMMERCE' )
		loColeccion.Agregar( 'CODBARRAALTER','CODBARRAALTER' )
		loColeccion.Agregar( 'CODIGOAUTORIZACIONDJCP','CODIGOAUTORIZACIONDJCP' )
		loColeccion.Agregar( 'CODIGODESERVICIO','CODIGODESERVICIO' )
		loColeccion.Agregar( 'COLOR','COLOR' )
		loColeccion.Agregar( 'COMISION','COMISION' )
		loColeccion.Agregar( 'COMPORTAMIENTOCODIGOSUGERIDOENTIDAD','COMPORTAMIENTOCODIGOSUGERIDOENTIDAD' )
		loColeccion.Agregar( 'COMPROBANTEDECAJA','COMPROBANTEDECAJA' )
		loColeccion.Agregar( 'COMPROBANTEDERETENCIONES','COMPROBANTEDERETENCIONES' )
		loColeccion.Agregar( 'COMPROBANTEDERETENCIONESGANANCIAS','COMPROBANTEDERETENCIONESGANANCIAS' )
		loColeccion.Agregar( 'COMPROBANTEDERETENCIONESIVA','COMPROBANTEDERETENCIONESIVA' )
		loColeccion.Agregar( 'COMPROBANTEDERETENCIONESSUSS','COMPROBANTEDERETENCIONESSUSS' )
		loColeccion.Agregar( 'COMPROBANTEDERETENCIONRECIBIDO','COMPROBANTEDERETENCIONRECIBIDO' )
		loColeccion.Agregar( 'COMPROBANTEPAGO','COMPROBANTEPAGO' )
		loColeccion.Agregar( 'COMPROBANTESECOMMERCE','COMPROBANTESECOMMERCE' )
		loColeccion.Agregar( 'CONCEPTOCAJA','CONCEPTOCAJA' )
		loColeccion.Agregar( 'CONCEPTOENTIDADFINANCIERA','CONCEPTOENTIDADFINANCIERA' )
		loColeccion.Agregar( 'CONCEPTOLIQUIDACIONTARJETA','CONCEPTOLIQUIDACIONTARJETA' )
		loColeccion.Agregar( 'CONCEPTOPAGO','CONCEPTOPAGO' )
		loColeccion.Agregar( 'CONCILIACIONDECAJA','CONCILIACIONDECAJA' )
		loColeccion.Agregar( 'CONCILIACIONES','CONCILIACIONES' )
		loColeccion.Agregar( 'CONDICIONDEPAGO','CONDICIONDEPAGO' )
		loColeccion.Agregar( 'CONDICIONIMPO','CONDICIONIMPO' )
		loColeccion.Agregar( 'CONFIGURACIONARTICULOECOMMERCE','CONFIGURACIONARTICULOECOMMERCE' )
		loColeccion.Agregar( 'CONTABILIZACION','CONTABILIZACION' )
		loColeccion.Agregar( 'CONVERSION','CONVERSION' )
		loColeccion.Agregar( 'CONVERSIONVALORES','CONVERSIONVALORES' )
		loColeccion.Agregar( 'COTIZACION','COTIZACION' )
		loColeccion.Agregar( 'COTIZACIONPRODUCCION','COTIZACIONPRODUCCION' )
		loColeccion.Agregar( 'CRITERIOSVALORES','CRITERIOSVALORES' )
		loColeccion.Agregar( 'CUENTABANCARIA','CUENTABANCARIA' )
		loColeccion.Agregar( 'CUENTACORREO','CUENTACORREO' )
		loColeccion.Agregar( 'CUPON','CUPON' )
		loColeccion.Agregar( 'CURVADEPRODUCCION','CURVADEPRODUCCION' )
		loColeccion.Agregar( 'CURVADETALLES','CURVADETALLES' )
		loColeccion.Agregar( 'CAJAESTADO','CAJAESTADO' )
		loColeccion.Agregar( 'CATEGORIACLIENTE','CATEGORIACLIENTE' )
		loColeccion.Agregar( 'CLASIFICACIONCLIENTE','CLASIFICACIONCLIENTE' )
		loColeccion.Agregar( 'CLASIFICACIONPROVEEDOR','CLASIFICACIONPROVEEDOR' )
		loColeccion.Agregar( 'CLASIFICACIONVENDEDOR','CLASIFICACIONVENDEDOR' )
		loColeccion.Agregar( 'DATOSFISCALES','DATOSFISCALES' )
		loColeccion.Agregar( 'DATOSTARJETA','DATOSTARJETA' )
		loColeccion.Agregar( 'DESCARGADECHEQUES','DESCARGADECHEQUES' )
		loColeccion.Agregar( 'DESCUENTO','DESCUENTO' )
		loColeccion.Agregar( 'DESPACHODEIMPORTACION','DESPACHODEIMPORTACION' )
		loColeccion.Agregar( 'DESTINODESCARGACHEQUES','DESTINODESCARGACHEQUES' )
		loColeccion.Agregar( 'DEVOLUCION','DEVOLUCION' )
		loColeccion.Agregar( 'DISENOEXPO','DISENOEXPO' )
		loColeccion.Agregar( 'DISENOIMPO','DISENOIMPO' )
		loColeccion.Agregar( 'DISENOIMPRESION','DISENOIMPRESION' )
		loColeccion.Agregar( 'DISTRIBUCIONCENTRODECOSTO','DISTRIBUCIONCENTRODECOSTO' )
		loColeccion.Agregar( 'ECOMMERCE','ECOMMERCE' )
		loColeccion.Agregar( 'EJERCICIO','EJERCICIO' )
		loColeccion.Agregar( 'EMAIL','EMAIL' )
		loColeccion.Agregar( 'ENTIDADADICIONAL1','ENTIDADADICIONAL1' )
		loColeccion.Agregar( 'ENTIDADADICIONAL2','ENTIDADADICIONAL2' )
		loColeccion.Agregar( 'ENTIDADADICIONAL3','ENTIDADADICIONAL3' )
		loColeccion.Agregar( 'ENTIDADFINANCIERA','ENTIDADFINANCIERA' )
		loColeccion.Agregar( 'ENTREGADEMERCADERIAS','ENTREGADEMERCADERIAS' )
		loColeccion.Agregar( 'ENVIODECUENTACORRIENTEPORMAIL','ENVIODECUENTACORRIENTEPORMAIL' )
		loColeccion.Agregar( 'ENVIODEMENSAJERIA','ENVIODEMENSAJERIA' )
		loColeccion.Agregar( 'EQUIVALORLINCE','EQUIVALORLINCE' )
		loColeccion.Agregar( 'ERRORSAP','ERRORSAP' )
		loColeccion.Agregar( 'ESTADOSDEINTERACCION','ESTADOSDEINTERACCION' )
		loColeccion.Agregar( 'ESTILOIMPRESION','ESTILOIMPRESION' )
		loColeccion.Agregar( 'ETIQUETASECOMMERCE','ETIQUETASECOMMERCE' )
		loColeccion.Agregar( 'EXPOAGRUPADAS','EXPOAGRUPADAS' )
		loColeccion.Agregar( 'EQUIVALENCIA','EQUIVALENCIA' )
		loColeccion.Agregar( 'FACTURA','FACTURA' )
		loColeccion.Agregar( 'FACTURAAGRUPADA','FACTURAAGRUPADA' )
		loColeccion.Agregar( 'FACTURADECOMPRA','FACTURADECOMPRA' )
		loColeccion.Agregar( 'FACTURADEEXPORTACION','FACTURADEEXPORTACION' )
		loColeccion.Agregar( 'FACTURAELECTRONICA','FACTURAELECTRONICA' )
		loColeccion.Agregar( 'FACTURAELECTRONICADECREDITO','FACTURAELECTRONICADECREDITO' )
		loColeccion.Agregar( 'FACTURAELECTRONICAEXPORTACION','FACTURAELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'FAMILIA','FAMILIA' )
		loColeccion.Agregar( 'FERIADO','FERIADO' )
		loColeccion.Agregar( 'FINALDEPRODUCCION','FINALDEPRODUCCION' )
		loColeccion.Agregar( 'FORMATOEXPORTACION','FORMATOEXPORTACION' )
		loColeccion.Agregar( 'FORMULA','FORMULA' )
		loColeccion.Agregar( 'GESTIONCHCUSTODIA','GESTIONCHCUSTODIA' )
		loColeccion.Agregar( 'GESTIONDEPRODUCCION','GESTIONDEPRODUCCION' )
		loColeccion.Agregar( 'GESTIONVENDEDOR','GESTIONVENDEDOR' )
		loColeccion.Agregar( 'GRUPOVALOR','GRUPOVALOR' )
		loColeccion.Agregar( 'GTIN','GTIN' )
		loColeccion.Agregar( 'GRUPO','GRUPO' )
		loColeccion.Agregar( 'HERRAMIENTACONCILIACION','HERRAMIENTACONCILIACION' )
		loColeccion.Agregar( 'HERRAMIENTAAGRUPADORADEPACKS','HERRAMIENTAAGRUPADORADEPACKS' )
		loColeccion.Agregar( 'IMPDIRART','IMPDIRART' )
		loColeccion.Agregar( 'IMPDIRCAJ','IMPDIRCAJ' )
		loColeccion.Agregar( 'IMPDIRCCA','IMPDIRCCA' )
		loColeccion.Agregar( 'IMPDIRCCC','IMPDIRCCC' )
		loColeccion.Agregar( 'IMPDIRCLI','IMPDIRCLI' )
		loColeccion.Agregar( 'IMPDIRCON','IMPDIRCON' )
		loColeccion.Agregar( 'IMPDIRCUE','IMPDIRCUE' )
		loColeccion.Agregar( 'IMPDIRDES','IMPDIRDES' )
		loColeccion.Agregar( 'IMPDIRIMP','IMPDIRIMP' )
		loColeccion.Agregar( 'IMPDIRLIQ','IMPDIRLIQ' )
		loColeccion.Agregar( 'IMPDIROPE','IMPDIROPE' )
		loColeccion.Agregar( 'IMPDIRPRO','IMPDIRPRO' )
		loColeccion.Agregar( 'IMPDIRVAL','IMPDIRVAL' )
		loColeccion.Agregar( 'IMPOAGRUPADAS','IMPOAGRUPADAS' )
		loColeccion.Agregar( 'IMPRIMIRCOMPROBANTEPORLOTE','IMPRIMIRCOMPROBANTEPORLOTE' )
		loColeccion.Agregar( 'IMPUESTO','IMPUESTO' )
		loColeccion.Agregar( 'IMPVERCC','IMPVERCC' )
		loColeccion.Agregar( 'INDICESINFLACION','INDICESINFLACION' )
		loColeccion.Agregar( 'INSUMO','INSUMO' )
		loColeccion.Agregar( 'INTERACCIONDEORDEN','INTERACCIONDEORDEN' )
		loColeccion.Agregar( 'INVENTARIO','INVENTARIO' )
		loColeccion.Agregar( 'IMPRESIONDEETIQUETA','IMPRESIONDEETIQUETA' )
		loColeccion.Agregar( 'LIMITECONSUMO','LIMITECONSUMO' )
		loColeccion.Agregar( 'LINEASUCURSAL','LINEASUCURSAL' )
		loColeccion.Agregar( 'LINKQRENETIQUETA','LINKQRENETIQUETA' )
		loColeccion.Agregar( 'LIQUIDACIONDETALLER','LIQUIDACIONDETALLER' )
		loColeccion.Agregar( 'LIQUIDACIONDIARIA','LIQUIDACIONDIARIA' )
		loColeccion.Agregar( 'LIQUIDACIONMENSUAL','LIQUIDACIONMENSUAL' )
		loColeccion.Agregar( 'LISTADECOSTOSDEPRODUCCION','LISTADECOSTOSDEPRODUCCION' )
		loColeccion.Agregar( 'LISTADEPRECIOS','LISTADEPRECIOS' )
		loColeccion.Agregar( 'LISTADEPRECIOSCALCULADA','LISTADEPRECIOSCALCULADA' )
		loColeccion.Agregar( 'LINEA','LINEA' )
		loColeccion.Agregar( 'MAILPORLOTE','MAILPORLOTE' )
		loColeccion.Agregar( 'MAQUINARIA','MAQUINARIA' )
		loColeccion.Agregar( 'MARCA','MARCA' )
		loColeccion.Agregar( 'MINIMOREPOSICION','MINIMOREPOSICION' )
		loColeccion.Agregar( 'MODELODEPRODUCCION','MODELODEPRODUCCION' )
		loColeccion.Agregar( 'MODIFICACIONDECOSTOSDEPRODUCCION','MODIFICACIONDECOSTOSDEPRODUCCION' )
		loColeccion.Agregar( 'MODIFICACIONPRECIOS','MODIFICACIONPRECIOS' )
		loColeccion.Agregar( 'MONEDA','MONEDA' )
		loColeccion.Agregar( 'MOTIVO','MOTIVO' )
		loColeccion.Agregar( 'MOTIVODESCARTE','MOTIVODESCARTE' )
		loColeccion.Agregar( 'MOTIVODESCUENTOYDEVOLUCION','MOTIVODESCUENTOYDEVOLUCION' )
		loColeccion.Agregar( 'MOVIMIENTOBANCARIO','MOVIMIENTOBANCARIO' )
		loColeccion.Agregar( 'MOVIMIENTODESTOCK','MOVIMIENTODESTOCK' )
		loColeccion.Agregar( 'MOVIMIENTOSTOCKAINVENT','MOVIMIENTOSTOCKAINVENT' )
		loColeccion.Agregar( 'MOVIMIENTOSTOCKAPRODUCC','MOVIMIENTOSTOCKAPRODUCC' )
		loColeccion.Agregar( 'MOVIMIENTOSTOCKDESDEPRODUCC','MOVIMIENTOSTOCKDESDEPRODUCC' )
		loColeccion.Agregar( 'MATERIAL','MATERIAL' )
		loColeccion.Agregar( 'MERCADERIAENTRANSITO','MERCADERIAENTRANSITO' )
		loColeccion.Agregar( 'NOMBREDEFANTASIA','NOMBREDEFANTASIA' )
		loColeccion.Agregar( 'NOMENCLADORARBA','NOMENCLADORARBA' )
		loColeccion.Agregar( 'NOTADECREDITO','NOTADECREDITO' )
		loColeccion.Agregar( 'NOTADECREDITOAGRUPADA','NOTADECREDITOAGRUPADA' )
		loColeccion.Agregar( 'NOTADECREDITOCOMPRA','NOTADECREDITOCOMPRA' )
		loColeccion.Agregar( 'NOTADECREDITODEEXPORTACION','NOTADECREDITODEEXPORTACION' )
		loColeccion.Agregar( 'NOTADECREDITOELECTRONICA','NOTADECREDITOELECTRONICA' )
		loColeccion.Agregar( 'NOTADECREDITOELECTRONICADECREDITO','NOTADECREDITOELECTRONICADECREDITO' )
		loColeccion.Agregar( 'NOTADECREDITOELECTRONICAEXPORTACION','NOTADECREDITOELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'NOTADEDEBITO','NOTADEDEBITO' )
		loColeccion.Agregar( 'NOTADEDEBITOAGRUPADA','NOTADEDEBITOAGRUPADA' )
		loColeccion.Agregar( 'NOTADEDEBITOCOMPRA','NOTADEDEBITOCOMPRA' )
		loColeccion.Agregar( 'NOTADEDEBITODEEXPORTACION','NOTADEDEBITODEEXPORTACION' )
		loColeccion.Agregar( 'NOTADEDEBITOELECTRONICA','NOTADEDEBITOELECTRONICA' )
		loColeccion.Agregar( 'NOTADEDEBITOELECTRONICADECREDITO','NOTADEDEBITOELECTRONICADECREDITO' )
		loColeccion.Agregar( 'NOTADEDEBITOELECTRONICAEXPORTACION','NOTADEDEBITOELECTRONICAEXPORTACION' )
		loColeccion.Agregar( 'NUMERACIONES','NUMERACIONES' )
		loColeccion.Agregar( 'OBJETIVOSVENTA','OBJETIVOSVENTA' )
		loColeccion.Agregar( 'OPERACIONECOMMERCE','OPERACIONECOMMERCE' )
		loColeccion.Agregar( 'OPERADORADETARJETA','OPERADORADETARJETA' )
		loColeccion.Agregar( 'ORDENDEPAGO','ORDENDEPAGO' )
		loColeccion.Agregar( 'ORDENDEPRODUCCION','ORDENDEPRODUCCION' )
		loColeccion.Agregar( 'ORDENDESERVICIO','ORDENDESERVICIO' )
		loColeccion.Agregar( 'ORIGENDEDATOS','ORIGENDEDATOS' )
		loColeccion.Agregar( 'PAGO','PAGO' )
		loColeccion.Agregar( 'PAISES','PAISES' )
		loColeccion.Agregar( 'PALETADECOLORES','PALETADECOLORES' )
		loColeccion.Agregar( 'PEDIDO','PEDIDO' )
		loColeccion.Agregar( 'PEDIDODECOMPRA','PEDIDODECOMPRA' )
		loColeccion.Agregar( 'PLANDECUENTAS','PLANDECUENTAS' )
		loColeccion.Agregar( 'POS','POS' )
		loColeccion.Agregar( 'PREPARACIONDEMERCADERIA','PREPARACIONDEMERCADERIA' )
		loColeccion.Agregar( 'PRESUPUESTODECOMPRA','PRESUPUESTODECOMPRA' )
		loColeccion.Agregar( 'PROCESARNCPENDIENTEPROMOBANCO','PROCESARNCPENDIENTEPROMOBANCO' )
		loColeccion.Agregar( 'PROCESOPRODUCCION','PROCESOPRODUCCION' )
		loColeccion.Agregar( 'PROMOCION','PROMOCION' )
		loColeccion.Agregar( 'PROVEEDOR','PROVEEDOR' )
		loColeccion.Agregar( 'PROVINCIA','PROVINCIA' )
		loColeccion.Agregar( 'PUNTOSDEVENTA','PUNTOSDEVENTA' )
		loColeccion.Agregar( 'PASAJEDESTOCK','PASAJEDESTOCK' )
		loColeccion.Agregar( 'PICKING','PICKING' )
		loColeccion.Agregar( 'PRESUPUESTO','PRESUPUESTO' )
		loColeccion.Agregar( 'RAZONSOCIAL','RAZONSOCIAL' )
		loColeccion.Agregar( 'RECIBO','RECIBO' )
		loColeccion.Agregar( 'REGIMENIMPOSITIVO','REGIMENIMPOSITIVO' )
		loColeccion.Agregar( 'REGISTRODECOSTOS','REGISTRODECOSTOS' )
		loColeccion.Agregar( 'REGISTRODECUENTA','REGISTRODECUENTA' )
		loColeccion.Agregar( 'REGISTRODEMANTENIMIENTO','REGISTRODEMANTENIMIENTO' )
		loColeccion.Agregar( 'REMITO','REMITO' )
		loColeccion.Agregar( 'REMITODECOMPRA','REMITODECOMPRA' )
		loColeccion.Agregar( 'REMITOELECTRONICO','REMITOELECTRONICO' )
		loColeccion.Agregar( 'RENUMERAASIENTOS','RENUMERAASIENTOS' )
		loColeccion.Agregar( 'REPORTEAUDITORIACIERREZ','REPORTEAUDITORIACIERREZ' )
		loColeccion.Agregar( 'REPORTEELECTRONICO','REPORTEELECTRONICO' )
		loColeccion.Agregar( 'REQUERIMIENTODECOMPRA','REQUERIMIENTODECOMPRA' )
		loColeccion.Agregar( 'REDONDEODEPRECIOS','REDONDEODEPRECIOS' )
		loColeccion.Agregar( 'REGLASTRANSFERENCIAS','REGLASTRANSFERENCIAS' )
		loColeccion.Agregar( 'SALTODECAMPO','SALTODECAMPO' )
		loColeccion.Agregar( 'SCRIPT','SCRIPT' )
		loColeccion.Agregar( 'SEGMENTACION','SEGMENTACION' )
		loColeccion.Agregar( 'SENIA','SENIA' )
		loColeccion.Agregar( 'SERVICIOREST','SERVICIOREST' )
		loColeccion.Agregar( 'SOLICITUDDECOMPRA','SOLICITUDDECOMPRA' )
		loColeccion.Agregar( 'SUCURSAL','SUCURSAL' )
		loColeccion.Agregar( 'SUCURSALBANCARIA','SUCURSALBANCARIA' )
		loColeccion.Agregar( 'TALLE','TALLE' )
		loColeccion.Agregar( 'TALLER','TALLER' )
		loColeccion.Agregar( 'TALONARIO','TALONARIO' )
		loColeccion.Agregar( 'TICKETFACTURA','TICKETFACTURA' )
		loColeccion.Agregar( 'TICKETNOTADECREDITO','TICKETNOTADECREDITO' )
		loColeccion.Agregar( 'TICKETNOTADEDEBITO','TICKETNOTADEDEBITO' )
		loColeccion.Agregar( 'TIDIFERENCIASDEINVENTARIO','TIDIFERENCIASDEINVENTARIO' )
		loColeccion.Agregar( 'TIDIFERENCIASDEINVENTARIODETALLE','TIDIFERENCIASDEINVENTARIODETALLE' )
		loColeccion.Agregar( 'TIINVENTARIOACONT','TIINVENTARIOACONT' )
		loColeccion.Agregar( 'TIINVENTARIOFISICO','TIINVENTARIOFISICO' )
		loColeccion.Agregar( 'TIINVENTARIOFISICODETALLE','TIINVENTARIOFISICODETALLE' )
		loColeccion.Agregar( 'TIPODEARTICULO','TIPODEARTICULO' )
		loColeccion.Agregar( 'TIPODEDIRECCION','TIPODEDIRECCION' )
		loColeccion.Agregar( 'TIPODEOPERACIONAFIP','TIPODEOPERACIONAFIP' )
		loColeccion.Agregar( 'TIPODEORDEN','TIPODEORDEN' )
		loColeccion.Agregar( 'TIPOIMPUESTO','TIPOIMPUESTO' )
		loColeccion.Agregar( 'TIPOOBJETIVO','TIPOOBJETIVO' )
		loColeccion.Agregar( 'TIPOSUCURSAL','TIPOSUCURSAL' )
		loColeccion.Agregar( 'TRANSFERENCIAENTRECUENTAS','TRANSFERENCIAENTRECUENTAS' )
		loColeccion.Agregar( 'TRANSPORTISTA','TRANSPORTISTA' )
		loColeccion.Agregar( 'TRATAMIENTOCOMPROBANTES','TRATAMIENTOCOMPROBANTES' )
		loColeccion.Agregar( 'TEMPORADA','TEMPORADA' )
		loColeccion.Agregar( 'TIPOCLIENTE','TIPOCLIENTE' )
		loColeccion.Agregar( 'UNIDADDEMEDIDAARBA','UNIDADDEMEDIDAARBA' )
		loColeccion.Agregar( 'UNIDADDEMEDIDA','UNIDADDEMEDIDA' )
		loColeccion.Agregar( 'VALEDECAMBIO','VALEDECAMBIO' )
		loColeccion.Agregar( 'VALOR','VALOR' )
		loColeccion.Agregar( 'VALORESENTRANSITO','VALORESENTRANSITO' )
		loColeccion.Agregar( 'VENDEDOR','VENDEDOR' )
		loColeccion.Agregar( 'WEBHOOK','WEBHOOK' )
		loColeccion.Agregar( 'ZUDESCARGALAN','ZUDESCARGALAN' )
		loColeccion.Agregar( 'AGRUPAMIENTO','AGRUPAMIENTO' )
		loColeccion.Agregar( 'DISENOTRANSFORMACIONLINCE','DISENOTRANSFORMACIONLINCE' )
		return loColeccion
	endfunc

	*------------------------------------------------------------------------------------
	Function ObtenerCamposAtributosCombinacionConcatenados() as string
		return 'ARTICULO, CCOLOR, TALLE'
	endfunc

	*-----------------------------------------------------------------------------------------
	Function ObtenerValidacionesDeFiltrosDeDescuentos() as String
		local lcRetorno as String
		
		text to lcRetorno textmerge noshow
			iif( .nEvitar = 3, .T., this.ValidarCaracteres( .ListaDesde, .ListaHasta, this.oEntidadPadre.LISTADEPRECIOS_PK ) ) and iif( .nEvitar = 2, .T., this.ValidarCaracteres( .VendDesde, .VendHasta, this.oEntidadPadre.VENDEDOR_PK ) ) and iif( .nEvitar = 2, .T., this.ValidarCaracteres( .Vendedor_ClasificacionVDesde, .Vendedor_ClasificacionVHasta, this.oEntidadPadre.VENDEDOR.Clasificacion_PK ) ) and iif( .nEvitar = 1, .T., this.ValidarCaracteres( .Cliente_ClasificacionCDesde, .Cliente_ClasificacionCHasta, this.oEntidadPadre.CLIENTE.Clasificacion_PK ) ) and iif( .nEvitar = 1, .T., this.ValidarCaracteres( .Cliente_TipoCDesde, .Cliente_TipoCHasta, this.oEntidadPadre.CLIENTE.TipoCli_PK ) ) and iif( .nEvitar = 1, .T., this.ValidarCaracteres( .Cliente_CategoriaCDesde, .Cliente_CategoriaCHasta, this.oEntidadPadre.CLIENTE.CategCli_PK ) ) and .T.
		endtext
		
		return lcRetorno
	endfunc

*-----------------------------------------------------------------------------------------
	Function ObtenerAtributosDeFiltrosDeDescuentos() as Object
		local loRetorno
		
		loRetorno = _screen.zoo.crearobjeto( 'ZooColeccion' )
		loRetorno.add( 'ListaDesde' )
		loRetorno.add( 'ListaHasta' )
		loRetorno.add( 'VendDesde' )
		loRetorno.add( 'VendHasta' )
		loRetorno.add( 'Vendedor_ClasificacionVDesde' )
		loRetorno.add( 'Vendedor_ClasificacionVHasta' )
		loRetorno.add( 'Cliente_ClasificacionCDesde' )
		loRetorno.add( 'Cliente_ClasificacionCHasta' )
		loRetorno.add( 'Cliente_TipoCDesde' )
		loRetorno.add( 'Cliente_TipoCHasta' )
		loRetorno.add( 'Cliente_CategoriaCDesde' )
		loRetorno.add( 'Cliente_CategoriaCHasta' )
		
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
