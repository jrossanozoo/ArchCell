
define class Din_DetalleNOTADECREDITOCOMPRAFacturadetalle as DetalleArticuloscompra of DetalleArticuloscompra.Prg

	Sum_Afe_saldo = 0
	Sum_Ajusteporredondeoconimpuestos = 0
	Sum_Ajusteporredondeosinimpuestos = 0
	Sum_Bruto = 0
	Sum_Cantidad = 0
	Sum_Impuestos = 0
	Sum_Monto = 0
	Sum_Montoporcentajedescuentoconimpuesto = 0
	Sum_Neto = 0

	nCantidadItems = 9999
	cNombre = 'Facturadetalle'
	cEtiqueta = 'Facturadetalle'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = ''

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function _CargarItem( tnItem as integer )
		Local loEx as Excepcion, llVacio as Boolean
		if tnItem <= 0
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			With loEx
				.Message = 'El item está fuera del rango'
				.Grabar()
				.Throw()
			EndWith
		EndIf
		With this.oItem
			Try
				.lCargando = .t.
				.NroItem = tnItem
				llVacio = .t.
				.Articulo_PK = this.Item[ tnItem ].Articulo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Articulo_PK', .Articulo_PK )
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.MontoPorcentajeDescuentoConImpuesto = this.Item[ tnItem ].MontoPorcentajeDescuentoConImpuesto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoPorcentajeDescuentoConImpuesto', .MontoPorcentajeDescuentoConImpuesto )
			
				.Impuestos = this.Item[ tnItem ].Impuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Impuestos', .Impuestos )
			
				.Kit = this.Item[ tnItem ].Kit
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Kit', .Kit )
			
				.Material_PK = this.Item[ tnItem ].Material_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Material_PK', .Material_PK )
			
				.MontoCFI = this.Item[ tnItem ].MontoCFI
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoCFI', .MontoCFI )
			
				.MontoDTO1 = this.Item[ tnItem ].MontoDTO1
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDTO1', .MontoDTO1 )
			
				.MontoIVA = this.Item[ tnItem ].MontoIVA
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoIVA', .MontoIVA )
			
				.Neto = this.Item[ tnItem ].Neto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Neto', .Neto )
			
				.NroItem = this.Item[ tnItem ].NroItem
			
				.Oferta = this.Item[ tnItem ].Oferta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Oferta', .Oferta )
			
				.PorcentajeCFI = this.Item[ tnItem ].PorcentajeCFI
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeCFI', .PorcentajeCFI )
			
				.PorcentajeDTO1 = this.Item[ tnItem ].PorcentajeDTO1
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeDTO1', .PorcentajeDTO1 )
			
				.PorcentajeIVA = this.Item[ tnItem ].PorcentajeIVA
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeIVA', .PorcentajeIVA )
			
				.PrecioConImpuestos = this.Item[ tnItem ].PrecioConImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioConImpuestos', .PrecioConImpuestos )
			
				.PrecioDeLista = this.Item[ tnItem ].PrecioDeLista
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioDeLista', .PrecioDeLista )
			
				.PrecioSinImpuestos = this.Item[ tnItem ].PrecioSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioSinImpuestos', .PrecioSinImpuestos )
			
				.PrecioUnitario = this.Item[ tnItem ].PrecioUnitario
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioUnitario', .PrecioUnitario )
			
				.TipoListaDePrecio = this.Item[ tnItem ].TipoListaDePrecio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoListaDePrecio', .TipoListaDePrecio )
			
				.Unidad_PK = this.Item[ tnItem ].Unidad_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Unidad_PK', .Unidad_PK )
			
				.idItem = this.Item[ tnItem ].idItem
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'idItem', .idItem )
			
				.idOrigen = this.Item[ tnItem ].idOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'idOrigen', .idOrigen )
			
				.CodigoOrigen = this.Item[ tnItem ].CodigoOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoOrigen', .CodigoOrigen )
			
				.Afe_NroItem = this.Item[ tnItem ].Afe_NroItem
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_NroItem', .Afe_NroItem )
			
				.Afe_TipoComprobante = this.Item[ tnItem ].Afe_TipoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_TipoComprobante', .Afe_TipoComprobante )
			
				.Afe_Letra = this.Item[ tnItem ].Afe_Letra
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_Letra', .Afe_Letra )
			
				.Afe_PuntoDeVenta = this.Item[ tnItem ].Afe_PuntoDeVenta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_PuntoDeVenta', .Afe_PuntoDeVenta )
			
				.Afe_Numero = this.Item[ tnItem ].Afe_Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_Numero', .Afe_Numero )
			
				.Afe_Cantidad = this.Item[ tnItem ].Afe_Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_Cantidad', .Afe_Cantidad )
			
				.Afe_Saldo = this.Item[ tnItem ].Afe_Saldo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_Saldo', .Afe_Saldo )
			
				.afe_CantidadOriginal = this.Item[ tnItem ].afe_CantidadOriginal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'afe_CantidadOriginal', .afe_CantidadOriginal )
			
				.afe_SaldoActual = this.Item[ tnItem ].afe_SaldoActual
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'afe_SaldoActual', .afe_SaldoActual )
			
				.afe_SaldoOriginal = this.Item[ tnItem ].afe_SaldoOriginal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'afe_SaldoOriginal', .afe_SaldoOriginal )
			
				.Articulo_CondicionIvaCompras = this.Item[ tnItem ].Articulo_CondicionIvaCompras
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Articulo_CondicionIvaCompras', .Articulo_CondicionIvaCompras )
			
				.Articulo_PorcentajeIvaCompras = this.Item[ tnItem ].Articulo_PorcentajeIvaCompras
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Articulo_PorcentajeIvaCompras', .Articulo_PorcentajeIvaCompras )
			
				.NoProcesarStock = this.Item[ tnItem ].NoProcesarStock
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NoProcesarStock', .NoProcesarStock )
			
				.Afe_timeStamp = this.Item[ tnItem ].Afe_timeStamp
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_timeStamp', .Afe_timeStamp )
			
				.CodigoDeBarras = this.Item[ tnItem ].CodigoDeBarras
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoDeBarras', .CodigoDeBarras )
			
				.Equivalencia_PK = this.Item[ tnItem ].Equivalencia_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Equivalencia_PK', .Equivalencia_PK )
			
				.MontoProrrateoRecargoConImpuestos = this.Item[ tnItem ].MontoProrrateoRecargoConImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoProrrateoRecargoConImpuestos', .MontoProrrateoRecargoConImpuestos )
			
				.MontoProrrateoTotal = this.Item[ tnItem ].MontoProrrateoTotal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoProrrateoTotal', .MontoProrrateoTotal )
			
				.MontoProrrateoPercepciones = this.Item[ tnItem ].MontoProrrateoPercepciones
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoProrrateoPercepciones', .MontoProrrateoPercepciones )
			
				.MontoProrrateoDescuentoConImpuestos = this.Item[ tnItem ].MontoProrrateoDescuentoConImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoProrrateoDescuentoConImpuestos', .MontoProrrateoDescuentoConImpuestos )
			
				.MontoProrrateoRecargoSinImpuestos = this.Item[ tnItem ].MontoProrrateoRecargoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoProrrateoRecargoSinImpuestos', .MontoProrrateoRecargoSinImpuestos )
			
				.MontoProrrateoDescuentoSinImpuestos = this.Item[ tnItem ].MontoProrrateoDescuentoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoProrrateoDescuentoSinImpuestos', .MontoProrrateoDescuentoSinImpuestos )
			
				.MontoPorcentajeDescuentoSinImpuesto = this.Item[ tnItem ].MontoPorcentajeDescuentoSinImpuesto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoPorcentajeDescuentoSinImpuesto', .MontoPorcentajeDescuentoSinImpuesto )
			
				.MontoDescuentoConImpuestos = this.Item[ tnItem ].MontoDescuentoConImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDescuentoConImpuestos', .MontoDescuentoConImpuestos )
			
				.MontoDescuentoSinImpuestos = this.Item[ tnItem ].MontoDescuentoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDescuentoSinImpuestos', .MontoDescuentoSinImpuestos )
			
				.Afe_Codigo = this.Item[ tnItem ].Afe_Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afe_Codigo', .Afe_Codigo )
			
				.UsarPrecioDeLista = this.Item[ tnItem ].UsarPrecioDeLista
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'UsarPrecioDeLista', .UsarPrecioDeLista )
			
				.Bruto = this.Item[ tnItem ].Bruto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Bruto', .Bruto )
			
				.AjustePorRedondeoConImpuestos = this.Item[ tnItem ].AjustePorRedondeoConImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AjustePorRedondeoConImpuestos', .AjustePorRedondeoConImpuestos )
			
				.AjustePorRedondeoSinImpuestos = this.Item[ tnItem ].AjustePorRedondeoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AjustePorRedondeoSinImpuestos', .AjustePorRedondeoSinImpuestos )
			
				.FueAutorizadoDevolucion = this.Item[ tnItem ].FueAutorizadoDevolucion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FueAutorizadoDevolucion', .FueAutorizadoDevolucion )
			
				.IdItemArticulos = this.Item[ tnItem ].IdItemArticulos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdItemArticulos', .IdItemArticulos )
			
				.Comportamiento = this.Item[ tnItem ].Comportamiento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comportamiento', .Comportamiento )
			
				.EsLibre = this.Item[ tnItem ].EsLibre
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EsLibre', .EsLibre )
			
				.PercepcionIvaRG5329 = this.Item[ tnItem ].PercepcionIvaRG5329
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PercepcionIvaRG5329', .PercepcionIvaRG5329 )
			
				.ArticuloDetalle = this.Item[ tnItem ].ArticuloDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ArticuloDetalle', .ArticuloDetalle )
			
				.Color_PK = this.Item[ tnItem ].Color_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Color_PK', .Color_PK )
			
				.ColorDetalle = this.Item[ tnItem ].ColorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ColorDetalle', .ColorDetalle )
			
				.Talle = this.Item[ tnItem ].Talle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Talle', .Talle )
			
				.Descuento = this.Item[ tnItem ].Descuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descuento', .Descuento )
			
				.Cantidad = this.Item[ tnItem ].Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cantidad', .Cantidad )
			
				.MontoDescuento = this.Item[ tnItem ].MontoDescuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDescuento', .MontoDescuento )
			
				.MontoProrrateoIVA = this.Item[ tnItem ].MontoProrrateoIVA
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoProrrateoIVA', .MontoProrrateoIVA )
			
				.IDSeniaCancelada = this.Item[ tnItem ].IDSeniaCancelada
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IDSeniaCancelada', .IDSeniaCancelada )
			
				.Precio = this.Item[ tnItem ].Precio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Precio', .Precio )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.CentroDeCosto_PK = this.Item[ tnItem ].CentroDeCosto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CentroDeCosto_PK', .CentroDeCosto_PK )
			
				.DistribucionCentroDeCosto_PK = this.Item[ tnItem ].DistribucionCentroDeCosto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DistribucionCentroDeCosto_PK', .DistribucionCentroDeCosto_PK )
			
				.lCargando = .f.
				if llVacio
					this.oItem.SetearValoresSugeridos()
				endif
			Finally
				.lCargando = .f.
			EndTry
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function AplanarItem() as Object
		local loRetorno as object
		loRetorno = createobject('ItemAuxiliar')

		with loRetorno
			.Articulo_PK = this.oItem.Articulo_PK
			.Codigo = this.oItem.Codigo
			.MontoPorcentajeDescuentoConImpuesto = this.oItem.MontoPorcentajeDescuentoConImpuesto
			.Impuestos = this.oItem.Impuestos
			.Kit = this.oItem.Kit
			.Material_PK = this.oItem.Material_PK
			.MontoCFI = this.oItem.MontoCFI
			.MontoDTO1 = this.oItem.MontoDTO1
			.MontoIVA = this.oItem.MontoIVA
			.Neto = this.oItem.Neto
			.NroItem = this.oItem.NroItem
			.Oferta = this.oItem.Oferta
			.PorcentajeCFI = this.oItem.PorcentajeCFI
			.PorcentajeDTO1 = this.oItem.PorcentajeDTO1
			.PorcentajeIVA = this.oItem.PorcentajeIVA
			.PrecioConImpuestos = this.oItem.PrecioConImpuestos
			.PrecioDeLista = this.oItem.PrecioDeLista
			.PrecioSinImpuestos = this.oItem.PrecioSinImpuestos
			.PrecioUnitario = this.oItem.PrecioUnitario
			.TipoListaDePrecio = this.oItem.TipoListaDePrecio
			.Unidad_PK = this.oItem.Unidad_PK
			.idItem = this.oItem.idItem
			.idOrigen = this.oItem.idOrigen
			.CodigoOrigen = this.oItem.CodigoOrigen
			.Afe_NroItem = this.oItem.Afe_NroItem
			.Afe_TipoComprobante = this.oItem.Afe_TipoComprobante
			.Afe_Letra = this.oItem.Afe_Letra
			.Afe_PuntoDeVenta = this.oItem.Afe_PuntoDeVenta
			.Afe_Numero = this.oItem.Afe_Numero
			.Afe_Cantidad = this.oItem.Afe_Cantidad
			.Afe_Saldo = this.oItem.Afe_Saldo
			.afe_CantidadOriginal = this.oItem.afe_CantidadOriginal
			.afe_SaldoActual = this.oItem.afe_SaldoActual
			.afe_SaldoOriginal = this.oItem.afe_SaldoOriginal
			.Articulo_CondicionIvaCompras = this.oItem.Articulo_CondicionIvaCompras
			.Articulo_PorcentajeIvaCompras = this.oItem.Articulo_PorcentajeIvaCompras
			.NoProcesarStock = this.oItem.NoProcesarStock
			.Afe_timeStamp = this.oItem.Afe_timeStamp
			.CodigoDeBarras = this.oItem.CodigoDeBarras
			.Equivalencia_PK = this.oItem.Equivalencia_PK
			.MontoProrrateoRecargoConImpuestos = this.oItem.MontoProrrateoRecargoConImpuestos
			.MontoProrrateoTotal = this.oItem.MontoProrrateoTotal
			.MontoProrrateoPercepciones = this.oItem.MontoProrrateoPercepciones
			.MontoProrrateoDescuentoConImpuestos = this.oItem.MontoProrrateoDescuentoConImpuestos
			.MontoProrrateoRecargoSinImpuestos = this.oItem.MontoProrrateoRecargoSinImpuestos
			.MontoProrrateoDescuentoSinImpuestos = this.oItem.MontoProrrateoDescuentoSinImpuestos
			.MontoPorcentajeDescuentoSinImpuesto = this.oItem.MontoPorcentajeDescuentoSinImpuesto
			.MontoDescuentoConImpuestos = this.oItem.MontoDescuentoConImpuestos
			.MontoDescuentoSinImpuestos = this.oItem.MontoDescuentoSinImpuestos
			.Afe_Codigo = this.oItem.Afe_Codigo
			.UsarPrecioDeLista = this.oItem.UsarPrecioDeLista
			.Bruto = this.oItem.Bruto
			.AjustePorRedondeoConImpuestos = this.oItem.AjustePorRedondeoConImpuestos
			.AjustePorRedondeoSinImpuestos = this.oItem.AjustePorRedondeoSinImpuestos
			.FueAutorizadoDevolucion = this.oItem.FueAutorizadoDevolucion
			.IdItemArticulos = this.oItem.IdItemArticulos
			.Comportamiento = this.oItem.Comportamiento
			.EsLibre = this.oItem.EsLibre
			.PercepcionIvaRG5329 = this.oItem.PercepcionIvaRG5329
			.ArticuloDetalle = this.oItem.ArticuloDetalle
			.Color_PK = this.oItem.Color_PK
			.ColorDetalle = this.oItem.ColorDetalle
			.Talle = this.oItem.Talle
			.Descuento = this.oItem.Descuento
			.Cantidad = this.oItem.Cantidad
			.MontoDescuento = this.oItem.MontoDescuento
			.MontoProrrateoIVA = this.oItem.MontoProrrateoIVA
			.IDSeniaCancelada = this.oItem.IDSeniaCancelada
			.Precio = this.oItem.Precio
			.Monto = this.oItem.Monto
			.CentroDeCosto_PK = this.oItem.CentroDeCosto_PK
			.DistribucionCentroDeCosto_PK = this.oItem.DistribucionCentroDeCosto_PK
			.NroItem = iif( this.oItem.NroItem = 0, this.Count + 1, this.oItem.NroItem )
		endwith

		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function Modificar() as void
	local lnItem as integer, loEx as Exception

	with this
		if .ValidarItem()
			lnItem = .oItem.NroItem
			if lnItem <= 0
				.AgregarInformacion( 'Debe cargar un item para poder modificar' )
				goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
			endif

			if .oItem.ValidarExistenciaCamposFijos()
			else
				.oItem.Limpiar( .t. )
			endif

			.oItem.NroItem = lnItem
			.Item[ lnItem ].Articulo_PK = .oItem.Articulo_PK
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].MontoPorcentajeDescuentoConImpuesto = .oItem.MontoPorcentajeDescuentoConImpuesto
			.Item[ lnItem ].Impuestos = .oItem.Impuestos
			.Item[ lnItem ].Kit = .oItem.Kit
			.Item[ lnItem ].Material_PK = .oItem.Material_PK
			.Item[ lnItem ].MontoCFI = .oItem.MontoCFI
			.Item[ lnItem ].MontoDTO1 = .oItem.MontoDTO1
			.Item[ lnItem ].MontoIVA = .oItem.MontoIVA
			.Item[ lnItem ].Neto = .oItem.Neto
			.Item[ lnItem ].NroItem = .oItem.NroItem
			.Item[ lnItem ].Oferta = .oItem.Oferta
			.Item[ lnItem ].PorcentajeCFI = .oItem.PorcentajeCFI
			.Item[ lnItem ].PorcentajeDTO1 = .oItem.PorcentajeDTO1
			.Item[ lnItem ].PorcentajeIVA = .oItem.PorcentajeIVA
			.Item[ lnItem ].PrecioConImpuestos = .oItem.PrecioConImpuestos
			.Item[ lnItem ].PrecioDeLista = .oItem.PrecioDeLista
			.Item[ lnItem ].PrecioSinImpuestos = .oItem.PrecioSinImpuestos
			.Item[ lnItem ].PrecioUnitario = .oItem.PrecioUnitario
			.Item[ lnItem ].TipoListaDePrecio = .oItem.TipoListaDePrecio
			.Item[ lnItem ].Unidad_PK = .oItem.Unidad_PK
			.Item[ lnItem ].idItem = .oItem.idItem
			.Item[ lnItem ].idOrigen = .oItem.idOrigen
			.Item[ lnItem ].CodigoOrigen = .oItem.CodigoOrigen
			.Item[ lnItem ].Afe_NroItem = .oItem.Afe_NroItem
			.Item[ lnItem ].Afe_TipoComprobante = .oItem.Afe_TipoComprobante
			.Item[ lnItem ].Afe_Letra = .oItem.Afe_Letra
			.Item[ lnItem ].Afe_PuntoDeVenta = .oItem.Afe_PuntoDeVenta
			.Item[ lnItem ].Afe_Numero = .oItem.Afe_Numero
			.Item[ lnItem ].Afe_Cantidad = .oItem.Afe_Cantidad
			.Item[ lnItem ].Afe_Saldo = .oItem.Afe_Saldo
			.Item[ lnItem ].afe_CantidadOriginal = .oItem.afe_CantidadOriginal
			.Item[ lnItem ].afe_SaldoActual = .oItem.afe_SaldoActual
			.Item[ lnItem ].afe_SaldoOriginal = .oItem.afe_SaldoOriginal
			.Item[ lnItem ].Articulo_CondicionIvaCompras = .oItem.Articulo_CondicionIvaCompras
			.Item[ lnItem ].Articulo_PorcentajeIvaCompras = .oItem.Articulo_PorcentajeIvaCompras
			.Item[ lnItem ].NoProcesarStock = .oItem.NoProcesarStock
			.Item[ lnItem ].Afe_timeStamp = .oItem.Afe_timeStamp
			.Item[ lnItem ].CodigoDeBarras = .oItem.CodigoDeBarras
			.Item[ lnItem ].Equivalencia_PK = .oItem.Equivalencia_PK
			.Item[ lnItem ].MontoProrrateoRecargoConImpuestos = .oItem.MontoProrrateoRecargoConImpuestos
			.Item[ lnItem ].MontoProrrateoTotal = .oItem.MontoProrrateoTotal
			.Item[ lnItem ].MontoProrrateoPercepciones = .oItem.MontoProrrateoPercepciones
			.Item[ lnItem ].MontoProrrateoDescuentoConImpuestos = .oItem.MontoProrrateoDescuentoConImpuestos
			.Item[ lnItem ].MontoProrrateoRecargoSinImpuestos = .oItem.MontoProrrateoRecargoSinImpuestos
			.Item[ lnItem ].MontoProrrateoDescuentoSinImpuestos = .oItem.MontoProrrateoDescuentoSinImpuestos
			.Item[ lnItem ].MontoPorcentajeDescuentoSinImpuesto = .oItem.MontoPorcentajeDescuentoSinImpuesto
			.Item[ lnItem ].MontoDescuentoConImpuestos = .oItem.MontoDescuentoConImpuestos
			.Item[ lnItem ].MontoDescuentoSinImpuestos = .oItem.MontoDescuentoSinImpuestos
			.Item[ lnItem ].Afe_Codigo = .oItem.Afe_Codigo
			.Item[ lnItem ].UsarPrecioDeLista = .oItem.UsarPrecioDeLista
			.Item[ lnItem ].Bruto = .oItem.Bruto
			.Item[ lnItem ].AjustePorRedondeoConImpuestos = .oItem.AjustePorRedondeoConImpuestos
			.Item[ lnItem ].AjustePorRedondeoSinImpuestos = .oItem.AjustePorRedondeoSinImpuestos
			.Item[ lnItem ].FueAutorizadoDevolucion = .oItem.FueAutorizadoDevolucion
			.Item[ lnItem ].IdItemArticulos = .oItem.IdItemArticulos
			.Item[ lnItem ].Comportamiento = .oItem.Comportamiento
			.Item[ lnItem ].EsLibre = .oItem.EsLibre
			.Item[ lnItem ].PercepcionIvaRG5329 = .oItem.PercepcionIvaRG5329
			.Item[ lnItem ].ArticuloDetalle = .oItem.ArticuloDetalle
			.Item[ lnItem ].Color_PK = .oItem.Color_PK
			.Item[ lnItem ].ColorDetalle = .oItem.ColorDetalle
			.Item[ lnItem ].Talle = .oItem.Talle
			.Item[ lnItem ].Descuento = .oItem.Descuento
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
			.Item[ lnItem ].MontoDescuento = .oItem.MontoDescuento
			.Item[ lnItem ].MontoProrrateoIVA = .oItem.MontoProrrateoIVA
			.Item[ lnItem ].IDSeniaCancelada = .oItem.IDSeniaCancelada
			.Item[ lnItem ].Precio = .oItem.Precio
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].CentroDeCosto_PK = .oItem.CentroDeCosto_PK
			.Item[ lnItem ].DistribucionCentroDeCosto_PK = .oItem.DistribucionCentroDeCosto_PK
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Afe_saldo as Number, lnSum_Ajusteporredondeoconimpuestos as Number, lnSum_Ajusteporredondeosinimpuestos as Number, lnSum_Bruto as Number, lnSum_Cantidad as Number, lnSum_Impuestos as Number, lnSum_Monto as Number, lnSum_Montoporcentajedescuentoconimpuesto as Number, lnSum_Neto as Number

		with this
			lnSum_Afe_saldo = 0
			lnSum_Ajusteporredondeoconimpuestos = 0
			lnSum_Ajusteporredondeosinimpuestos = 0
			lnSum_Bruto = 0
			lnSum_Cantidad = 0
			lnSum_Impuestos = 0
			lnSum_Monto = 0
			lnSum_Montoporcentajedescuentoconimpuesto = 0
			lnSum_Neto = 0
			if this.lEsNavegacion
				if select( 'c_Facturadetalle' ) > 0 and reccount( 'c_Facturadetalle' ) > 0
					sum Afe_saldo, Ajusteporredondeoconimpuestos, Ajusteporredondeosinimpuestos, Bruto, Cantidad, Monto, Montoporcentajedescuentoconimpuesto, Neto;
						 to ;
						 lnSum_Afe_saldo, lnSum_Ajusteporredondeoconimpuestos, lnSum_Ajusteporredondeosinimpuestos, lnSum_Bruto, lnSum_Cantidad, lnSum_Monto, lnSum_Montoporcentajedescuentoconimpuesto, lnSum_Neto
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.ARTICULO_PK)
								lnSum_Afe_saldo = lnSum_Afe_saldo + .Afe_saldo
								lnSum_Ajusteporredondeoconimpuestos = lnSum_Ajusteporredondeoconimpuestos + .Ajusteporredondeoconimpuestos
								lnSum_Ajusteporredondeosinimpuestos = lnSum_Ajusteporredondeosinimpuestos + .Ajusteporredondeosinimpuestos
								lnSum_Bruto = lnSum_Bruto + .Bruto
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
								lnSum_Impuestos = lnSum_Impuestos + .Impuestos
								lnSum_Monto = lnSum_Monto + .Monto
								lnSum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto + .Montoporcentajedescuentoconimpuesto
								lnSum_Neto = lnSum_Neto + .Neto
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Afe_saldo = lnSum_Afe_saldo + .Afe_saldo
						lnSum_Ajusteporredondeoconimpuestos = lnSum_Ajusteporredondeoconimpuestos + .Ajusteporredondeoconimpuestos
						lnSum_Ajusteporredondeosinimpuestos = lnSum_Ajusteporredondeosinimpuestos + .Ajusteporredondeosinimpuestos
						lnSum_Bruto = lnSum_Bruto + .Bruto
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						lnSum_Impuestos = lnSum_Impuestos + .Impuestos
						lnSum_Monto = lnSum_Monto + .Monto
						lnSum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto + .Montoporcentajedescuentoconimpuesto
						lnSum_Neto = lnSum_Neto + .Neto
					endwith
				endif
			endif

			if .Sum_Afe_saldo != lnSum_Afe_saldo
				.Sum_Afe_saldo = lnSum_Afe_saldo
				.EventoCambioSum_Afe_saldo()
			endif
			if .Sum_Ajusteporredondeoconimpuestos != lnSum_Ajusteporredondeoconimpuestos
				.Sum_Ajusteporredondeoconimpuestos = lnSum_Ajusteporredondeoconimpuestos
				.EventoCambioSum_Ajusteporredondeoconimpuestos()
			endif
			if .Sum_Ajusteporredondeosinimpuestos != lnSum_Ajusteporredondeosinimpuestos
				.Sum_Ajusteporredondeosinimpuestos = lnSum_Ajusteporredondeosinimpuestos
				.EventoCambioSum_Ajusteporredondeosinimpuestos()
			endif
			if .Sum_Bruto != lnSum_Bruto
				.Sum_Bruto = lnSum_Bruto
				.EventoCambioSum_Bruto()
			endif
			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Impuestos != lnSum_Impuestos
				.Sum_Impuestos = lnSum_Impuestos
				.EventoCambioSum_Impuestos()
			endif
			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif
			if .Sum_Montoporcentajedescuentoconimpuesto != lnSum_Montoporcentajedescuentoconimpuesto
				.Sum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto
				.EventoCambioSum_Montoporcentajedescuentoconimpuesto()
			endif
			if .Sum_Neto != lnSum_Neto
				.Sum_Neto = lnSum_Neto
				.EventoCambioSum_Neto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Afe_saldo() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Ajusteporredondeoconimpuestos() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Ajusteporredondeosinimpuestos() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Bruto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cantidad() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Impuestos() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Monto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montoporcentajedescuentoconimpuesto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Neto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Afe_saldo as Number, lnSum_Ajusteporredondeoconimpuestos as Number, lnSum_Ajusteporredondeosinimpuestos as Number, lnSum_Bruto as Number, lnSum_Cantidad as Number, lnSum_Impuestos as Number, lnSum_Monto as Number, lnSum_Montoporcentajedescuentoconimpuesto as Number, lnSum_Neto as Number

		with this
			lnSum_Afe_saldo = 0
			lnSum_Ajusteporredondeoconimpuestos = 0
			lnSum_Ajusteporredondeosinimpuestos = 0
			lnSum_Bruto = 0
			lnSum_Cantidad = 0
			lnSum_Impuestos = 0
			lnSum_Monto = 0
			lnSum_Montoporcentajedescuentoconimpuesto = 0
			lnSum_Neto = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.ARTICULO_PK)
								lnSum_Afe_saldo = lnSum_Afe_saldo + .Afe_saldo
								lnSum_Ajusteporredondeoconimpuestos = lnSum_Ajusteporredondeoconimpuestos + .Ajusteporredondeoconimpuestos
								lnSum_Ajusteporredondeosinimpuestos = lnSum_Ajusteporredondeosinimpuestos + .Ajusteporredondeosinimpuestos
								lnSum_Bruto = lnSum_Bruto + .Bruto
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
								lnSum_Impuestos = lnSum_Impuestos + .Impuestos
								lnSum_Monto = lnSum_Monto + .Monto
								lnSum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto + .Montoporcentajedescuentoconimpuesto
								lnSum_Neto = lnSum_Neto + .Neto
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.ARTICULO_PK)
						lnSum_Afe_saldo = lnSum_Afe_saldo + .Afe_saldo
						lnSum_Ajusteporredondeoconimpuestos = lnSum_Ajusteporredondeoconimpuestos + .Ajusteporredondeoconimpuestos
						lnSum_Ajusteporredondeosinimpuestos = lnSum_Ajusteporredondeosinimpuestos + .Ajusteporredondeosinimpuestos
						lnSum_Bruto = lnSum_Bruto + .Bruto
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						lnSum_Impuestos = lnSum_Impuestos + .Impuestos
						lnSum_Monto = lnSum_Monto + .Monto
						lnSum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto + .Montoporcentajedescuentoconimpuesto
						lnSum_Neto = lnSum_Neto + .Neto
					endif
				endwith
			endif

			if .Sum_Afe_saldo != lnSum_Afe_saldo
				.Sum_Afe_saldo = lnSum_Afe_saldo
				.EventoCambioSum_Afe_saldo()
			endif
			if .Sum_Ajusteporredondeoconimpuestos != lnSum_Ajusteporredondeoconimpuestos
				.Sum_Ajusteporredondeoconimpuestos = lnSum_Ajusteporredondeoconimpuestos
				.EventoCambioSum_Ajusteporredondeoconimpuestos()
			endif
			if .Sum_Ajusteporredondeosinimpuestos != lnSum_Ajusteporredondeosinimpuestos
				.Sum_Ajusteporredondeosinimpuestos = lnSum_Ajusteporredondeosinimpuestos
				.EventoCambioSum_Ajusteporredondeosinimpuestos()
			endif
			if .Sum_Bruto != lnSum_Bruto
				.Sum_Bruto = lnSum_Bruto
				.EventoCambioSum_Bruto()
			endif
			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Impuestos != lnSum_Impuestos
				.Sum_Impuestos = lnSum_Impuestos
				.EventoCambioSum_Impuestos()
			endif
			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif
			if .Sum_Montoporcentajedescuentoconimpuesto != lnSum_Montoporcentajedescuentoconimpuesto
				.Sum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto
				.EventoCambioSum_Montoporcentajedescuentoconimpuesto()
			endif
			if .Sum_Neto != lnSum_Neto
				.Sum_Neto = lnSum_Neto
				.EventoCambioSum_Neto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Afe_saldo as Number, lnSum_Ajusteporredondeoconimpuestos as Number, lnSum_Ajusteporredondeosinimpuestos as Number, lnSum_Bruto as Number, lnSum_Cantidad as Number, lnSum_Impuestos as Number, lnSum_Monto as Number, lnSum_Montoporcentajedescuentoconimpuesto as Number, lnSum_Neto as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Afe_saldo'
			this.Sum_Afe_saldo = this.Sum_Afe_saldo - tnValorAnt + tnValor
			this.EventoCambioSum_Afe_saldo()
		case tcAtributo == 'Ajusteporredondeoconimpuestos'
			this.Sum_Ajusteporredondeoconimpuestos = this.Sum_Ajusteporredondeoconimpuestos - tnValorAnt + tnValor
			this.EventoCambioSum_Ajusteporredondeoconimpuestos()
		case tcAtributo == 'Ajusteporredondeosinimpuestos'
			this.Sum_Ajusteporredondeosinimpuestos = this.Sum_Ajusteporredondeosinimpuestos - tnValorAnt + tnValor
			this.EventoCambioSum_Ajusteporredondeosinimpuestos()
		case tcAtributo == 'Bruto'
			this.Sum_Bruto = this.Sum_Bruto - tnValorAnt + tnValor
			this.EventoCambioSum_Bruto()
		case tcAtributo == 'Cantidad'
			this.Sum_Cantidad = this.Sum_Cantidad - tnValorAnt + tnValor
			this.EventoCambioSum_Cantidad()
		case tcAtributo == 'Impuestos'
			this.Sum_Impuestos = this.Sum_Impuestos - tnValorAnt + tnValor
			this.EventoCambioSum_Impuestos()
		case tcAtributo == 'Monto'
			this.Sum_Monto = this.Sum_Monto - tnValorAnt + tnValor
			this.EventoCambioSum_Monto()
		case tcAtributo == 'Montoporcentajedescuentoconimpuesto'
			this.Sum_Montoporcentajedescuentoconimpuesto = this.Sum_Montoporcentajedescuentoconimpuesto - tnValorAnt + tnValor
			this.EventoCambioSum_Montoporcentajedescuentoconimpuesto()
		case tcAtributo == 'Neto'
			this.Sum_Neto = this.Sum_Neto - tnValorAnt + tnValor
			this.EventoCambioSum_Neto()

		endcase
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Limpiar() as boolean
		DoDefault()
		this.Sumarizar()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemNOTADECREDITOCOMPRAFacturadetalle' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'AcumularSumarizado', this, 'Acumular', 0) 
			bindevent( this.oItem, 'TotalizarSumarizado', this, 'Totalizar', 0) 
			bindevent( this.oItem, 'CambioSumarizado', this, 'Sumarizar', 0) 
			bindevent( this.oItem, 'EventoDespuesDeSetear', this, 'ValidarCantidadDeItemsEnDetalle' )
		endif
		return this.oItem
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Cargar() as Void
		local loItem as object, lnI as integer, lcClave as string, lcFiltro as String 
		lnI = 1

		select c_Facturadetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Articulo_PK = c_Facturadetalle.Articulo
			loItem.Codigo = c_Facturadetalle.Codigo
			loItem.MontoPorcentajeDescuentoConImpuesto = c_Facturadetalle.MontoPorcentajeDescuentoConImpuesto
			loItem.Kit = c_Facturadetalle.Kit
			loItem.Material_PK = c_Facturadetalle.Material
			loItem.MontoCFI = c_Facturadetalle.MontoCFI
			loItem.MontoDTO1 = c_Facturadetalle.MontoDTO1
			loItem.MontoIVA = c_Facturadetalle.MontoIVA
			loItem.Neto = c_Facturadetalle.Neto
			loItem.NroItem = c_Facturadetalle.NroItem
			loItem.Oferta = c_Facturadetalle.Oferta
			loItem.PorcentajeCFI = c_Facturadetalle.PorcentajeCFI
			loItem.PorcentajeDTO1 = c_Facturadetalle.PorcentajeDTO1
			loItem.PorcentajeIVA = c_Facturadetalle.PorcentajeIVA
			loItem.PrecioConImpuestos = c_Facturadetalle.PrecioConImpuestos
			loItem.PrecioSinImpuestos = c_Facturadetalle.PrecioSinImpuestos
			loItem.PrecioUnitario = c_Facturadetalle.PrecioUnitario
			loItem.TipoListaDePrecio = c_Facturadetalle.TipoListaDePrecio
			loItem.Unidad_PK = c_Facturadetalle.Unidad
			loItem.idItem = c_Facturadetalle.idItem
			loItem.idOrigen = c_Facturadetalle.idOrigen
			loItem.Afe_NroItem = c_Facturadetalle.Afe_NroItem
			loItem.Afe_TipoComprobante = c_Facturadetalle.Afe_TipoComprobante
			loItem.Afe_Letra = c_Facturadetalle.Afe_Letra
			loItem.Afe_PuntoDeVenta = c_Facturadetalle.Afe_PuntoDeVenta
			loItem.Afe_Numero = c_Facturadetalle.Afe_Numero
			loItem.Afe_Cantidad = c_Facturadetalle.Afe_Cantidad
			loItem.Afe_Saldo = c_Facturadetalle.Afe_Saldo
			loItem.Articulo_CondicionIvaCompras = c_Facturadetalle.Articulo_CondicionIvaCompras
			loItem.Articulo_PorcentajeIvaCompras = c_Facturadetalle.Articulo_PorcentajeIvaCompras
			loItem.NoProcesarStock = c_Facturadetalle.NoProcesarStock
			loItem.Afe_timeStamp = c_Facturadetalle.Afe_timeStamp
			loItem.Equivalencia_PK = c_Facturadetalle.Equivalencia
			loItem.MontoProrrateoRecargoConImpuestos = c_Facturadetalle.MontoProrrateoRecargoConImpuestos
			loItem.MontoProrrateoTotal = c_Facturadetalle.MontoProrrateoTotal
			loItem.MontoProrrateoPercepciones = c_Facturadetalle.MontoProrrateoPercepciones
			loItem.MontoProrrateoDescuentoConImpuestos = c_Facturadetalle.MontoProrrateoDescuentoConImpuestos
			loItem.MontoProrrateoRecargoSinImpuestos = c_Facturadetalle.MontoProrrateoRecargoSinImpuestos
			loItem.MontoProrrateoDescuentoSinImpuestos = c_Facturadetalle.MontoProrrateoDescuentoSinImpuestos
			loItem.MontoPorcentajeDescuentoSinImpuesto = c_Facturadetalle.MontoPorcentajeDescuentoSinImpuesto
			loItem.MontoDescuentoConImpuestos = c_Facturadetalle.MontoDescuentoConImpuestos
			loItem.MontoDescuentoSinImpuestos = c_Facturadetalle.MontoDescuentoSinImpuestos
			loItem.Afe_Codigo = c_Facturadetalle.Afe_Codigo
			loItem.UsarPrecioDeLista = c_Facturadetalle.UsarPrecioDeLista
			loItem.Bruto = c_Facturadetalle.Bruto
			loItem.AjustePorRedondeoConImpuestos = c_Facturadetalle.AjustePorRedondeoConImpuestos
			loItem.AjustePorRedondeoSinImpuestos = c_Facturadetalle.AjustePorRedondeoSinImpuestos
			loItem.IdItemArticulos = c_Facturadetalle.IdItemArticulos
			loItem.Comportamiento = c_Facturadetalle.Comportamiento
			loItem.PercepcionIvaRG5329 = c_Facturadetalle.PercepcionIvaRG5329
			loItem.ArticuloDetalle = c_Facturadetalle.ArticuloDetalle
			loItem.Color_PK = c_Facturadetalle.Color
			loItem.ColorDetalle = c_Facturadetalle.ColorDetalle
			loItem.Talle = c_Facturadetalle.Talle
			loItem.Descuento = c_Facturadetalle.Descuento
			loItem.Cantidad = c_Facturadetalle.Cantidad
			loItem.MontoDescuento = c_Facturadetalle.MontoDescuento
			loItem.MontoProrrateoIVA = c_Facturadetalle.MontoProrrateoIVA
			loItem.IDSeniaCancelada = c_Facturadetalle.IDSeniaCancelada
			loItem.Precio = c_Facturadetalle.Precio
			loItem.Monto = c_Facturadetalle.Monto
			loItem.CentroDeCosto_PK = c_Facturadetalle.CentroDeCosto
			loItem.DistribucionCentroDeCosto_PK = c_Facturadetalle.DistribucionCentroDeCosto
			loItem.NroItem = lnI 
			this.AgregarItemPlano( loItem )
			lnI = lnI + 1
		endscan

		this.Sumarizar()

	endfunc


	*--------------------------------------------------------------------------------------------------------
	function ValidarExistenciaCamposFijosItemPlano( tnItem as integer ) as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		if  empty( this.item[ tnItem ].Articulo_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].ARTICULO_PK) = 'C'
				if len( alltrim( this.Item[lni].ARTICULO_PK )) <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULO_PK ))) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPORCENTAJEDESCUENTOCONIMPUESTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPORCENTAJEDESCUENTOCONIMPUESTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPORCENTAJEDESCUENTOCONIMPUESTO - int( this.Item[lni].MONTOPORCENTAJEDESCUENTOCONIMPUESTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPORCENTAJEDESCUENTOCONIMPUESTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPORCENTAJEDESCUENTOCONIMPUESTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].KIT) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].KIT ) ) ) 
				lnValorDelDecimal = this.Item[lni].KIT - int( this.Item[lni].KIT )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo KIT del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo KIT del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MATERIAL_PK) = 'C'
				if len( alltrim( this.Item[lni].MATERIAL_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo MATERIAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].MATERIAL_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MATERIAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOCFI) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOCFI ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOCFI - int( this.Item[lni].MONTOCFI )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOCFI del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOCFI del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODTO1) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODTO1 ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODTO1 - int( this.Item[lni].MONTODTO1 )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODTO1 del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODTO1 del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOIVA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOIVA ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOIVA - int( this.Item[lni].MONTOIVA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOIVA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOIVA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NETO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NETO ) ) ) 
				lnValorDelDecimal = this.Item[lni].NETO - int( this.Item[lni].NETO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NETO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NETO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NROITEM) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NROITEM ) ) ) 
				lnValorDelDecimal = this.Item[lni].NROITEM - int( this.Item[lni].NROITEM )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NROITEM del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROITEM del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].OFERTA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].OFERTA ) ) ) 
				lnValorDelDecimal = this.Item[lni].OFERTA - int( this.Item[lni].OFERTA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 14
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo OFERTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:14), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo OFERTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PORCENTAJECFI) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJECFI ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJECFI - int( this.Item[lni].PORCENTAJECFI )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJECFI del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJECFI del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PORCENTAJEDTO1) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJEDTO1 ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJEDTO1 - int( this.Item[lni].PORCENTAJEDTO1 )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDTO1 del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDTO1 del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PORCENTAJEIVA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJEIVA ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJEIVA - int( this.Item[lni].PORCENTAJEIVA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEIVA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEIVA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PRECIOCONIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PRECIOCONIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].PRECIOCONIMPUESTOS - int( this.Item[lni].PRECIOCONIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIOCONIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIOCONIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PRECIOSINIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PRECIOSINIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].PRECIOSINIMPUESTOS - int( this.Item[lni].PRECIOSINIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIOSINIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIOSINIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PRECIOUNITARIO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PRECIOUNITARIO ) ) ) 
				lnValorDelDecimal = this.Item[lni].PRECIOUNITARIO - int( this.Item[lni].PRECIOUNITARIO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIOUNITARIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIOUNITARIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOLISTADEPRECIO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIPOLISTADEPRECIO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIPOLISTADEPRECIO - int( this.Item[lni].TIPOLISTADEPRECIO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIPOLISTADEPRECIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOLISTADEPRECIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].UNIDAD_PK) = 'C'
				if len( alltrim( this.Item[lni].UNIDAD_PK )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo UNIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].UNIDAD_PK ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo UNIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDITEM) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].IDITEM ) ) ) 
				lnValorDelDecimal = this.Item[lni].IDITEM - int( this.Item[lni].IDITEM )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 9
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo IDITEM del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:9), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDITEM del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDORIGEN) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].IDORIGEN ) ) ) 
				lnValorDelDecimal = this.Item[lni].IDORIGEN - int( this.Item[lni].IDORIGEN )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 9
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo IDORIGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:9), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDORIGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_NROITEM) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AFE_NROITEM ) ) ) 
				lnValorDelDecimal = this.Item[lni].AFE_NROITEM - int( this.Item[lni].AFE_NROITEM )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AFE_NROITEM del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_NROITEM del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_TIPOCOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AFE_TIPOCOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].AFE_TIPOCOMPROBANTE - int( this.Item[lni].AFE_TIPOCOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AFE_TIPOCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_TIPOCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_LETRA) = 'C'
				if len( alltrim( this.Item[lni].AFE_LETRA )) <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo AFE_LETRA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].AFE_LETRA ))) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_LETRA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_PUNTODEVENTA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AFE_PUNTODEVENTA ) ) ) 
				lnValorDelDecimal = this.Item[lni].AFE_PUNTODEVENTA - int( this.Item[lni].AFE_PUNTODEVENTA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AFE_PUNTODEVENTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_PUNTODEVENTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_NUMERO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AFE_NUMERO ) ) ) 
				lnValorDelDecimal = this.Item[lni].AFE_NUMERO - int( this.Item[lni].AFE_NUMERO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AFE_NUMERO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_NUMERO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_CANTIDAD) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AFE_CANTIDAD ) ) ) 
				lnValorDelDecimal = this.Item[lni].AFE_CANTIDAD - int( this.Item[lni].AFE_CANTIDAD )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AFE_CANTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_CANTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_SALDO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AFE_SALDO ) ) ) 
				lnValorDelDecimal = this.Item[lni].AFE_SALDO - int( this.Item[lni].AFE_SALDO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AFE_SALDO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_SALDO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULO_CONDICIONIVACOMPRAS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ARTICULO_CONDICIONIVACOMPRAS ) ) ) 
				lnValorDelDecimal = this.Item[lni].ARTICULO_CONDICIONIVACOMPRAS - int( this.Item[lni].ARTICULO_CONDICIONIVACOMPRAS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ARTICULO_CONDICIONIVACOMPRAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO_CONDICIONIVACOMPRAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULO_PORCENTAJEIVACOMPRAS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ARTICULO_PORCENTAJEIVACOMPRAS ) ) ) 
				lnValorDelDecimal = this.Item[lni].ARTICULO_PORCENTAJEIVACOMPRAS - int( this.Item[lni].ARTICULO_PORCENTAJEIVACOMPRAS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ARTICULO_PORCENTAJEIVACOMPRAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO_PORCENTAJEIVACOMPRAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOPROCESARSTOCK) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOPROCESARSTOCK del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_TIMESTAMP) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AFE_TIMESTAMP ) ) ) 
				lnValorDelDecimal = this.Item[lni].AFE_TIMESTAMP - int( this.Item[lni].AFE_TIMESTAMP )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AFE_TIMESTAMP del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_TIMESTAMP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].EQUIVALENCIA_PK) = 'C'
				if len( alltrim( this.Item[lni].EQUIVALENCIA_PK )) <= 14
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo EQUIVALENCIA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].EQUIVALENCIA_PK ))) + ' Máxima:14), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo EQUIVALENCIA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPRORRATEORECARGOCONIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPRORRATEORECARGOCONIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPRORRATEORECARGOCONIMPUESTOS - int( this.Item[lni].MONTOPRORRATEORECARGOCONIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPRORRATEORECARGOCONIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPRORRATEORECARGOCONIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPRORRATEOTOTAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPRORRATEOTOTAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPRORRATEOTOTAL - int( this.Item[lni].MONTOPRORRATEOTOTAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPRORRATEOTOTAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPRORRATEOTOTAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPRORRATEOPERCEPCIONES) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPRORRATEOPERCEPCIONES ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPRORRATEOPERCEPCIONES - int( this.Item[lni].MONTOPRORRATEOPERCEPCIONES )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPRORRATEOPERCEPCIONES del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPRORRATEOPERCEPCIONES del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPRORRATEODESCUENTOCONIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPRORRATEODESCUENTOCONIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPRORRATEODESCUENTOCONIMPUESTOS - int( this.Item[lni].MONTOPRORRATEODESCUENTOCONIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPRORRATEODESCUENTOCONIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPRORRATEODESCUENTOCONIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPRORRATEORECARGOSINIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPRORRATEORECARGOSINIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPRORRATEORECARGOSINIMPUESTOS - int( this.Item[lni].MONTOPRORRATEORECARGOSINIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPRORRATEORECARGOSINIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPRORRATEORECARGOSINIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPRORRATEODESCUENTOSINIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPRORRATEODESCUENTOSINIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPRORRATEODESCUENTOSINIMPUESTOS - int( this.Item[lni].MONTOPRORRATEODESCUENTOSINIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPRORRATEODESCUENTOSINIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPRORRATEODESCUENTOSINIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPORCENTAJEDESCUENTOSINIMPUESTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPORCENTAJEDESCUENTOSINIMPUESTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPORCENTAJEDESCUENTOSINIMPUESTO - int( this.Item[lni].MONTOPORCENTAJEDESCUENTOSINIMPUESTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPORCENTAJEDESCUENTOSINIMPUESTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPORCENTAJEDESCUENTOSINIMPUESTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODESCUENTOCONIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODESCUENTOCONIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODESCUENTOCONIMPUESTOS - int( this.Item[lni].MONTODESCUENTOCONIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOCONIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOCONIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODESCUENTOSINIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODESCUENTOSINIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODESCUENTOSINIMPUESTOS - int( this.Item[lni].MONTODESCUENTOSINIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOSINIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOSINIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFE_CODIGO) = 'C'
				if len( alltrim( this.Item[lni].AFE_CODIGO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo AFE_CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].AFE_CODIGO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFE_CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].USARPRECIODELISTA) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo USARPRECIODELISTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BRUTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].BRUTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].BRUTO - int( this.Item[lni].BRUTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo BRUTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BRUTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AJUSTEPORREDONDEOCONIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AJUSTEPORREDONDEOCONIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].AJUSTEPORREDONDEOCONIMPUESTOS - int( this.Item[lni].AJUSTEPORREDONDEOCONIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AJUSTEPORREDONDEOCONIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AJUSTEPORREDONDEOCONIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AJUSTEPORREDONDEOSINIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AJUSTEPORREDONDEOSINIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].AJUSTEPORREDONDEOSINIMPUESTOS - int( this.Item[lni].AJUSTEPORREDONDEOSINIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AJUSTEPORREDONDEOSINIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AJUSTEPORREDONDEOSINIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDITEMARTICULOS) = 'C'
				if len( alltrim( this.Item[lni].IDITEMARTICULOS )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDITEMARTICULOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDITEMARTICULOS ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDITEMARTICULOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COMPORTAMIENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].COMPORTAMIENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].COMPORTAMIENTO - int( this.Item[lni].COMPORTAMIENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo COMPORTAMIENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMPORTAMIENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PERCEPCIONIVARG5329) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PERCEPCIONIVARG5329 ) ) ) 
				lnValorDelDecimal = this.Item[lni].PERCEPCIONIVARG5329 - int( this.Item[lni].PERCEPCIONIVARG5329 )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PERCEPCIONIVARG5329 del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PERCEPCIONIVARG5329 del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULODETALLE) = 'C'
				if len( alltrim( this.Item[lni].ARTICULODETALLE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULODETALLE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLOR_PK) = 'C'
				if len( alltrim( this.Item[lni].COLOR_PK )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLOR_PK ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COLOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLORDETALLE) = 'C'
				if len( alltrim( this.Item[lni].COLORDETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLORDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLORDETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COLORDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLE) = 'C'
				if len( alltrim( this.Item[lni].TALLE )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLE ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESCUENTO ) ) ) 
				if 0 > this.Item[lni].DESCUENTO 
					lnLargoEntero = lnLargoEntero - 1
				Endif
				lnValorDelDecimal = this.Item[lni].DESCUENTO - int( this.Item[lni].DESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDAD) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDAD ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDAD - int( this.Item[lni].CANTIDAD )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODESCUENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODESCUENTO - int( this.Item[lni].MONTODESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOPRORRATEOIVA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOPRORRATEOIVA ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOPRORRATEOIVA - int( this.Item[lni].MONTOPRORRATEOIVA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOPRORRATEOIVA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOPRORRATEOIVA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDSENIACANCELADA) = 'C'
				if len( alltrim( this.Item[lni].IDSENIACANCELADA )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDSENIACANCELADA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDSENIACANCELADA ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDSENIACANCELADA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PRECIO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PRECIO ) ) ) 
				lnValorDelDecimal = this.Item[lni].PRECIO - int( this.Item[lni].PRECIO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTO - int( this.Item[lni].MONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CENTRODECOSTO_PK) = 'C'
				if len( alltrim( this.Item[lni].CENTRODECOSTO_PK )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CENTRODECOSTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CENTRODECOSTO_PK ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CENTRODECOSTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DISTRIBUCIONCENTRODECOSTO_PK) = 'C'
				if len( alltrim( this.Item[lni].DISTRIBUCIONCENTRODECOSTO_PK )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DISTRIBUCIONCENTRODECOSTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DISTRIBUCIONCENTRODECOSTO_PK ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DISTRIBUCIONCENTRODECOSTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
		EndFor
		Return llRetorno 
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function CrearItemAuxiliar() as Object
		return createobject( 'itemAuxiliar' )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ClonarItemAuxiliar( tnItem as Integer ) as Object
		loItemOrigen = this.Item[tnItem]
		loRetorno = createobject( 'itemAuxiliar' )
		this.CopiarItemaItem( loItemOrigen, loRetorno ) 

		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CopiarItemaItem( toItemOrigen as Object, toItemDestino as Object ) as Object
		toItemDestino.Articulo_PK = toItemOrigen.Articulo_PK
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Montoporcentajedescuentoconimpuesto = toItemOrigen.Montoporcentajedescuentoconimpuesto
		toItemDestino.Impuestos = toItemOrigen.Impuestos
		toItemDestino.Kit = toItemOrigen.Kit
		toItemDestino.Material_PK = toItemOrigen.Material_PK
		toItemDestino.Montocfi = toItemOrigen.Montocfi
		toItemDestino.Montodto1 = toItemOrigen.Montodto1
		toItemDestino.Montoiva = toItemOrigen.Montoiva
		toItemDestino.Neto = toItemOrigen.Neto
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Oferta = toItemOrigen.Oferta
		toItemDestino.Porcentajecfi = toItemOrigen.Porcentajecfi
		toItemDestino.Porcentajedto1 = toItemOrigen.Porcentajedto1
		toItemDestino.Porcentajeiva = toItemOrigen.Porcentajeiva
		toItemDestino.Precioconimpuestos = toItemOrigen.Precioconimpuestos
		toItemDestino.Preciodelista = toItemOrigen.Preciodelista
		toItemDestino.Preciosinimpuestos = toItemOrigen.Preciosinimpuestos
		toItemDestino.Preciounitario = toItemOrigen.Preciounitario
		toItemDestino.Tipolistadeprecio = toItemOrigen.Tipolistadeprecio
		toItemDestino.Unidad_PK = toItemOrigen.Unidad_PK
		toItemDestino.Iditem = toItemOrigen.Iditem
		toItemDestino.Idorigen = toItemOrigen.Idorigen
		toItemDestino.Codigoorigen = toItemOrigen.Codigoorigen
		toItemDestino.Afe_nroitem = toItemOrigen.Afe_nroitem
		toItemDestino.Afe_tipocomprobante = toItemOrigen.Afe_tipocomprobante
		toItemDestino.Afe_letra = toItemOrigen.Afe_letra
		toItemDestino.Afe_puntodeventa = toItemOrigen.Afe_puntodeventa
		toItemDestino.Afe_numero = toItemOrigen.Afe_numero
		toItemDestino.Afe_cantidad = toItemOrigen.Afe_cantidad
		toItemDestino.Afe_saldo = toItemOrigen.Afe_saldo
		toItemDestino.Afe_cantidadoriginal = toItemOrigen.Afe_cantidadoriginal
		toItemDestino.Afe_saldoactual = toItemOrigen.Afe_saldoactual
		toItemDestino.Afe_saldooriginal = toItemOrigen.Afe_saldooriginal
		toItemDestino.Articulo_condicionivacompras = toItemOrigen.Articulo_condicionivacompras
		toItemDestino.Articulo_porcentajeivacompras = toItemOrigen.Articulo_porcentajeivacompras
		toItemDestino.Noprocesarstock = toItemOrigen.Noprocesarstock
		toItemDestino.Afe_timestamp = toItemOrigen.Afe_timestamp
		toItemDestino.Codigodebarras = toItemOrigen.Codigodebarras
		toItemDestino.Equivalencia_PK = toItemOrigen.Equivalencia_PK
		toItemDestino.Montoprorrateorecargoconimpuestos = toItemOrigen.Montoprorrateorecargoconimpuestos
		toItemDestino.Montoprorrateototal = toItemOrigen.Montoprorrateototal
		toItemDestino.Montoprorrateopercepciones = toItemOrigen.Montoprorrateopercepciones
		toItemDestino.Montoprorrateodescuentoconimpuestos = toItemOrigen.Montoprorrateodescuentoconimpuestos
		toItemDestino.Montoprorrateorecargosinimpuestos = toItemOrigen.Montoprorrateorecargosinimpuestos
		toItemDestino.Montoprorrateodescuentosinimpuestos = toItemOrigen.Montoprorrateodescuentosinimpuestos
		toItemDestino.Montoporcentajedescuentosinimpuesto = toItemOrigen.Montoporcentajedescuentosinimpuesto
		toItemDestino.Montodescuentoconimpuestos = toItemOrigen.Montodescuentoconimpuestos
		toItemDestino.Montodescuentosinimpuestos = toItemOrigen.Montodescuentosinimpuestos
		toItemDestino.Afe_codigo = toItemOrigen.Afe_codigo
		toItemDestino.Usarpreciodelista = toItemOrigen.Usarpreciodelista
		toItemDestino.Bruto = toItemOrigen.Bruto
		toItemDestino.Ajusteporredondeoconimpuestos = toItemOrigen.Ajusteporredondeoconimpuestos
		toItemDestino.Ajusteporredondeosinimpuestos = toItemOrigen.Ajusteporredondeosinimpuestos
		toItemDestino.Fueautorizadodevolucion = toItemOrigen.Fueautorizadodevolucion
		toItemDestino.Iditemarticulos = toItemOrigen.Iditemarticulos
		toItemDestino.Comportamiento = toItemOrigen.Comportamiento
		toItemDestino.Eslibre = toItemOrigen.Eslibre
		toItemDestino.Percepcionivarg5329 = toItemOrigen.Percepcionivarg5329
		toItemDestino.Articulodetalle = toItemOrigen.Articulodetalle
		toItemDestino.Color_PK = toItemOrigen.Color_PK
		toItemDestino.Colordetalle = toItemOrigen.Colordetalle
		toItemDestino.Talle = toItemOrigen.Talle
		toItemDestino.Descuento = toItemOrigen.Descuento
		toItemDestino.Cantidad = toItemOrigen.Cantidad
		toItemDestino.Montodescuento = toItemOrigen.Montodescuento
		toItemDestino.Montoprorrateoiva = toItemOrigen.Montoprorrateoiva
		toItemDestino.Idseniacancelada = toItemOrigen.Idseniacancelada
		toItemDestino.Precio = toItemOrigen.Precio
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Centrodecosto_PK = toItemOrigen.Centrodecosto_PK
		toItemDestino.Distribucioncentrodecosto_PK = toItemOrigen.Distribucioncentrodecosto_PK
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Actualizar( tcClave as string ) as Void
		local lcInformacion as String, loEx as Exception
		if this.oItem.TieneDisponible()
			dodefault( tcClave )
			this.Sumarizar()
		else
			lcInformacion = this.oitem.ocompstock.FormarMensajeCombSegunDisponible( This.oitem )
			this.limpiarInformacion()
			this.agregarinformacion( lcInformacion )
			if goParametros.Felino.Generales.PermitirPasarSinStock
				This.EventoNoHayStock( this.oInformacion )
				dodefault( tcClave )
				this.Sumarizar()
			else
				loEx = newobject( 'zooexception', 'zooexception.prg' )
				with loEx
					.AgregarInformacion( lcInformacion )
				endwith
				goServicios.Errores.LevantarExcepcion( loEx )
			endif
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function VerificarSiElAtributoEstaVacio( tcAtributo as String, txValor as Variant ) as Boolean
		local llRetorno as boolean
		llRetorno = .t.
		if this.ElAtributoEsVerificableComoVacio( tcAtributo )
			llRetorno = empty( txValor )
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ElAtributoEsVerificableComoVacio( tcAtributo as String ) as Boolean
		Return dodefault( tcAtributo ) 
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerFiltro( ) as String
		local lcRetorno as String
		lcRetorno = '.T.'
		return lcRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCampoInicialYOBligatorioDelDetalle() as String
	local lcRetorno as string
		lcRetorno = 'Articulo_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Articulo_PK = []
	Codigo = []
	Montoporcentajedescuentoconimpuesto = 0
	Impuestos = 0
	Kit = 0
	Material_PK = []
	Montocfi = 0
	Montodto1 = 0
	Montoiva = 0
	Neto = 0
	Nroitem = 0
	Oferta = 0
	Porcentajecfi = 0
	Porcentajedto1 = 0
	Porcentajeiva = 0
	Precioconimpuestos = 0
	Preciodelista = 0
	Preciosinimpuestos = 0
	Preciounitario = 0
	Tipolistadeprecio = 0
	Unidad_PK = []
	Iditem = 0
	Idorigen = 0
	Codigoorigen = 0
	Afe_nroitem = 0
	Afe_tipocomprobante = 0
	Afe_letra = []
	Afe_puntodeventa = 0
	Afe_numero = 0
	Afe_cantidad = 0
	Afe_saldo = 0
	Afe_cantidadoriginal = 0
	Afe_saldoactual = 0
	Afe_saldooriginal = 0
	Articulo_condicionivacompras = 0
	Articulo_porcentajeivacompras = 0
	Noprocesarstock = .F.
	Afe_timestamp = 0
	Codigodebarras = []
	Equivalencia_PK = []
	Montoprorrateorecargoconimpuestos = 0
	Montoprorrateototal = 0
	Montoprorrateopercepciones = 0
	Montoprorrateodescuentoconimpuestos = 0
	Montoprorrateorecargosinimpuestos = 0
	Montoprorrateodescuentosinimpuestos = 0
	Montoporcentajedescuentosinimpuesto = 0
	Montodescuentoconimpuestos = 0
	Montodescuentosinimpuestos = 0
	Afe_codigo = []
	Usarpreciodelista = .F.
	Bruto = 0
	Ajusteporredondeoconimpuestos = 0
	Ajusteporredondeosinimpuestos = 0
	Fueautorizadodevolucion = .F.
	Iditemarticulos = []
	Comportamiento = 0
	Eslibre = .F.
	Percepcionivarg5329 = 0
	Articulodetalle = []
	Color_PK = []
	Colordetalle = []
	Talle = []
	Descuento = 0
	Cantidad = 0
	Montodescuento = 0
	Montoprorrateoiva = 0
	Idseniacancelada = []
	Precio = 0
	Monto = 0
	Centrodecosto_PK = []
	Distribucioncentrodecosto_PK = []
	NroItem = 0

enddefine