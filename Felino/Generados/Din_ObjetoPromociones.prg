
define class Din_ObjetoPromociones as Custom
	cCursor = ''
	cCursorPrecios = ''
	****************************************************************************************************
	Protected Function CrearCursorPromociones() as void
		Local lcCursor as String
		lcCursor = sys( 2015 )
		Create Cursor &lcCursor ( Atributo c(100), Item l, TipoDato C(1), Longitud N( 3 ), Decimales N( 2 ), ClaveForanea c(40) )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Codigo',.F., 'C', 5,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Nombre',.F., 'C', 30,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Codigo',.F., 'C', 38,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Codigo',.T., 'C', 13,0,'ARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Descripcion',.T., 'C', 40,0,'ARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Cantidad',.T., 'N', 8,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Color.Codigo',.T., 'C', 2,0,'COLOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Color.Descripcion',.T., 'C', 50,0,'COLOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Descuento',.T., 'N', 7,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.PrecioConImpuestos',.T., 'N', 15,4,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Talle',.T., 'C', 3,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.MontoDescuento',.T., 'N', 8,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.IdItemArticulos',.T., 'C', 38,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Stock',.T., 'N', 10,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Fecha',.F., 'D', 8,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ListaDePrecios.Codigo',.F., 'C', 6,0,'LISTADEPRECIOS' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ListaDePrecios.Nombre',.F., 'C', 30,0,'LISTADEPRECIOS' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'MonedaComprobante.Codigo',.F., 'C', 10,0,'MONEDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'MonedaComprobante.Descripcion',.F., 'C', 40,0,'MONEDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'PorcentajeDescuento',.F., 'N', 6,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.IdItemValores',.T., 'C', 38,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.PorcentajeDesRec',.T., 'N', 6,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.EsRetiroEfectivo',.T., 'L', 1,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'MontoDescuento3',.F., 'N', 15,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.Codigo',.F., 'C', 5,0,'SUCURSAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.Nombre',.F., 'C', 60,0,'SUCURSAL' )
		insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'HoraAltaFW', .f., 'C', 8, 0, '' )
		this.cCursor = lcCursor
	EndFunc
	****************************************************************************************************
	Function ObtenerCursorPromociones() as String
		If empty( this.cCursor )
			this.CrearCursorPromociones()
		EndIf
		Return This.cCursor
	EndFunc
	****************************************************************************************************
	
	*-----------------------------------------------------------------------------------------
	function ObtenerXmlParticipantesAltaPromociones() as String
		local lcRetorno as string
		text to lcRetorno noshow flags 1 pretext 1 + 2 + 4 + 8
			<?xml version="1.0" encoding="utf-16"?>
			<Participantes>
			<Participante Atributo="CLIENTE" Entidad="CLIENTE" Descripcion="Cliente" TipoDato="C" Longitud="5" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="5" Decimales="0" />
			<Atributo Nombre="NOMBRE" Descripcion="Nombre" TipoDato="C" Longitud="30" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="SUCURSAL" Entidad="SUCURSAL" Descripcion="Sucursal" TipoDato="C" Longitud="5" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="5" Decimales="0" />
			<Atributo Nombre="NOMBRE" Descripcion="Nombre" TipoDato="C" Longitud="60" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="MONEDACOMPROBANTE" Entidad="MONEDA" Descripcion="Moneda" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="LISTADEPRECIOS" Entidad="LISTADEPRECIOS" Descripcion="Lista de Precio" TipoDato="C" Longitud="6" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="6" Decimales="0" />
			<Atributo Nombre="NOMBRE" Descripcion="Nombre" TipoDato="C" Longitud="30" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="ARTICULO" Entidad="ARTICULO" Descripcion="Artículo" TipoDato="C" Longitud="13" Decimales="0" Detalle="FACTURADETALLE">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="13" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="COLOR" Entidad="COLOR" Descripcion="Color" TipoDato="C" Longitud="2" Decimales="0" Detalle="FACTURADETALLE">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="2" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			</Participantes>
		endtext
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	Protected Function CrearCursorPrecios() as void
		Local lcCursor as String
		lcCursor = sys( 2015 )
		Create Cursor &lcCursor ( Articulo C(13), Color C(2), Talle C(3), Lista C(6), Monedalista C(10), Precio N(8,2) )
		this.cCursorPrecios = lcCursor
	EndFunc
	****************************************************************************************************
	Function ObtenerCursorPrecios() as String
		If empty( this.cCursorPrecios )
			this.CrearCursorPrecios()
		EndIf
		Return This.cCursorPrecios
	EndFunc
	****************************************************************************************************

enddefine