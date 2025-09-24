
define class Din_ObjetoPromociones as Custom
	cCursor = ''
	cCursorPrecios = ''
	****************************************************************************************************
	Protected Function CrearCursorPromociones() as void
		Local lcCursor as String
		lcCursor = sys( 2015 )
		Create Cursor &lcCursor ( Atributo c(100), Item l, TipoDato C(1), Longitud N( 3 ), Decimales N( 2 ), ClaveForanea c(40) )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Codigo',.F., 'C', 10,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.FechaNacimiento',.F., 'D', 8,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Localidad',.F., 'C', 70,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Nombre',.F., 'C', 185,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Pais.Codigo',.F., 'C', 3,0,'PAISES' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Pais.Descripcion',.F., 'C', 30,0,'PAISES' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Provincia.Codigo',.F., 'C', 2,0,'PROVINCIA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Provincia.Descripcion',.F., 'C', 50,0,'PROVINCIA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Clasificacion.Codigo',.F., 'C', 10,0,'CLASIFICACIONCLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Clasificacion.Descripcion',.F., 'C', 50,0,'CLASIFICACIONCLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.EstadoCivil',.F., 'C', 13,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Hijos',.F., 'N', 2,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Cliente.Sexo',.F., 'C', 10,0,'CLIENTE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Codigo',.F., 'C', 38,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Codigo',.T., 'C', 15,0,'ARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Descripcion',.T., 'C', 100,0,'ARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Proveedor.Codigo',.T., 'C', 10,0,'PROVEEDOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Proveedor.Nombre',.T., 'C', 60,0,'PROVEEDOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Temporada.Codigo',.T., 'C', 5,0,'TEMPORADA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Temporada.Descripcion',.T., 'C', 50,0,'TEMPORADA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.UnidadDeMedida.Codigo',.T., 'C', 3,0,'UNIDADDEMEDIDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.UnidadDeMedida.Descripcion',.T., 'C', 50,0,'UNIDADDEMEDIDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Familia.Codigo',.T., 'C', 10,0,'FAMILIA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Familia.Descripcion',.T., 'C', 50,0,'FAMILIA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Material.Codigo',.T., 'C', 10,0,'MATERIAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Material.Descripcion',.T., 'C', 40,0,'MATERIAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Linea.Codigo',.T., 'C', 10,0,'LINEA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Linea.Descripcion',.T., 'C', 50,0,'LINEA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Grupo.Codigo',.T., 'C', 10,0,'GRUPO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Grupo.Descripcion',.T., 'C', 50,0,'GRUPO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.CategoriaDeArticulo.Codigo',.T., 'C', 10,0,'CATEGORIADEARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.CategoriaDeArticulo.Descripcion',.T., 'C', 50,0,'CATEGORIADEARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Clasificacion.Codigo',.T., 'C', 10,0,'CLASIFICACIONARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Clasificacion.Descripcion',.T., 'C', 50,0,'CLASIFICACIONARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Ano',.T., 'N', 4,0,'ARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.TipodeArticulo.Codigo',.T., 'C', 10,0,'TIPODEARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.TipodeArticulo.Descripcion',.T., 'C', 50,0,'TIPODEARTICULO' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Paletadecolores.Codigo',.T., 'C', 10,0,'PALETADECOLORES' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Paletadecolores.Descripcion',.T., 'C', 40,0,'PALETADECOLORES' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Curvadetalles.Codigo',.T., 'C', 10,0,'CURVADETALLES' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Articulo.Curvadetalles.Descripcion',.T., 'C', 40,0,'CURVADETALLES' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Cantidad',.T., 'N', 8,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Descuento',.T., 'N', 7,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.PrecioConImpuestos',.T., 'N', 15,4,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Color.Codigo',.T., 'C', 6,0,'COLOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Color.Descripcion',.T., 'C', 50,0,'COLOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Talle.Codigo',.T., 'C', 5,0,'TALLE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Talle.Descripcion',.T., 'C', 50,0,'TALLE' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.MontoDescuento',.T., 'N', 12,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.IdItemArticulos',.T., 'C', 38,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'FacturaDetalle.Stock',.T., 'N', 10,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Fecha',.F., 'D', 8,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ListaDePrecios.Codigo',.F., 'C', 6,0,'LISTADEPRECIOS' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ListaDePrecios.Nombre',.F., 'C', 30,0,'LISTADEPRECIOS' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'MonedaComprobante.Codigo',.F., 'C', 10,0,'MONEDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'MonedaComprobante.Descripcion',.F., 'C', 40,0,'MONEDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'PorcentajeDescuento',.F., 'N', 6,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Monto',.T., 'N', 15,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Total',.T., 'N', 15,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Valor.Codigo',.T., 'C', 5,0,'VALOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Valor.Descripcion',.T., 'C', 40,0,'VALOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Valor.SimboloMonetario.Codigo',.T., 'C', 10,0,'MONEDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Valor.SimboloMonetario.Descripcion',.T., 'C', 40,0,'MONEDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Valor.Tipo',.T., 'N', 2,0,'VALOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Valor.OperadoraTarjeta.Codigo',.T., 'C', 15,0,'OPERADORADETARJETA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Valor.OperadoraTarjeta.Descripcion',.T., 'C', 100,0,'OPERADORADETARJETA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Valor.TipoTarjeta',.T., 'C', 1,0,'VALOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.RecargoPorcentaje',.T., 'N', 6,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Codigo',.T., 'C', 38,0,'CUPON' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.NumeroCupon',.T., 'N', 12,0,'CUPON' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Valor.Codigo',.T., 'C', 5,0,'VALOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Valor.Descripcion',.T., 'C', 40,0,'VALOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Valor.SimboloMonetario.Codigo',.T., 'C', 10,0,'MONEDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Valor.SimboloMonetario.Descripcion',.T., 'C', 40,0,'MONEDA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Valor.Tipo',.T., 'N', 2,0,'VALOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Valor.OperadoraTarjeta.Codigo',.T., 'C', 15,0,'OPERADORADETARJETA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Valor.OperadoraTarjeta.Descripcion',.T., 'C', 100,0,'OPERADORADETARJETA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Valor.TipoTarjeta',.T., 'C', 1,0,'VALOR' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.Cuotas',.T., 'N', 3,0,'CUPON' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.EntidadFinanciera.Codigo',.T., 'C', 5,0,'ENTIDADFINANCIERA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.EntidadFinanciera.Descripcion',.T., 'C', 40,0,'ENTIDADFINANCIERA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.ClaseDeTarjeta.Codigo',.T., 'C', 5,0,'CLASEDETARJETA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.Cupon.ClaseDeTarjeta.Descripcion',.T., 'C', 40,0,'CLASEDETARJETA' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.IdItemValores',.T., 'C', 38,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.AutorizacionPOS',.T., 'L', 1,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.PorcentajeDesRec',.T., 'N', 6,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'ValoresDetalle.EsRetiroEfectivo',.T., 'L', 1,0,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'MontoDescuento3',.F., 'N', 15,2,'' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.Codigo',.F., 'C', 10,0,'SUCURSAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.Descripcion',.F., 'C', 50,0,'SUCURSAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.tipo.Codigo',.F., 'C', 10,0,'TIPOSUCURSAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.tipo.Descripcion',.F., 'C', 50,0,'TIPOSUCURSAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.Linea.Codigo',.F., 'C', 10,0,'LINEASUCURSAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.Linea.Descripcion',.F., 'C', 50,0,'LINEASUCURSAL' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.Segmentacion.Codigo',.F., 'C', 10,0,'SEGMENTACION' )
		Insert into &lcCursor ( Atributo, Item, TipoDato, Longitud, Decimales, ClaveForanea ) values ( 'Sucursal.Segmentacion.Descripcion',.F., 'C', 50,0,'SEGMENTACION' )
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
			<Participante Atributo="CLIENTE" Entidad="CLIENTE" Descripcion="Cliente" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="SEXO" Descripcion="Sexo" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="NOMBRE" Descripcion="Denominación o razón social" TipoDato="C" Longitud="185" Decimales="0" />
			<Atributo Nombre="LOCALIDAD" Descripcion="Localidad" TipoDato="C" Longitud="70" Decimales="0" />
			<Atributo Nombre="FECHANACIMIENTO" Descripcion="Fecha de nacimiento" TipoDato="D" Longitud="8" Decimales="0" />
			<Atributo Nombre="ESTADOCIVIL" Descripcion="Estado civil" TipoDato="C" Longitud="13" Decimales="0" />
			<Atributo Nombre="HIJOS" Descripcion="Cantidad de hijos" TipoDato="N" Longitud="2" Decimales="0" />
			<Participante Atributo="PROVINCIA" Entidad="PROVINCIA" Descripcion="Provincia" TipoDato="C" Longitud="2" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="2" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="PAIS" Entidad="PAISES" Descripcion="País" TipoDato="C" Longitud="3" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="3" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="30" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="CLASIFICACION" Entidad="CLASIFICACIONCLIENTE" Descripcion="Clasificación" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			</Atributos>
			</Participante>
			<Participante Atributo="SUCURSAL" Entidad="SUCURSAL" Descripcion="Sucursal" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			<Participante Atributo="TIPO" Entidad="TIPOSUCURSAL" Descripcion="Tipo" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="LINEA" Entidad="LINEASUCURSAL" Descripcion="Línea" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="SEGMENTACION" Entidad="SEGMENTACION" Descripcion="Segmentación" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			</Atributos>
			</Participante>
			<Participante Atributo="MONEDACOMPROBANTE" Entidad="MONEDA" Descripcion="Moneda" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="LISTADEPRECIOS" Entidad="LISTADEPRECIOS" Descripcion="Lista de precio" TipoDato="C" Longitud="6" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="6" Decimales="0" />
			<Atributo Nombre="NOMBRE" Descripcion="Nombre" TipoDato="C" Longitud="30" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="ARTICULO" Entidad="ARTICULO" Descripcion="Artículo" TipoDato="C" Longitud="15" Decimales="0" Detalle="FACTURADETALLE">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="15" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="100" Decimales="0" />
			<Atributo Nombre="ANO" Descripcion="Año" TipoDato="N" Longitud="4" Decimales="0" />
			<Participante Atributo="PROVEEDOR" Entidad="PROVEEDOR" Descripcion="Proveedor" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="NOMBRE" Descripcion="Nombre" TipoDato="C" Longitud="60" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="UNIDADDEMEDIDA" Entidad="UNIDADDEMEDIDA" Descripcion="Unidad de medida" TipoDato="C" Longitud="3" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="3" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="TEMPORADA" Entidad="TEMPORADA" Descripcion="Temporada" TipoDato="C" Longitud="5" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="5" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="FAMILIA" Entidad="FAMILIA" Descripcion="Familia" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="MATERIAL" Entidad="MATERIAL" Descripcion="Material" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="LINEA" Entidad="LINEA" Descripcion="Línea" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="GRUPO" Entidad="GRUPO" Descripcion="Grupo" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="CATEGORIADEARTICULO" Entidad="CATEGORIADEARTICULO" Descripcion="Categoría" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="CLASIFICACION" Entidad="CLASIFICACIONARTICULO" Descripcion="Clasificación" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="TIPODEARTICULO" Entidad="TIPODEARTICULO" Descripcion="Tipo" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="PALETADECOLORES" Entidad="PALETADECOLORES" Descripcion="Paleta de colores" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="CURVADETALLES" Entidad="CURVADETALLES" Descripcion="Curva de talles" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			</Atributos>
			</Participante>
			<Participante Atributo="COLOR" Entidad="COLOR" Descripcion="Color" TipoDato="C" Longitud="6" Decimales="0" Detalle="FACTURADETALLE">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="6" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="TALLE" Entidad="TALLE" Descripcion="Talle" TipoDato="C" Longitud="5" Decimales="0" Detalle="FACTURADETALLE">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="5" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="50" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="VALOR" Entidad="VALOR" Descripcion="Valor" TipoDato="C" Longitud="5" Decimales="0" Detalle="VALORESDETALLE">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="5" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			<Atributo Nombre="TIPO" Descripcion="Tipo" TipoDato="N" Longitud="2" Decimales="0" />
			<Atributo Nombre="TIPOTARJETA" Descripcion="Tipo tarjeta" TipoDato="C" Longitud="1" Decimales="0" />
			<Participante Atributo="SIMBOLOMONETARIO" Entidad="MONEDA" Descripcion="Moneda" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="OPERADORATARJETA" Entidad="OPERADORADETARJETA" Descripcion="Operadora de la tarjeta" TipoDato="C" Longitud="15" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="15" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="100" Decimales="0" />
			</Atributos>
			</Participante>
			</Atributos>
			</Participante>
			<Participante Atributo="CUPON" Entidad="CUPON" Descripcion="Cupón de tarjeta" TipoDato="C" Longitud="38" Decimales="0" Detalle="VALORESDETALLE">
			<Atributos>
			<Atributo Nombre="NUMEROCUPON" Descripcion="Número" TipoDato="N" Longitud="12" Decimales="0" />
			<Atributo Nombre="CUOTAS" Descripcion="Cuotas" TipoDato="N" Longitud="3" Decimales="0" />
			<Participante Atributo="VALOR" Entidad="VALOR" Descripcion="Valor" TipoDato="C" Longitud="5" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="5" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			<Atributo Nombre="TIPO" Descripcion="Tipo" TipoDato="N" Longitud="2" Decimales="0" />
			<Atributo Nombre="TIPOTARJETA" Descripcion="Tipo tarjeta" TipoDato="C" Longitud="1" Decimales="0" />
			<Participante Atributo="SIMBOLOMONETARIO" Entidad="MONEDA" Descripcion="Moneda" TipoDato="C" Longitud="10" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="10" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="OPERADORATARJETA" Entidad="OPERADORADETARJETA" Descripcion="Operadora de la tarjeta" TipoDato="C" Longitud="15" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="15" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="100" Decimales="0" />
			</Atributos>
			</Participante>
			</Atributos>
			</Participante>
			<Participante Atributo="ENTIDADFINANCIERA" Entidad="ENTIDADFINANCIERA" Descripcion="Entidad financiera" TipoDato="C" Longitud="5" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="5" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
			<Participante Atributo="CLASEDETARJETA" Entidad="CLASEDETARJETA" Descripcion="Clase de tarjeta" TipoDato="C" Longitud="5" Decimales="0" Detalle="">
			<Atributos>
			<Atributo Nombre="CODIGO" Descripcion="Código" TipoDato="C" Longitud="5" Decimales="0" />
			<Atributo Nombre="DESCRIPCION" Descripcion="Descripción" TipoDato="C" Longitud="40" Decimales="0" />
			</Atributos>
			</Participante>
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
		Create Cursor &lcCursor ( Articulo C(15), Color C(6), Talle C(5), Lista C(6), Monedalista C(10), Precio N(12,2) )
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