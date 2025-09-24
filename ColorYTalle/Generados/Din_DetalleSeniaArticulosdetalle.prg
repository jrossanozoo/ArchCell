
define class Din_DetalleSENIAArticulosdetalle as detalle of detalle.prg

	Sum_Cantidad = 0
	Sum_Monto = 0
	Sum_Montodescuento = 0
	Sum_Montoporcentajedescuentoconimpuesto = 0

	nCantidadItems = 999
	cNombre = 'Articulosdetalle'
	cEtiqueta = 'Artículos señados'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Artículos señados'

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
			
				.MontoCFI = this.Item[ tnItem ].MontoCFI
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoCFI', .MontoCFI )
			
				.MontoDTO1 = this.Item[ tnItem ].MontoDTO1
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDTO1', .MontoDTO1 )
			
				.NroItem = this.Item[ tnItem ].NroItem
			
				.PorcentajeCFI = this.Item[ tnItem ].PorcentajeCFI
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeCFI', .PorcentajeCFI )
			
				.PorcentajeDTO1 = this.Item[ tnItem ].PorcentajeDTO1
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeDTO1', .PorcentajeDTO1 )
			
				.PrecioConImpuestos = this.Item[ tnItem ].PrecioConImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioConImpuestos', .PrecioConImpuestos )
			
				.PrecioSinImpuestos = this.Item[ tnItem ].PrecioSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioSinImpuestos', .PrecioSinImpuestos )
			
				.PrecioUnitario = this.Item[ tnItem ].PrecioUnitario
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioUnitario', .PrecioUnitario )
			
				.PrecioSinImpuestosSinRedondear = this.Item[ tnItem ].PrecioSinImpuestosSinRedondear
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioSinImpuestosSinRedondear', .PrecioSinImpuestosSinRedondear )
			
				.PrecioConImpuestosSinRedondear = this.Item[ tnItem ].PrecioConImpuestosSinRedondear
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioConImpuestosSinRedondear', .PrecioConImpuestosSinRedondear )
			
				.PrecioSinRedondear = this.Item[ tnItem ].PrecioSinRedondear
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PrecioSinRedondear', .PrecioSinRedondear )
			
				.Articulo_CondicionIvaVentas = this.Item[ tnItem ].Articulo_CondicionIvaVentas
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Articulo_CondicionIvaVentas', .Articulo_CondicionIvaVentas )
			
				.Articulo_PorcentajeIvaVentas = this.Item[ tnItem ].Articulo_PorcentajeIvaVentas
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Articulo_PorcentajeIvaVentas', .Articulo_PorcentajeIvaVentas )
			
				.MontoDescuentoConImpuestos = this.Item[ tnItem ].MontoDescuentoConImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDescuentoConImpuestos', .MontoDescuentoConImpuestos )
			
				.MontoDescuentoSinImpuestos = this.Item[ tnItem ].MontoDescuentoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDescuentoSinImpuestos', .MontoDescuentoSinImpuestos )
			
				.TasaImpuestoInterno = this.Item[ tnItem ].TasaImpuestoInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TasaImpuestoInterno', .TasaImpuestoInterno )
			
				.CodigoMotivoDevolucion_PK = this.Item[ tnItem ].CodigoMotivoDevolucion_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoMotivoDevolucion_PK', .CodigoMotivoDevolucion_PK )
			
				.CodigoMotivoDescuento_PK = this.Item[ tnItem ].CodigoMotivoDescuento_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoMotivoDescuento_PK', .CodigoMotivoDescuento_PK )
			
				.Comportamiento = this.Item[ tnItem ].Comportamiento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comportamiento', .Comportamiento )
			
				.NoProcesarStock = this.Item[ tnItem ].NoProcesarStock
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NoProcesarStock', .NoProcesarStock )
			
				.ArticuloDetalle = this.Item[ tnItem ].ArticuloDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ArticuloDetalle', .ArticuloDetalle )
			
				.Color_PK = this.Item[ tnItem ].Color_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Color_PK', .Color_PK )
			
				.ColorDetalle = this.Item[ tnItem ].ColorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ColorDetalle', .ColorDetalle )
			
				.Talle_PK = this.Item[ tnItem ].Talle_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Talle_PK', .Talle_PK )
			
				.TalleDetalle = this.Item[ tnItem ].TalleDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TalleDetalle', .TalleDetalle )
			
				.Cantidad = this.Item[ tnItem ].Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cantidad', .Cantidad )
			
				.Precio = this.Item[ tnItem ].Precio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Precio', .Precio )
			
				.Descuento = this.Item[ tnItem ].Descuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descuento', .Descuento )
			
				.MontoDescuento = this.Item[ tnItem ].MontoDescuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDescuento', .MontoDescuento )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
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
			.MontoCFI = this.oItem.MontoCFI
			.MontoDTO1 = this.oItem.MontoDTO1
			.NroItem = this.oItem.NroItem
			.PorcentajeCFI = this.oItem.PorcentajeCFI
			.PorcentajeDTO1 = this.oItem.PorcentajeDTO1
			.PrecioConImpuestos = this.oItem.PrecioConImpuestos
			.PrecioSinImpuestos = this.oItem.PrecioSinImpuestos
			.PrecioUnitario = this.oItem.PrecioUnitario
			.PrecioSinImpuestosSinRedondear = this.oItem.PrecioSinImpuestosSinRedondear
			.PrecioConImpuestosSinRedondear = this.oItem.PrecioConImpuestosSinRedondear
			.PrecioSinRedondear = this.oItem.PrecioSinRedondear
			.Articulo_CondicionIvaVentas = this.oItem.Articulo_CondicionIvaVentas
			.Articulo_PorcentajeIvaVentas = this.oItem.Articulo_PorcentajeIvaVentas
			.MontoDescuentoConImpuestos = this.oItem.MontoDescuentoConImpuestos
			.MontoDescuentoSinImpuestos = this.oItem.MontoDescuentoSinImpuestos
			.TasaImpuestoInterno = this.oItem.TasaImpuestoInterno
			.CodigoMotivoDevolucion_PK = this.oItem.CodigoMotivoDevolucion_PK
			.CodigoMotivoDescuento_PK = this.oItem.CodigoMotivoDescuento_PK
			.Comportamiento = this.oItem.Comportamiento
			.NoProcesarStock = this.oItem.NoProcesarStock
			.ArticuloDetalle = this.oItem.ArticuloDetalle
			.Color_PK = this.oItem.Color_PK
			.ColorDetalle = this.oItem.ColorDetalle
			.Talle_PK = this.oItem.Talle_PK
			.TalleDetalle = this.oItem.TalleDetalle
			.Cantidad = this.oItem.Cantidad
			.Precio = this.oItem.Precio
			.Descuento = this.oItem.Descuento
			.MontoDescuento = this.oItem.MontoDescuento
			.Monto = this.oItem.Monto
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
			.Item[ lnItem ].MontoCFI = .oItem.MontoCFI
			.Item[ lnItem ].MontoDTO1 = .oItem.MontoDTO1
			.Item[ lnItem ].NroItem = .oItem.NroItem
			.Item[ lnItem ].PorcentajeCFI = .oItem.PorcentajeCFI
			.Item[ lnItem ].PorcentajeDTO1 = .oItem.PorcentajeDTO1
			.Item[ lnItem ].PrecioConImpuestos = .oItem.PrecioConImpuestos
			.Item[ lnItem ].PrecioSinImpuestos = .oItem.PrecioSinImpuestos
			.Item[ lnItem ].PrecioUnitario = .oItem.PrecioUnitario
			.Item[ lnItem ].PrecioSinImpuestosSinRedondear = .oItem.PrecioSinImpuestosSinRedondear
			.Item[ lnItem ].PrecioConImpuestosSinRedondear = .oItem.PrecioConImpuestosSinRedondear
			.Item[ lnItem ].PrecioSinRedondear = .oItem.PrecioSinRedondear
			.Item[ lnItem ].Articulo_CondicionIvaVentas = .oItem.Articulo_CondicionIvaVentas
			.Item[ lnItem ].Articulo_PorcentajeIvaVentas = .oItem.Articulo_PorcentajeIvaVentas
			.Item[ lnItem ].MontoDescuentoConImpuestos = .oItem.MontoDescuentoConImpuestos
			.Item[ lnItem ].MontoDescuentoSinImpuestos = .oItem.MontoDescuentoSinImpuestos
			.Item[ lnItem ].TasaImpuestoInterno = .oItem.TasaImpuestoInterno
			.Item[ lnItem ].CodigoMotivoDevolucion_PK = .oItem.CodigoMotivoDevolucion_PK
			.Item[ lnItem ].CodigoMotivoDescuento_PK = .oItem.CodigoMotivoDescuento_PK
			.Item[ lnItem ].Comportamiento = .oItem.Comportamiento
			.Item[ lnItem ].NoProcesarStock = .oItem.NoProcesarStock
			.Item[ lnItem ].ArticuloDetalle = .oItem.ArticuloDetalle
			.Item[ lnItem ].Color_PK = .oItem.Color_PK
			.Item[ lnItem ].ColorDetalle = .oItem.ColorDetalle
			.Item[ lnItem ].Talle_PK = .oItem.Talle_PK
			.Item[ lnItem ].TalleDetalle = .oItem.TalleDetalle
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
			.Item[ lnItem ].Precio = .oItem.Precio
			.Item[ lnItem ].Descuento = .oItem.Descuento
			.Item[ lnItem ].MontoDescuento = .oItem.MontoDescuento
			.Item[ lnItem ].Monto = .oItem.Monto
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Monto as Number, lnSum_Montodescuento as Number, lnSum_Montoporcentajedescuentoconimpuesto as Number

		with this
			lnSum_Cantidad = 0
			lnSum_Monto = 0
			lnSum_Montodescuento = 0
			lnSum_Montoporcentajedescuentoconimpuesto = 0
			if this.lEsNavegacion
				if select( 'c_Articulosdetalle' ) > 0 and reccount( 'c_Articulosdetalle' ) > 0
					sum Cantidad, Monto, Montodescuento, Montoporcentajedescuentoconimpuesto;
						 to ;
						 lnSum_Cantidad, lnSum_Monto, lnSum_Montodescuento, lnSum_Montoporcentajedescuentoconimpuesto
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.ARTICULO_PK)
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
								lnSum_Monto = lnSum_Monto + .Monto
								lnSum_Montodescuento = lnSum_Montodescuento + .Montodescuento
								lnSum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto + .Montoporcentajedescuentoconimpuesto
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						lnSum_Monto = lnSum_Monto + .Monto
						lnSum_Montodescuento = lnSum_Montodescuento + .Montodescuento
						lnSum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto + .Montoporcentajedescuentoconimpuesto
					endwith
				endif
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif
			if .Sum_Montodescuento != lnSum_Montodescuento
				.Sum_Montodescuento = lnSum_Montodescuento
				.EventoCambioSum_Montodescuento()
			endif
			if .Sum_Montoporcentajedescuentoconimpuesto != lnSum_Montoporcentajedescuentoconimpuesto
				.Sum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto
				.EventoCambioSum_Montoporcentajedescuentoconimpuesto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cantidad() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Monto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montodescuento() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montoporcentajedescuentoconimpuesto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Monto as Number, lnSum_Montodescuento as Number, lnSum_Montoporcentajedescuentoconimpuesto as Number

		with this
			lnSum_Cantidad = 0
			lnSum_Monto = 0
			lnSum_Montodescuento = 0
			lnSum_Montoporcentajedescuentoconimpuesto = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.ARTICULO_PK)
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
								lnSum_Monto = lnSum_Monto + .Monto
								lnSum_Montodescuento = lnSum_Montodescuento + .Montodescuento
								lnSum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto + .Montoporcentajedescuentoconimpuesto
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.ARTICULO_PK)
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						lnSum_Monto = lnSum_Monto + .Monto
						lnSum_Montodescuento = lnSum_Montodescuento + .Montodescuento
						lnSum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto + .Montoporcentajedescuentoconimpuesto
					endif
				endwith
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif
			if .Sum_Montodescuento != lnSum_Montodescuento
				.Sum_Montodescuento = lnSum_Montodescuento
				.EventoCambioSum_Montodescuento()
			endif
			if .Sum_Montoporcentajedescuentoconimpuesto != lnSum_Montoporcentajedescuentoconimpuesto
				.Sum_Montoporcentajedescuentoconimpuesto = lnSum_Montoporcentajedescuentoconimpuesto
				.EventoCambioSum_Montoporcentajedescuentoconimpuesto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Monto as Number, lnSum_Montodescuento as Number, lnSum_Montoporcentajedescuentoconimpuesto as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Cantidad'
			this.Sum_Cantidad = this.Sum_Cantidad - tnValorAnt + tnValor
			this.EventoCambioSum_Cantidad()
		case tcAtributo == 'Monto'
			this.Sum_Monto = this.Sum_Monto - tnValorAnt + tnValor
			this.EventoCambioSum_Monto()
		case tcAtributo == 'Montodescuento'
			this.Sum_Montodescuento = this.Sum_Montodescuento - tnValorAnt + tnValor
			this.EventoCambioSum_Montodescuento()
		case tcAtributo == 'Montoporcentajedescuentoconimpuesto'
			this.Sum_Montoporcentajedescuentoconimpuesto = this.Sum_Montoporcentajedescuentoconimpuesto - tnValorAnt + tnValor
			this.EventoCambioSum_Montoporcentajedescuentoconimpuesto()

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
			this.oItem = _Screen.zoo.crearobjeto( 'ItemSENIAArticulosdetalle' )
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

		select c_Articulosdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Articulo_PK = c_Articulosdetalle.Articulo
			loItem.Codigo = c_Articulosdetalle.Codigo
			loItem.MontoPorcentajeDescuentoConImpuesto = c_Articulosdetalle.MontoPorcentajeDescuentoConImpuesto
			loItem.MontoCFI = c_Articulosdetalle.MontoCFI
			loItem.MontoDTO1 = c_Articulosdetalle.MontoDTO1
			loItem.NroItem = c_Articulosdetalle.NroItem
			loItem.PorcentajeCFI = c_Articulosdetalle.PorcentajeCFI
			loItem.PorcentajeDTO1 = c_Articulosdetalle.PorcentajeDTO1
			loItem.PrecioConImpuestos = c_Articulosdetalle.PrecioConImpuestos
			loItem.PrecioSinImpuestos = c_Articulosdetalle.PrecioSinImpuestos
			loItem.PrecioUnitario = c_Articulosdetalle.PrecioUnitario
			loItem.PrecioSinImpuestosSinRedondear = c_Articulosdetalle.PrecioSinImpuestosSinRedondear
			loItem.PrecioConImpuestosSinRedondear = c_Articulosdetalle.PrecioConImpuestosSinRedondear
			loItem.PrecioSinRedondear = c_Articulosdetalle.PrecioSinRedondear
			loItem.Articulo_CondicionIvaVentas = c_Articulosdetalle.Articulo_CondicionIvaVentas
			loItem.Articulo_PorcentajeIvaVentas = c_Articulosdetalle.Articulo_PorcentajeIvaVentas
			loItem.MontoDescuentoConImpuestos = c_Articulosdetalle.MontoDescuentoConImpuestos
			loItem.MontoDescuentoSinImpuestos = c_Articulosdetalle.MontoDescuentoSinImpuestos
			loItem.TasaImpuestoInterno = c_Articulosdetalle.TasaImpuestoInterno
			loItem.CodigoMotivoDevolucion_PK = c_Articulosdetalle.CodigoMotivoDevolucion
			loItem.CodigoMotivoDescuento_PK = c_Articulosdetalle.CodigoMotivoDescuento
			loItem.Comportamiento = c_Articulosdetalle.Comportamiento
			loItem.NoProcesarStock = c_Articulosdetalle.NoProcesarStock
			loItem.ArticuloDetalle = c_Articulosdetalle.ArticuloDetalle
			loItem.Color_PK = c_Articulosdetalle.Color
			loItem.ColorDetalle = c_Articulosdetalle.ColorDetalle
			loItem.Talle_PK = c_Articulosdetalle.Talle
			loItem.TalleDetalle = c_Articulosdetalle.TalleDetalle
			loItem.Cantidad = c_Articulosdetalle.Cantidad
			loItem.Precio = c_Articulosdetalle.Precio
			loItem.Descuento = c_Articulosdetalle.Descuento
			loItem.MontoDescuento = c_Articulosdetalle.MontoDescuento
			loItem.Monto = c_Articulosdetalle.Monto
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
				if len( alltrim( this.Item[lni].ARTICULO_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULO_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].MONTOCFI) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOCFI ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOCFI - int( this.Item[lni].MONTOCFI )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOCFI del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOCFI del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODTO1) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODTO1 ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODTO1 - int( this.Item[lni].MONTODTO1 )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODTO1 del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODTO1 del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIOUNITARIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIOUNITARIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PRECIOSINIMPUESTOSSINREDONDEAR) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PRECIOSINIMPUESTOSSINREDONDEAR ) ) ) 
				lnValorDelDecimal = this.Item[lni].PRECIOSINIMPUESTOSSINREDONDEAR - int( this.Item[lni].PRECIOSINIMPUESTOSSINREDONDEAR )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 9
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIOSINIMPUESTOSSINREDONDEAR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:9), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIOSINIMPUESTOSSINREDONDEAR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PRECIOCONIMPUESTOSSINREDONDEAR) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PRECIOCONIMPUESTOSSINREDONDEAR ) ) ) 
				lnValorDelDecimal = this.Item[lni].PRECIOCONIMPUESTOSSINREDONDEAR - int( this.Item[lni].PRECIOCONIMPUESTOSSINREDONDEAR )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 9
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIOCONIMPUESTOSSINREDONDEAR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:9), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIOCONIMPUESTOSSINREDONDEAR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PRECIOSINREDONDEAR) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PRECIOSINREDONDEAR ) ) ) 
				lnValorDelDecimal = this.Item[lni].PRECIOSINREDONDEAR - int( this.Item[lni].PRECIOSINREDONDEAR )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 9
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIOSINREDONDEAR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:9), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIOSINREDONDEAR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULO_CONDICIONIVAVENTAS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ARTICULO_CONDICIONIVAVENTAS ) ) ) 
				lnValorDelDecimal = this.Item[lni].ARTICULO_CONDICIONIVAVENTAS - int( this.Item[lni].ARTICULO_CONDICIONIVAVENTAS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ARTICULO_CONDICIONIVAVENTAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO_CONDICIONIVAVENTAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULO_PORCENTAJEIVAVENTAS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ARTICULO_PORCENTAJEIVAVENTAS ) ) ) 
				lnValorDelDecimal = this.Item[lni].ARTICULO_PORCENTAJEIVAVENTAS - int( this.Item[lni].ARTICULO_PORCENTAJEIVAVENTAS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ARTICULO_PORCENTAJEIVAVENTAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO_PORCENTAJEIVAVENTAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].TASAIMPUESTOINTERNO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TASAIMPUESTOINTERNO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TASAIMPUESTOINTERNO - int( this.Item[lni].TASAIMPUESTOINTERNO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TASAIMPUESTOINTERNO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TASAIMPUESTOINTERNO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOMOTIVODEVOLUCION_PK) = 'C'
				if len( alltrim( this.Item[lni].CODIGOMOTIVODEVOLUCION_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOMOTIVODEVOLUCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOMOTIVODEVOLUCION_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOMOTIVODEVOLUCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOMOTIVODESCUENTO_PK) = 'C'
				if len( alltrim( this.Item[lni].CODIGOMOTIVODESCUENTO_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOMOTIVODESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOMOTIVODESCUENTO_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOMOTIVODESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].NOPROCESARSTOCK) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOPROCESARSTOCK del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULODETALLE) = 'C'
				if len( alltrim( this.Item[lni].ARTICULODETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULODETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLOR_PK) = 'C'
				if len( alltrim( this.Item[lni].COLOR_PK )) <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLOR_PK ))) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].TALLE_PK) = 'C'
				if len( alltrim( this.Item[lni].TALLE_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLE_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLEDETALLE) = 'C'
				if len( alltrim( this.Item[lni].TALLEDETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLEDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLEDETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLEDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].MONTODESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODESCUENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODESCUENTO - int( this.Item[lni].MONTODESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTO - int( this.Item[lni].MONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Montocfi = toItemOrigen.Montocfi
		toItemDestino.Montodto1 = toItemOrigen.Montodto1
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Porcentajecfi = toItemOrigen.Porcentajecfi
		toItemDestino.Porcentajedto1 = toItemOrigen.Porcentajedto1
		toItemDestino.Precioconimpuestos = toItemOrigen.Precioconimpuestos
		toItemDestino.Preciosinimpuestos = toItemOrigen.Preciosinimpuestos
		toItemDestino.Preciounitario = toItemOrigen.Preciounitario
		toItemDestino.Preciosinimpuestossinredondear = toItemOrigen.Preciosinimpuestossinredondear
		toItemDestino.Precioconimpuestossinredondear = toItemOrigen.Precioconimpuestossinredondear
		toItemDestino.Preciosinredondear = toItemOrigen.Preciosinredondear
		toItemDestino.Articulo_condicionivaventas = toItemOrigen.Articulo_condicionivaventas
		toItemDestino.Articulo_porcentajeivaventas = toItemOrigen.Articulo_porcentajeivaventas
		toItemDestino.Montodescuentoconimpuestos = toItemOrigen.Montodescuentoconimpuestos
		toItemDestino.Montodescuentosinimpuestos = toItemOrigen.Montodescuentosinimpuestos
		toItemDestino.Tasaimpuestointerno = toItemOrigen.Tasaimpuestointerno
		toItemDestino.Codigomotivodevolucion_PK = toItemOrigen.Codigomotivodevolucion_PK
		toItemDestino.Codigomotivodescuento_PK = toItemOrigen.Codigomotivodescuento_PK
		toItemDestino.Comportamiento = toItemOrigen.Comportamiento
		toItemDestino.Noprocesarstock = toItemOrigen.Noprocesarstock
		toItemDestino.Articulodetalle = toItemOrigen.Articulodetalle
		toItemDestino.Color_PK = toItemOrigen.Color_PK
		toItemDestino.Colordetalle = toItemOrigen.Colordetalle
		toItemDestino.Talle_PK = toItemOrigen.Talle_PK
		toItemDestino.Talledetalle = toItemOrigen.Talledetalle
		toItemDestino.Cantidad = toItemOrigen.Cantidad
		toItemDestino.Precio = toItemOrigen.Precio
		toItemDestino.Descuento = toItemOrigen.Descuento
		toItemDestino.Montodescuento = toItemOrigen.Montodescuento
		toItemDestino.Monto = toItemOrigen.Monto
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
	Montocfi = 0
	Montodto1 = 0
	Nroitem = 0
	Porcentajecfi = 0
	Porcentajedto1 = 0
	Precioconimpuestos = 0
	Preciosinimpuestos = 0
	Preciounitario = 0
	Preciosinimpuestossinredondear = 0
	Precioconimpuestossinredondear = 0
	Preciosinredondear = 0
	Articulo_condicionivaventas = 0
	Articulo_porcentajeivaventas = 0
	Montodescuentoconimpuestos = 0
	Montodescuentosinimpuestos = 0
	Tasaimpuestointerno = 0
	Codigomotivodevolucion_PK = []
	Codigomotivodescuento_PK = []
	Comportamiento = 0
	Noprocesarstock = .F.
	Articulodetalle = []
	Color_PK = []
	Colordetalle = []
	Talle_PK = []
	Talledetalle = []
	Cantidad = 0
	Precio = 0
	Descuento = 0
	Montodescuento = 0
	Monto = 0
	NroItem = 0

enddefine